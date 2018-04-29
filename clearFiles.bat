@Echo off
echo This program will clear all event logs and temporary files in Windows 7 (without prompting).
CHOICE /C YN /M "Are you sure? :" 
IF ERRORLEVEL 2 goto cancel
IF ERRORLEVEL 1 GOTO clearFiles



:clearFiles
rd /s /q %temp%
mkdir %temp%
rd /s /q %WINDIR%\temp\
mkdir %WINDIR%\temp\
for /f %x in ('wevtutil el') do wevtutil cl "%x"
ipconfig /flushdns
echo "All done!"
pause
exit

:cancel
echo "Nothing is modified!"
pause
exit
