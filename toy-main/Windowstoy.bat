@echo off
@REM setlocal enabledelayedexpansion
@REM if not "%*"=="" (
@REM     set "sr=%*"
@REM     echo "%sr%"
@REM     echo "%sr:~,1%"|findstr "[0-9]" >nul 2>nul && goto dobat || goto docmd
@REM     )
echo %~0 by alittlemc;%~0
echo version 1.1;updatetime 2022-10-06 ��
echo hostname %COMPUTERNAME%;user %USERNAME%
:0
@REM if %info%==y (
echo ----------====start====----------
echo    ID    NOTES
echo     0      ��ʾ��ʾ
echo     00     �˳�
echo     1      �л���administratorִ��
echo      1a    �л���ָ���û�ִ��
echo     2      ������������
echo     3      �޸����뷨
echo     4      ����ͬ��ϵͳʱ��
::echo      4a    �ֶ��޸�ϵͳʱ��
echo     5      ������װ%~dp0Ŀ¼��ȫ��*.msu,*.msi,*.exe��ִ���ļ�
echo     6      �������������
echo     7      �µ���������
::echo      7a    �ϵ����޸���
echo.
set dev=�豸������(devmgmt.msc)
set reg=ע���(regedit)
set dco=ϵͳ���(dcomcnfg)
set com=���������(compmgmt.msc)
set mst=Զ������(mstsc)
set cle=��������(cleanmgr)
set lus=�����û�/��(lusrmgr.msc)
set osk=��Ļ����(osk)
set info=��ʾϵͳ��Ϣ
set win=���Windowsϵͳ(winver)
set fsm=�����ļ��й���(fsmgmt.msc)
set gpe=�����(gpedit.msc)
set uti=��������(utilman)
set off=ע��(logoff)

echo         =����=
echo     01     %dev%
echo     02     %reg%
echo     03     %dco%
echo     04     %com%
echo     05     %mst%
echo     06     %cle%
echo     07     %lus%
echo     08     %osk%
echo     09     %win%
echo     10     %fsm%
echo     11     %gpe%
echo     12     %uti%
echo     0a     %off%
echo     0b     %info%
::echo systemreset ����Windows
::echo systemreset-cleanpc ���²�����Windows
goto start

:start0
::echo ��������cmd����Ҳ�������빦��ID
@REM setlocal enabledelayedexpansion
set /p "sr=%~dp0#"
::���ֿ�ͷ���ǹ���id,������cmd����
::echo input %sr%
echo %sr:~,1%|findstr "[0-9]" >nul 2>nul && goto dobat || goto docmd
::echo findstr����ӡsr��һλ�Ǻ�0-9��������&&��Ͳ�ִ��,�����Ƿ����docmd��ִ��
pause>nul

:dobat
echo Do bat
goto %sr% 2>nul||echo δƥ�䵽��ID&%~0%&pause>nul
pause>nul

:1
    echo get administrator
    net user administrator /active:yes
    echo administrator
goto start

:1a
    set /p user=�����û���:
    echo change %user%
    net user  %user% /active:yes
    echo %user%
goto start

:00
    exit
goto start

:2
    echo ������������(netsh winsock reset)
    set y=<nul
    set /p y=ȷ����������?(y/n)
    if %y%==y (netsh winsock reset)
    set y=<nul
goto start

:3
    echo �޸����뷨(ctfmon)
    ctfmon
goto start

:4
   echo ����ͬ��ʱ��
   net time \\time.windows.com /set /y
goto start

:4a
   set y=<nul
   echo ��ǰʱ��%date% %time%
   set /p y=����ϵͳʱ��(��:2022-10-06)����nȡ��
   if %y%==n (goto start) else (date %y%)
   echo %date% %time% 
   set y=<nul
goto start

:5
    echo ������װ
    set y=<nul
    set /p "y=��װ��ǰĿ¼�п�ִ�г���?(y/n)"
    for %%f in (*.msu,*.msi,*.exe) do ( start /wait %%f )
::��Ŀ¼Ҳ��װ/R Ĭ�ϰ�װ/s        
    set y=<nul
goto start

:6
    :rename
    set y=<nul
    echo ��ǰ��������:%COMPUTERNAME%
    set /p id=��������������:
    set /p y=ȷ�Ͻ�%COMPUTERNAME%�޸�Ϊ%id%?(y/n/r)
    if %y%==r (goto rename)
    if %y%==y (netdom.exe renamecomputer %COMPUTERNAME% /newname: %id%)
    echo ��ǰ��������:%COMPUTERNAME%
goto start

:7
    :redomain
    set /p domain=������AD����:
    set /p y=ȷ�Ͻ������Ϊ%domain%?(y/n/r)
    if %y%==r (goto redomain)
    if %y%==y (netdom join %COMPUTERNAME% /DOMAIN:%domain%)
::/UserD:%user%���û��ʺţ� /PasswordD:%passwd%���û����룩
goto start

:0b
    hostname
    wmic baseboard list brief
    wmic bios get serialnumber
    ::wmic nic get macaddress 

    wmic cpu get caption, name, deviceid, numberofcores, maxclockspeed, status

    wmic memorychip get banklabel,devicelocator,capacity,speed
    wmic computersystem get totalphysicalmemory

    wmic computersystem get caption,dnshostname,model,systemtype

    wmic nic list brief

    wmic diskdrive get model,size
    wmic logicaldisk get name,size
    ::wmic partition get name,size,type

    wmic ntdomain get caption,dnsforestname,domaincontrolleraddress,domaincontrollername,status
goto start

::����

:01
echo %dev%
devmgmt.msc
goto start

:02
echo %reg%
regedit
goto start

:03
echo %dco%
dcomcnfg
goto start

:04
echo %com%
compmgmt.msc
goto start

:05
echo %mst%
mstsc
goto start

:06
echo %cle%
fsmgmt.msc
goto start

:07
echo %lus%
lusrmgr.msc
goto start

:08
echo %osk%
osk
goto start

:09
echo %win%
winver
goto start

:10
echo %fsm%
fsmgmt.msc
goto start

:11
echo %gpe%
gpedit.msc
goto start

:12
echo %uti%
utilman
goto start

:0a
    set y=<nul
    set /p y=ȷ��ע��?(y/n):
    if %y%==y (logoff)
    set y=<nul
goto start

:start
::if not "%~1"=="" ( 
::     pause>nul )
echo -----------====end====-----------
goto start0

:docmd
echo Do cmd
%sr%
goto start

pause>nul
