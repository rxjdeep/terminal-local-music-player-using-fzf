# PASTE THIS IN YOUR POWERSHELL SCRIPTS FILE WHICH IS USUALLY IN A FOLDER CALLED "WindowsPowershell" IN YOUR DOCUMENTS FOLDER. 
# The function name can be changed as well the search path.

function music {
    # Define the base music directory (the directory where your music or anything really, is saved)
    $musicDir = "$HOME\Music"

    # Get all items (files and directories) recursively from the base music directory
    $items = Get-ChildItem -Path $musicDir -Recurse

    # Extract folder names and file names for fzf
    $folders = $items | Where-Object { $_.PSIsContainer } | Select-Object -ExpandProperty FullName
    $files = $items | Where-Object { -not $_.PSIsContainer } | Select-Object -ExpandProperty FullName

    # Use fzf to select a folder or file
    $selectedItem = $folders + $files | ForEach-Object { $_.Substring($musicDir.Length + 1) } | fzf --prompt "Input Selection> "

    if ($selectedItem) {
        $selectedItemPath = Join-Path -Path $musicDir -ChildPath $selectedItem
        $selectedItemInfo = Get-Item -Path $selectedItemPath

        if ($selectedItemInfo.PSIsContainer) {
            # If the selected item is a folder, get all music files in that folder
            $filesInFolder = Get-ChildItem -Path $selectedItemPath -Recurse -File
            
            if ($filesInFolder.Count -eq 0) {
                Write-Host "No user files found in the selected folder."
                return
            }

            # Display filenames in fzf and select a file
            $selectedFileName = $filesInFolder | Select-Object -ExpandProperty Name | fzf --prompt "Select a file> "
            
            if ($selectedFileName) {
                # Get the full path of the selected filename
                $selectedFile = $filesInFolder | Where-Object { $_.Name -eq $selectedFileName } | Select-Object -ExpandProperty FullName
                Write-Host "Playing file: $selectedFile"
                
                # Play the selected file using mpv with these flags you can modify accordingly (or if you use vlc you can change this)
                mpv --no-video --resume-playback "$selectedFile"
            } else {
                Write-Host "No file selected."
            }
        } else {
            Write-Host "Playing file: $selectedItemPath"
            mpv --no-video --resume-playback "$selectedItemPath"
        }
    } else {
        Write-Host "No item selected."
    }

    cd "$HOME"
}

