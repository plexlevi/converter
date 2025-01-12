# Beállítjuk a szkript útvonalát
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Add-Type -AssemblyName System.Windows.Forms

. (Join-Path $scriptRoot 'converter.designer.ps1')

# Köszöntő szöveg kiírása a konzolban
Write-Host "DAW Converter v.0.2"
Write-Host ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("Created By Levente Géczy")))
Write-Host "DAW Converter v.0.2'2025"

# Eseménykezelő hozzáadása a Video Convert gombhoz
$Converter_Form.video_convert.add_Click({
    # Beolvassuk és futtatjuk a fordaw.ps1 szkriptet
    $fordawScriptPath = Join-Path $scriptRoot 'fordaw.ps1'
    . $fordawScriptPath
})

# Eseménykezelő hozzáadása a Converter_Form bezárásához
$Converter_Form.add_FormClosing({
    # Üzenet kiírása a konzolban
    Write-Host "The software is closing... Bye! :)"

    # Konzol ablak bezárása, amikor a főablak bezáródik
    [System.Environment]::Exit(0)
})

$Converter_Form.ShowDialog()
