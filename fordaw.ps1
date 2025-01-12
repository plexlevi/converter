Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'fordaw.designer.ps1')

$fontPath = $PSScriptRoot + '\Tuffy-Regular.ttf' -replace '\\', '\\' -replace ':','\:'

$ffmpegBinary = "ffmpeg"
$hardwareAcceleration = "-hwaccel auto"
$videoCodec = "-c:v libx264"
$crfOption = "-crf $($fordaw_Form.fordaw_crf.Value)"
$pixelFormat = "-pix_fmt yuvj420p"
$presetOption = "-preset fast"
$profileOption = "-profile:v high"
$levelOption = "-level:v 4.1"
$x264Params = "-x264-params keyint=12:min-keyint=1:ref=1:bframes=0:qcomp=0.8:aq-strength=0.5:dct-decimate=0:fast-pskip=0:deblock=-2,-2"
$bitrateOption = "-b:v 0"

$filterComplexStart = "-filter_complex `"[0:v]"
$filterDrawtext = "drawtext=fontfile='$fontPath'"

$filterX = ":x=(w-text_w)/2"
$filterY = ":y=h-(2*text_h)"
$filterFontColor = ":fontcolor=0xeeeeeeff"
$filterFontSize = ":fontsize=h/25"
$filterBox = ":box=1"
$filterBoxColor = ":boxcolor=0x3333333f,"

$filterComplexTimecodeStart = "drawtext=fontfile='$fontPath'"
$filterTimecode = ":timecode='00\:00\:00\:00'"
$filterTimecodeR = ":r=25.0"
$filterTimecodeX = ":x=(w-text_w)/2"
$filterTimecodeY = ":y=text_h"
$filterTimecodeFontColor = ":fontcolor=0xeeeeeeff"
$filterTimecodeFontSize = ":fontsize=h/12"
$filterTimecodeBox = ":box=1:boxborderw=10"
$filterTimecodeBoxColor = ":boxcolor=0x3333333f"
$filterTimecodeOption = ":tc24hmax=1"
$filterComplexScale = ",scale=-1:720[out]`""

$mapOption = "-map [out]"
$audioCodec = "-map 0:a? -c:a aac"
$audioRate = "-ar 48k"
$audioBitrate = "-b:a 256k"
$swsFlags = "-sws_flags bicubic"
$vsyncOption = "-vsync passthrough"
$metadataOption = "-map_metadata 0"
$videoMetadata = "-map_metadata:s:v 0:s:v"
$audioMetadata = "-map_metadata:s:a 0:s:a"
$movFlags = "-movflags use_metadata_tags"
$outputOverwrite = "-y" 

