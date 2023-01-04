:: Restart Network Adapters
:: https://github.com/HarryVasanth/winTools

@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && goto :eof)

:: User Confirmation
echo This program will restart your Network Adapters.
CHOICE /C YN /M "Are you sure? :" 
if exist %errorlevel% goto answerNo
if not exist %errorlevel% GOTO answerYes

:: Restart Individual Network Adapters
:answerYes
for /f "delims=" %%i in ('netsh int show interface^|find "Connected"') do (
	netsh int set interface name="%%i" admin="disabled" >nul 2>&1
	netsh int set interface name="%%i" admin="enabled" >nul 2>&1
)

:: Done
echo "All done!"
pause
goto :eof

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
goto :eof
