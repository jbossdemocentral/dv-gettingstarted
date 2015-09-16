CLS
REM <tags xmi:uuid="mmuuid:08524d3b-1757-4aba-bddb-be39c40bc726" key="connection:FlatFileHomeUrl" value="/home/kpeeples/gitrepository/jbossdemocentral/dv-odata-docker-integration-demo/support/data"/>
REM <tags xmi:uuid="mmuuid:75e5aa4a-0e8b-4299-8b91-c8bb2f1198fd" key="connection:LocalFilePath" value="/home/kpeeples/gitrepository/jbossdemocentral/dv-odata-docker-integration-demo/support/data/CustomerHistory.xml"/>
REM set repo directory to parent directory
pushd..
SET parentName=%cd%
popd
REM Update CSV model with correct folder path in FlatFileHomeUrl
SET current=/home/kpeeples/gitrepository/jbossdemocentral/dv-gettingstarted/support/data
SET change=%parentName%\support\data
SET filename=%parentName%\projects\helloworldgettingstarted\CustomerContext\sources\CustomerContextCSVSourceModel.xmi
CALL replace.bat %current% %change% %filename% > newfile.txt
MOVE /Y newfile.txt %filename%
REM Update XML model with correct folder path in LocalFilePath
SET current=/home/kpeeples/gitrepository/jbossdemocentral/dv-gettingstarted/support/data/
SET change=%parentName%\support\data\
SET filename=%parentName%\projects\helloworldgettingstarted\CustomerContext\sources\CustomerContextXMLSourceModel.xmi
CALL replace.bat %current% %change% %filename% > newfile.txt
MOVE /Y newfile.txt %filename%
REM Update VDB for parent directories
mkdir %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\tmp
COPY %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\CustomerContextVDB.vdb %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\tmp
cd %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\tmp
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('CustomerContextVDB.vdb', 'CustomerContextVDB'); }"
REM MoveModel Files Over
COPY /Y %parentName%\projects\helloworldgettingstarted\CustomerContext\sources\CustomerContextCSVSourceModel.xmi %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\tmp\CustomerContextVDB\CustomerContext\sources\CustomerContextCSVSourceModel.xmi
COPY /Y %parentName%\projects\helloworldgettingstarted\CustomerContext\sources\CustomerContextCSVSourceModel.xmi %parentName%\projects\helloworldgettingstarted\CustomerContext\virtual_databases\tmp\CustomerContextVDB\CustomerContext\sources\CustomerContextXMLSourceModel.xmi
REM Zip file back up
del CustomerContextVDB.vdb
powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('CustomerContextVDB', 'CustomerContextVDB.vdb'); }"
MOVE /Y CustomerContextVDB.vdb ..
CD ..
RMDIR /S /Q tmp
