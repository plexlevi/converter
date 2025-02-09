# Beállítjuk a szkript útvonalát
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Add-Type -AssemblyName System.Windows.Forms

. (Join-Path $scriptRoot 'converter.designer.ps1')

function Set-ConsoleColor { # A legközelebbi konzol szín beállítása a megadott RGB szín alapján
    param (
        [int]$r,
        [int]$g,
        [int]$b,
        [string]$type = "Foreground"  # "Foreground" vagy "Background"
    )
    $color = [System.Drawing.Color]::FromArgb($r, $g, $b)
    $consoleColor = [System.ConsoleColor]::Black
    $closestDistance = [double]::MaxValue

    foreach ($name in [Enum]::GetValues([System.ConsoleColor])) {
        $consoleColorValue = [System.ConsoleColor]::Parse([System.ConsoleColor], $name)
        $consoleColorRgb = [System.Drawing.Color]::FromName($consoleColorValue.ToString())
        $distance = [math]::Sqrt([math]::Pow($color.R - $consoleColorRgb.R, 2) + [math]::Pow($color.G - $consoleColorRgb.G, 2) + [math]::Pow($color.B - $consoleColorRgb.B, 2))

        if ($distance -lt $closestDistance) {
            $closestDistance = $distance
            $consoleColor = $consoleColorValue
        }
    }

    if ($type -eq "Foreground") {
        [System.Console]::ForegroundColor = $consoleColor
    } elseif ($type -eq "Background") {
        [System.Console]::BackgroundColor = $consoleColor
    }
}

Set-ConsoleColor -r 255 -g 165 -b 0 -type "Foreground"
[System.Console]::Clear()  # Töröld a konzolt, hogy az új háttérszín érvényesüljön

# Köszöntő szöveg kiírása a konzolban
Write-Host @"
  _____                          _              ______           _____     __          __  
 / ____|                        | |            |  ____|         |  __ \   /\ \        / /  
| |     ___  _ ____   _____ _ __| |_ ___ _ __  | |__ ___  _ __  | |  | | /  \ \  /\  / /__ 
| |    / _ \| '_ \ \ / / _ \ '__| __/ _ \ '__| |  __/ _ \| '__| | |  | |/ /\ \ \/  \/ / __|
| |___| (_) | | | \ V /  __/ |  | ||  __/ |    | | | (_) | |    | |__| / ____ \  /\  /\__ \
 \_____\___/|_| |_|\_/ \___|_|   \__\___|_|    |_|  \___/|_|    |_____/_/    \_\/  \/ |___/
"@
Write-Host ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("---------------------Created By Levente Géczy (2025)------------------------")))
Write-Host ""
[System.Console]::ResetColor()

# Initialize global variable to store ffmpeg commands
$global:ffmpegCommands = ""
$ffprobeBinary = "ffprobe"

function Get-VideoDuration {
    param (
        [string]$inputFile
    )
    $ffprobeOutput = & $ffprobeBinary -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 -- $inputFile
    if ($ffprobeOutput) {
        return [math]::Round([double]$ffprobeOutput)
    } else {
        throw "Could not determine the duration of the input video."
    }
}

