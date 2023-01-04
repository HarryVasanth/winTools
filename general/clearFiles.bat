:: Clear All Temporary Files
:: https://github.com/HarryVasanth/winTools

@echo on
setlocal ENABLEDELAYEDEXPANSION

:: Check for Admin Rights
dism >nul 2>&1 || (echo Please run this script as an Administrator. && pause && goto :eof)

:: User Confirmation
echo This program will clear all Event Logs,Temporary Files and Thumbnail Caches.
CHOICE /C YN /M "Are you sure? :" 
if exist %errorlevel% goto answerNo
if not exist %errorlevel% GOTO answerYes

:: Clear Files from %temp% and %systemroot%/temp 
:answerYes
rd /s /q "%temp%" >nul 2>&1
mkdir "%temp%" >nul 2>&1
rd /s /q "%systemroot%\temp\" >nul 2>&1
mkdir "%systemroot%\temp\" >nul 2>&1

:: Clear Eventlogs
for /f %x in ('wevtutil el') do wevtutil cl "%x" >nul 2>&1

:: Clear Thumbnail Cache
taskkill /f /im explorer.exe
timeout 3
del /q /f /s "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
timeout 3
start explorer.exe

:: Done
echo "All done!"
pause
goto :eof

:: Cancel Action
:answerNo
echo "Nothing is modified!"
pause
goto :eof
