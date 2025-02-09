$Converter_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$video_convert = $null
[System.Windows.Forms.Button]$start_conversion = $null
[System.Windows.Forms.ListBox]$ffmpegCommandList = $null
[System.Windows.Forms.CheckBox]$open_outfolder = $null
[System.Windows.Forms.Button]$prepare_27lufs = $null
[System.Windows.Forms.Button]$replace_audio = $null
[System.Windows.Forms.Button]$ffmpeg_install = $null
function InitializeComponent
{
$video_convert = (New-Object -TypeName System.Windows.Forms.Button)
$start_conversion = (New-Object -TypeName System.Windows.Forms.Button)
$ffmpegCommandList = (New-Object -TypeName System.Windows.Forms.ListBox)
$open_outfolder = (New-Object -TypeName System.Windows.Forms.CheckBox)
$prepare_27lufs = (New-Object -TypeName System.Windows.Forms.Button)
$replace_audio = (New-Object -TypeName System.Windows.Forms.Button)
$ffmpeg_install = (New-Object -TypeName System.Windows.Forms.Button)
$Converter_Form.SuspendLayout()
#
#video_convert
#
$video_convert.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$video_convert.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$video_convert.Name = [System.String]'video_convert'
$video_convert.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]48))
$video_convert.TabIndex = [System.Int32]0
$video_convert.Text = [System.String]'Video Convert...'
$video_convert.UseVisualStyleBackColor = $true
#
#start_conversion
#
$start_conversion.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
$start_conversion.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$start_conversion.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]206,[System.Int32]268))
$start_conversion.Name = [System.String]'start_conversion'
$start_conversion.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]41))
$start_conversion.TabIndex = [System.Int32]1
$start_conversion.Text = [System.String]'START CONVERSION'
$start_conversion.UseVisualStyleBackColor = $true
#
#ffmpegCommandList
#
$ffmpegCommandList.Anchor = ([System.Windows.Forms.AnchorStyles][System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left -bor [System.Windows.Forms.AnchorStyles]::Right)
$ffmpegCommandList.BorderStyle = [System.Windows.Forms.BorderStyle]::None
$ffmpegCommandList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]66))
$ffmpegCommandList.Name = [System.String]'ffmpegCommandList'
$ffmpegCommandList.ScrollAlwaysVisible = $true
$ffmpegCommandList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]458,[System.Int32]182))
$ffmpegCommandList.TabIndex = [System.Int32]2
$ffmpegCommandList.SelectionMode = [System.Windows.Forms.SelectionMode]::MultiExtended
#
#open_outfolder
#
$open_outfolder.Anchor = ([System.Windows.Forms.AnchorStyles][System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Left)
$open_outfolder.Checked = $true
$open_outfolder.CheckState = [System.Windows.Forms.CheckState]::Checked
$open_outfolder.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$open_outfolder.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]273))
$open_outfolder.Name = [System.String]'open_outfolder'
$open_outfolder.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]32))
$open_outfolder.TabIndex = [System.Int32]3
$open_outfolder.Text = [System.String]'Open Output Folder on finish'
$open_outfolder.UseVisualStyleBackColor = $true
#
#prepare_27lufs
#
$prepare_27lufs.Anchor = ([System.Windows.Forms.AnchorStyles][System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Right)
$prepare_27lufs.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$prepare_27lufs.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]390,[System.Int32]12))
$prepare_27lufs.Name = [System.String]'prepare_27lufs'
$prepare_27lufs.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]48))
$prepare_27lufs.TabIndex = [System.Int32]4
$prepare_27lufs.Text = [System.String]'Audio Convert ...'
$prepare_27lufs.UseVisualStyleBackColor = $true
#
#replace_audio
#
$replace_audio.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$replace_audio.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]99,[System.Int32]12))
$replace_audio.Name = [System.String]'replace_audio'
$replace_audio.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]48))
$replace_audio.TabIndex = [System.Int32]5
$replace_audio.Text = [System.String]'Replace Audio'
$replace_audio.UseVisualStyleBackColor = $true
#
#ffmpeg_install
#
$ffmpeg_install.Anchor = ([System.Windows.Forms.AnchorStyles][System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right)
$ffmpeg_install.FlatStyle = [System.Windows.Forms.FlatStyle]::Popup
$ffmpeg_install.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]418,[System.Int32]268))
$ffmpeg_install.Name = [System.String]'ffmpeg_install'
$ffmpeg_install.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]54,[System.Int32]41))
$ffmpeg_install.TabIndex = [System.Int32]6
$ffmpeg_install.Text = [System.String]'FFMpeg'
$ffmpeg_install.UseVisualStyleBackColor = $true
#
#Converter_Form
#
$Converter_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]321))
$Converter_Form.Controls.Add($ffmpeg_install)
$Converter_Form.Controls.Add($replace_audio)
$Converter_Form.Controls.Add($prepare_27lufs)
$Converter_Form.Controls.Add($open_outfolder)
$Converter_Form.Controls.Add($video_convert)
$Converter_Form.Controls.Add($start_conversion)
$Converter_Form.Controls.Add($ffmpegCommandList)
$Converter_Form.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Consolas',[System.Single]8.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Converter_Form.MaximizeBox = $false
$Converter_Form.MaximumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]1000,[System.Int32]800))
$Converter_Form.MinimumSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]500,[System.Int32]360))
$Converter_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$Converter_Form.Text = [System.String]'Converter'
$Converter_Form.ResumeLayout($false)
Add-Member -InputObject $Converter_Form -Name video_convert -Value $video_convert -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name start_conversion -Value $start_conversion -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name ffmpegCommandList -Value $ffmpegCommandList -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name open_outfolder -Value $open_outfolder -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name prepare_27lufs -Value $prepare_27lufs -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name replace_audio -Value $replace_audio -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name ffmpeg_install -Value $ffmpeg_install -MemberType NoteProperty
}
. InitializeComponent
