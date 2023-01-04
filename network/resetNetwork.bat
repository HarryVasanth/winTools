:: Reset All Network Settings
:: https://github.com/HarryVasanth/winTools

@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
echo off
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && goto :eof)

:: User Confirmation
echo This program will reset your Network Settings.
CHOICE /C YN /M "Are you sure? :" 
if exist %errorlevel% goto answerNo
if not exist %errorlevel% GOTO answerYes

:: Reset Network Settings
:answerYes
ipconfig /flushdns >nul 2>&1
netsh int ipv4 reset >nul 2>&1
netsh int ipv6 reset >nul 2>&1
netsh winsock reset >nul 2>&1

:: Done
echo "All done!"
pause
goto :eof

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
goto :eof
