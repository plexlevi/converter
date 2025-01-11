$fordaw_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Panel]$fordaw_Panel = $null
[System.Windows.Forms.Label]$fordaw_Label1 = $null
[System.Windows.Forms.TrackBar]$fordaw_crf = $null
[System.Windows.Forms.CheckBox]$fordaw_preview = $null
[System.Windows.Forms.Button]$fordaw_start = $null
function InitializeComponent
{
$fordaw_Panel = (New-Object -TypeName System.Windows.Forms.Panel)
$fordaw_Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_crf = (New-Object -TypeName System.Windows.Forms.TrackBar)
$fordaw_preview = (New-Object -TypeName System.Windows.Forms.CheckBox)
$fordaw_start = (New-Object -TypeName System.Windows.Forms.Button)
$fordaw_Panel.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).BeginInit()
$fordaw_Form.SuspendLayout()
#
#fordaw_Panel
#
$fordaw_Panel.Controls.Add($fordaw_Label1)
$fordaw_Panel.Controls.Add($fordaw_crf)
$fordaw_Panel.Controls.Add($fordaw_preview)
$fordaw_Panel.Controls.Add($fordaw_start)
$fordaw_Panel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
$fordaw_Panel.Name = [System.String]'fordaw_Panel'
$fordaw_Panel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]359,[System.Int32]267))
$fordaw_Panel.TabIndex = [System.Int32]0
#
#fordaw_Label1
#
$fordaw_Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]45,[System.Int32]32))
$fordaw_Label1.Name = [System.String]'fordaw_Label1'
$fordaw_Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]68,[System.Int32]23))
$fordaw_Label1.TabIndex = [System.Int32]4
$fordaw_Label1.Text = [System.String]'Quality:'
#
#fordaw_crf
#
$fordaw_crf.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]119,[System.Int32]23))
$fordaw_crf.Name = [System.String]'fordaw_crf'
$fordaw_crf.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]228,[System.Int32]45))
$fordaw_crf.TabIndex = [System.Int32]3
$fordaw_crf.add_Scroll($fordaw_crf_Scroll)
#
#fordaw_preview
#
$fordaw_preview.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]45,[System.Int32]89))
$fordaw_preview.Name = [System.String]'fordaw_preview'
$fordaw_preview.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_preview.TabIndex = [System.Int32]2
$fordaw_preview.Text = [System.String]'30s preview'
$fordaw_preview.UseVisualStyleBackColor = $true
#
#fordaw_start
#
$fordaw_start.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]45,[System.Int32]152))
$fordaw_start.Name = [System.String]'fordaw_start'
$fordaw_start.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$fordaw_start.TabIndex = [System.Int32]1
$fordaw_start.Text = [System.String]'Start'
$fordaw_start.UseVisualStyleBackColor = $true
#
#fordaw_Form
#
$fordaw_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]359,[System.Int32]267))
$fordaw_Form.Controls.Add($fordaw_Panel)
$fordaw_Form.Text = [System.String]'For DAW'
$fordaw_Panel.ResumeLayout($false)
$fordaw_Panel.PerformLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).EndInit()
$fordaw_Form.ResumeLayout($false)
Add-Member -InputObject $fordaw_Form -Name fordaw_Panel -Value $fordaw_Panel -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label1 -Value $fordaw_Label1 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_crf -Value $fordaw_crf -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_preview -Value $fordaw_preview -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_start -Value $fordaw_start -MemberType NoteProperty
}
. InitializeComponent
