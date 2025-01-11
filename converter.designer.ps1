$Converter_Form = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.MenuStrip]$MainMenu = $null
[System.Windows.Forms.ToolStripMenuItem]$VideoToolStripMenuItem = $null
[System.Windows.Forms.ToolStripMenuItem]$ForDAWToolStripMenuItem = $null
[System.Windows.Forms.Panel]$Converter_Panel1 = $null

function InitializeComponent
{
    $resources = . (Join-Path $PSScriptRoot 'converter.resources.ps1')
    $MainMenu = (New-Object -TypeName System.Windows.Forms.MenuStrip)
    $VideoToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $ForDAWToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $Converter_Panel1 = (New-Object -TypeName System.Windows.Forms.Panel)
    $MainMenu.SuspendLayout()
    $Converter_Form.SuspendLayout()
    
    # MainMenu
    $MainMenu.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($VideoToolStripMenuItem))
    $MainMenu.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
    $MainMenu.Name = [System.String]'MainMenu'
    $MainMenu.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]437,[System.Int32]24))
    $MainMenu.TabIndex = [System.Int32]0
    $MainMenu.Text = [System.String]'MenuStrip1'
    
    # VideoToolStripMenuItem
    $VideoToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($ForDAWToolStripMenuItem))
    $VideoToolStripMenuItem.Name = [System.String]'VideoToolStripMenuItem'
    $VideoToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]49,[System.Int32]20))
    $VideoToolStripMenuItem.Text = [System.String]'Video'
    
    # ForDAWToolStripMenuItem
    $ForDAWToolStripMenuItem.Name = [System.String]'ForDAWToolStripMenuItem'
    $ForDAWToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]22))
    $ForDAWToolStripMenuItem.Text = [System.String]'For DAW'
    
    # Converter_Panel1
    $Converter_Panel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]27))
    $Converter_Panel1.Name = [System.String]'Converter_Panel1'
    $Converter_Panel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]413,[System.Int32]251))
    $Converter_Panel1.TabIndex = [System.Int32]1
    
    # Converter_Form
    $Converter_Form.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]437,[System.Int32]290))
    $Converter_Form.Controls.Add($Converter_Panel1)
    $Converter_Form.Controls.Add($MainMenu)
    $Converter_Form.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Consolas',[System.Single]8.25,[System.Drawing.FontStyle]::Regular,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
    $Converter_Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $Converter_Form.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
    $Converter_Form.MainMenuStrip = $MainMenu
    $Converter_Form.MaximizeBox = $false
    $Converter_Form.Name = [System.String]'Converter_Form'
    $Converter_Form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $Converter_Form.Text = [System.String]'Converter'
    $MainMenu.ResumeLayout($false)
    $MainMenu.PerformLayout()
    $Converter_Form.ResumeLayout($false)
    $Converter_Form.PerformLayout()
    
    Add-Member -InputObject $Converter_Form -Name MainMenu -Value $MainMenu -MemberType NoteProperty
    Add-Member -InputObject $Converter_Form -Name VideoToolStripMenuItem -Value $VideoToolStripMenuItem -MemberType NoteProperty
    Add-Member -InputObject $Converter_Form -Name ForDAWToolStripMenuItem -Value $ForDAWToolStripMenuItem -MemberType NoteProperty
    Add-Member -InputObject $Converter_Form -Name Converter_Panel1 -Value $Converter_Panel1 -MemberType NoteProperty
}
. InitializeComponent
