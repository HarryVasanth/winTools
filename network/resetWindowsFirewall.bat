:: Reset Windows Firewall
:: https://github.com/HarryVasanth/winTools

@echo off
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && exit /b 1)

:: User Confirmation
echo This program will reset your Windows Firewall.
CHOICE /C YN /M "Are you sure? :" 
IF ERRORLEVEL 2 goto answerNo
IF ERRORLEVEL 1 GOTO answerYes


:: Reset Firewall Profiles
:answerYes
netsh advfirewall set allprofiles state off >nul 2>&1
netsh advfirewall firewall delete rule all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound >nul 2>&1
netsh advfirewall reset >nul 2>&1
netsh advfirewall set allprofiles state on >nul 2>&1

:: Done
echo "All done!"
pause
exit /b 0

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
exit /b 0