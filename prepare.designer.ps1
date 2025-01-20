$prepare_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Button]$prepare_open = $null
[System.Windows.Forms.ListBox]$prepare_fileList = $null
[System.Windows.Forms.TextBox]$prepare_prefix = $null
[System.Windows.Forms.Label]$Label1 = $null
[System.Windows.Forms.Button]$prepare_addToCue = $null
[System.Windows.Forms.Label]$Label2 = $null
[System.Windows.Forms.TextBox]$prepare_lufs = $null
[System.Windows.Forms.OpenFileDialog]$OpenFileDialog2 = $null
[System.Windows.Forms.TextBox]$prepare_tp = $null
[System.Windows.Forms.Label]$Label3 = $null
[System.Windows.Forms.CheckBox]$prepare_normalize = $null
[System.Windows.Forms.GroupBox]$GroupBox1 = $null
[System.Windows.Forms.GroupBox]$GroupBox2 = $null
[System.Windows.Forms.ComboBox]$prepare_mixdown_v = $null
[System.Windows.Forms.CheckBox]$prepare_mixdown = $null
[System.Windows.Forms.CheckBox]$prepare_resample = $null
[System.Windows.Forms.GroupBox]$GroupBox3 = $null
[System.Windows.Forms.ComboBox]$prepare_sr = $null
[System.Windows.Forms.GroupBox]$GroupBox4 = $null
[System.Windows.Forms.CheckBox]$prepare_rebit = $null
[System.Windows.Forms.ComboBox]$prepare_bd = $null
function InitializeComponent
{
$prepare_open = (New-Object -TypeName System.Windows.Forms.Button)
$prepare_fileList = (New-Object -TypeName System.Windows.Forms.ListBox)
$prepare_prefix = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$prepare_addToCue = (New-Object -TypeName System.Windows.Forms.Button)
$Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$prepare_lufs = (New-Object -TypeName System.Windows.Forms.TextBox)
$OpenFileDialog2 = (New-Object -TypeName System.Windows.Forms.OpenFileDialog)
$prepare_tp = (New-Object -TypeName System.Windows.Forms.TextBox)
$Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$prepare_normalize = (New-Object -TypeName System.Windows.Forms.CheckBox)
$GroupBox1 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$GroupBox2 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$prepare_mixdown_v = (New-Object -TypeName System.Windows.Forms.ComboBox)
$prepare_mixdown = (New-Object -TypeName System.Windows.Forms.CheckBox)
$prepare_resample = (New-Object -TypeName System.Windows.Forms.CheckBox)
$GroupBox3 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$prepare_sr = (New-Object -TypeName System.Windows.Forms.ComboBox)
$GroupBox4 = (New-Object -TypeName System.Windows.Forms.GroupBox)
$prepare_rebit = (New-Object -TypeName System.Windows.Forms.CheckBox)
$prepare_bd = (New-Object -TypeName System.Windows.Forms.ComboBox)
$GroupBox1.SuspendLayout()
$GroupBox2.SuspendLayout()
$GroupBox3.SuspendLayout()
$GroupBox4.SuspendLayout()
$prepare_Form.SuspendLayout()
#
#prepare_open
#
$prepare_open.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]12))
$prepare_open.Name = [System.String]'prepare_open'
$prepare_open.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]23))
$prepare_open.TabIndex = [System.Int32]0
$prepare_open.Text = [System.String]'Open Files...'
$prepare_open.UseVisualStyleBackColor = $true
#
#prepare_fileList
#
$prepare_fileList.FormattingEnabled = $true
$prepare_fileList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]41))
$prepare_fileList.Name = [System.String]'prepare_fileList'
$prepare_fileList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]436,[System.Int32]134))
$prepare_fileList.TabIndex = [System.Int32]1
#
#prepare_prefix
#
$prepare_prefix.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]86,[System.Int32]195))
$prepare_prefix.Name = [System.String]'prepare_prefix'
$prepare_prefix.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]81,[System.Int32]20))
$prepare_prefix.TabIndex = [System.Int32]2
#
#Label1
#
$Label1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]198))
$Label1.Name = [System.String]'Label1'
$Label1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]61,[System.Int32]20))
$Label1.TabIndex = [System.Int32]3
$Label1.Text = [System.String]'Prefix:'
#
#prepare_addToCue
#
$prepare_addToCue.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]191,[System.Int32]338))
$prepare_addToCue.Name = [System.String]'prepare_addToCue'
$prepare_addToCue.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]92,[System.Int32]39))
$prepare_addToCue.TabIndex = [System.Int32]4
$prepare_addToCue.Text = [System.String]'ADD TO CUE'
$prepare_addToCue.UseVisualStyleBackColor = $true
#
#Label2
#
$Label2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]27))
$Label2.Name = [System.String]'Label2'
$Label2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]37,[System.Int32]23))
$Label2.TabIndex = [System.Int32]5
$Label2.Text = [System.String]'LUFS:'
#
#prepare_lufs
#
$prepare_lufs.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]80,[System.Int32]24))
$prepare_lufs.Name = [System.String]'prepare_lufs'
$prepare_lufs.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]45,[System.Int32]20))
$prepare_lufs.TabIndex = [System.Int32]6
$prepare_lufs.Text = [System.String]'27'
#
#OpenFileDialog2
#
$OpenFileDialog2.add_FileOk($OpenFileDialog1_FileOk)
#
#prepare_tp
#
$prepare_tp.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]80,[System.Int32]47))
$prepare_tp.Name = [System.String]'prepare_tp'
$prepare_tp.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]45,[System.Int32]20))
$prepare_tp.TabIndex = [System.Int32]7
$prepare_tp.Text = [System.String]'1'
#
#Label3
#
$Label3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]50))
$Label3.Name = [System.String]'Label3'
$Label3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]68,[System.Int32]23))
$Label3.TabIndex = [System.Int32]8
$Label3.Text = [System.String]'True Peak:'
#
#prepare_normalize
#
$prepare_normalize.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]-4))
$prepare_normalize.Name = [System.String]'prepare_normalize'
$prepare_normalize.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$prepare_normalize.TabIndex = [System.Int32]9
$prepare_normalize.Text = [System.String]'Normalize'
$prepare_normalize.UseVisualStyleBackColor = $true
#
#GroupBox1
#
$GroupBox1.Controls.Add($prepare_normalize)
$GroupBox1.Controls.Add($prepare_tp)
$GroupBox1.Controls.Add($Label3)
$GroupBox1.Controls.Add($Label2)
$GroupBox1.Controls.Add($prepare_lufs)
$GroupBox1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]321,[System.Int32]233))
$GroupBox1.Name = [System.String]'GroupBox1'
$GroupBox1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]139,[System.Int32]85))
$GroupBox1.TabIndex = [System.Int32]10
$GroupBox1.TabStop = $false
#
#GroupBox2
#
$GroupBox2.Controls.Add($prepare_mixdown_v)
$GroupBox2.Controls.Add($prepare_mixdown)
$GroupBox2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]173,[System.Int32]233))
$GroupBox2.Name = [System.String]'GroupBox2'
$GroupBox2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]143,[System.Int32]58))
$GroupBox2.TabIndex = [System.Int32]11
$GroupBox2.TabStop = $false
#
#prepare_mixdown_v
#
$prepare_mixdown_v.FormattingEnabled = $true
$prepare_mixdown_v.Items.AddRange([System.Object[]]@([System.String]'Stereo',[System.String]'Mono'))
$prepare_mixdown_v.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]30))
$prepare_mixdown_v.Name = [System.String]'prepare_mixdown_v'
$prepare_mixdown_v.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]21))
$prepare_mixdown_v.TabIndex = [System.Int32]1
#
#prepare_mixdown
#
$prepare_mixdown.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]-4))
$prepare_mixdown.Name = [System.String]'prepare_mixdown'
$prepare_mixdown.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$prepare_mixdown.TabIndex = [System.Int32]0
$prepare_mixdown.Text = [System.String]'Mixdown'
$prepare_mixdown.UseVisualStyleBackColor = $true
#
#prepare_resample
#
$prepare_resample.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]-2))
$prepare_resample.Name = [System.String]'prepare_resample'
$prepare_resample.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]106,[System.Int32]22))
$prepare_resample.TabIndex = [System.Int32]12
$prepare_resample.Text = [System.String]'Sample rate'
$prepare_resample.UseVisualStyleBackColor = $true
#
#GroupBox3
#
$GroupBox3.Controls.Add($prepare_sr)
$GroupBox3.Controls.Add($prepare_resample)
$GroupBox3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]233))
$GroupBox3.Name = [System.String]'GroupBox3'
$GroupBox3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]143,[System.Int32]58))
$GroupBox3.TabIndex = [System.Int32]13
$GroupBox3.TabStop = $false
#
#prepare_sr
#
$prepare_sr.FormattingEnabled = $true
$prepare_sr.Items.AddRange([System.Object[]]@([System.String]'44100',[System.String]'48000',[System.String]'96000',[System.String]'19200'))
$prepare_sr.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]30))
$prepare_sr.Name = [System.String]'prepare_sr'
$prepare_sr.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]21))
$prepare_sr.TabIndex = [System.Int32]13
#
#GroupBox4
#
$GroupBox4.Controls.Add($prepare_rebit)
$GroupBox4.Controls.Add($prepare_bd)
$GroupBox4.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]297))
$GroupBox4.Name = [System.String]'GroupBox4'
$GroupBox4.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]143,[System.Int32]56))
$GroupBox4.TabIndex = [System.Int32]14
$GroupBox4.TabStop = $false
#
#prepare_rebit
#
$prepare_rebit.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]-3))
$prepare_rebit.Name = [System.String]'prepare_rebit'
$prepare_rebit.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$prepare_rebit.TabIndex = [System.Int32]1
$prepare_rebit.Text = [System.String]'Bit Depth'
$prepare_rebit.UseVisualStyleBackColor = $true
#
#prepare_bd
#
$prepare_bd.FormattingEnabled = $true
$prepare_bd.Items.AddRange([System.Object[]]@([System.String]'16 bit',[System.String]'24 bit',[System.String]'32 bit'))
$prepare_bd.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]27))
$prepare_bd.Name = [System.String]'prepare_bd'
$prepare_bd.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]106,[System.Int32]21))
$prepare_bd.TabIndex = [System.Int32]0
#
#prepare_Form
#
$prepare_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]389))
$prepare_Form.Controls.Add($GroupBox4)
$prepare_Form.Controls.Add($GroupBox3)
$prepare_Form.Controls.Add($GroupBox2)
$prepare_Form.Controls.Add($GroupBox1)
$prepare_Form.Controls.Add($prepare_addToCue)
$prepare_Form.Controls.Add($Label1)
$prepare_Form.Controls.Add($prepare_prefix)
$prepare_Form.Controls.Add($prepare_fileList)
$prepare_Form.Controls.Add($prepare_open)
$prepare_Form.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Consolas',[System.Single]8.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$prepare_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
$prepare_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$prepare_Form.Text = [System.String]'Prepare'
$GroupBox1.ResumeLayout($false)
$GroupBox1.PerformLayout()
$GroupBox2.ResumeLayout($false)
$GroupBox3.ResumeLayout($false)
$GroupBox4.ResumeLayout($false)
$prepare_Form.ResumeLayout($false)
$prepare_Form.PerformLayout()
Add-Member -InputObject $prepare_Form -Name prepare_open -Value $prepare_open -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_fileList -Value $prepare_fileList -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_prefix -Value $prepare_prefix -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name Label1 -Value $Label1 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_addToCue -Value $prepare_addToCue -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name Label2 -Value $Label2 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_lufs -Value $prepare_lufs -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name OpenFileDialog2 -Value $OpenFileDialog2 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_tp -Value $prepare_tp -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name Label3 -Value $Label3 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_normalize -Value $prepare_normalize -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name GroupBox1 -Value $GroupBox1 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name GroupBox2 -Value $GroupBox2 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_mixdown_v -Value $prepare_mixdown_v -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_mixdown -Value $prepare_mixdown -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_resample -Value $prepare_resample -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name GroupBox3 -Value $GroupBox3 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_sr -Value $prepare_sr -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name GroupBox4 -Value $GroupBox4 -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_rebit -Value $prepare_rebit -MemberType NoteProperty
Add-Member -InputObject $prepare_Form -Name prepare_bd -Value $prepare_bd -MemberType NoteProperty
}
. InitializeComponent
