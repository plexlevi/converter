$OpenFileDialog1_FileOk = {
}
$prepare_addToCue_Click = {
}
Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'prepare.designer.ps1')

# FFmpeg és FFprobe binárisok
$ffmpegBinary = "ffmpeg "
$ffprobeBinary = "ffprobe "

# Konfigurációs fájl elérési útja
$configFilePath = Join-Path $PSScriptRoot 'prepare_config.json'

# Konfiguráció betöltése
function LoadConfig {
    if (Test-Path $configFilePath) {
        $config = Get-Content $configFilePath | ConvertFrom-Json
        $prepare_Form.prepare_mixdown.Checked = $config.prepare_mixdown
        $prepare_Form.prepare_mixdown_v.SelectedIndex = $config.prepare_mixdown_v
        $prepare_Form.prepare_lufs.SelectedIndex = $config.prepare_lufs
        $prepare_Form.prepare_tp.SelectedIndex = $config.prepare_tp
        $prepare_Form.prepare_normalize.Checked = $config.prepare_normalize
        $prepare_Form.prepare_resample.Checked = $config.prepare_resample
        $prepare_Form.prepare_sr.SelectedIndex = $config.prepare_sr
        $prepare_Form.prepare_rebit.Checked = $config.prepare_rebit
        $prepare_Form.prepare_bd.SelectedIndex = $config.prepare_bd
        $prepare_Form.prepare_prefix.Text = $config.prepare_prefix
        if ($config.windowSize -and $config.windowPosition) {
            $prepare_Form.Size = New-Object System.Drawing.Size ($config.windowSize.Width, $config.windowSize.Height)
            $prepare_Form.Location = New-Object System.Drawing.Point ($config.windowPosition.X, $config.windowPosition.Y)
        }
    }
}

# Konfiguráció mentése
function SaveConfig {
    $config = @{
        prepare_mixdown = $prepare_Form.prepare_mixdown.Checked
        prepare_mixdown_v = $prepare_Form.prepare_mixdown_v.SelectedIndex
        prepare_lufs = $prepare_Form.prepare_lufs.SelectedIndex
        prepare_tp = $prepare_Form.prepare_tp.SelectedIndex
        prepare_normalize = $prepare_Form.prepare_normalize.Checked
        prepare_resample = $prepare_Form.prepare_resample.Checked
        prepare_sr = $prepare_Form.prepare_sr.SelectedIndex
        prepare_rebit = $prepare_Form.prepare_rebit.Checked
        prepare_bd = $prepare_Form.prepare_bd.SelectedIndex
        prepare_prefix = $prepare_Form.prepare_prefix.Text
        windowSize = @{
            Width = $prepare_Form.Size.Width
            Height = $prepare_Form.Size.Height
        }
        windowPosition = @{
            X = $prepare_Form.Location.X
            Y = $prepare_Form.Location.Y
        }
    }
    $config | ConvertTo-Json | Set-Content $configFilePath
}

