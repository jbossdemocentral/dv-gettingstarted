@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL DISABLEDELAYEDEXPANSION
REM BatchSubstitude - parses a File line by line and replaces a substring"
REM syntax: BatchSubstitude.bat OldStr NewStr File
REM OldStr [in] - string to be replaced
REM NewStr [in] - string to replace with
REM File [in] - file to be parsed
REM $changed 20100115
REM $source http://www.dostips.com
if "%~1"=="" findstr "^::" "%~f0"&GOTO:EOF
for /f "tokens=1,* delims=]" %%A in ('"type %3|find /n /v """') do (
set "line=%%B"
if defined line (
call set "line=echo.%%line:%~1=%~2%%"
for /f "delims=" %%X in ('"echo."%%line%%""') do %%~X
) ELSE echo.
)