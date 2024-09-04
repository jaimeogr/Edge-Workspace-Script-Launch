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

# Enumerate each workspace with a number and its name
Write-Host "Available Workspaces:"
$counter = 1
foreach ($workspace in $jsonContent.workspaces) {
    Write-Host "$counter`: $($workspace.name)"
    $counter++
}
Write-Host "0: Exit"  # Adding an option to exit


# Function to read a single key input without requiring Enter
function Read-SingleKey {
    $key = $null
    while ($null -eq $key) {
        if ([System.Console]::KeyAvailable) {
            $key = [System.Console]::ReadKey($true)
        }
    }
    return $key
}


# Prompt user to select a workspace by number
do {
    Write-Host "Enter the number of the workspace you want to open (or 0 to exit):"

    $keyInfo = Read-SingleKey


    # Check if the key input is a number
    if ($keyInfo.KeyChar -match '^\d$') {
        # Convert the key character to a string and then to an integer
        $selectedIndex = [int]$keyInfo.KeyChar.ToString() 
        
        if ($selectedIndex -eq 0) {
            Write-Host "Exiting the script."
            exit
        }
        elseif ($selectedIndex -ge 1 -and $selectedIndex -le $jsonContent.workspaces.Count) {
            $isValid = $true
        }
        else {
            Write-Host "Invalid selection. Please enter a valid number between 1 and $($jsonContent.workspaces.Count), or 0 to exit."
            $isValid = $false
        }
    }
    else {
        Write-Host "Invalid input. Please enter a number."
        $isValid = $false
    }

} until ($isValid)


# Get the selected workspace
$selectedWorkspace = $jsonContent.workspaces[$selectedIndex - 1]
$workspaceID = $selectedWorkspace.id


# if the workspace has the word "ship", but "shipping" will be false. then it will prompt to open a project in visual studio code and a powershell window.
if ($selectedWorkspace.name -match '\bship\b' -or $selectedWorkspace.name -eq 'DS') {
    $projectsFoldersPath = "C:\Users\$username\OneDrive\Documentos\Projects"
	
    # Check for available folders in the specified directory
    $folders = Get-ChildItem -Path $projectsFoldersPath -Directory

    if ($folders.Count -eq 0) {
        Write-Host "No folders found in the directory: $projectsFoldersPath"
    } else {
        Write-Host "Projects available:"
        $counter = 1
        foreach ($folder in $folders) {
            Write-Host "$counter`: $($folder.Name)"
            $counter++
        }
        Write-Host "0: Exit"  # Adding an option to exit


        do {
            Write-Host "Enter the number of the folder you want to open in Visual Studio and PowerShell:"
            # Prompt user to select a folder
            $keyStroke = Read-SingleKey
            $selectedFolderIndex = [int]$keyStroke.KeyChar.ToString()


            if ($selectedFolderIndex -eq 0) {
                Write-Host "Exiting the script."
                exit
            }
            if ($selectedFolderIndex -ge 1 -and $selectedFolderIndex -le $folders.Count) {
                $selectedFolder = $folders[$selectedFolderIndex - 1].FullName
                Write-Host "Opening Visual Studio and PowerShell in folder: $selectedFolder"
            
                # Open Visual Studio Code in the selected folder
                # method 1
                Start-Process -FilePath "code" -ArgumentList $selectedFolder

                # method 2
                #Start-Process cmd.exe -ArgumentList "/c code `"$selectedFolder`""


                # Open PowerShell in the selected folder
                #method 1
                Start-Process -FilePath "powershell.exe" -WorkingDirectory $selectedFolder
                
                # method 2
                #Set-Location $selectedFolder
                #& powershell.exe -NoExit

                # method 3
                #Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "cd `"$selectedFolder`""
                $isValid = $true
            }
            else {
                Write-Host "Invalid selection. Try Again."
                $isValid = $false
            }
        } until ($isValid)
    }
}

# Launch Microsoft Edge with the selected workspace
Write-Host "Launching Microsoft Edge for workspace: $($selectedWorkspace.name)"
Start-Process -FilePath "msedge.exe" -ArgumentList "--launch-workspace=$workspaceID --start-maximized --no-startup-window"

exit