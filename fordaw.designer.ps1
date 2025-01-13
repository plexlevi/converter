$fordaw_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.Panel]$fordaw_Panel = $null
[System.Windows.Forms.Label]$fordaw_Label4 = $null
[System.Windows.Forms.Label]$fordaw_Label3 = $null
[System.Windows.Forms.Label]$fordaw_Label2 = $null
[System.Windows.Forms.Label]$fordaw_crf_current = $null
[System.Windows.Forms.Label]$fordaw_Label1 = $null
[System.Windows.Forms.TrackBar]$fordaw_crf = $null
[System.Windows.Forms.CheckBox]$fordaw_preview = $null
[System.Windows.Forms.Button]$fordaw_start = $null
[System.Windows.Forms.Button]$fordaw_open = $null
[System.Windows.Forms.ListBox]$fordaw_fileList = $null
[System.Windows.Forms.OpenFileDialog]$OpenFileDialog1 = $null


function InitializeComponent
{
$fordaw_Panel = (New-Object -TypeName System.Windows.Forms.Panel)
$fordaw_Label4 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label3 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label2 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_crf_current = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_Label1 = (New-Object -TypeName System.Windows.Forms.Label)
$fordaw_crf = (New-Object -TypeName System.Windows.Forms.TrackBar)
$fordaw_preview = (New-Object -TypeName System.Windows.Forms.CheckBox)
$fordaw_start = (New-Object -TypeName System.Windows.Forms.Button)
$fordaw_open = (New-Object -TypeName System.Windows.Forms.Button)
$fordaw_fileList = (New-Object -TypeName System.Windows.Forms.ListBox)
$fordaw_fileList.Add_KeyDown({
    param ($s, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Delete -or $e.KeyCode -eq [System.Windows.Forms.Keys]::Back) {
        $selectedIndex = $fordaw_fileList.SelectedIndex
        if ($selectedIndex -ge 0) {
            $fordaw_fileList.Items.RemoveAt($selectedIndex)
        }
    }
})
$fordaw_fileList.DrawMode = [System.Windows.Forms.DrawMode]::Normal
$fordaw_fileList.ItemHeight = 25
$OpenFileDialog1 = (New-Object -TypeName System.Windows.Forms.OpenFileDialog)
$fordaw_Panel.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).BeginInit()
$fordaw_Form.SuspendLayout()
#
#fordaw_Panel
#
$fordaw_Panel.Controls.Add($fordaw_Label4)
$fordaw_Panel.Controls.Add($fordaw_Label3)
$fordaw_Panel.Controls.Add($fordaw_Label2)
$fordaw_Panel.Controls.Add($fordaw_crf_current)
$fordaw_Panel.Controls.Add($fordaw_Label1)
$fordaw_Panel.Controls.Add($fordaw_crf)
$fordaw_Panel.Controls.Add($fordaw_preview)
$fordaw_Panel.Controls.Add($fordaw_start)
$fordaw_Panel.Controls.Add($fordaw_open)
$fordaw_Panel.Controls.Add($fordaw_fileList)
$fordaw_Panel.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
$fordaw_Panel.Name = [System.String]'fordaw_Panel'
$fordaw_Panel.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]488,[System.Int32]318))
$fordaw_Panel.TabIndex = [System.Int32]0
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
$fordaw_preview.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]263))
$fordaw_preview.Name = [System.String]'fordaw_preview'
$fordaw_preview.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]104,[System.Int32]24))
$fordaw_preview.TabIndex = [System.Int32]2
$fordaw_preview.Text = [System.String]'30s preview'
$fordaw_preview.UseVisualStyleBackColor = $true
#
#fordaw_start
#
$fordaw_start.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]385,[System.Int32]263))
$fordaw_start.Name = [System.String]'fordaw_start'
$fordaw_start.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$fordaw_start.TabIndex = [System.Int32]1
$fordaw_start.Text = [System.String]'Start'
$fordaw_start.UseVisualStyleBackColor = $true
#
#fordaw_open
#
$fordaw_open.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]12))
$fordaw_open.Name = [System.String]'fordaw_open'
$fordaw_open.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]23))
$fordaw_open.TabIndex = [System.Int32]0
$fordaw_open.Text = [System.String]'Open Files'
$fordaw_open.UseVisualStyleBackColor = $true
#
#fordaw_fileList
#
$fordaw_fileList.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]24,[System.Int32]50))
$fordaw_fileList.Name = [System.String]'fordaw_fileList'
$fordaw_fileList.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]436,[System.Int32]134))
$fordaw_fileList.TabIndex = [System.Int32]6
$fordaw_fileList.ItemHeight = 25
$fordaw_fileList.Add_KeyDown({
    param ($s, $e)
    if ($e.KeyCode -eq [System.Windows.Forms.Keys]::Delete -or $e.KeyCode -eq [System.Windows.Forms.Keys]::Back) {
        $selectedIndex = $fordaw_fileList.SelectedIndex
        if ($selectedIndex -ge 0) {
            $fordaw_fileList.Items.RemoveAt($selectedIndex)
        }
    }
})
$fordaw_fileList.DrawMode = [System.Windows.Forms.DrawMode]::Normal
#
#OpenFileDialog1
#
$OpenFileDialog1.FileName = [System.String]''
#
#fordaw_Form
#
$fordaw_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]484,[System.Int32]311))
$fordaw_Form.Controls.Add($fordaw_Panel)
$fordaw_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
$fordaw_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$fordaw_Form.Text = [System.String]'For DAW'
$fordaw_Panel.ResumeLayout($false)
$fordaw_Panel.PerformLayout()
([System.ComponentModel.ISupportInitialize]$fordaw_crf).EndInit()
$fordaw_Form.ResumeLayout($false)
Add-Member -InputObject $fordaw_Form -Name fordaw_Panel -Value $fordaw_Panel -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label4 -Value $fordaw_Label4 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label3 -Value $fordaw_Label3 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label2 -Value $fordaw_Label2 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_crf_current -Value $fordaw_crf_current -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_Label1 -Value $fordaw_Label1 -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_crf -Value $fordaw_crf -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_preview -Value $fordaw_preview -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_start -Value $fordaw_start -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_open -Value $fordaw_open -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name fordaw_fileList -Value $fordaw_fileList -MemberType NoteProperty
Add-Member -InputObject $fordaw_Form -Name OpenFileDialog1 -Value $OpenFileDialog1 -MemberType NoteProperty
}
. InitializeComponent
