# Beállítjuk a szkript útvonalát
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $scriptRoot 'converter.designer.ps1')

# Ellenőrizzük, hogy a Converter_Form és annak elemei helyesen inicializálódtak-e
if ($null -eq $Converter_Form -or $null -eq $Converter_Form.ForDAWToolStripMenuItem -or $null -eq $Converter_Form.Converter_Panel1) {
    Write-Error "The Converter_Form or one of its components is null. Please check the initialization."
    return
}

# Eseménykezelő hozzáadása a For DAW gombhoz
$Converter_Form.ForDAWToolStripMenuItem.add_Click({
    # Dinamikusan betöltjük a fordaw.designer.ps1 és fordaw.ps1 fájlokat
    $fordawDesignerPath = Join-Path $scriptRoot 'fordaw.designer.ps1'
    $fordawScriptPath = Join-Path $scriptRoot 'fordaw.ps1'

    # Beolvassuk és futtatjuk a fordaw.designer.ps1 szkriptet
    . $fordawDesignerPath

    # Beolvassuk és futtatjuk a fordaw.ps1 szkriptet anélkül, hogy megnyitná a formot
    . $fordawScriptPath

    # Hozzáadjuk a fordaw_Panel vezérlőit a Converter_Panel1-hez
    $Converter_Form.Converter_Panel1.Controls.Clear()

    # Add fordaw_Panel to Converter_Panel1
    $Converter_Form.Converter_Panel1.Controls.Add($fordaw_Form.fordaw_Panel)

    $Converter_Form.Converter_Panel1.Refresh()
})

$Converter_Form.ShowDialog()
