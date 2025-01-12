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

# Add event handlers after initialization
$fordaw_Form.fordaw_crf.add_Scroll({
    $fordaw_Form.fordaw_crf_current.Text = $fordaw_Form.fordaw_crf.Value.ToString()
})

$fordaw_Form.fordaw_open.add_Click({
    $OpenFileDialog1.Filter = "Video Files|*.mp4;*.avi;*.mov;*.mkv"
    $OpenFileDialog1.Multiselect = $true
    if ($OpenFileDialog1.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $fordaw_Form.fordaw_fileList.Items.Clear()
        $OpenFileDialog1.FileNames | ForEach-Object { $fordaw_Form.fordaw_fileList.Items.Add($_) }
    }
})

$fordaw_Form.fordaw_start.add_Click({
    if ($fordaw_Form.fordaw_fileList.Items.Count -eq 0) {
        Write-Host "No files selected for conversion."
        return
    }
    $jobs = @()
    foreach ($file in $fordaw_Form.fordaw_fileList.Items) {
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
        
        $job = Start-Job -ScriptBlock {
            param ($command)
            Invoke-Expression $command
        } -ArgumentList $global:completeFfmpegCommand
        $jobs += $job
        Write-Host "Started conversion for: $outputFile"
    }
    
    # Wait for all jobs to complete
    $jobs | ForEach-Object { $_ | Wait-Job }
    
    Write-Host "All conversions completed."
    [System.Windows.Forms.MessageBox]::Show("All conversions completed.", "Conversion Finished", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

# Remove the form closing event handler to prevent the form from closing
$fordaw_Form.add_FormClosing({
    $Converter_Form.Show()
})

# Show the PowerShell window
$fordaw_Form.ShowDialog()