# Változók inicializálása és ellenőrzések
function InitializeVariables {
    $global:outputOverwrite = "-y "
    if ($prepare_Form.prepare_mixdown.Checked -eq $true) {
        if ($prepare_Form.prepare_mixdown_v.Text -eq "stereo") {
            $global:outputChannels = "-ac 2 "
        } elseif ($prepare_Form.prepare_mixdown_v.Text -eq "mono") {
            $global:outputChannels = "-ac 1 "
        } else {
            $global:outputChannels = ""
        }
    } else {
        $global:outputChannels = ""
    }
    
    $lufs = $prepare_Form.prepare_lufs.Text.ToString()
    $tp = $prepare_Form.prepare_tp.Text.ToString()
    if ($prepare_Form.prepare_normalize.Checked -eq $true) {
        $global:loudness = "-af loudnorm=I=" + $lufs + ":LRA=8:TP=" + $tp + ":linear=true "
    } else {
        $global:loudness = ""
    }
    
    if ($prepare_Form.prepare_resample.Checked -eq $true) {
        $global:outputSampleRate = "-ar " + $prepare_Form.prepare_sr.Text.ToString() + " "
    } else {
        $global:outputSampleRate = "-ar 48000 "
    }

    if ($prepare_Form.prepare_rebit.Checked -eq $true) {
        if ($prepare_Form.prepare_bd.Text -eq "16 bit") {
            $global:outputBitDepth = "-c:a pcm_s16le "
        } elseif ($prepare_Form.prepare_bd.Text -eq "24 bit") {
            $global:outputBitDepth = "-c:a pcm_s24le "
        } elseif ($prepare_Form.prepare_bd.Text -eq "32 bit") {
            $global:outputBitDepth = "-c:a pcm_s32le "
        } else {
            $global:outputBitDepth = "-c:a pcm_s24le "
        }
    } else {
        $global:outputBitDepth = "-c:a pcm_s24le "
    }
    
    $global:outputFormat = "-rf64 auto "
}

function CheckClicked {
    if ($prepare_Form.prepare_normalize.Checked -eq $false) {
        $prepare_Form.Label2.ForeColor = 'Gray'
        $prepare_Form.Label3.ForeColor = 'Gray'
        $prepare_Form.prepare_lufs.Enabled = $false
        $prepare_Form.prepare_tp.Enabled = $false
    } else {
        $prepare_Form.Label2.ForeColor = 'Black'
        $prepare_Form.Label3.ForeColor = 'Black'
        $prepare_Form.prepare_lufs.Enabled = $true
        $prepare_Form.prepare_tp.Enabled = $true
    }
    
    if ($prepare_Form.prepare_mixdown.Checked -eq $false) {
        $prepare_Form.prepare_mixdown_v.Enabled = $false
    } else {
        $prepare_Form.prepare_mixdown_v.Enabled = $true
    }

    if ($prepare_Form.prepare_resample.Checked -eq $false) {
        $prepare_Form.prepare_sr.Enabled = $false
    } else {
        $prepare_Form.prepare_sr.Enabled = $true
    }

    if ($prepare_Form.prepare_rebit.Checked -eq $false) {
        $prepare_Form.prepare_bd.Enabled = $false
    } else {
        $prepare_Form.prepare_bd.Enabled = $true
    }
}

$prepare_Form.add_Load({
    LoadConfig
    CheckClicked
    # Ensure the form is within screen bounds
    if ($prepare_Form.Location.X -lt 0 -or $prepare_Form.Location.Y -lt 0) {
        $prepare_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterParent
    }
})

$prepare_Form.prepare_normalize.add_CheckedChanged({
    CheckClicked        
})
$prepare_Form.prepare_mixdown.add_CheckedChanged({
    CheckClicked        
})

$prepare_Form.prepare_resample.add_CheckedChanged({
    CheckClicked        
})
$prepare_Form.prepare_rebit.add_CheckedChanged({
    CheckClicked        
})

function Get-AudioInfo {
    param (
        [string]$inputFile
    )
    $ffprobeOutput = & $ffprobeBinary -v quiet -print_format json -show_format -show_streams $inputFile
    if ($ffprobeOutput) {
        $audioInfo = $ffprobeOutput | ConvertFrom-Json
        $audioInfo.format.duration = [TimeSpan]::FromSeconds([double]$audioInfo.format.duration).ToString("hh\:mm\:ss")
        if ($audioInfo.streams[0].bit_rate) {
            $audioInfo.streams[0].bit_rate = [math]::Round([double]$audioInfo.streams[1].bit_rate / 1000, 2)
        }
        $audioInfo.format.bit_rate = [math]::Round([double]$audioInfo.format.bit_rate / 1000, 2)
        $audioInfo.format.size = [math]::Round([double]$audioInfo.format.size / (1024 * 1024), 2)
        return $audioInfo
    } else {
        throw "Could not retrieve audio information."
    }
}

