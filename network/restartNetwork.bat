:: Restart Network Adapters
:: https://github.com/HarryVasanth/winTools

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && exit /b 1)

:: User Confirmation
echo This program will restart your Network Adapters.
CHOICE /C YN /M "Are you sure? :" 
IF ERRORLEVEL 2 goto answerNo
IF ERRORLEVEL 1 GOTO answerYes


:: Restart Individual Network Adapters
:answerYes
for /f "tokens=3,*" %%i in ('netsh int show interface^|find "Connected"') do (
	netsh int set interface name="%%j" admin="disabled" >nul 2>&1
	netsh int set interface name="%%j" admin="enabled" >nul 2>&1
)

:: Done
echo "All done!"
pause
exit /b 0

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
exit /b 0