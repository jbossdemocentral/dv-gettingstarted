@ECHO OFF
setlocal

REM Start a JBoss Data Virtualization and JBoss Fuse environment.
REM 
REM This script expects JBoss Fuse to be running in order to start the c1 container
REM
REM author: cojan.van.ballegooijen@redhat.com, andy.block@gmail.com
REM

set PROJECT_HOME=%~dp0
set FUSE_DIR=%PROJECT_HOME%target\fuse\jboss-fuse-6.1.0.redhat-379
set DV_DIR=%PROJECT_HOME%target\dv
set KARAF_LOG=%FUSE_DIR%\data\log\fuse.log

if exist "%KARAF_LOG%" (
	del %KARAF_LOG%
)

call "%FUSE_DIR%\bin\start.bat"

echo Starting JBoss Fuse and wait for 60 seconds
echo.

timeout 60 /nobreak

echo.
echo Starting JBoss Data Virtualization
echo.

start "" "%DV_DIR%\bin\standalone.bat"

if not exist "%FUSE_DIR%\instances\c1" (

	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" "fabric:create --wait-for-provisioning"
	call mvn -f "%PROJECT_HOME%\projects\usecase1\pom.xml" clean install -DskipTests
	call mvn -f "%PROJECT_HOME%\projects\usecase1\pom.xml" fabric8:deploy -DskipTests

	call mvn -f "%PROJECT_HOME%\projects\usecase2\pom.xml" clean install -DskipTests
	call mvn -f "%PROJECT_HOME%\projects\usecase2\pom.xml" fabric8:deploy -DskipTests

	call mvn -f "%PROJECT_HOME%\projects\usecase4\pom.xml" clean install -DskipTests
	call mvn -f "%PROJECT_HOME%\projects\usecase4\pom.xml" fabric8:deploy -DskipTests

	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" "profile-edit --bundles wrap:file:///%DV_DIR:\=/%/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase1 1.0"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" "profile-edit --bundles wrap:file:///%DV_DIR:\=/%/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase2 1.0"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" "profile-edit --bundles wrap:file:///%DV_DIR:\=/%/dataVirtualization/jdbc/teiid-8.4.1-redhat-7-jdbc.jar usecase4 1.0"
	call "%FUSE_DIR%\bin\client.bat" "-h" "127.0.0.1" "-r" "10" "-u" "admin" "-p" "admin" "fabric:container-create-child --profile usecase1 --profile usecase2 --profile usecase4 --profile jboss-fuse-minimal root c1"
	
)
