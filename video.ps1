Add-Type -AssemblyName System.Windows.Forms

# Function to open file dialog and select multiple files
function Select-Files {
    [System.Windows.Forms.OpenFileDialog]$fileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $filter = "Video files (*.mp4;*.avi;*.mkv;*.mov;*.wmv)|*.mp4;*.avi;*.mkv;*.mov;*.wmv|All files (*.*)|*.*"

    $fileDialog.Multiselect = $true
    if ($fileDialog.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        return $fileDialog.FileNames
    } else {
        return $null
    }
}

# Function to get video framerate using ffmpeg
function Get-Framerate($inputFile) {
    $ffmpegOutput = ffmpeg -i $inputFile 2>&1 | Select-String -Pattern '(\d+(\.\d+)?) fps'
    if ($ffmpegOutput) {
        $framerate = [double]$ffmpegOutput.Matches[0].Groups[1].Value
        if ($framerate -match '^\d{1,2}$') {
            return "$framerate.0"
        } else {
            return $framerate
        }
    } else {
        throw "Could not determine framerate for $inputFile"
    }
}

# Function to process each video file
function Process-Video {
    param (
        [string]$inputFile,
        [int]$crfValue,
        [bool]$preview
    )

    $inputDir = [System.IO.Path]::GetDirectoryName($inputFile)
    $inputName = [System.IO.Path]::GetFileNameWithoutExtension($inputFile)
    $outputDir = "$inputDir\Video Files"
    if (-not (Test-Path -Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir
    }
    $outputFile = "$outputDir\$inputName" + ".mp4"

    $framerate = Get-Framerate -inputFile $inputFile
    $drawTextFileName = $inputName
    $framerateParam = "r=$framerate"

    # Debug: Print the original video framerate and the framerate parameter
    Write-Output "Processing file: $inputFile"
    Write-Output "Original video framerate: $framerate fps"
    Write-Output "Framerate parameter: $framerateParam"
    
    $filterComplex = "[0:v]drawtext=font=Tuffy:text='$drawTextFileName':$($framerateParam):x=(w-text_w)/2:y=h-25:fontcolor=0xccccccff:fontsize=22:box=1:boxcolor=0x3333337f,drawtext=font=Tuffy:timecode='00\:00\:00\:00':$($framerateParam):x=(w-text_w)/2:y=25:fontcolor=0xccccccff:fontsize=48:box=1:boxcolor=0x3333337f:tc24hmax=1,scale=1280:720[out]"

    $previewOption = if ($preview) { "-t 30" } else { "" }

    $ffmpegCommand = "ffmpeg -hwaccel d3d11va -i `"$inputFile`" $previewOption -c:v libx264 -crf $crfValue -pix_fmt yuvj420p -preset fast -profile:v high -level:v 4.1 -x264-params keyint=12:min-keyint=1:ref=1:bframes=0:qcomp=0.8:aq-strength=0.5:dct-decimate=0:fast-pskip=0:deblock=-2,-2 -b:v 0 -filter_complex `"$filterComplex`" -map `"[out]`" -c:a aac -ar 48k -b:a 256k -filter:a `"`"volume=0.0dB`"`" -map a? -timecode `"`"00:00:00:00`"`" -sws_flags bicubic -vsync passthrough -map_metadata 0 -map_metadata:s:v 0:s:v -map_metadata:s:a 0:s:a -movflags use_metadata_tags -f mp4 -y `"$outputFile`""
    
    Invoke-Expression $ffmpegCommand
}

# Create controls in the existing $Panel1
$Panel1.Controls.Clear()

# Create a horizontal slider for CRF value, inverted
$slider = New-Object System.Windows.Forms.TrackBar
$slider.Orientation = [System.Windows.Forms.Orientation]::Horizontal
$slider.Minimum = 10
$slider.Maximum = 26
$slider.Value = 20
$slider.TickFrequency = 1
$slider.Width = 300
$slider.Top = 20
$slider.Left = 50

# Create label for CRF value
$sliderLabel = New-Object System.Windows.Forms.Label
$sliderLabel.Text = "CRF Value: 16"
$sliderLabel.Top = 70
$sliderLabel.Left = 50
$sliderLabel.Width = 300

# Update label on slider value change
$slider.add_ValueChanged({
    $invertedValue = 36 - $slider.Value
    $sliderLabel.Text = "CRF Value: $invertedValue"
})

$Panel1.Controls.Add($slider)
$Panel1.Controls.Add($sliderLabel)

# Create a checkbox for preview
$checkBox = New-Object System.Windows.Forms.CheckBox
$checkBox.Text = "Preview"
$checkBox.Top = 130
$checkBox.Left = 50
$Panel1.Controls.Add($checkBox)

# Create a button to start processing
$button = New-Object System.Windows.Forms.Button
$button.Text = "Start Processing"
$button.Top = 160
$button.Left = 50
$button.Add_Click({
    $files = Select-Files
    if ($files) {
        foreach ($file in $files) {
            $invertedValue = 36 - $slider.Value
            Process-Video -inputFile $file -crfValue $invertedValue -preview $checkBox.Checked
        }
        $Form1.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("No files were selected.", "Info", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
        $Form1.Close()
    }
})
$Panel1.Controls.Add($button)
