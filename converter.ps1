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
 _____     __          __   _____                          _            
|  __ \   /\ \        / /  / ____|                        | |           
| |  | | /  \ \  /\  / /  | |     ___  _ ____   _____ _ __| |_ ___ _ __ 
| |  | |/ /\ \ \/  \/ /   | |    / _ \| '_ \ \ / / _ \ '__| __/ _ \ '__|
| |__| / ____ \  /\  /    | |___| (_) | | | \ V /  __/ |  | ||  __/ |   
|_____/_/    \_\/  \/      \_____\___/|_| |_|\_/ \___|_|   \__\___|_|   
"@
Write-Host ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("---------------------Created By Levente Géczy (2025)--------------------")))
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

    $totalDuration = if ($ffmpegCommand -match "-t\s+30") { 30 } elseif ($previewDuration -gt 0) { $previewDuration } else { Get-VideoDuration -inputFile $inputFile }

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
            $estimatedTotalTime = [TimeSpan]::FromSeconds(($elapsedTime.TotalSeconds / $totalProcessedTime) * ($totalFiles * $totalDuration))
            $eta = $startTime.Add($estimatedTotalTime) - (Get-Date)
            $totalStatusText = "{1}/{2}     {0}     {3}%     ETA: {4}" -f [System.IO.Path]::GetFileName($inputFile), $currentFileIndex, $totalFiles, $totalPercentComplete, $eta.ToString("hh\:mm\:ss")
            
            # Ensure totalPercentComplete is a valid integer
            if ($totalPercentComplete -ge 0 -and $totalPercentComplete -le 100) {
                Write-Progress -Activity "Overall progress" -Status $totalStatusText -PercentComplete $totalPercentComplete -Id 1
            }
        }
    }

    $process.WaitForExit()
}

# Eseménykezelő hozzáadása a Video Convert gombhoz
$Converter_Form.video_convert.add_Click({
    # Beolvassuk és futtatjuk a fordaw.ps1 szkriptet
    $fordawScriptPath = Join-Path $scriptRoot 'fordaw.ps1'
    $Converter_Form.Hide()
    . $fordawScriptPath
    $Converter_Form.Show()

    # Add the commands to the list box
    $global:ffmpegCommands.Trim().Split("`n") | ForEach-Object {
        $Converter_Form.ffmpegCommandList.Items.Add($_)
    }
    $global:ffmpegCommands = ""
})

# Eseménykezelő hozzáadása a Start Conversion gombhoz
$Converter_Form.start_conversion.add_Click({
    $Converter_Form.Hide() # Hide the form while conversion is running
    $totalFiles = $Converter_Form.ffmpegCommandList.Items.Count
    $currentFileIndex = 0
    foreach ($command in $Converter_Form.ffmpegCommandList.Items) {
        $currentFileIndex++
        $previewDuration = 0 # Define the preview duration if needed
        Start-Conversion -ffmpegCommand $command -currentFileIndex $currentFileIndex -totalFiles $totalFiles -previewDuration $previewDuration
    }
    Write-Host "All conversions completed."
    # Remove the progress bar after all conversions are completed
    Write-Progress -Activity "Overall progress" -Status "Completed" -Completed -Id 1
    $Converter_Form.ffmpegCommandList.Items.Clear() # Clear the list after conversion
    $Converter_Form.Show() # Show the form again after conversion is finished

    # Play success sound as a background task
    Start-Job -ScriptBlock {
        $successSoundPath = Join-Path $using:scriptRoot 'success.wav'
        [System.Media.SoundPlayer]::new($successSoundPath).PlaySync()
    }
})

# Eseménykezelő hozzáadása a Converter_Form bezárásához
$Converter_Form.add_FormClosing({
    # Üzenet kiírása a konzolban
    Write-Host "The software is closing... Bye! :)"

    # Konzol ablak bezárása, amikor a főablak bezáródik
    [System.Environment]::Exit(0)
})

$Converter_Form.ShowDialog()
