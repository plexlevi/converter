$Converter_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$video_convert = $null
[System.Windows.Forms.Button]$start_conversion = $null
[System.Windows.Forms.ListBox]$ffmpegCommandList = $null
[System.Windows.Forms.CheckBox]$open_outfolder = $null
[System.Windows.Forms.Button]$prepare_27lufs = $null
function InitializeComponent
{
$resources = . (Join-Path $PSScriptRoot 'converter.resources.ps1')
$video_convert = (New-Object -TypeName System.Windows.Forms.Button)
$start_conversion = (New-Object -TypeName System.Windows.Forms.Button)
$ffmpegCommandList = (New-Object -TypeName System.Windows.Forms.ListBox)
$open_outfolder = (New-Object -TypeName System.Windows.Forms.CheckBox)
$prepare_27lufs = (New-Object -TypeName System.Windows.Forms.Button)
$Converter_Form.SuspendLayout()
#
#video_convert
#
$video_convert.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$video_convert.Name = [System.String]'video_convert'
$video_convert.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]48))
$video_convert.TabIndex = [System.Int32]0
$video_convert.Text = [System.String]'Video Convert...'
$video_convert.UseVisualStyleBackColor = $true
#
#start_conversion
#
$start_conversion.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]207,[System.Int32]258))
$start_conversion.Name = [System.String]'start_conversion'
$start_conversion.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]41))
$start_conversion.TabIndex = [System.Int32]1
$start_conversion.Text = [System.String]'START CONVERSION'
$start_conversion.UseVisualStyleBackColor = $true
#
#ffmpegCommandList
#
$ffmpegCommandList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]66))
$ffmpegCommandList.Name = [System.String]'ffmpegCommandList'
$ffmpegCommandList.ScrollAlwaysVisible = $true
$ffmpegCommandList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]460,[System.Int32]186))
$ffmpegCommandList.TabIndex = [System.Int32]2
#
#open_outfolder
#
$open_outfolder.Checked = $true
$open_outfolder.CheckState = [System.Windows.Forms.CheckState]::Checked
$open_outfolder.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]267))
$open_outfolder.Name = [System.String]'open_outfolder'
$open_outfolder.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]32))
$open_outfolder.TabIndex = [System.Int32]3
$open_outfolder.Text = [System.String]'Open Output Folder on finish'
$open_outfolder.UseVisualStyleBackColor = $true
#
#prepare_27lufs
#
$prepare_27lufs.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]391,[System.Int32]12))
$prepare_27lufs.Name = [System.String]'prepare_27lufs'
$prepare_27lufs.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]48))
$prepare_27lufs.TabIndex = [System.Int32]4
$prepare_27lufs.Text = [System.String]'Audio Convert ...'
$prepare_27lufs.UseVisualStyleBackColor = $true
#
#Converter_Form
#
$Converter_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]311))
$Converter_Form.Controls.Add($prepare_27lufs)
$Converter_Form.Controls.Add($open_outfolder)
$Converter_Form.Controls.Add($video_convert)
$Converter_Form.Controls.Add($start_conversion)
$Converter_Form.Controls.Add($ffmpegCommandList)
$Converter_Form.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Consolas',[System.Single]8.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Converter_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Converter_Form.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
$Converter_Form.MaximizeBox = $false
$Converter_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$Converter_Form.Text = [System.String]'Converter'
$Converter_Form.ResumeLayout($false)
Add-Member -InputObject $Converter_Form -Name video_convert -Value $video_convert -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name start_conversion -Value $start_conversion -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name ffmpegCommandList -Value $ffmpegCommandList -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name open_outfolder -Value $open_outfolder -MemberType NoteProperty
Add-Member -InputObject $Converter_Form -Name prepare_27lufs -Value $prepare_27lufs -MemberType NoteProperty
}
. InitializeComponent
