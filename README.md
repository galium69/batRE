# batRE
 A batch file and resources to attack an offline windows !
 
 He can bypass the secure boot (winePE is signed by Microsoft), and SATA parameters, because winPE is a Microsoft system.
 
 # disclaimer 
 
 This tool is for educational purposes only, please do not use it in illegal context.
 
 NEVER USE THIS TOOL ON AN ENCRYPTED PC (bitlocker), HE CAN BE LOCKED
 
 ## how it works 
 
 there are five options : 
 1. dump  : the dump fonction try to copy SAM and SYSTEM files to the winPE device (SAM and SYSTEM folders)
 2. admin : this will create an admin account, with creating a schtask on the local system, to do that, winPE mount the register subkey HKLM\SOFTWARE (located at c:\windows\system32\config\SOFTWARE ) at the HKLM\tmp subkey of the winPE registry, after that, winPE will merge registry files (\reg folder), and the task file to c:\windows\system32\tasks to impersonate a legetimate schtask. the schtask execute a script, that create an acount and add it to the administrator group.   
 3.
 4.
 5. windef :
 
 ## to do list
 * a deactivation fonction for ESET or kaspersky, but without uninstall it or deactivating the service
 * a working self-destruct fonction
 * support severals SAM and SYSTEM at the same time
 * add a fonction for copying the database of an Domain Controler (ad)
 * try to made a automation that find the local windows hardisk letter
 * move the location of schtask to c:\windows\temp
 * automatic deletion of logs for the schtasks manager
 ## license