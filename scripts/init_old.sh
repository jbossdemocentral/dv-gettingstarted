#!/bin/sh

#-DTRACE=TRUE

DIRNAME=`pwd`

RUN_CONF="$DIRNAME/setup.conf"
if [ -r "$RUN_CONF" ]; then
    . "$RUN_CONF"
fi

if [ "x$JBOSS_HOME" = "x" ]; then
        JBOSS_HOME=$DIRNAME/dv_server
fi

if [ -d "$JBOSS_HOME" ]; then
	rm -rf $JBOSS_HOME
fi

if [ ! -f "$EAP_JAR" ]; then
	echo ""
	echo "Stop: The EAP $EAP_JAR is not found in $DIRNAME"
    exit 1
fi

if [ ! -f "$EAP_PATCH_ZIP" ]; then
	echo ""
	echo "Stop: The EAP patch $EAP_PATCH_ZIP is not found in $DIRNAME"
    exit 1
fi

if [ ! -f "$DV_JAR" ]; then
	echo ""
	echo "Stop: The DV $DV_JAR is not found in $DIRNAME"
    exit 1
fi

mkdir $JBOSS_HOME

echo "Installing EAP Server ..."

# substitute the correct installation path
java -jar ./lib/dv_quickstart-2.1.0.jar 1 $DIRNAME/eap-installer.xml $JBOSS_HOME

if [ $? != 0 ] ; then
	echo ""
	echo "Stop due to error"
    exit 1
fi

#  BZ : https://bugzilla.redhat.com/show_bug.cgi?id=1225450
#  issue with using INSTALL_PATH (-DINSTALL_PATH=..)

# install EAP
java  -jar jboss-eap-6.4.0-installer.jar eap-installer.xml 

echo "Installed EAP Server"

#  start server install the eap 6.4.3 patch
cd $JBOSS_HOME/bin

echo "Starting EAP Server, to install patches ..."

./standalone.sh >>console.log &

cd $DIRNAME

java -jar ./lib/dv_quickstart-2.1.0.jar 2 localhost 9990

echo "Ping Status: " $?

if [ $? != 0 ] ; then
	echo ""
	echo "Stop due to error"
    exit 1
fi

echo "Started EAP Server"

echo "Installing EAP 6.4.3 Patch ..."

PATCH_DIR=$DIRNAME

# install patch
$JBOSS_HOME/bin/jboss-cli.sh --command="patch apply $PATCH_DIR/jboss-eap-6.4.3-patch.zip"

echo "Installed EAP 6.4.3 Patch"

echo "Shutting down server ..."

./shutdown_server.sh

#  pause for 20 seconds until the server is fully available
#  otherwise, the admin config options are not enabled
java -jar ./lib/dv_quickstart-2.1.0.jar 3 20

echo "Shut down server"

echo "Installing DV ..."

# substitute the correct installation path
java -jar ./lib/dv_quickstart-2.1.0.jar 1 $DIRNAME/dv-installer.xml $JBOSS_HOME

if [ $? != 0 ] ; then
	echo ""
	echo "Stop due to error"
    exit 1
fi

# install DV
java -jar jboss-dv-installer-6.2.0.redhat-2.jar dv-installer.xml 

echo "DV server has been installed, starting server"

echo "Starting DV Server ..."

cd $JBOSS_HOME/bin

./standalone.sh >>console.log &

cd $DIRNAME

java -jar ./lib/dv_quickstart-2.1.0.jar 2 localhost 9990

echo "Ping Status: " $?

if [ $? != 0 ] ; then
	echo ""
	echo "Stop due to error"
    exit 1
fi

echo "Started DV Server"

#  pause for 20 seconds until the server is fully available
#  otherwise, the admin config options are not enabled
java -jar ./lib/dv_quickstart-2.1.0.jar 3 30

echo "Configure quickstart data sources..."

cp -r ./deployment/teiidfiles  $JBOSS_HOME

cd $JBOSS_HOME/

./bin/jboss-cli.sh  --connect --file=$DIRNAME/deployment/scripts/setup.cli

cd $DIRNAME

cp $JBOSS_HOME/teiidfiles/vdb/*.*  $JBOSS_HOME/standalone/deployments

echo "Completed configuring quickstart data sources"

echo ""
echo "********************************************
echo "DV Server is ready to run the DV Quickstart"
echo "********************************************






