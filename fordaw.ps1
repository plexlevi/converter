$fordaw_crf_Scroll = {
}
Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'fordaw.designer.ps1')

$fordaw_Form.fordaw_start.add_Click({
    # Az ffmpeg parancs PowerShellben
    $filename = "D:\DDS\The Great British Bake Off 11\CNEM0078250A_00.mp4"
    $videoname = [System.IO.Path]::GetFileNameWithoutExtension($filename)
    $ffmpegCommand = 'ffmpeg -hwaccel auto -i "' + $filename + '" -t 30 -c:v libx264 -crf 16 -pix_fmt yuvj420p -preset fast -profile:v high -level:v 4.1 -x264-params keyint=12:min-keyint=1:ref=1:bframes=0:qcomp=0.8:aq-strength=0.5:dct-decimate=0:fast-pskip=0:deblock=-2,-2 -b:v 0 -filter_complex "[0:v]drawtext=font=Tuffy:text=' + $videoname + ':r=25.0:x=(w-text_w)/2:y=h-25:fontcolor=0xccccccff:fontsize=22:box=1:boxcolor=0x3333337f, drawtext=font=Tuffy:timecode=00\\\:00\\\:00\\\:00:r=25.0:x=(w-text_w)/2:y=25:fontcolor=0xccccccff:fontsize=48:box=1:boxcolor=0x3333337f:tc24hmax=1,scale=1280:720[out]" -map "[out]" -c:a aac -ar 48k -b:a 256k -sws_flags bicubic -vsync passthrough -map_metadata 0 -map_metadata:s:v 0:s:v -map_metadata:s:a 0:s:a -movflags use_metadata_tags -y "' + "$filename" + '_cv.mp4"'
    Invoke-Expression $ffmpegCommand
})