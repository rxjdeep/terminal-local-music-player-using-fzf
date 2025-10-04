# Music Management Script

This is a script that helps you quickly access and play music files from your collection. The script allows you to search for music files or folders within your specified music directory and play the selected files using `mpv`.
Available for Windows Powershell and Linux Bash

## Features

- Search and play music files within a specified directory.
- Filter results by exact folder names to display only the contents of that folder. (by searching like /chill/song.mp3)
- Supports real-time filtering with `fzf`.

## Setup (Windows Powershell):

To set up and use the script on a Windows machine, please follow these steps:

1. Run with Elevated Privileges

    Ensure that you execute the following setup steps with administrative privileges to avoid permission issues.


2. Install Dependencies

    The script requires the following dependencies:
   
       - mpv: A media player for playing audio and video files.
       - fzf: A command-line fuzzy finder for real-time search and filtering.

    You can install these dependencies using the following methods:
   
        - For mpv, download and install it from the official mpv website.
        - For fzf, follow the installation instructions provided on the fzf GitHub page.
   

4. Copy the Script to PowerShell Startup Configuration

      Save the win-script-music.ps1 script.

      Open your PowerShell profile configuration file, typically located at `C:\Users\<YourUsername>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`.

      Copy my exact script text to 'Microsoft.PowerShell_profile.ps1' or you can even the add the following line to include the script in your PowerShell session:

    `."<path-to-your-script>\win-script-music.ps1"`

    Replace <path-to-your-script> with the actual path where you saved the `win-script-music.ps1` script.


5. Restart PowerShell


6. Get Started

    Type `music` in the PowerShell terminal to run the script.
    Follow the prompt to search for and play music files from your local collection.


## Setup (Linux Bash):
lol here's a one liner (run either of these):

`mpv "$(cd <you_music_folder_path> && echo ''$(pwd)'/'$(fzf -e)'')"`
`mpv <your_music_folder_path>/"$(du -h /run/user/1000/kio-fuse*/sftp/s23/sdcard/Music | fzf -e)"`
`mpv -- "$(find <your_music_folder_path> -type f -printf '%p\t%P\n' \
  | fzf -e --delimiter=$'\t' --with-nth=2 \
  | cut -f1)"`