# Function to update the complete FFmpeg command
function Update-FFmpegCommand {
    if ($fordaw_Form.fordaw_fileList.Items.Count -gt 0) {
        $inputFile = $fordaw_Form.fordaw_fileList.Items[0]
        $outputDir = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($inputFile), "Video Files")
        if (-not (Test-Path -Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir | Out-Null
        }
        $outputFile = [System.IO.Path]::Combine($outputDir, [System.IO.Path]::GetFileNameWithoutExtension($inputFile) + ".mp4")
        $filterText = ":text='" + [System.IO.Path]::GetFileNameWithoutExtension($inputFile) + "'"
        $inputOption = "-i `"$inputFile`""
        if ($fordaw_Form.fordaw_preview.Checked) {
            $durationOption = "-t 30"
        } else {
            $durationOption = ""
        }
        $crfOption = "-crf $($fordaw_Form.fordaw_crf.Value)"
    }
    $global:completeFfmpegCommand = $ffmpegBinary + " " + $hardwareAcceleration + " " + $inputOption + " " + $durationOption + " " + $videoCodec + " " + $crfOption + " " + $pixelFormat + " " + $presetOption + " " + $profileOption + " " + $levelOption + " " + $x264Params + " " + $bitrateOption + " " + $filterComplexStart + $filterDrawtext + $filterText + $filterX + $filterY + $filterFontColor + $filterFontSize + $filterBox + $filterBoxColor + $filterComplexTimecodeStart + $filterTimecode + $filterTimecodeR + $filterTimecodeX + $filterTimecodeY + $filterTimecodeFontColor + $filterTimecodeFontSize + $filterTimecodeBox + $filterTimecodeBoxColor + $filterTimecodeOption + $filterComplexScale + " " + $mapOption + " " + $audioCodec + " " + $audioRate + " " + $audioBitrate + " " + $swsFlags + " " + $vsyncOption + " " + $metadataOption + " " + $videoMetadata + " " + $audioMetadata + " " + $movFlags + " " + $outputOverwrite + " `"" + $outputFile + "`""
    Clear-Host
    Write-Host "FFmpeg command: $completeFfmpegCommand"
}

# Add event handlers after initialization
$fordaw_Form.fordaw_crf.add_Scroll({
    if ($null -ne $fordaw_Form.fordaw_crf -and $null -ne $fordaw_Form.fordaw_crf_current) {
        $fordaw_Form.fordaw_crf_current.Text = $fordaw_Form.fordaw_crf.Value.ToString()
        $crfOption = "-crf $($fordaw_Form.fordaw_crf.Value)"
        Update-FFmpegCommand
    } else {
        Write-Host "The fordaw_crf or fordaw_crf_current variable does not exist or is null."
    }
})

$fordaw_Form.fordaw_preview.add_CheckedChanged({
    Update-FFmpegCommand
})

$fordaw_Form.fordaw_open.add_Click({
    $OpenFileDialog1.Filter = "Video Files|*.mp4;*.avi;*.mov;*.mkv"
    $OpenFileDialog1.Multiselect = $true
    if ($OpenFileDialog1.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $fordaw_Form.fordaw_fileList.Items.Clear()
        $OpenFileDialog1.FileNames | ForEach-Object { $fordaw_Form.fordaw_fileList.Items.Add($_) }
        Update-FFmpegCommand
    }
})

# Initial update of the FFmpeg command
Update-FFmpegCommand

$fordaw_Form.fordaw_start.add_Click({
    if ($fordaw_Form.fordaw_fileList.Items.Count -eq 0) {
        Write-Host "No files selected for conversion."
        return
    }
    foreach ($file in $fordaw_Form.fordaw_fileList.Items) {
        $inputFile = $file
        $outputDir = [System.IO.Path]::Combine([System.IO.Path]::GetDirectoryName($inputFile), "Video Files")
        if (-not (Test-Path -Path $outputDir)) {
            New-Item -ItemType Directory -Path $outputDir | Out-Null
        }
        $outputFile = [System.IO.Path]::Combine($outputDir, [System.IO.Path]::GetFileNameWithoutExtension($inputFile) + ".mp4")
        $videoname = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
        $inputOption = "-i `"$inputFile`""
        if ($fordaw_Form.fordaw_preview.Checked) {
            $durationOption = "-t 30"
        } else {
            $durationOption = ""
        }
        $crfOption = "-crf $($fordaw_Form.fordaw_crf.Value)"
        $filterText = ":text='" + $videoname + "'"
        $global:completeFfmpegCommand = $ffmpegBinary + " " + $hardwareAcceleration + " " + $inputOption + " " + $durationOption + " " + $videoCodec + " " + $crfOption + " " + $pixelFormat + " " + $presetOption + " " + $profileOption + " " + $levelOption + " " + $x264Params + " " + $bitrateOption + " " + $filterComplexStart + $filterDrawtext + $filterText + $filterX + $filterY + $filterFontColor + $filterFontSize + $filterBox + $filterBoxColor + $filterComplexTimecodeStart + $filterTimecode + $filterTimecodeR + $filterTimecodeX + $filterTimecodeY + $filterTimecodeFontColor + $filterTimecodeFontSize + $filterTimecodeBox + $filterTimecodeBoxColor + $filterTimecodeOption + $filterComplexScale + " " + $mapOption + " " + $audioCodec + " " + $audioRate + " " + $audioBitrate + " " + $swsFlags + " " + $vsyncOption + " " + $metadataOption + " " + $videoMetadata + " " + $audioMetadata + " " + $movFlags + " " + $outputOverwrite + " `"" + $outputFile + "`""
        Invoke-Expression $completeFfmpegCommand
        Write-Host "The conversion is finished: $outputFile"
    }
    
    # Close the form after conversion
    $fordaw_Form.Close()
})

# Show the PowerShell window
$fordaw_Form.ShowDialog()