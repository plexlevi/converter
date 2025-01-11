$Form1 = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.MenuStrip]$MenuStrip1 = $null
[System.Windows.Forms.ToolStripMenuItem]$VideoToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$ForDAWToolStripMenuItem = $null
function InitializeComponent
{
$MenuStrip1 = (New-Object -TypeName System.Windows.Forms.MenuStrip)
$VideoToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$ForDAWToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
$MenuStrip1.SuspendLayout()
$Form1.SuspendLayout()
#
#MenuStrip1
#
$MenuStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($VideoToolStripMenuItem))
$MenuStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
$MenuStrip1.Name = [System.String]'MenuStrip1'
$MenuStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]437,[System.Int32]24))
$MenuStrip1.TabIndex = [System.Int32]0
$MenuStrip1.Text = [System.String]'MenuStrip1'
#
#VideoToolStripMenuItem
#
$VideoToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($ForDAWToolStripMenuItem))
$VideoToolStripMenuItem.Name = [System.String]'VideoToolStripMenuItem'
$VideoToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]49,[System.Int32]20))
$VideoToolStripMenuItem.Text = [System.String]'Video'
#
#ForDAWToolStripMenuItem
#
$ForDAWToolStripMenuItem.Name = [System.String]'ForDAWToolStripMenuItem'
$ForDAWToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]22))
$ForDAWToolStripMenuItem.Text = [System.String]'For DAW'
#
#Form1
#
$Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]437,[System.Int32]290))
$Form1.Controls.Add($MenuStrip1)
$Form1.MainMenuStrip = $MenuStrip1
$Form1.Text = [System.String]'Form1'
$MenuStrip1.ResumeLayout($false)
$MenuStrip1.PerformLayout()
$Form1.ResumeLayout($false)
$Form1.PerformLayout()
Add-Member -InputObject $Form1 -Name MenuStrip1 -Value $MenuStrip1 -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name VideoToolStripMenuItem -Value $VideoToolStripMenuItem -MemberType NoteProperty
Add-Member -InputObject $Form1 -Name ForDAWToolStripMenuItem -Value $ForDAWToolStripMenuItem -MemberType NoteProperty
}
. InitializeComponent
