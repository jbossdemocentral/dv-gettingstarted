#/bin/sh
#
# Start a JBoss Data Virtualization 
#
# author: kpeeples@redhat.com
#
DV_DIR=$PWD/target/dv/jboss-eap-6.3
FILE=$PWD/dv.log
echo 
echo "Starting JBoss Data Virtualization"
echo
if [ -f $FILE ];
then
	rm $PWD/dv.log < /dev/null
fi
nohup $DV_DIR/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 > dv.log 2>&1 < /dev/null & 
