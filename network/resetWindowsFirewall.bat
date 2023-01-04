:: Reset Windows Firewall
:: https://github.com/HarryVasanth/winTools

@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && goto :eof)

:: User Confirmation
echo This program will reset your Windows Firewall.
CHOICE /C YN /M "Are you sure? :" 
if exist %errorlevel% goto answerNo
if not exist %errorlevel% GOTO answerYes

:: Reset Firewall Profiles
:answerYes
netsh advfirewall set allprofiles state off >nul 2>&1
netsh advfirewall firewall delete rule all
netsh advfirewall set allprofiles firewallpolicy blockinbound,blockoutbound
netsh advfirewall reset >nul 2>&1
netsh advfirewall set allprofiles state on >nul 2>&1

:: Done
echo "All done!"
pause
goto :eof

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
goto :eof
