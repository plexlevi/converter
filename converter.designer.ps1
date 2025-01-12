$Converter_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$video_convert = $null
function InitializeComponent
{
$resources = . (Join-Path $PSScriptRoot 'converter.resources.ps1')
$video_convert = (New-Object -TypeName System.Windows.Forms.Button)
$Converter_Form.SuspendLayout()
#
#video_convert
#
$video_convert.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]12))
$video_convert.Name = [System.String]'video_convert'
$video_convert.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]41))
$video_convert.TabIndex = [System.Int32]0
$video_convert.Text = [System.String]'Video Convert'
$video_convert.UseVisualStyleBackColor = $true
#
#Converter_Form
#
$Converter_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]311))
$Converter_Form.Controls.Add($video_convert)
$Converter_Form.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Consolas',[System.Single]8.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$Converter_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$Converter_Form.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
$Converter_Form.MaximizeBox = $false
$Converter_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$Converter_Form.Text = [System.String]'Converter'
$Converter_Form.ResumeLayout($false)
Add-Member -InputObject $Converter_Form -Name video_convert -Value $video_convert -MemberType NoteProperty
}
. InitializeComponent
