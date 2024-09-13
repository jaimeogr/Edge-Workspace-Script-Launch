# Get the current username
$username = $env:USERNAME

# Define the path to the JSON file using the current username
$jsonFilePath = "C:\Users\$username\AppData\Local\Microsoft\Edge\User Data\Default\Workspaces\WorkspacesCache"

# Read and parse the JSON file
$jsonContent = Get-Content -Path $jsonFilePath -Raw | ConvertFrom-Json

# Check if the JSON content has workspaces
if ($null -eq $jsonContent.workspaces) {
    Write-Host "No workspaces found in the JSON file."
    exit
}

# Enumerate each workspace and append its name to a new array
$workspacesArray = @()
foreach ($workspace in $jsonContent.workspaces) {
    $workspacesArray += $workspace.name
}

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

            Write-Host "$inputChar"
            $substring = $globalValidCharacters.Substring(1, $Number_Of_Items)
            Write-Host "$substring"

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

# launches edge workspace window
function Open-EdgeWorkspaceWindow {
    param (
        [string]$Selected_Workspace_Name,
        [string]$Selected_Workspace_ID
    )
    Write-Host "Will open workspace id: $($Selected_Workspace_ID)"
    # Launch Microsoft Edge with the selected workspace
    Write-Host "Launching Microsoft Edge for workspace: $($Selected_Workspace_Name)"
    Start-Process -FilePath "msedge.exe" -ArgumentList "--launch-workspace=$Selected_Workspace_ID --start-maximized --no-startup-window"
}


# Enumerate each workspace with an index and its name
Show-ListOfItems -Items $workspacesArray


# Prompt user to select a workspace by index
$keyStroke = Read-SingleKey -Number_Of_Items $workspacesArray.Count

Write-Host "keyStroke: $keyStroke"


if ($keyStroke -eq 0) {
    Write-Host "Exiting the script."
    exit
}


Write-Host "keyStroke type: $($keyStroke.GetType())"
Write-Host "keyStroke length: $($keyStroke.Length)"
Write-Host "keyStroke: ${keyStroke}"
Write-Host "keyStroke: ${keyStroke}"

# # Display ASCII or Unicode values for keyStroke
# $keyStrokeBytes = [System.Text.Encoding]::UTF8.GetBytes($keyStroke)
# Write-Host "keyStroke byte values: $($keyStrokeBytes -join ', ')"

# # Display ASCII or Unicode values for globalValidCharacters
# $globalValidCharactersBytes = [System.Text.Encoding]::UTF8.GetBytes($globalValidCharacters)
# Write-Host "globalValidCharacters byte values: $($globalValidCharactersBytes -join ', ')"


# Get the index of the character
$index = $globalValidCharacters.IndexOf([char]$keyStroke) - 1
Write-Host "index: $index"
Write-Host "index: $index"


# Get the selected workspace
$selectedWorkspace = $jsonContent.workspaces[$index]
$workspaceID = $selectedWorkspace.id
$workspaceName = $selectedWorkspace.name

Write-Host "Workspace: $selectedWorkspace"
Write-Host "ID: $workspaceID"
Write-Host "Name: $workspaceName"



# if the workspace has the word "ship", but "shipping" will be false. then it will prompt to open a project in visual studio code and a powershell window.
if ($selectedWorkspace.name -match '\bship\b' -or $selectedWorkspace.name -eq 'DS') {
    $projectsFoldersPath = "C:\Users\$username\OneDrive\Documentos\Projects"
	
    # Check for available folders in the specified directory
    $folders = Get-ChildItem -Path $projectsFoldersPath -Directory

    $folders[0]
    if ($folders.Count -eq 0) {
        Write-Host "No folders found in the directory: $projectsFoldersPath"
    }
    else {
        $foldersArray = @()
        foreach ($f in $folders) {
            $foldersArray += $f.Name
        }
        Write-Host "Projects available:"
        Show-ListOfItems -Items $foldersArray

        $chosenFolder = Read-SingleKey -Number_Of_Items $foldersArray.Count
        Write-Host "chosenFolder: $chosenFolder"

        if ($chosenFolder -eq 0) {
            Open-EdgeWorkspaceWindow -Selected_Workspace_ID $workspaceID -Selected_Workspace_Name $workspaceName
            Write-Host "Exiting the script."
            exit
        } else {
            $folderIndex = $globalValidCharacters.IndexOf([char]$chosenFolder) - 1
            $selectedFolder = $folders[$folderIndex].FullName
            Write-Host "Opening Visual Studio and PowerShell in folder: $selectedFolder"
            # Open Visual Studio Code in the selected folder
            Start-Process -FilePath "code" -ArgumentList $selectedFolder -WindowStyle Hidden
            # Open PowerShell in the selected folder
            Start-Process -FilePath "powershell.exe" -WorkingDirectory $selectedFolder -WindowStyle Maximized
            Open-EdgeWorkspaceWindow -Selected_Workspace_ID $workspaceID -Selected_Workspace_Name $workspaceName

        }
    }
}


exit