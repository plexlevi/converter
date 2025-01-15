$fordaw_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Panel]$fordaw_Panel = $null
[System.Windows.Forms.RadioButton]$fordaw_dnxhd = $null
[System.Windows.Forms.RadioButton]$fordaw_h264 = $null
[System.Windows.Forms.CheckBox]$fordaw_webquality = $null
[System.Windows.Forms.CheckBox]$fordaw_blackbg = $null
[System.Windows.Forms.CheckBox]$timecodeburnin = $null
[System.Windows.Forms.Label]$fordaw_Label4 = $null
[System.Windows.Forms.Label]$fordaw_Label3 = $null
[System.Windows.Forms.Label]$fordaw_Label2 = $null
[System.Windows.Forms.Label]$fordaw_crf_current = $null
[System.Windows.Forms.Label]$fordaw_Label1 = $null
[System.Windows.Forms.TrackBar]$fordaw_crf = $null
[System.Windows.Forms.CheckBox]$fordaw_preview = $null
[System.Windows.Forms.Button]$fordaw_addToCue = $null
[System.Windows.Forms.Button]$fordaw_open = $null
[System.Windows.Forms.ListBox]$fordaw_fileList = $null
[System.Windows.Forms.OpenFileDialog]$OpenFileDialog1 = $null
function InitializeComponent
{
$fordaw_Panel = (New-Object -TypeName System.Windows.Forms.Panel)
$fordaw_dnxhd = (New-Object -TypeName System.Windows.Forms.RadioButton)
$fordaw_h264 = (New-Object -TypeName System.Windows.Forms.RadioButton)
$fordaw_webquality = (New-Object -TypeName System.Windows.Forms.CheckBox)
$fordaw_blackbg = (New-Object -TypeName System.Windows.Forms.CheckBox)
$timecodeburnin = (New-Object -TypeName System.Windows.Forms.CheckBox)
$fordaw_Label4 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_crf_current = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_crf = (New-Object -TypeName System.Windows.Forms.TrackBar)
$fordaw_preview = (New-Object -TypeName System.Windows.Forms.CheckBox)
$fordaw_addToCue = (New-Object -TypeName System.Windows.Forms.Button)
$fordaw_open = (New-Object -TypeName System.Windows.Forms.Button)
$fordaw_fileList = (New-Object -TypeName System.Windows.Forms.ListBox)
$OpenFileDialog1 = (New-Object -TypeName System.Windows.Forms.OpenFileDialog)
$fordaw_Panel.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).BeginInit()
$fordaw_Form.SuspendLayout()
#
#fordaw_Panel
#
$fordaw_Panel.Controls.Add($fordaw_dnxhd)
$fordaw_Panel.Controls.Add($fordaw_h264)
$fordaw_Panel.Controls.Add($fordaw_webquality)
$fordaw_Panel.Controls.Add($fordaw_blackbg)
$fordaw_Panel.Controls.Add($timecodeburnin)
$fordaw_Panel.Controls.Add($fordaw_Label4)
$fordaw_Panel.Controls.Add($fordaw_Label3)
$fordaw_Panel.Controls.Add($fordaw_Label2)
$fordaw_Panel.Controls.Add($fordaw_crf_current)
$fordaw_Panel.Controls.Add($fordaw_Label1)
$fordaw_Panel.Controls.Add($fordaw_crf)
$fordaw_Panel.Controls.Add($fordaw_preview)
$fordaw_Panel.Controls.Add($fordaw_addToCue)
$fordaw_Panel.Controls.Add($fordaw_open)
$fordaw_Panel.Controls.Add($fordaw_fileList)
$fordaw_Panel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
$fordaw_Panel.Name = [System.String]'fordaw_Panel'
$fordaw_Panel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]488,[System.Int32]397))
$fordaw_Panel.TabIndex = [System.Int32]0
#
#fordaw_dnxhd
#
$fordaw_dnxhd.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]356,[System.Int32]293))
$fordaw_dnxhd.Name = [System.String]'fordaw_dnxhd'
$fordaw_dnxhd.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_dnxhd.TabIndex = [System.Int32]15
$fordaw_dnxhd.Text = [System.String]'DNxHD'
$fordaw_dnxhd.UseVisualStyleBackColor = $true
#
#fordaw_h264
#
$fordaw_h264.Checked = $true
$fordaw_h264.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]356,[System.Int32]263))
$fordaw_h264.Name = [System.String]'fordaw_h264'
$fordaw_h264.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_h264.TabIndex = [System.Int32]14
$fordaw_h264.TabStop = $true
$fordaw_h264.Text = [System.String]'H.264'
$fordaw_h264.UseVisualStyleBackColor = $true
#
#fordaw_webquality
#
$fordaw_webquality.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]264))
$fordaw_webquality.Name = [System.String]'fordaw_webquality'
$fordaw_webquality.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_webquality.TabIndex = [System.Int32]12
$fordaw_webquality.Text = [System.String]'Web quality'
$fordaw_webquality.UseVisualStyleBackColor = $true
#
#fordaw_blackbg
#
$fordaw_blackbg.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]134,[System.Int32]293))
$fordaw_blackbg.Name = [System.String]'fordaw_blackbg'
$fordaw_blackbg.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]120,[System.Int32]24))
$fordaw_blackbg.TabIndex = [System.Int32]11
$fordaw_blackbg.Text = [System.String]'Black background'
$fordaw_blackbg.UseVisualStyleBackColor = $true
#
#timecodeburnin
#
$timecodeburnin.Checked = $true
$timecodeburnin.CheckState = [System.Windows.Forms.CheckState]::Checked
$timecodeburnin.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]134,[System.Int32]263))
$timecodeburnin.Name = [System.String]'timecodeburnin'
$timecodeburnin.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]120,[System.Int32]24))
$timecodeburnin.TabIndex = [System.Int32]10
$timecodeburnin.Text = [System.String]'Timecode Burnin'
$timecodeburnin.UseVisualStyleBackColor = $true
#
#fordaw_Label4
#
$fordaw_Label4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]430,[System.Int32]241))
$fordaw_Label4.Name = [System.String]'fordaw_Label4'
$fordaw_Label4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]30,[System.Int32]19))
$fordaw_Label4.TabIndex = [System.Int32]9
$fordaw_Label4.Text = [System.String]'Best'
#
#fordaw_Label3
#
$fordaw_Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]273,[System.Int32]242))
$fordaw_Label3.Name = [System.String]'fordaw_Label3'
$fordaw_Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]46,[System.Int32]18))
$fordaw_Label3.TabIndex = [System.Int32]8
$fordaw_Label3.Text = [System.String]'Optimal'
#
#fordaw_Label2
#
$fordaw_Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]103,[System.Int32]241))
$fordaw_Label2.Name = [System.String]'fordaw_Label2'
$fordaw_Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]25,[System.Int32]19))
$fordaw_Label2.TabIndex = [System.Int32]7
$fordaw_Label2.Text = [System.String]'Ok'
#
#fordaw_crf_current
#
$fordaw_crf_current.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$fordaw_crf_current.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]74,[System.Int32]207))
$fordaw_crf_current.Name = [System.String]'fordaw_crf_current'
$fordaw_crf_current.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]23,[System.Int32]28))
$fordaw_crf_current.TabIndex = [System.Int32]5
$fordaw_crf_current.Text = [System.String]'16'
#
#fordaw_Label1
#
$fordaw_Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]207))
$fordaw_Label1.Name = [System.String]'fordaw_Label1'
$fordaw_Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]63,[System.Int32]28))
$fordaw_Label1.TabIndex = [System.Int32]4
$fordaw_Label1.Text = [System.String]'Quality:'
#
#fordaw_crf
#
$fordaw_crf.LargeChange = [System.Int32]1
$fordaw_crf.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]103,[System.Int32]194))
$fordaw_crf.Maximum = [System.Int32]23
$fordaw_crf.Minimum = [System.Int32]10
$fordaw_crf.Name = [System.String]'fordaw_crf'
$fordaw_crf.RightToLeft = [System.Windows.Forms.RightToLeft]::Yes
$fordaw_crf.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]357,[System.Int32]45))
$fordaw_crf.TabIndex = [System.Int32]3
$fordaw_crf.TickStyle = [System.Windows.Forms.TickStyle]::Both
$fordaw_crf.Value = [System.Int32]16
#
#fordaw_preview
#
$fordaw_preview.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]294))
$fordaw_preview.Name = [System.String]'fordaw_preview'
$fordaw_preview.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_preview.TabIndex = [System.Int32]2
$fordaw_preview.Text = [System.String]'30s preview'
$fordaw_preview.UseVisualStyleBackColor = $true
#
#fordaw_addToCue
#
$fordaw_addToCue.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]207,[System.Int32]338))
$fordaw_addToCue.Name = [System.String]'fordaw_addToCue'
$fordaw_addToCue.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]39))
$fordaw_addToCue.TabIndex = [System.Int32]1
$fordaw_addToCue.Text = [System.String]'ADD TO CUE'
$fordaw_addToCue.UseVisualStyleBackColor = $true
#
#fordaw_open
#
$fordaw_open.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]12))
$fordaw_open.Name = [System.String]'fordaw_open'
$fordaw_open.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]86,[System.Int32]23))
$fordaw_open.TabIndex = [System.Int32]0
$fordaw_open.Text = [System.String]'Open Files...'
$fordaw_open.UseVisualStyleBackColor = $true
#
#fordaw_fileList
#
$fordaw_fileList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]50))
$fordaw_fileList.Name = [System.String]'fordaw_fileList'
$fordaw_fileList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]436,[System.Int32]134))
$fordaw_fileList.TabIndex = [System.Int32]6
#
#fordaw_Form
#
$fordaw_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]389))
$fordaw_Form.Controls.Add($fordaw_Panel)
$fordaw_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
$fordaw_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$fordaw_Form.Text = [System.String]'For DAW'
$fordaw_Panel.ResumeLayout($false)
$fordaw_Panel.PerformLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).EndInit()
$fordaw_Form.ResumeLayout($false)
Add-Member -InputObject $fordaw_Form -Name fordaw_Panel -Value $fordaw_Panel -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_dnxhd -Value $fordaw_dnxhd -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_h264 -Value $fordaw_h264 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_webquality -Value $fordaw_webquality -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_blackbg -Value $fordaw_blackbg -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name timecodeburnin -Value $timecodeburnin -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label4 -Value $fordaw_Label4 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label3 -Value $fordaw_Label3 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label2 -Value $fordaw_Label2 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_crf_current -Value $fordaw_crf_current -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label1 -Value $fordaw_Label1 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_crf -Value $fordaw_crf -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_preview -Value $fordaw_preview -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_addToCue -Value $fordaw_addToCue -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_open -Value $fordaw_open -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_fileList -Value $fordaw_fileList -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name OpenFileDialog1 -Value $OpenFileDialog1 -MemberType NoteProperty
}
. InitializeComponent
