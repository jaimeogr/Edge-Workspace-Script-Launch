You should set your antivirus to constantly analyze this scripts i guess, or whatever.
Cheers!

Move the shortcut (.lnk file) to the desktop for easy access.
Youll need to modify some path files probably, too easy.
%SOFTWARE_PROJECTS% is one environment variable that needs to direct towards your projects folder.
Projects could be just at the root of C disk, this will help avoid problems with OneDrive.




This is a possible version of the 'settings.json' file for the settings of Powershell:

{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": 
    [
        {
            "command": 
            {
                "action": "copy",
                "singleLine": false
            },
            "id": "User.copy.644BA8F2",
            "keys": "ctrl+c"
        },
        {
            "command": "paste",
            "id": "User.paste",
            "keys": "ctrl+v"
        },
        {
            "command": 
            {
                "action": "splitPane",
                "split": "auto",
                "splitMode": "duplicate"
            },
            "id": "User.splitPane.A6751878",
            "keys": "alt+shift+d"
        },
        {
            "command": "find",
            "id": "User.find",
            "keys": "ctrl+shift+f"
        }
    ],
    "confirmCloseAllTabs": false,
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
    "launchMode": "maximized",
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        }
    ],
    "profiles": 
    {
        "defaults": 
        {
            "colorScheme": "Dracula",
            "font": 
            {
                "face": "Hack Nerd Font Mono"
            },
            "useAcrylic": false
        },
        "list": 
        [
            {
                "name": "Root",
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{8d89f31d-18ef-4ed8-b7e2-eebf2263431d}",
                "startingDirectory": "%SOFTWARE_PROJECTS%\\Jardinero-Gaucho",
                "icon": "C:\\Icons\\orange.png"
            },
            {
                "name": "Frontend",
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{f3fe7341-93af-4010-9ceb-77f573f8b380}",
                "startingDirectory": "%SOFTWARE_PROJECTS%\\Jardinero-Gaucho\\apps\\frontend",
                "icon": "C:\\Icons\\purple-square.png"
            },
            {
                "name": "Backend",
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{7ea0217e-a9d7-4ce0-8028-8a8ac79ab4bb}",
                "startingDirectory": "%SOFTWARE_PROJECTS%\\Jardinero-Gaucho\\apps\\backend",
                "icon": "C:\\Icons\\green-circle.png"
            },
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell",
                "startingDirectory": "%SOFTWARE_PROJECTS%"
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "Command Prompt"
            },
            {
                "guid": "{b453ae62-4e3d-5e58-b989-0a998ec441b8}",
                "hidden": false,
                "name": "Azure Cloud Shell",
                "source": "Windows.Terminal.Azure"
            }
        ]
    },
    "schemes": 
    [
        {
            "background": "#080808",
            "black": "#0A0A0A",
            "blue": "#0037DA",
            "brightBlack": "#767676",
            "brightBlue": "#3B78FF",
            "brightCyan": "#61D6D6",
            "brightGreen": "#16C60C",
            "brightPurple": "#B4009E",
            "brightRed": "#E74856",
            "brightWhite": "#F2F2F2",
            "brightYellow": "#F9F1A5",
            "cursorColor": "#FFFFFF",
            "cyan": "#3A96DD",
            "foreground": "#CCCCCC",
            "green": "#13A10E",
            "name": "Campbell (modified)",
            "purple": "#881798",
            "red": "#C50F1F",
            "selectionBackground": "#FFFFFF",
            "white": "#CCCCCC",
            "yellow": "#C19C00"
        },
        {
            "background": "#1E1F29",
            "black": "#000000",
            "blue": "#BD93F9",
            "brightBlack": "#555555",
            "brightBlue": "#BD93F9",
            "brightCyan": "#8BE9FD",
            "brightGreen": "#50FA7B",
            "brightPurple": "#FF79C6",
            "brightRed": "#FF5555",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#F1FA8C",
            "cursorColor": "#BBBBBB",
            "cyan": "#8BE9FD",
            "foreground": "#F8F8F2",
            "green": "#50FA7B",
            "name": "Dracula",
            "purple": "#FF79C6",
            "red": "#FF5555",
            "selectionBackground": "#44475A",
            "white": "#BBBBBB",
            "yellow": "#F1FA8C"
        },
        {
            "background": "#111927",
            "black": "#000000",
            "blue": "#004CFF",
            "brightBlack": "#666666",
            "brightBlue": "#5CB2FF",
            "brightCyan": "#5CECC6",
            "brightGreen": "#C5F467",
            "brightPurple": "#AE81FF",
            "brightRed": "#FF8484",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#FFCC5C",
            "cursorColor": "#FFFFFF",
            "cyan": "#2EE7B6",
            "foreground": "#D4D4D4",
            "green": "#9FEF00",
            "name": "xcad_hackthebox",
            "purple": "#BC3FBC",
            "red": "#FF3E3E",
            "selectionBackground": "#FFFFFF",
            "white": "#FFFFFF",
            "yellow": "#FFAF00"
        },
        {
            "background": "#1A1A1A",
            "black": "#121212",
            "blue": "#2B4FFF",
            "brightBlack": "#2F2F2F",
            "brightBlue": "#5C78FF",
            "brightCyan": "#5AC8FF",
            "brightGreen": "#905AFF",
            "brightPurple": "#5EA2FF",
            "brightRed": "#BA5AFF",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#685AFF",
            "cursorColor": "#FFFFFF",
            "cyan": "#28B9FF",
            "foreground": "#F1F1F1",
            "green": "#7129FF",
            "name": "xcad_tdl",
            "purple": "#2883FF",
            "red": "#A52AFF",
            "selectionBackground": "#FFFFFF",
            "white": "#F1F1F1",
            "yellow": "#3D2AFF"
        },
        {
            "background": "#0F0F0F",
            "black": "#000000",
            "blue": "#2878FF",
            "brightBlack": "#2F2F2F",
            "brightBlue": "#5E99FF",
            "brightCyan": "#5AD6FF",
            "brightGreen": "#FFB15A",
            "brightPurple": "#935CFF",
            "brightRed": "#FF755A",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#FFD25A",
            "cursorColor": "#FFFFFF",
            "cyan": "#28C8FF",
            "foreground": "#F1F1F1",
            "green": "#FF9A28",
            "name": "xcad_tdl_colorful",
            "purple": "#732BFF",
            "red": "#FF4C27",
            "selectionBackground": "#FFFFFF",
            "white": "#F1F1F1",
            "yellow": "#FFC72A"
        },
        {
            "background": "#0F0F0F",
            "black": "#000000",
            "blue": "#184AE8",
            "brightBlack": "#5F5F5F",
            "brightBlue": "#4771F5",
            "brightCyan": "#31C1FF",
            "brightGreen": "#FFD631",
            "brightPurple": "#7631FF",
            "brightRed": "#FF3190",
            "brightWhite": "#FFFFFF",
            "brightYellow": "#FF9731",
            "cursorColor": "#FFFFFF",
            "cyan": "#008DCB",
            "foreground": "#D9D9D9",
            "green": "#CBA300",
            "name": "xcad_tdl_old",
            "purple": "#4300CB",
            "red": "#CB005F",
            "selectionBackground": "#FFFFFF",
            "white": "#CFCFCF",
            "yellow": "#CB6600"
        },
        {
            "background": "#282C34",
            "black": "#000000",
            "blue": "#007ACC",
            "brightBlack": "#75715E",
            "brightBlue": "#11A8CD",
            "brightCyan": "#11A8CD",
            "brightGreen": "#0DBC79",
            "brightPurple": "#AE81FF",
            "brightRed": "#DD6B65",
            "brightWhite": "#F8F8F2",
            "brightYellow": "#E6DB74",
            "cursorColor": "#FFFFFF",
            "cyan": "#11A8CD",
            "foreground": "#D4D4D4",
            "green": "#0DBC79",
            "name": "xcad_vscode",
            "purple": "#BC3FBC",
            "red": "#F4423A",
            "selectionBackground": "#FFFFFF",
            "white": "#F8F8F2",
            "yellow": "#E5E510"
        }
    ],
    "themes": [],
    "useAcrylicInTabRow": true
}