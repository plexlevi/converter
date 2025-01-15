Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'fordaw.designer.ps1')

$fontPath = $PSScriptRoot + '\Tuffy-Regular.ttf' -replace '\\', '\\' -replace ':','\:'

$ffmpegBinary = "ffmpeg "
$ffprobeBinary = "ffprobe "
$hardwareAcceleration = "-hwaccel auto "
$videoCodec = "-c:v libx264 "
$pixelFormat = "-pix_fmt yuvj420p "
$presetOption = "-preset fast "
$profileOption = "-profile:v high "
$levelOption = "-level:v 4.1 "
$x264Params = "-x264-params keyint=12:min-keyint=1:ref=1:bframes=0:qcomp=0.8:aq-strength=0.5:dct-decimate=0:fast-pskip=0:deblock=-2,-2 "
$rescale = ""#-vf scale=-1:720 "

$filterComplexStart = "-filter_complex `"[0:v]"
$filterDrawtext = "drawtext=fontfile='$fontPath'"
$filterX = ":x=(w-text_w)/2"
$filterY = ":y=h-(2*text_h)"
$filterFontColor = ":fontcolor=0xeeeeeeff"
$filterFontSize = ":fontsize=h/25"
$filterBox = ":box=1"
$filterBoxColor = ":boxcolor=0x3333333f,"

$filterComplexTimecodeStart = "drawtext=fontfile='$fontPath'"
$filterTimecodeX = ":x=(w-text_w)/2"
$filterTimecodeY = ":y=h-(text_h+h/14*12.5)"
$filterTimecodeFontColor = ":fontcolor=0xeeeeeeff"
$filterTimecodeFontSize = ":fontsize=h/12"
$filterTimecodeBox = ":box=1:boxborderw=10"
$filterTimecodeBoxColor = ":boxcolor=0x3333333f"
$filterTimecodeOption = ":tc24hmax=1"
$filterComplexScale = ",scale=-1:720[out]`" "

$mapOption = "-map [out] "
$audioCodec = "-map 0:a? -c:a aac "
$audioRate = "-ar 48k "
$audioBitrate = "-b:a 256k "
$swsFlags = "-sws_flags bicubic "
$metadataOption = "-map_metadata 0 "
$movFlags = "-movflags use_metadata_tags "
$outputOverwrite = "-y "

# Function to get the framerate of the input video using ffprobe
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

# Function to check if the framerate is dropframe
function DropOrNot {
    param (
        $framerate
    )
    return ($framerate -eq "30000/1001" -or $framerate -eq "60000/1001")
}

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

# Function to get video information using ffprobe
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

# Add event handlers after initialization
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
        if ($fordaw_Form.fordaw_preview.Checked) {
            $durationOption = "-t 30 "
        } else {
            $durationOption = ""
        }
        $crfOption = "-crf $($fordaw_Form.fordaw_crf.Value) "
        $filterText = ":text='" + $videoname + "' "
        
        # Get the framerate of the input video
        $framerate = Get-VideoFramerate -inputFile $inputFile
        $filterR = ":r=$framerate "
        $filterTimecodeR = ":r=$framerate "
        
        # Determine the timecode separator based on dropframe
        if (DropOrNot -framerate $framerate) {
            $filterTimecode = ":timecode='00\:00\:00\;00' "
        } else {
            $filterTimecode = ":timecode='00\:00\:00\:00' "
        }
        
        $global:completeFfmpegCommand = $ffmpegBinary + $hardwareAcceleration + $inputOption + $durationOption + $videoCodec + $crfOption + $pixelFormat + $presetOption + $profileOption + $levelOption + $x264Params + $rescale + $filterComplexStart + $filterDrawtext + $filterText + $filterR + $filterX + $filterY + $filterFontColor + $filterFontSize + $filterBox + $filterBoxColor + $filterComplexTimecodeStart + $filterTimecode + $filterTimecodeR + $filterTimecodeX + $filterTimecodeY + $filterTimecodeFontColor + $filterTimecodeFontSize + $filterTimecodeBox + $filterTimecodeBoxColor + $filterTimecodeOption + $filterComplexScale + $mapOption + $audioCodec + $audioRate + $audioBitrate + $swsFlags + $vsyncOption + $metadataOption + $videoMetadata + $audioMetadata + $movFlags + $outputOverwrite + "`"" + $outputFile + "`""
        
        # Pass the command back to converter.ps1 using a global variable
        $global:ffmpegCommands += $global:completeFfmpegCommand + "`n"
    }
    
    $fordaw_Form.Close()
})

# Remove the form closing event handler to prevent the form from closing
$fordaw_Form.add_FormClosing({
    $Converter_Form.Show()
})

# Show the PowerShell window
$fordaw_Form.ShowDialog()