Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'fordaw.designer.ps1')

# Betűtípus elérési útvonal beállítása
$fontPath = $PSScriptRoot + '\Tuffy-Regular.ttf' -replace '\\', '\\' -replace ':','\:'

# FFmpeg és FFprobe binárisok
$ffmpegBinary = "ffmpeg "
$ffprobeBinary = "ffprobe "

# Változók inicializálása és ellenőrzések
function InitializeVariables {
    $global:hardwareAcceleration = "-hwaccel auto "
    $global:videoCodec = "-c:v libx264 "
    $global:pixelFormat = "-pix_fmt yuv420p "
    
    if ($fordaw_Form.fordaw_webquality.Checked) {
        $global:presetOption = ""
        $global:profileOption = "-profile:v high "
        $global:levelOption = "-level:v 3.2 "
        $global:x264Params = "-x264-params keyint=30:min-keyint=15:ref=1:bframes=2:b-pyramid=none "
    } else {
        $global:presetOption = "-preset fast "
        $global:profileOption = "-profile:v high "
        $global:levelOption = "-level:v 4.1 "
        $global:x264Params = "-x264-params keyint=12:min-keyint=1:ref=1:bframes=0:qcomp=0.8:aq-strength=0.5:dct-decimate=0:fast-pskip=0:deblock=-2,-2 "
    }

    if ($fordaw_Form.fordaw_preview.Checked) {
        $global:durationOption = "-t 10 "
    } else {
        $global:durationOption = ""
    }

    $global:filterComplexStart = "-filter_complex `"[0:v]"

    if ($fordaw_Form.timecodeburnin.Checked) {
        $global:filterDrawtext = "drawtext=fontfile='$fontPath'"
        $global:filterX = ":x=(w-text_w)/2"
        $global:filterY = ":y=h-(2*text_h)"
        $global:filterFontColor = ":fontcolor=0xeeeeeeff"
        $global:filterFontSize = ":fontsize=h/25"
        $global:filterBox = ":box=1:boxborderw=5"
        $global:filterComplexTimecodeStart = "drawtext=fontfile='$fontPath'"
        $global:filterTimecodeX = ":x=(w-text_w)/2"
        $global:filterTimecodeY = ":y=h-(text_h+h/14*12.5)"
        $global:filterTimecodeFontColor = ":fontcolor=0xeeeeeeff"
        $global:filterTimecodeFontSize = ":fontsize=h/12"
        $global:filterTimecodeBox = ":box=1:boxborderw=10"
        $global:filterTimecodeOption = ":tc24hmax=1,"
        $global:filterTimecode = if (DropOrNot -framerate $framerate) {
            ":timecode='00\:00\:00\;00'"
        } else {
            ":timecode='00\:00\:00\:00'"
        }
    
        if ($fordaw_Form.timecodeburnin.Checked -and $fordaw_Form.fordaw_blackbg.Checked) {
            $global:filterTimecodeBoxColor = ":boxcolor=0x323232ff"
            $global:filterBoxColor = ":boxcolor=0x323232ff,"
        } else {
            $global:filterTimecodeBoxColor = ":boxcolor=0x3333333f"
            $global:filterBoxColor = ":boxcolor=0x3333333f,"
        }
    } else {
        $global:filterDrawtext = ""
        $global:filterX = ""
        $global:filterY = ""
        $global:filterFontColor = ""
        $global:filterFontSize = ""
        $global:filterBox = ""
        $global:filterComplexTimecodeStart = ""
        $global:filterTimecodeX = ""
        $global:filterTimecodeY = ""
        $global:filterTimecodeFontColor = ""
        $global:filterTimecodeFontSize = ""
        $global:filterTimecodeBox = ""
        $global:filterTimecodeOption = ""
        $global:filterBoxColor = ""
        $global:filterTimecodeBoxColor = ""
        $global:filterTimecode = ""
    }
    $global:filterComplexScale = "scale=w=1280:h=720:force_original_aspect_ratio=decrease,pad=1280:720:(ow-iw)/2:(oh-ih)/2,scale=in_range=full:out_range=limited[out]`" "
    $global:mapOption = "-map [out] "
    $global:audioCodec = "-map 0:a? -c:a aac "
    if ($fordaw_Form.fordaw_webquality.Checked) {
        $global:audioRate = "-ac 2 -ar 44100 "
        $global:audioBitrate = "-b:a 128k "
    } else {
        $global:audioRate = "-ar 48k "
        $global:audioBitrate = "-b:a 256k "
    }
    $global:outputOverwrite = "-y "
}