function Start-Conversion {
    param (
        [string]$ffmpegCommand,
        [int]$currentFileIndex,
        [int]$totalFiles,
        [int]$previewDuration
    )
    # Extract the input file name from the ffmpeg command
    if ($ffmpegCommand -match '-i\s+"([^"]+)"') {
        $inputFile = $matches[1]
    } elseif ($ffmpegCommand -match "-i\s+(\S+)") {
        $inputFile = $matches[1]
    } else {
        throw "Could not extract input file from ffmpeg command."
    }

    $totalDuration = if ($ffmpegCommand -match "-t\s+10") { 10 } elseif ($previewDuration -gt 0) { $previewDuration } else { Get-VideoDuration -inputFile $inputFile }

    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = "cmd.exe"
    $processInfo.Arguments = "/c $ffmpegCommand"
    $processInfo.RedirectStandardOutput = $true
    $processInfo.RedirectStandardError = $true
    $processInfo.UseShellExecute = $false
    $processInfo.CreateNoWindow = $true

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $processInfo
    $process.Start() | Out-Null

    $totalProcessedTime = 0
    $startTime = Get-Date

    while (-not $process.HasExited) {
        $output = $process.StandardError.ReadLine()
        if ($output -match "time=(\d+:\d+:\d+.\d+)") {
            $currentTime = $matches[1]
            $currentSeconds = [TimeSpan]::Parse($currentTime).TotalSeconds
            $totalProcessedTime = ($currentFileIndex - 1) * $totalDuration + $currentSeconds
            $totalPercentComplete = [math]::Round(($totalProcessedTime / ($totalFiles * $totalDuration)) * 100)
            $elapsedTime = (Get-Date) - $startTime
            if ($totalProcessedTime -gt 0) {
                $estimatedTotalTime = [TimeSpan]::FromSeconds(($elapsedTime.TotalSeconds / $totalProcessedTime) * ($totalFiles * $totalDuration))
                $eta = $startTime.Add($estimatedTotalTime) - (Get-Date)
                $totalStatusText = "{1}/{2}     {3}%     {0}     ETA: {4}" -f [System.IO.Path]::GetFileName($inputFile), $currentFileIndex, $totalFiles, $totalPercentComplete, $eta.ToString("hh\:mm\:ss")
                
                # Ensure totalPercentComplete is a valid integer
                if ($totalPercentComplete -ge 0 -and $totalPercentComplete -le 100) {
                    Write-Progress -Activity "Overall progress" -Status $totalStatusText -PercentComplete $totalPercentComplete -Id 1
                }
            }
        }
    }

    $process.WaitForExit()
}

# Konfigurációs fájl elérési útja
$configFilePath = Join-Path $scriptRoot 'converter_config.json'

# Konfiguráció betöltése
function LoadConfig {
    if (Test-Path $configFilePath) {
        $config = Get-Content $configFilePath | ConvertFrom-Json
        $Converter_Form.open_outfolder.Checked = $config.open_outfolder
        if ($config.windowSize -and $config.windowPosition) {
            $Converter_Form.Size = New-Object System.Drawing.Size ($config.windowSize.Width, $config.windowSize.Height)
            $Converter_Form.Location = New-Object System.Drawing.Point ($config.windowPosition.X, $config.windowPosition.Y)
        }
    }
}

# Konfiguráció mentése
function SaveConfig {
    $config = @{
        open_outfolder = $Converter_Form.open_outfolder.Checked
        windowSize = @{
            Width = $Converter_Form.Size.Width
            Height = $Converter_Form.Size.Height
        }
        windowPosition = @{
            X = $Converter_Form.Location.X
            Y = $Converter_Form.Location.Y
        }
    }
    $config | ConvertTo-Json | Set-Content $configFilePath
}

# Function to add commands to the list and select the first item
function Add-CommandsToList {
    param (
        [string]$commands
    )
    $commands.Trim().Split("`n") | ForEach-Object {
        if ($_ -ne "") {
            $Converter_Form.ffmpegCommandList.Items.Add($_)
        }
    }
    $global:ffmpegCommands = ""
}

# Eseménykezelő hozzáadása a Video Convert gombhoz
$Converter_Form.video_convert.add_Click({
    # Beolvassuk és futtatjuk a fordaw.ps1 szkriptet
    $fordawScriptPath = Join-Path $scriptRoot 'fordaw.ps1'
    . $fordawScriptPath
    Add-CommandsToList -commands $global:ffmpegCommands
})

# Eseménykezelő hozzáadása a Video Convert gombhoz
$Converter_Form.prepare_27lufs.add_Click({
    # Beolvassuk és futtatjuk a fordaw.ps1 szkriptet
    $prepareScriptPath = Join-Path $scriptRoot 'prepare.ps1'
    . $prepareScriptPath
    Add-CommandsToList -commands $global:ffmpegCommands
})

# Eseménykezelő hozzáadása a Replace Audio gombhoz
$Converter_Form.replace_audio.add_Click({
    # Beolvassuk és futtatjuk a replace_audio.ps1 szkriptet egy külön ablakban
    $replaceAudioScriptPath = Join-Path $scriptRoot 'replace_audio.ps1'
    . $replaceAudioScriptPath
    Add-CommandsToList -commands $global:ffmpegCommands
})

