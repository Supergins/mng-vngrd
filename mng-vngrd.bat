@echo off
echo You're running 'mng-vngrd.bat' script.
echo This script allows you to quickly enable/disable Vanguard individual services startup
echo and disable Vanguard for the current session.
echo ATTENTION: THIS SCRIPT HAS TO BE RUN AS ADMIN TO WORK PROPERLY.
echo NOTE: If you don't want to see Vanguard Tray notification icon on your task bar
echo you have to manually disable it in Windows' autostart settings. You don't have
echo to have the notification icon process running to play VALORANT.
echo This script already provides the same functionality of that tray process.
echo.


@REM Check vgc service status and if it exists
@REM enables or disables service depending on user input.
echo -------------------------------------------------------------
echo        Checking vgc service status...
sc qc "vgc" >nul
if ERRORLEVEL 1 (
    echo [WARNING]: vgc service is not present on this machine. If thats not the case make sure you are running this script as admin.
) else (
    echo [Success]: vgc service found. && echo.

    for /f "tokens=3 delims=: " %%H in ('sc qc "vgc" ^| findstr /i "START_TYPE"') do (
        echo current status is set to: %%H && echo.
        if /i "%%H" EQU "DEMAND_START" (
            choice /c ny /n /t 180 /d y /m "DO YOU WANT TO DISABLE vgc SERVICE STARTUP? [Y/n]    "
            if ERRORLEVEL 2 (
                echo.
                echo        Disabling vgc...
                sc config vgc start= disabled >nul && echo [Success]: vgc service successfully disabled. || echo [ERROR]: Failed to disable vgc service autostart. Check if you are running this script as admin. && goto error
            )
        ) else (
            choice /c ny /n /t 180 /d y /m "DO YOU WANT TO ENABLE vgc SERVICE STARTUP? [Y/n]    "
            if ERRORLEVEL 2 (
                echo.
                echo        Enabling vgc...
                sc config vgc start= demand >nul && echo [Success]: vgc service successfully enabled. || echo [ERROR]: Failed to enable vgc service autostart. Check if you are running this script as admin. && goto error
            )
        )
    )
)
echo. & echo.

@REM Check vgk service status and if it exists
@REM enables or disables service depending on user input.
echo -------------------------------------------------------------
echo        Checking vgk service status...
sc qc "vgk" >nul
if ERRORLEVEL 1 (
    echo [WARNING]: vgk service is not present on this machine. If thats not the case make sure you are running this script as admin.
) else (
    echo [Success]: vgk service found. && echo.

    for /f "tokens=3 delims=: " %%H in ('sc qc "vgk" ^| findstr /i "START_TYPE"') do (
        echo current status is set to: %%H && echo.
        if /i "%%H" EQU "SYSTEM_START" (
            choice /c ny /n /t 180 /d y /m "DO YOU WANT TO DISABLE vgk SERVICE STARTUP? [Y/n]    "
            if ERRORLEVEL 2 (
                echo.
                echo        Disabling vgk...
                sc config vgk start= disabled >nul && echo [Success]: vgk service startup successfully disabled. || echo [ERROR]: Failed to disable vgk service autostart. Check if you are running this script as admin. && goto error
            )
        ) else (
            choice /c ny /n /t 180 /d y /m "DO YOU WANT TO ENABLE vgk SERVICE STARTUP? [Y/n]    "
            if ERRORLEVEL 2 (
                echo.
                echo        Enabling vgk...
                sc config vgk start= system >nul && echo [Success]: vgk service startup successfully enabled. || echo [ERROR]: Failed to enable vgk service autostart. Check if you are running this script as admin. && goto error
            )
        )
    )
)
echo. & echo.


@REM Checks if any of the Vanduard processes/services are running
echo -------------------------------------------------------------
choice /c ny /n /t 180 /d y /m "DO YOU WANT TO DISABLE VANGUARD (includes Vanguard Tray process and vgc, vgk services)? [Y/n]    "
if ERRORLEVEL 2 (
    echo.
    echo        Killing Vanduard Tray process...
    taskkill /im vgtray.exe /f
    echo.

    echo        Stopping vgc and vgk services...
    call :StopRunningService vgc
    call :StopRunningService vgk
)


@REM Restart PC
echo -------------------------------------------------------------
echo        All done.
choice /c ny /n /t 180 /d y /m "Do you want to restart this PC? [Y/n]    "
if ERRORLEVEL 2 (
    shutdown /r /t 5
) else (
    echo. && echo Please note that if you enabled any service you need to restart this machine for them to properly load to play the game. && echo.
)

@REM End of script
pause
exit 0




@REM Stops service of given name if it is running
:StopRunningService
for /F "tokens=3 delims=: " %%H in ('sc query "%~1" ^| findstr /i "STATE"') do (
    if /I "%%H" EQU "RUNNING" (
        net stop %~1 && exit /b 0
    )
)
exit /b 1


@REM Exits script if error ocurent during execution
:error
pause
exit 1