# Funkció a videó framerate-jének lekérésére ffprobe segítségével
function Get-VideoFramerate {
    param (
        [string]$inputFile
    )
    $ffprobeOutput = & $ffprobeBinary -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 $inputFile
    if ($ffprobeOutput) {
        $frameRate = $ffprobeOutput
        return $frameRate
    } else {
        throw "Could not determine the framerate of the input video."
    }
}

# Funkció a dropframe ellenőrzésére
function DropOrNot {
    param (
        $framerate
    )
    return ($framerate -eq "30000/1001" -or $framerate -eq "60000/1001")
}

# Funkció a videó hosszának lekérésére ffprobe segítségével
function Get-VideoDuration {
    param (
        [string]$inputFile
    )
    $ffprobeOutput = & $ffprobeBinary -v error -select_streams v:0 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $inputFile
    if ($ffprobeOutput) {
        return [math]::Round([double]$ffprobeOutput)
    } else {
        throw "Could not determine the duration of the input video."
    }
}

# Funkció a videó információinak lekérésére ffprobe segítségével
function Get-VideoInfo {
    param (
        [string]$inputFile
    )
    $ffprobeOutput = & $ffprobeBinary -v quiet -print_format json -show_format -show_streams $inputFile
    if ($ffprobeOutput) {
        $videoInfo = $ffprobeOutput | ConvertFrom-Json
        $videoInfo.format.duration = [TimeSpan]::FromSeconds([double]$videoInfo.format.duration).ToString("hh\:mm\:ss")
        if ($videoInfo.streams[1].bit_rate) {
            $videoInfo.streams[1].bit_rate = [math]::Round([double]$videoInfo.streams[1].bit_rate / 1000, 2)
        }
        $videoInfo.format.bit_rate = [math]::Round([double]$videoInfo.format.bit_rate / 1000, 2)
        $videoInfo.format.size = [math]::Round([double]$videoInfo.format.size / (1024 * 1024), 2)
        return $videoInfo
    } else {
        throw "Could not retrieve video information."
    }
}

# Eseménykezelők hozzáadása inicializálás után
$fordaw_Form.add_Load({
    $fordaw_Form.fordaw_open.PerformClick()
    UpdateControlsState
})

$fordaw_Form.fordaw_crf.add_Scroll({
    $fordaw_Form.fordaw_crf_current.Text = $fordaw_Form.fordaw_crf.Value.ToString()
})

$fordaw_Form.fordaw_webquality.add_CheckedChanged({
    if ($fordaw_Form.fordaw_webquality.Checked) {
        $fordaw_Form.fordaw_h264.Checked = $true
    }
    UpdateControlsState
})

$fordaw_Form.timecodeburnin.add_CheckedChanged({
    UpdateControlsState
})

$fordaw_Form.fordaw_dnxhd.add_CheckedChanged({
    UpdateControlsState
})

