:: Reset All Network Settings
:: https://github.com/HarryVasanth/winTools

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && exit /b 1)

:: User Confirmation
echo This program will reset your Network Settings.
CHOICE /C YN /M "Are you sure? :" 
IF ERRORLEVEL 2 goto answerNo
IF ERRORLEVEL 1 GOTO answerYes


:: Reset Network Settings
:answerYes
ipconfig /flushdns >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1
netsh winsock reset >nul 2>&1

:: Done
echo "All done!"
pause
exit /b 0

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
exit /b 0