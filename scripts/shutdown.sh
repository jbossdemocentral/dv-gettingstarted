JBOSS_HOME_DV=../target/dv6.2/EAP-6.4.0

echo -e "Shutting down server ...\n"

$JBOSS_HOME_DV/bin/jboss-cli.sh --connect command=:shutdown