# Eseménykezelő hozzáadása az ffmpeg gombhoz
$Converter_Form.ffmpeg_install.add_Click({
    # Beolvassuk és futtatjuk az install_ffmpeg.ps1 szkriptet
    $installFfmpegScriptPath = Join-Path $scriptRoot 'install_ffmpeg.ps1'
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$installFfmpegScriptPath`""
})

# Eseménykezelő hozzáadása a Start Conversion gombhoz
$Converter_Form.start_conversion.add_Click({
    $Converter_Form.Hide() # Hide the form while conversion is running
    $totalFiles = $Converter_Form.ffmpegCommandList.Items.Count
    $currentFileIndex = 0
    $outputFolder = $null

    foreach ($command in $Converter_Form.ffmpegCommandList.Items) {
        $currentFileIndex++
        $previewDuration = 0 # Define the preview duration if needed

        # Extract the input file name from the ffmpeg command
        if ($command -match '-i\s+"([^"]+)"') {
            $inputFile = $matches[1]
        } elseif ($command -match "-i\s+(\S+)") {
            $inputFile = $matches[1]
        } else {
            throw "Could not extract input file from ffmpeg command."
        }

        # Set the output folder based on the input file
        $outputFolder = Split-Path -Parent $inputFile

        Start-Conversion -ffmpegCommand $command -currentFileIndex $currentFileIndex -totalFiles $totalFiles -previewDuration $previewDuration
    }
    Write-Host "All conversions completed."
    # Remove the progress bar after all conversions are completed
    Write-Progress -Activity "Overall progress" -Status "Completed" -Completed -Id 1
    $Converter_Form.ffmpegCommandList.Items.Clear() # Clear the list after conversion
    $Converter_Form.Show() # Show the form again after conversion is finished

    # Open the output folder if the checkbox is checked
    if ($Converter_Form.open_outfolder.Checked -and $outputFolder) {
        $opening = $outputFolder
        Start-Process explorer.exe $opening
    }

    # Play success sound as a background task
    Start-Job -ScriptBlock {
        $successSoundPath = Join-Path $using:scriptRoot 'success.wav'
        [System.Media.SoundPlayer]::new($successSoundPath).PlaySync()
    }
})

# Eseménykezelő hozzáadása a ffmpegCommandList elemek törléséhez
$Converter_Form.ffmpegCommandList.add_KeyDown({
    param ($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Delete -or $e.KeyCode -eq [System.Windows.Forms.Keys]::Back) {
        $selectedIndices = @($Converter_Form.ffmpegCommandList.SelectedIndices)
        for ($i = $selectedIndices.Count - 1; $i -ge 0; $i--) {
            $Converter_Form.ffmpegCommandList.Items.RemoveAt($selectedIndices[$i])
        }
    }
})

# Drag and Drop eseménykezelők hozzáadása a ffmpegCommandList-hez
$Converter_Form.ffmpegCommandList.add_MouseDown({
    param ($sender, $e)
    if ($e.Button -eq [System.Windows.Forms.MouseButtons]::Left) {
        $selectedItem = $Converter_Form.ffmpegCommandList.SelectedItem
        if ($null -ne $selectedItem) {
            $Converter_Form.ffmpegCommandList.DoDragDrop($selectedItem, [System.Windows.Forms.DragDropEffects]::Move)
        }
    }
})

$Converter_Form.ffmpegCommandList.add_DragOver({
    param ($sender, $e)
    $e.Effect = [System.Windows.Forms.DragDropEffects]::Move
})

$Converter_Form.ffmpegCommandList.add_DragDrop({
    param ($sender, $e)
    $point = $Converter_Form.ffmpegCommandList.PointToClient([System.Drawing.Point]::new($e.X, $e.Y))
    $index = $Converter_Form.ffmpegCommandList.IndexFromPoint($point)
    if ($index -ge 0) {
        $item = $Converter_Form.ffmpegCommandList.SelectedItem
        $Converter_Form.ffmpegCommandList.Items.Remove($item)
        $Converter_Form.ffmpegCommandList.Items.Insert($index, $item)
        $Converter_Form.ffmpegCommandList.SelectedItem = $item
    }
})

# Drag and Drop engedélyezése
$Converter_Form.ffmpegCommandList.AllowDrop = $true

# Eseménykezelő hozzáadása a Converter_Form bezárásához
$Converter_Form.add_FormClosing({
    SaveConfig
    # Üzenet kiírása a konzolban
    Write-Host "The software is closing... Bye! :)"

    # Konzol ablak bezárása, amikor a főablak bezáródik
    [System.Environment]::Exit(0)
})

$Converter_Form.add_Load({
    LoadConfig
})

$Converter_Form.ShowDialog()
