# <tags xmi:uuid="mmuuid:08524d3b-1757-4aba-bddb-be39c40bc726" key="connection:FlatFileHomeUrl" value="/home/kpeeples/gitrepository/jbossdemocentral/dv-odata-docker-integration-demo/support/data"/>
# <tags xmi:uuid="mmuuid:75e5aa4a-0e8b-4299-8b91-c8bb2f1198fd" key="connection:LocalFilePath" value="/home/kpeeples/gitrepository/jbossdemocentral/dv-odata-docker-integration-demo/support/data/CustomerHistory.xml"/>
# set repo directory
parentName=${PWD%/*}
# Update CSV model with correct folder path in FlatFileHomeUrl
sed -i.bak "s:/home/kpeeples/gitrepository/jbossdemocentral/dv-gettingstarted/support/data:$parentName/support/data:" "../projects/helloworldgettingstarted/CustomerContext/sources/CustomerContextCSVSourceModel.xmi"
# Update CSV model with correct folder path in LocalFilePath
sed -i.bak "s:/home/kpeeples/gitrepository/jbossdemocentral/dv-gettingstarted/support/data:$parentName/support/data:" "../projects/helloworldgettingstarted/CustomerContext/sources/CustomerContextXMLSourceModel.xmi"
# Update VDB for parent directories
unzip ../projects/helloworldgettingstarted/CustomerContext/virtual_databases/CustomerContextVDB.vdb -d ../projects/helloworldgettingstarted/CustomerContext/virtual_databases/tmp
# MoveModel Files Over
cp ../projects/helloworldgettingstarted/CustomerContext/sources/CustomerContextCSVSourceModel.xmi ../projects/helloworldgettingstarted/CustomerContext/virtual_databases/tmp/CustomerContext/sources/CustomerContextCSVSourceModel.xmi
cp ../projects/helloworldgettingstarted/CustomerContext/sources/CustomerContextCSVSourceModel.xmi ../projects/helloworldgettingstarted/CustomerContext/virtual_databases/tmp/CustomerContext/sources/CustomerContextXMLSourceModel.xmi
# Zip file back up
cd ../projects/helloworldgettingstarted/CustomerContext/virtual_databases/tmp/
zip -r CustomerContextVDB.vdb .
cp CustomerContextVDB.vdb ..
