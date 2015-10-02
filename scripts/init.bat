@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=JBoss Data Virtualization Getting Started Demo
set AUTHORS=Kenny Peeples, Andrew Block
set PROJECT=git@github.com:jbossdemocentral/dv-gettingstarted.git
set PRODUCT=JBoss DV Demo
set INSTALL_DIR=%PROJECT_HOME%..\target\
set JBOSS_HOME_DV=%PROJECT_HOME%..\target\dv6.2\EAP-6.4.0
set SERVER_BIN_DV=%JBOSS_HOME_DV%\bin\
set SERVER_CONF_DV=%JBOSS_HOME_DV%\standalone\configuration\
set SRC_DIR=%PROJECT_HOME%..\software
set DV_SUPPORT_DIR=%PROJECT_HOME%\..\support
set PRJ_DIR=%PROJECT_HOME%..\projects
set EAP=jboss-eap-6.4.0-installer.jar
set DV=jboss-dv-installer-6.2.0.redhat-3.jar
set EAP_VERSION=6.4.0
set DV_VERSION=6.2.0
set EAP_PATCH=jboss-eap-6.4.3-patch.zip
set NOPAUSE=true

REM wipe screen.
cls

echo.
echo Setting up the %DEMO%
echo.
echo brought to you by,   
echo   %AUTHORS%
echo.
echo   %PROJECT%
echo.

REM make some checks first before proceeding.	
if exist "%SRC_DIR%\%DV%" (
        echo JBoss DV product sources present...
        echo.
) else (
        echo Need to download %DV% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%EAP%" (
        echo JBoss EAP product sources present...
        echo.
) else (
        echo Need to download %EAP% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%EAP_PATCH%" (
        echo JBoss EAP product patch present...
        echo.
) else (
        echo Need to download %EAP_PATCH% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

REM JBoss product installation if exists.
if exist "%INSTALL_DIR%" (
	echo - existing JBoss product install detected...
	echo.
	echo - removing existing JBoss product installation...
	echo.

	rmdir /s /q "%INSTALL_DIR%"
)

echo Starting JBoss EAP Install. Press any key or wait 5 seconds
timeout 5

REM Run EAP installer
echo.
echo Product installer running now...
echo.
call java -jar %SRC_DIR%\%EAP% %DV_SUPPORT_DIR%\eap64-installer.xml 

if not "%ERRORLEVEL%" == "0" (
	echo Error Occurred During JBoss EAP Installation!
	echo.
	GOTO :EOF
)

echo Installed JBoss EAP server
echo.
echo Starting JBoss EAP server


start "" %JBOSS_HOME_DV%\bin\standalone.bat ^>console.log

echo.
echo Waiting for JBoss EAP to Start

:loop
timeout /t 5 > null 2>&1
(type console.log |find "started in") > null 2>&1
if errorlevel 1 goto loop

echo.
echo JBoss EAP server started


call %JBOSS_HOME_DV%\bin\jboss-cli.bat --command="patch apply %SRC_DIR%\jboss-eap-6.4.3-patch.zip --override-all"

if not "%ERRORLEVEL%" == "0" (
	echo Error occurred during JBoss EAP patch installation!
	echo.
	GOTO :EOF
)

echo Installed JBoss EAP patch...
echo.

echo.
echo Shutting down JBoss EAP server...

call %JBOSS_HOME_DV%\bin\jboss-cli.bat --connect command=:shutdown

if not "%ERRORLEVEL%" == "0" (
	echo Error occurred during JBoss EAP shutdown!
	echo.
	GOTO :EOF
)

echo.
echo Shutdown JBoss EAP server...
echo.

echo Starting JBoss DV Install. Press any key or wait 5 seconds
timeout 5 > null 2>&1

REM Run JBoss DV installer.
echo.
echo Installing JBoss DV now...
echo.
call java -jar %SRC_DIR%\%DV% %DV_SUPPORT_DIR%\dv62-installer.xml 

if not "%ERRORLEVEL%" == "0" (
	echo Error occurred during JBoss DV installation!
	echo.
	GOTO :EOF
)

echo.
echo Post JBoss DV install configuration...
echo.


echo.
echo  - install teiid security files...
echo.
xcopy /Y /Q /S "%DV_SUPPORT_DIR%\application*" "%SERVER_CONF_DV%"


echo.
echo   - move data files...
echo.
xcopy /Y /Q /S "%DV_SUPPORT_DIR%\data\*" "%JBOSS_HOME_DV%\standalone\data"

echo.
echo   - move virtual database...
echo.
xcopy /Y /Q "%DV_SUPPORT_DIR%\vdb" "%JBOSS_HOME_DV%\standalone\deployments"

echo   - setting up dv standalone.xml configuration adjustments...
echo.
xcopy /Y /Q "%DV_SUPPORT_DIR%\dv62-standalone.xml" "%SERVER_CONF_DV%\standalone.xml"

echo   - cleaning up install log...
echo.
del console.log > null 2>&1

REM Final instructions to user to start and run demo.                                                                  
echo.
echo See README.md for any additional steps                   
echo %DEMO% Setup Complete.
echo.
