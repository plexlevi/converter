Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'replace_audio.designer.ps1')
$replace_audio.ShowDialog()