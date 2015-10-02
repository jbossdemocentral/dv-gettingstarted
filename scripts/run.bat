@ECHO OFF
setlocal

set PROJECT_HOME=%~dp0
set JBOSS_HOME_DV=%PROJECT_HOME%..\target\dv6.2\EAP-6.4.0
set DV_DIR=%PROJECT_HOME%..\target\dv6.2\EAP-6.4.0
set FILE=%PROJECT_HOME%..\dv.log

echo.
echo Starting JBoss Data Virtualization and waiting on server to start
echo.

if exist "%JBOSS_HOME_DV%\standalone\log\server.log" (
	del %JBOSS_HOME_DV%\standalone\log\server.log
)
	
if exist "%FILE%" (
	del %FILE%
)

start "" %DV_DIR%\bin\standalone.bat -b 0.0.0.0 -bmanagement 0.0.0.0 ^> dv.log

:loop
timeout /t 5 > null 2>&1
(type %JBOSS_HOME_DV%\standalone\log\server.log |find "started in") > null 2>&1
if errorlevel 1 goto loop

echo. 
echo Started JBoss Data Virtualization
echo.