# Támogatott kiterjesztések listája
$supportedExtensions = @(".mp3", ".wav", ".flac", ".aac", ".ogg", ".wma", ".m4a", ".mp4", ".avi", ".mov", ".mkv", ".flv", ".wmv", ".webm", ".m4v", ".3gp", ".3g2", ".mts", ".m2ts", ".ts", ".mxf", ".vob", ".ogv", ".divx", ".xvid", ".rm", ".rmvb", ".asf", ".amv", ".mpg", ".mpeg", ".mpe", ".mpv", ".m2v", ".svi", ".f4v", ".f4p", ".f4a", ".f4b")

# Fájl hozzáadása a listához és információk kiírása
function AddFileToList {
    param (
        [string]$file
    )
    $prepare_Form.prepare_fileList.Items.Add($file)
    $audioInfo = Get-AudioInfo -inputFile $file

    Set-ConsoleColor -r 63 -g 181 -b 224 -type "Foreground"

    Write-Host "$file"
    Write-Host "Duration:       $($audioInfo.format.duration)"
    Write-Host "File Size:      $($audioInfo.format.size) MB"
    Write-Host "Format:         $($audioInfo.format.format_long_name)"
    Write-Host "Audio Codec:    $($audioInfo.streams[0].codec_long_name)"
    Write-Host "Sample Rate:    $($audioInfo.streams[0].sample_rate) KHz"
    Write-Host "Channel Layout: $($audioInfo.streams[0].channel_layout), $($audioInfo.streams[0].channels) channels"
    Write-Host "Bit Rate:       $($audioInfo.format.bit_rate) kb/s"
    Write-Host "Language:       $($audioInfo.streams[0].tags.language)"
    Write-Host "Title:          $($audioInfo.streams[0].tags.title)"
    Write-Host "Album:          $($audioInfo.streams[0].tags.album)"
    Write-Host "Artist:         $($audioInfo.streams[0].tags.artist)"
    Write-Host "Genre:          $($audioInfo.streams[0].tags.genre)"
    Write-Host "Track:          $($audioInfo.streams[0].tags.track)"
    Write-Host "Date:           $($audioInfo.streams[0].tags.date)"
    Write-Host ""
    Write-Host ""

    [System.Console]::ResetColor()
}

# Fájl megnyitása gomb eseménykezelője
$prepare_Form.prepare_open.add_Click({
    $OpenFileDialog2.Filter = "Audio and Video Files|*.mp3;*.wav;*.flac;*.aac;*.ogg;*.wma;*.m4a;*.mp4;*.avi;*.mov;*.mkv;*.flv;*.wmv;*.webm;*.m4v;*.3gp;*.3g2;*.mts;*.m2ts;*.ts;*.mxf;*.vob;*.ogv;*.divx;*.xvid;*.rm;*.rmvb;*.asf;*.amv;*.mpg;*.mpeg;*.mpe;*.mpv;*.m2v;*.svi;*.f4v;*.f4p;*.f4a;*.f4b"
    $OpenFileDialog2.Multiselect = $true
    if ($OpenFileDialog2.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $OpenFileDialog2.FileNames | ForEach-Object { 
            AddFileToList -file $_
        }
    }
})

# Eseménykezelő hozzáadása a prepare_fileList elemek törléséhez
$prepare_Form.prepare_fileList.add_KeyDown({
    param ($sender, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Delete -or $e.KeyCode -eq [System.Windows.Forms.Keys]::Back) {
        $selectedIndices = @($prepare_Form.prepare_fileList.SelectedIndices)
        for ($i = $selectedIndices.Count - 1; $i -ge 0; $i--) {
            $prepare_Form.prepare_fileList.Items.RemoveAt($selectedIndices[$i])
        }
    }
})