# Funkció a vezérlők állapotának frissítésére
function UpdateControlsState {
    if ($fordaw_Form.fordaw_webquality.Checked) {
        $fordaw_Form.fordaw_dnxhd.Enabled = $false
    } else {
        $fordaw_Form.fordaw_dnxhd.Enabled = $true
    }

    if (-not $fordaw_Form.timecodeburnin.Checked) {
        $fordaw_Form.fordaw_blackbg.Enabled = $false
    } else {
        $fordaw_Form.fordaw_blackbg.Enabled = $true
    }

    if ($fordaw_Form.fordaw_dnxhd.Checked) {
        $fordaw_Form.fordaw_crf.Enabled = $false
        $fordaw_Form.fordaw_Label1.ForeColor = [System.Drawing.Color]::DarkGray
        $fordaw_Form.fordaw_crf_current.ForeColor = [System.Drawing.Color]::DarkGray
        $fordaw_Form.fordaw_Label2.ForeColor = [System.Drawing.Color]::DarkGray
        $fordaw_Form.fordaw_Label3.ForeColor = [System.Drawing.Color]::DarkGray
        $fordaw_Form.fordaw_Label4.ForeColor = [System.Drawing.Color]::DarkGray
    } else {
        $fordaw_Form.fordaw_crf.Enabled = $true
        $fordaw_Form.fordaw_Label1.ForeColor = [System.Drawing.Color]::Black
        $fordaw_Form.fordaw_crf_current.ForeColor = [System.Drawing.Color]::Black
        $fordaw_Form.fordaw_Label2.ForeColor = [System.Drawing.Color]::Black
        $fordaw_Form.fordaw_Label3.ForeColor = [System.Drawing.Color]::Black
        $fordaw_Form.fordaw_Label4.ForeColor = [System.Drawing.Color]::Black
    }
}

# Fájl megnyitása gomb eseménykezelője
$fordaw_Form.fordaw_open.add_Click({
    $OpenFileDialog1.Filter = "Video Files|*.mp4;*.avi;*.mov;*.mkv;*.flv;*.wmv;*.webm;*.m4v;*.3gp;*.3g2;*.mts;*.m2ts;*.ts;*.mxf;*.vob;*.ogv;*.divx;*.xvid;*.rm;*.rmvb;*.asf;*.amv;*.mpg;*.mpeg;*.mpe;*.mpv;*.m2v;*.svi;*.mkv;*.f4v;*.f4p;*.f4a;*.f4b"
    $OpenFileDialog1.Multiselect = $true
    if ($OpenFileDialog1.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $fordaw_Form.fordaw_fileList.Items.Clear()
        $OpenFileDialog1.FileNames | ForEach-Object { 
            $fordaw_Form.fordaw_fileList.Items.Add($_)
            $videoInfo = Get-VideoInfo -inputFile $_

            Set-ConsoleColor -r 63 -g 181 -b 224 -type "Foreground"

            $frameRate = $videoInfo.streams[0].avg_frame_rate
            if ($frameRate -match "(\d+)/(\d+)") {
                $numerator = [double]$matches[1]
                $denominator = [double]$matches[2]
                $frameRateValue = $numerator / $denominator
                if ($frameRateValue -eq [math]::Round($frameRateValue)) {
                    $frameRateDisplay = [math]::Round($frameRateValue)
                } else {
                    $frameRateDisplay = "{0:N2}" -f $frameRateValue -replace ',', '.'
                }
            } else {
                $frameRateDisplay = $frameRate
            }

            Write-Host "$_"
            Write-Host "Codec:          $($videoInfo.streams[0].codec_long_name)"
            Write-Host "Profile:        $($videoInfo.streams[0].profile)"
            Write-Host "Level:          $($videoInfo.streams[0].level)"
            Write-Host "Resolution:     $($videoInfo.streams[0].width) x $($videoInfo.streams[0].height) - $($videoInfo.streams[0].field_order)"
            Write-Host "Frame Rate:     $frameRateDisplay fps"
            Write-Host "Aspect Ratio:   $($videoInfo.streams[0].display_aspect_ratio)"
            Write-Host "Pixel Format:   $($videoInfo.streams[0].pix_fmt)"
            Write-Host "Color Space:    $($videoInfo.streams[0].color_space)"
            Write-Host "Keyframes:      $($videoInfo.streams[0].refs)"
            Write-Host "B-frames:       $($videoInfo.streams[0].has_b_frames)"
            if ($videoInfo.streams[1]) {
                Write-Host "Audio Codec:    $($videoInfo.streams[1].codec_long_name)"
                Write-Host "Sample Rate:    $($videoInfo.streams[1].sample_rate) KHz"
                Write-Host "Channel Layout: $($videoInfo.streams[1].channel_layout), $($videoInfo.streams[1].channels) channels"
                if ($videoInfo.streams[1].bit_rate) {
                    Write-Host "Audio Bit Rate: $($videoInfo.streams[1].bit_rate) kb/s"
                }
            }
            Write-Host "Format:         $($videoInfo.format.format_long_name)"
            Write-Host "Duration:       $($videoInfo.format.duration)"
            Write-Host "File Size:      $($videoInfo.format.size) MB"
            Write-Host "Bit Rate:       $($videoInfo.format.bit_rate) kb/s"
            Write-Host ""
            Write-Host ""

            [System.Console]::ResetColor()
        }
    }
})

