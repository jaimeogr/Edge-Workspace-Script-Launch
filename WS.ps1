
# Function to read a single key input without requiring Enter
$globalValidCharacters = "0123456789QWERTYUIOPASDFGHJKLZXCVBNM"

# displays items for workspaces or for projects
function Show-ListOfItems {
    param (
        [string[]]$Items
    )
    for ($i = 0; $i -lt $Items.Count; $i++) {
        $currentChar = $globalValidCharacters[$i + 1]  # Select a character from the global valid characters
        Write-Host "${currentChar}: $($Items[$i])"  
    }
    Write-Host "0: Exit"  # Adding an option to exit
}

# reads a single keystroke from the globalValidCharacters variable
function Read-SingleKey {
    param (
        [int]$Number_Of_Items
    )
    $Number_Of_Items = $Number_Of_Items + 1 #to consider the 0, the first value
    $key = $null
    while ($null -eq $key) {
        if ([System.Console]::KeyAvailable) {
            $key = [System.Console]::ReadKey($true)

            # Convert the pressed key to uppercase
            $inputChar = $key.KeyChar.ToString().ToUpper()

            $substring = $globalValidCharacters.Substring(1, $Number_Of_Items)
            
            if ($inputChar -eq 0) {
                $key = '0'
                return $key
            }
            # Check if the uppercase character is in the list of valid characters
            if ($substring.Contains($inputChar)) {
                return $inputChar  # Return the valid uppercase character
            }
            else {
                # Invalid key, reset $key to null to keep waiting
                $key = $null
            }
        }
    }
}


$projectsFoldersPath = "C:\Projects"

# Check for available folders in the specified directory
$folders = Get-ChildItem -Path $projectsFoldersPath -Directory

if ($folders.Count -eq 0) {
    Write-Host "No folders found in the directory: $projectsFoldersPath"
}
else {
    $foldersArray = @()
    foreach ($f in $folders) {
        $foldersArray += $f.Name
    }
    Write-Host "`nProjects available:"
    Show-ListOfItems -Items $foldersArray

    $chosenFolder = Read-SingleKey -Number_Of_Items $foldersArray.Count

    if ($chosenFolder -eq 0) {
        Write-Host "Exiting the script."
        exit
    }
    else {
        $folderIndex = $globalValidCharacters.IndexOf([char]$chosenFolder) - 1
        $selectedFolder = $folders[$folderIndex].FullName
        
        if ( $selectedFolder -eq "C:\Projects\Jardinero-Gaucho") {
            # If the project is Jardinero-Gaucho
            Write-Host "`nRun android emulator or not?"
        
            # Define emulator options
            $androidEmulatorOptions = @("Yes", "No")
            Show-ListOfItems -Items $androidEmulatorOptions

            # Read user's choice
            $runAndroidEmulator = Read-SingleKey -Number_Of_Items $androidEmulatorOptions.Count

            if ($runAndroidEmulator -eq "1") {
                # User chose to run the Android emulator
                Start-Process -FilePath "wt.exe" -ArgumentList "-p Root powershell.exe -NoExit -Command npm run c1 ; new-tab -p Root ; new-tab -p Frontend ; new-tab -p Frontend ; new-tab -p Backend ; new-tab -p Backend" -WindowStyle Maximized
            }
            else {
                Start-Process -FilePath "wt.exe" -ArgumentList "-p Root ; new-tab -p Root ; new-tab -p Frontend ; new-tab -p Frontend ; new-tab -p Backend ; new-tab -p Backend" -WindowStyle Maximized
            }
        }
        else {
            # if the project is not Jardinero-Gaucho
            # Open Windows Terminal in the selected folder with 3 tabs
            Start-Process -FilePath "wt.exe" -ArgumentList "-d `"$selectedFolder`" ; new-tab -d `"$selectedFolder`" ; new-tab -d `"$selectedFolder`" ; new-tab -d `"$selectedFolder`"" -WindowStyle Maximized
        }

        # Open the selected folder in File Explorer
        Start-Process explorer.exe -ArgumentList $selectedFolder
        
        # Open Visual Studio Code in the selected folder
        Start-Process -FilePath "code" -ArgumentList $selectedFolder -WindowStyle Hidden
    }
}

Start-Process -FilePath "msedge.exe" -ArgumentList "--start-maximized --no-startup-window"


exit