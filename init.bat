@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set DEMO=JBoss Data Virtualization and Fuse Integration Demo
set AUTHORS=Kenny Peeples, Bill Kemp, Cojan van Ballegooijen, Andrew Block
set PROJECT=git@github.com:kpeeples/dv-fuse-integration-demo.git
set PRODUCT=JBoss DV and Fuse Integration Demo
set JBOSS_HOME=%PROJECT_HOME%target\jboss-eap-6.1
set JBOSS_HOME_DV=%PROJECT_HOME%target\dv
set JBOSS_HOME_FUSE=%PROJECT_HOME%target\fuse\jboss-fuse-6.1.0.redhat-379
set SERVER_DIR=%JBOSS_HOME%\standalone\deployments\
set SERVER_CONF=%JBOSS_HOME%\standalone\configuration\
set SERVER_BIN=%JBOSS_HOME%\bin\
set SERVER_BIN_DV=%JBOSS_HOME_DV%\bin\
set SERVER_BIN_FUSE=%JBOSS_HOME_FUSE%\bin\
set SERVER_CONF_DV=%JBOSS_HOME_DV%\standalone\configuration\
set SERVER_CONF_FUSE=%JBOSS_HOME_FUSE%\etc\
set SRC_DIR=%PROJECT_HOME%software
set SUPPORT_DIR=%PROJECT_HOME%support
set DV_SUPPORT_DIR=%SUPPORT_DIR%\dv-support
set FUSE_SUPPORT_DIR=%SUPPORT_DIR%\fuse-support
set PRJ_DIR=%PROJECT_HOME%projects
set FUSE=jboss-fuse-full-6.1.0.redhat-379.zip
set DV=jboss-dv-installer-6.1.0.redhat-3.jar
set FUSE_VERSION=6.1.0
set DV_VERSION=6.1.0

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

REM double check for maven
call where mvn >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
	echo Maven is required but not installed yet. aborting.
	GOTO :EOF
)

REM make some checks first before proceeding.	
if exist "%SRC_DIR%\%DV%" (
        echo JBoss product sources, %DV% is present...
        echo.
) else (
        echo Need to download %DV% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

if exist "%SRC_DIR%\%FUSE%" (
        echo JBoss product sources, %FUSE% is present...
        echo.
) else (
        echo Need to download %FUSE% package from the Customer Support Portal
        echo and place it in the %SRC_DIR% directory to proceed...
        echo.
        GOTO :EOF
)

REM JBoss product installation if exists.
if exist "%PROJECT_HOME%\target" (
	echo - existing JBoss product install detected...
	echo.
	echo - removing existing JBoss product installation...
	echo.

	rmdir /s /q "%PROJECT_HOME%\target"
)

echo Starting DV Install. Press any key or wait 5 seconds
timeout 5

REM Run DV installer
echo.
echo Product installer running now...
echo.
call java -jar %SRC_DIR%\%DV% %DV_SUPPORT_DIR%\InstallationScript.xml 

if not "%ERRORLEVEL%" == "0" (
	echo Error Occurred During DV Installation!
	echo.
	GOTO :EOF
)

echo Post DV install configuration. Press any key or wait 5 seconds
timeout 5

echo.
echo  - install teiid security files...
echo.
xcopy /Y /Q /S "%DV_SUPPORT_DIR%\teiid*" "%SERVER_CONF_DV%"


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
xcopy /Y /Q "%DV_SUPPORT_DIR%\standalone.dv.xml" "%SERVER_CONF_DV%\standalone.xml"


if exist "%PROJECT_HOME%\target" (

	md "%PROJECT_HOME%\target\fuse"
	REM Unzip the JBoss Fuse instance
	echo Unpacking JBoss FUSE %VERSION%...
	echo.
	cscript /nologo "%SUPPORT_DIR%\unzip.vbs" "%SRC_DIR%\%FUSE%" "%PROJECT_HOME%\target\fuse"

	if not "%ERRORLEVEL%" == "0" (
		echo Error Occurred During Installation!
		echo.
		GOTO :EOF
	)
	
) else (
	echo.
	echo Missing target directory, stopping installation.
	echo.
	GOTO :EOF
)
 

echo  - enabling demo accounts logins in users.properties file...
echo.
xcopy /Y /Q "%FUSE_SUPPORT_DIR%\users.properties" "%SERVER_CONF_FUSE%"
echo. 

echo  - enabling useCase 3 properties file...
echo.
xcopy /Y /Q "%FUSE_SUPPORT_DIR%\com.demo.usecase3.odata.cfg" "%SERVER_CONF_FUSE%"
echo. 

REM Final instructions to user to start and run demo.                                                                  
echo.
echo See Readme for any additional steps                   
echo %DEMO% Setup Complete.
echo.
