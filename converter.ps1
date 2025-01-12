# Beállítjuk a szkript útvonalát
$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
Add-Type -AssemblyName System.Windows.Forms

. (Join-Path $scriptRoot 'converter.designer.ps1')

# Köszöntő szöveg kiírása a konzolban
Write-Host @"
 _____     __          __   _____                          _            
|  __ \   /\ \        / /  / ____|                        | |           
| |  | | /  \ \  /\  / /  | |     ___  _ ____   _____ _ __| |_ ___ _ __ 
| |  | |/ /\ \ \/  \/ /   | |    / _ \| '_ \ \ / / _ \ '__| __/ _ \ '__|
| |__| / ____ \  /\  /    | |___| (_) | | | \ V /  __/ |  | ||  __/ |   
|_____/_/    \_\/  \/      \_____\___/|_| |_|\_/ \___|_|   \__\___|_|   
"@
Write-Host ([System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::Default.GetBytes("---------------------Created By Levente Géczy (2025)--------------------")))
Write-Host "Welcome to the Video Converter software!"
Write-Host ""


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
