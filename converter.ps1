Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'converter.designer.ps1')
$Form1.ShowDialog()