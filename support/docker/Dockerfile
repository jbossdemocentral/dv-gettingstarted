# Use jbossdemocentral/developer as the base
FROM jbossdemocentral/developer

# Maintainer details
MAINTAINER Andrew Block <andy.block@gmail.com>


# Environment Variables 
ENV DV_HOME /opt/jboss/dv/jboss-eap-6.4
ENV DV_VERSION_MAJOR 6
ENV DV_VERSION_MINOR 2
ENV DV_VERSION_MICRO 0
ENV DV_VERSION_BUILD redhat-2

# ADD Installation Files
COPY support/InstallationScript6.1.xml software/jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.$DV_VERSION_BUILD.jar /opt/jboss/

# Configure project prerequisites and run installer and cleanup installation components
RUN sed -i "s:<installpath>.*</installpath>:<installpath>$DV_HOME</installpath>:" /opt/jboss/InstallationScript6.1.xml \
  && java -jar /opt/jboss/jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.$DV_VERSION_BUILD.jar  /opt/jboss/InstallationScript6.1.xml \
  && rm -rf jboss-dv-installer-$DV_VERSION_MAJOR.$DV_VERSION_MINOR.$DV_VERSION_MICRO.$DV_VERSION_BUILD.jar /opt/jboss/InstallationScript6.1.xml $DV_HOME/standalone/configuration/standalone_xml_history/*

# Copy support files
COPY support/application* $DV_HOME/standalone/configuration/
COPY support/data/* $DV_HOME/standalone/data/
COPY support/vdb/ $DV_HOME/standalone/deployments/vdb
COPY support/standalone.dv.xml $DV_HOME/standalone/configuration/standalone.xml

# Swtich back to root user to perform build and cleanup
USER root

# Run Maven Build, adjust permissions and cleanup
RUN chown -R jboss:jboss $DV_HOME/standalone/configuration/application* $DV_HOME/standalone/data $DV_HOME/standalone/deployments/vdb $DV_HOME/standalone/configuration/standalone.xml
# Run as JBoss 
USER jboss

# Expose Ports
EXPOSE 9990 9999 8080 31000

# RUN DV
CMD ["/opt/jboss/dv/jboss-eap-6.3/bin/standalone.sh","-c","standalone.xml","-b", "0.0.0.0","-bmanagement","0.0.0.0"]