# Drag and Drop eseménykezelők hozzáadása
$prepare_Form.prepare_fileList.add_DragEnter({
    param ($sender, $e)
    if ($e.Data.GetDataPresent([System.Windows.Forms.DataFormats]::FileDrop)) {
        $e.Effect = [System.Windows.Forms.DragDropEffects]::Copy
    } else {
        $e.Effect = [System.Windows.Forms.DragDropEffects]::None
    }
})

$prepare_Form.prepare_fileList.add_DragDrop({
    param ($sender, $e)
    $files = $e.Data.GetData([System.Windows.Forms.DataFormats]::FileDrop)
    foreach ($file in $files) {
        $extension = [System.IO.Path]::GetExtension($file).ToLower()
        if ($extension -in $supportedExtensions) {
            AddFileToList -file $file
        }
    }
})

# Drag and Drop engedélyezése
$prepare_Form.prepare_fileList.AllowDrop = $true

# Fájlok listájának törlése gomb eseménykezelője
$prepare_Form.delete_list.add_Click({
    $prepare_Form.prepare_fileList.Items.Clear()
})

# Fájl hozzáadása a várólistához gomb eseménykezelője
$prepare_Form.prepare_addToCue.add_Click({
    if ($prepare_Form.prepare_fileList.Items.Count -eq 0) {
        Write-Host "No files selected for conversion."
        return
    }
    
    $currentFileIndex = 0
    foreach ($file in $prepare_Form.prepare_fileList.Items) {
        $currentFileIndex++
        $inputFile = $file
        $outputDir = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($inputFile), "Audio Files")

        if (-not (Test-Path -Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir | Out-Null
        }

        if ($prepare_Form.prepare_prefix.Text -ne "") {
            $prefix = $prepare_Form.prepare_prefix.Text.ToString().ToUpper() + "_"
        } else {
            $prefix = ""
        }

        $name = [System.IO.Path]::GetFileNameWithoutExtension($inputFile) + ".wav"
        $outname = $prefix + $name
        
        $outputFile = [System.IO.Path]::Combine($outputDir, $outname)
        $inputOption = "-i `"$inputFile`" "
        
        InitializeVariables

        $global:completeFfmpegCommand = $ffmpegBinary + $global:outputOverwrite + $inputOption + $global:outputChannels + $global:loudness + $global:outputSampleRate + $global:outputBitDepth + $global:outputFormat + "`"" + $outputFile + "`""
        
        # Parancs visszaadása a converter.ps1-nek egy globális változó segítségével
        $global:ffmpegCommands += $global:completeFfmpegCommand + "`n"
        Write-Host $global:ffmpegCommands
    }
    $Converter_Form.Show()
})

# Eseménykezelő eltávolítása a form bezárásához, hogy ne záródjon be a form
$prepare_Form.add_FormClosing({
    SaveConfig
})

# Konfiguráció törlése és form újratöltése
$prepare_Form.restore_defaults.add_Click({
    if (Test-Path $configFilePath) {
        Remove-Item $configFilePath
    }
    $prepare_Form.prepare_mixdown.Checked = $false
    $prepare_Form.prepare_mixdown_v.SelectedIndex = 0
    $prepare_Form.prepare_lufs.SelectedIndex = 11
    $prepare_Form.prepare_tp.SelectedIndex = 1
    $prepare_Form.prepare_normalize.Checked = $false
    $prepare_Form.prepare_resample.Checked = $false
    $prepare_Form.prepare_sr.SelectedIndex = 1
    $prepare_Form.prepare_rebit.Checked = $false
    $prepare_Form.prepare_bd.SelectedIndex = 1
    $prepare_Form.prepare_prefix.Text = ""
    $prepare_Form.Size = New-Object System.Drawing.Size 590, 400
    CheckClicked
    $prepare_Form.Refresh()
    # Az ablak középre helyezése
    $prepare_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
})

# PowerShell ablak megjelenítése
$prepare_Form.ShowDialog()