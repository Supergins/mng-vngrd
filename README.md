# mng-vngrd

---

This is a simple batch script meant to manage RIOT Vanguard startup settings. It was originally made for Valorant but should still work the same now that both **League of Legends** and **Valorant** have it. It's for peapole that dont play this games every day and don't want anti-cheat running 24/7 at every boot or need to disable Vanguard because it's blocking something they use.

It's basically a interactive batch script version of code in [this](https://gist.github.com/AndrewMast/742ac7e07c37096017e907b0fd8ec7bb) Gist discussion.

## Features

- Can modify the default startup setting of Vanguard services (vgc and vgk). Both enabling and disabling them (feature missing in Vanguard Tray).
- Can disable Vanguard for the current session (same feature avaiable with the "Exit Vanguard" opion in Vanguard Tray).

## How to use?

- Just download mng-vngrd.bat file from this repository and run it WITH ADMINISTRATOR PRIVILEGES.
- It does not take any cli arguments, all inputs are taken directly from user during execution (use "y" and "n" keys on keyboard).
- Without administrator privileges it won't work properly and may not even be able to detect Vanguard on your machine.

## Vanguard Tray Icon

Please note that this script doesn't disable "vgtray.exe" autostart. If you don't want to see it popping up on your task bar disable it manually in Windows autostart settings. It should be listed as either "vgtray.exe" or "Vanguard Tray Notification". You can freely disable it since Vanguard relys on services to work and this porcess is only for you to get notifications from Vanguard and to be able to close Vanguard completely for the current session. You don't need it since my script does the same thing and also has option to completly enable/disable Vanguard services loading on startup.

## What does it affect?

From what I know there are 3 things that Vanguard uses:

- vgtray.exe -> Process responsuble for tray icon.
- vgc -> One of Vanguard's services.
- vgk -> Another Vanduard's service.

This script covers all of the above.