# Fájl hozzáadása a várólistához gomb eseménykezelője
$fordaw_Form.fordaw_addToCue.add_Click({
    if ($fordaw_Form.fordaw_fileList.Items.Count -eq 0) {
        Write-Host "No files selected for conversion."
        return
    }
    
    $currentFileIndex = 0
    foreach ($file in $fordaw_Form.fordaw_fileList.Items) {
        $currentFileIndex++
        $inputFile = $file
        $outputDir = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($inputFile), "Video Files")
        if (-not (Test-Path -Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir | Out-Null
        }
        $outputFile = [System.IO.Path]::Combine($outputDir, [System.IO.Path]::GetFileNameWithoutExtension($inputFile) + ".mp4")
        $videoname = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
        $inputOption = "-i `"$inputFile`" "
        $crfOption = "-crf $($fordaw_Form.fordaw_crf.Value) "
        
        if ($fordaw_Form.timecodeburnin.Checked) {
            $filterText = ":text='" + $videoname + "'"
        
            # Framerate lekérése a bemeneti videóból
            $framerate = Get-VideoFramerate -inputFile $inputFile
            $filterR = ":r=$framerate"
            $filterTimecodeR = ":r=$framerate"
        }
        
        InitializeVariables

        $global:completeFfmpegCommand = $ffmpegBinary + $global:hardwareAcceleration + $inputOption + $global:durationOption + $global:videoCodec + $crfOption + $global:pixelFormat + $global:presetOption + $global:profileOption + $global:levelOption + $global:x264Params + $global:filterComplexStart + $global:filterDrawtext + $filterText + $filterR + $global:filterX + $global:filterY + $global:filterFontColor + $global:filterFontSize + $global:filterBox + $global:filterBoxColor + $global:filterComplexTimecodeStart + $global:filterTimecode + $filterTimecodeR + $global:filterTimecodeX + $global:filterTimecodeY + $global:filterTimecodeFontColor + $global:filterTimecodeFontSize + $global:filterTimecodeBox + $global:filterTimecodeBoxColor + $global:filterTimecodeOption + $global:filterComplexScale + $mapOption + $audioCodec + $audioRate + $audioBitrate + $outputOverwrite + "`"" + $outputFile + "`""
        
        # Parancs visszaadása a converter.ps1-nek egy globális változó segítségével
        $global:ffmpegCommands += $global:completeFfmpegCommand + "`n"
        Write-Host $global:ffmpegCommands
    }
    
    $fordaw_Form.Close()
})

# Eseménykezelő eltávolítása a form bezárásához, hogy ne záródjon be a form
$fordaw_Form.add_FormClosing({
    $Converter_Form.Show()
})

# PowerShell ablak megjelenítése
$fordaw_Form.ShowDialog()