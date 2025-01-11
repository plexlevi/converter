Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$ContextMenuStrip1_Opening = {
}

function InitializeComponent
{
    $Form1 = (New-Object -TypeName System.Windows.Forms.Form) # Inicializáld a $Form1 objektumot itt
    $resources = . (Join-Path $PSScriptRoot 'converter.resources.ps1')
    $MenuStrip1 = (New-Object -TypeName System.Windows.Forms.MenuStrip)
    $AudioToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $MergeToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $SeparateToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $VideoToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $ForDAWToolStripMenuItem = (New-Object -TypeName System.Windows.Forms.ToolStripMenuItem)
    $Panel1 = (New-Object -TypeName System.Windows.Forms.Panel)
    $MenuStrip1.SuspendLayout()
    $Form1.SuspendLayout() # Itt hívod meg a SuspendLayout metódust

    # MenuStrip1
    $MenuStrip1.Items.AddRange([System.Windows.Forms.ToolStripItem[]]@($AudioToolStripMenuItem,$VideoToolStripMenuItem))
    $MenuStrip1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]0))
    $MenuStrip1.Name = [System.String]'MenuStrip1'
    $MenuStrip1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]607,[System.Int32]24))
    $MenuStrip1.TabIndex = [System.Int32]0
    $MenuStrip1.Text = [System.String]'MenuStrip1'

    # AudioToolStripMenuItem
    $AudioToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($MergeToolStripMenuItem,$SeparateToolStripMenuItem))
    $AudioToolStripMenuItem.Name = [System.String]'AudioToolStripMenuItem'
    $AudioToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]51,[System.Int32]20))
    $AudioToolStripMenuItem.Text = [System.String]'Audio'

    # MergeToolStripMenuItem
    $MergeToolStripMenuItem.Name = [System.String]'MergeToolStripMenuItem'
    $MergeToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]22))
    $MergeToolStripMenuItem.Text = [System.String]'Merge'

    # SeparateToolStripMenuItem
    $SeparateToolStripMenuItem.Name = [System.String]'SeparateToolStripMenuItem'
    $SeparateToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]22))
    $SeparateToolStripMenuItem.Text = [System.String]'Separate'

    # VideoToolStripMenuItem
    $VideoToolStripMenuItem.DropDownItems.AddRange([System.Windows.Forms.ToolStripItem[]]@($ForDAWToolStripMenuItem))
    $VideoToolStripMenuItem.Name = [System.String]'VideoToolStripMenuItem'
    $VideoToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]49,[System.Int32]20))
    $VideoToolStripMenuItem.Text = [System.String]'Video'

    # ForDAWToolStripMenuItem
    $ForDAWToolStripMenuItem.Name = [System.String]'ForDAWToolStripMenuItem'
    $ForDAWToolStripMenuItem.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]152,[System.Int32]22))
    $ForDAWToolStripMenuItem.Text = [System.String]'For DAW'
    $ForDAWToolStripMenuItem.add_Click({ ForDAWToolStripMenuItem_Click })

    # Panel1
    $Panel1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]0,[System.Int32]27))
    $Panel1.Name = [System.String]'Panel1'
    $Panel1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]607,[System.Int32]418))
    $Panel1.TabIndex = [System.Int32]1

    # Form1
    $Form1.BackColor = [System.Drawing.Color]::LightGray
    $Form1.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]607,[System.Int32]444))
    $Form1.Controls.Add($Panel1)
    $Form1.Controls.Add($MenuStrip1)
    $Form1.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
    $Form1.Icon = ([System.Drawing.Icon]$resources.'$this.Icon')
    $Form1.MainMenuStrip = $MenuStrip1
    $Form1.MaximizeBox = $false
    $Form1.MinimizeBox = $false
    $Form1.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
    $Form1.Text = [System.String]'Converter'
    $MenuStrip1.ResumeLayout($false)
    $MenuStrip1.PerformLayout()
    $Form1.ResumeLayout($false) # Itt hívod meg a ResumeLayout metódust
    $Form1.PerformLayout()

    Add-Member -InputObject $Form1 -Name MenuStrip1 -Value $MenuStrip1 -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name AudioToolStripMenuItem -Value $AudioToolStripMenuItem -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name MergeToolStripMenuItem -Value $MergeToolStripMenuItem -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name SeparateToolStripMenuItem -Value $SeparateToolStripMenuItem -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name VideoToolStripMenuItem -Value $VideoToolStripMenuItem -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name ForDAWToolStripMenuItem -Value $ForDAWToolStripMenuItem -MemberType NoteProperty -Force
    Add-Member -InputObject $Form1 -Name Panel1 -Value $Panel1 -MemberType NoteProperty -Force
}

function ForDAWToolStripMenuItem_Click {
    # Clear the Panel1
    $Form1.Panel1.Controls.Clear()

    # Load and execute the video.ps1 file
    . (Join-Path $PSScriptRoot 'video.ps1')
}

. InitializeComponent

$Form1.ShowDialog()
