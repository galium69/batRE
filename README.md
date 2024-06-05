# batRE
 A batch file and resources to attack an offline windows !
 
 He can bypass the secure boot (winePE is signed by Microsoft), and SATA parameters, because winPE is a Microsoft system.
 
 # disclaimer 
 
 This tool is for educational purposes only, please do not use it in illegal context.
 
 NEVER USE THIS TOOL ON AN ENCRYPTED PC (bitlocker), HE CAN BE LOCKED
 
 ## how to install/use
 
 IMPORTANT : 
 winPE device is the USB key or CD were you install winPE
 winPE system is the system mounted (located in the \sources\boot.wim of the winPE key)
 
* install winPE in a usb key :
  (english)  https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/winpe-create-usb-bootable-drive?view=windows-11
  (french) https://gaby277.developpez.com/Tutoriels/utiliser-WinPE-pour-le-depannage/
 
  coppy the main.bat and the reg folder to the root of the WinPE device 
 
* you can modify the \windows\system32\startnet.cmd of the winPE system to lunch automaticly the main.bat (optional)
 example of a startnet :
 
`FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W Y Z) DO IF EXIST %%i:\SOURCES\Boot.wim SET MEDIAPE=%%i:
Start %MEDIAPE%\Main.bat`

* boot on the key
 
 ## how it works 
 
 there are five options : 
 1. dump  : the dump fonction try to copy SAM and SYSTEM files to the winPE device (SAM and SYSTEM folders)
 2. admin : this will create an admin account, creating a schtask on the local system. To do that, winPE mount the register subkey HKLM\SOFTWARE (located at c:\windows\system32\config\SOFTWARE ) at the HKLM\tmp subkey of the winPE registry. After that, winPE will merge registry files (\reg folder), and copy the task file to c:\windows\system32\tasks to impersonate a legetimate schtask. the schtask execute a script (you can modyfy it, for example to download and install rootkit, backdoor or to gain reverce shell). by default, the script create an acount and add it to the administrator group.   
 3. bypass_pass : this will rename the Magnify.exe of the local system to Magnify2.exe and the CMD.exe to Magnify. after that, you can open a cmd with NT autority\system accont by cliking on the magnifier on ergonomics options
 4. bypass_pass_end : this will revert chages of bypass pass.
 5. windef : this will add an exclusion for all .exe files on windows defender. to do that, winPE mount the HKLM\SOFTWARE subkey of the local machine, and it add an value called "exe" in the HKLM\SOFTWARE\Microsoft\Windows Defender\Exclusions\Extensions key
 
 ## to do list
 * a deactivation fonction for ESET or kaspersky, but without uninstall it or deactivating the service
 * a working self-destruct fonction
 * support severals SAM and SYSTEM at the same time
 * add a fonction for copying the database of an Domain Controler (ad)
 * try to made a automation that find the local windows hardisk letter
 * move the location of schtask to c:\windows\temp
 * automatic deletion of logs for the schtasks manager
 ## license