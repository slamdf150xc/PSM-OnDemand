@echo off

set domain=cyberarkdemo.com
set psmAddr=components.cyberarkdemo.com

if "%1" == "" goto prompt
if "%2" == "" goto prompt
if "%3" == "" goto prompt
if "%4" == "" goto prompt

if "%3" == "0" (
 echo alternate shell:s:psm /u %2@%domain% /a %1 /c %4
) > %1.rdp

if "%3" == "1" (
 echo alternate shell:s:psm /u %2 /a %1 /c %4
) > %1.rdp

(
 echo connection type:i:3
 echo full address:s:%psmAddr%
 echo authentication level:i:0
 echo enablecredsspsupport:i:0
 echo negotiate security layer:i:1
 echo desktopwidth:i:1280
 echo desktopheight:i:800
 echo screen mode id:i:1
 echo disable wallpaper:i:1
 echo PromptCredentialOnce:i:0
 echo winposstr:s:0,0,0,0,1400,1000
) >> %1.rdp

mstsc.exe %1.rdp

del %1.rdp

goto end

:prompt

set /p server=Enter the server you want to connect to: 
set /p adminID=Enter the admin ID [Must be stored in EPV]: 
set /p connectComp=Enter the connection component [Ex; PSM-RDP]:

:environment
set /p env=Enter 0 for domain or 1 for local: 
if "%env%" == "0" (
 echo alternate shell:s:psm /u %adminID%@%domain% /a %server% /c %connectComp% > %server%.rdp
 goto runRDP
)

if "%env%" == "1" (
 echo alternate shell:s:psm /u %adminID% /a %server% /c %connectComp% > %server%.rdp
 goto runRDP
)

goto environment

:runRDP
(
 echo connection type:i:3
 echo full address:s:%psmAddr%
 echo authentication level:i:0
 echo enablecredsspsupport:i:0
 echo negotiate security layer:i:1
 echo desktopwidth:i:1280
 echo desktopheight:i:800
 echo screen mode id:i:1
 echo disable wallpaper:i:1
 echo PromptCredentialOnce:i:0
 echo winposstr:s:0,0,0,0,1400,1000
) >> %server%.rdp

mstsc.exe %server%.rdp

del %server%.rdp

:end
