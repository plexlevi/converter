$replace_audio = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.ListBox]$list_audios = $null
[System.Windows.Forms.ListBox]$list_videos = $null
[System.Windows.Forms.Button]$open_audios = $null
[System.Windows.Forms.Button]$open_videos = $null
[System.Windows.Forms.Button]$Button3 = $null
function InitializeComponent
{
$list_audios = (New-Object -TypeName System.Windows.Forms.ListBox)
$list_videos = (New-Object -TypeName System.Windows.Forms.ListBox)
$open_audios = (New-Object -TypeName System.Windows.Forms.Button)
$open_videos = (New-Object -TypeName System.Windows.Forms.Button)
$Button3 = (New-Object -TypeName System.Windows.Forms.Button)
$replace_audio.SuspendLayout()
#
#list_audios
#
$list_audios.FormattingEnabled = $true
$list_audios.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]42))
$list_audios.Name = [System.String]'list_audios'
$list_audios.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]250,[System.Int32]290))
$list_audios.TabIndex = [System.Int32]0
#
#list_videos
#
$list_videos.FormattingEnabled = $true
$list_videos.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]270,[System.Int32]42))
$list_videos.Name = [System.String]'list_videos'
$list_videos.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]250,[System.Int32]290))
$list_videos.TabIndex = [System.Int32]1
#
#open_audios
#
$open_audios.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]14,[System.Int32]13))
$open_audios.Name = [System.String]'open_audios'
$open_audios.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]120,[System.Int32]23))
$open_audios.TabIndex = [System.Int32]2
$open_audios.Text = [System.String]'Open Audios...'
$open_audios.UseVisualStyleBackColor = $true
#
#open_videos
#
$open_videos.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]270,[System.Int32]13))
$open_videos.Name = [System.String]'open_videos'
$open_videos.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]120,[System.Int32]23))
$open_videos.TabIndex = [System.Int32]3
$open_videos.Text = [System.String]'Open Videos...'
$open_videos.UseVisualStyleBackColor = $true
#
#Button3
#
$Button3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]229,[System.Int32]338))
$Button3.Name = [System.String]'Button3'
$Button3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]75,[System.Int32]44))
$Button3.TabIndex = [System.Int32]4
$Button3.Text = [System.String]'Add to Cue'
$Button3.UseVisualStyleBackColor = $true
#
#replace_audio
#
$replace_audio.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]535,[System.Int32]393))
$replace_audio.Controls.Add($Button3)
$replace_audio.Controls.Add($open_videos)
$replace_audio.Controls.Add($open_audios)
$replace_audio.Controls.Add($list_videos)
$replace_audio.Controls.Add($list_audios)
$replace_audio.Name = [System.String]'replace_audio'
$replace_audio.Text = [System.String]'Replace Audio'
$replace_audio.ResumeLayout($false)
Add-Member -InputObject $replace_audio -Name list_audios -Value $list_audios -MemberType NoteProperty
Add-Member -InputObject $replace_audio -Name list_videos -Value $list_videos -MemberType NoteProperty
Add-Member -InputObject $replace_audio -Name open_audios -Value $open_audios -MemberType NoteProperty
Add-Member -InputObject $replace_audio -Name open_videos -Value $open_videos -MemberType NoteProperty
Add-Member -InputObject $replace_audio -Name Button3 -Value $Button3 -MemberType NoteProperty
}
. InitializeComponent
