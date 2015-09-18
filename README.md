## Data Virtualization Getting Started for a Developer Hello World Experience

NOTE: In order to run this demo for DV 6.2 you must download EAP 6.4.0, EAP 6.4.3 Patch and DV 6.2.  If you have any issues please add an issue and I will resolve.  

NOTE: Currently option 1 is working properly with the manual steps.  Correcting the option 2 automated steps.  

![alt text](https://raw.githubusercontent.com/jbossdemocentral/dv-gettingstarted/master/docs/images/dvdemo-gettingstarted2.png "Teiid VDBs")  

This Project contains a CSV file and XML File as datasources for a federated view in a Virtual Database.  You can view the project, preview data, deploy the VDB and browse to the OData URLs. 

## Credentials setup during install

**Management Credentials:**  
admin/redhat1!  
**Datavirtualization Credentials:**  
teiidUser/redhat1!  
**Datavirtualization Dashboard Credentials:**  
dashboardAdmin/redhat1!

## Steps to Run the Demo

**OPTION 1 - RUNNING AND PREVIEWING WITHIN JBDS**:  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download DV from jboss.org http://www.jboss.org/products/datavirt/download/  
-Download EAP 6.4.0 from jboss.org http://www.jboss.org/products/eap/download/  
-Download EAP 6.4.3 Roll up patch from CSP https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=39353  
-Install EAP, EAP Rollup Patch and Data Virtualization enabling OData  
  
**STEP 2:** Import, Preview Data and Deploy  
-NOTE:  In order to use the source files and VDB the Parent folder has to be updated to your local git clone directory for the project.  To do that run the script below otherwise manual update to the files:
CustomerContextCSVSourceModel.xmi  
CustomerContextXMLSourceModel.xmi  
CustomerContextVDB.vdb  
-From the scripts folder run  ```./update-folders.sh```  OR   ```./update-folders.bat```  
-Download JBDS http://www.jboss.org/products/devstudio/download/    
-Install JBDS and the Integration Stack https://devstudio.jboss.com/updates/8.0/integration-stack/  
-Add and start a new server with the home directory of the installed DV from above  
-Verify management and jdbc connections on the Teiid instance  
-Refresh the server  
-Import the project into JBDS (should have JBDIS installed)  
-Verify default teiid instance from actions in Teiid perspective  
-Right click on the 3 views/tables and preview the data  
-Click on the VDB and execute the selected text  
```SELECT * FROM CustomerContextView.CustomerContextTable;```  
-Deploy the VDB  
  
**STEP 3:** Browse the Data Virtualization and the Data throughthe Chrome Browser  
-All Data  
		```http://localhost:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContextTable?$format=json```  
-Specific Entity  
		```http://localhost:8080/odata/CustomerContextVDB/CustomerContextTable('123')?$format=json```   
-Metadata  
		```http://localhost:8080/odata/CustomerContextVDB/$metadata```     
-Management Console to view Virtual Database  
		```http://localhost:8080```  
-Dashboard  
		```http://localhost:8080/dashboard/```  
  
As Easy as 1,2,3....   

**OPTION 2 - STEPS TO RUN WITHOUT JBDS**:  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download DV 6.2 from jboss.org http://www.jboss.org/products/datavirt/download/  
-Download EAP 6.4.0 from jboss.org http://www.jboss.org/products/eap/download/  
-Download EAP 6.4.3 Roll up patch from CSP https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=39353  
-Put the EAP 6.4.0, EAP 6.4.3 Roll up patch and Data Virutalization into the software folder  
  
**STEP 2:** Run Scripts in the scripts folder  
-NOTE: In this option the data is set in ${jboss.home.dir}/standalone/data/ and the standalone.xml is update for the VDB.  The corresponding bat files require update.  
-Run ```./init.sh``` to setup DV  
-Run ```./run.sh``` to run DV.  Verify DV started completely with ```tail -f dv.log```   
-Run ```./test.sh > out.txt``` to test the OData url  
  
**STEP 3:** Browse the Data Virtualization and the Data  
-View the out.txt to see All Data, Specific Entity and Metadata examples for XML format and/or run the three below individually through the Chrome  browser.  
-All Data  
		```http://localhost:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContextTable?$format=json```  
-Specific Entity  
		```http://localhost:8080/odata/CustomerContextVDB/CustomerContextTable('123')?$format=json```   
-Metadata  
		```http://localhost:8080/odata/CustomerContextVDB/$metadata```     
-Management Console to view Virtual Database  
		```http://localhost:8080```  
-Dashboard  
		```http://localhost:8080/dashboard/``` 
 
As Easy as 1,2,3....  

**OPTION 3 - CONTAINERIZED INSTALL**: 

**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download DV 6.2 from jboss.org http://www.jboss.org/products/datavirt/download/  
-Download EAP 6.4.0 from jboss.org http://www.jboss.org/products/eap/download/  
-Download EAP 6.4.3 Roll up patch from CSP https://access.redhat.com/jbossnetwork/restricted/softwareDownload.html?softwareId=39353  
-Put the EAP 6.4.0, EAP 6.4.3 Roll up patch and Data Virutalization into the software folder  

**STEP 2:** Create and Run Container  
- Note: in this option the data is set in ${jboss.home.dir}/standalone/data/ and the standalone.xml is update for the VDB  
- Copy Dockerfile and .dockerignore files from support/docker directory to the project root.  
- Build demo image  

 	```  
 	docker build -t jbossdemocentral/dv-gettingstarted .  
 	```  

- Start demo container  

	```  
	docker run -it -p 9990 -p 9999:9999 -p 8080:8080 -p 31000:31000 jbossdemocentral/dv-gettingstarted  
	```  
- In many cases, the docker socket may not utilize the ```localhost``` interface. Changes may be required to modify the following scripts to utilize the correct interface docker is utilizing  
	- ```run.sh```   

-Run ```./test.sh > out.txt``` to test the OData url  

**STEP 3:** Browse the Data Virtualization and the Data  
-View the out.txt to see All Data, Specific Entity and Metadata examples for XML format and/or run the three below individually through the Chrome  browser.  
-All Data  
		```http://<DOCKER_HOST>:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContextTable?$format=json```  
-Specific Entity  
		```http://<DOCKER_HOST>:8080/odata/CustomerContextVDB/CustomerContextTable('123')?$format=json```   
-Metadata  
		```http://<DOCKER_HOST>:8080/odata/CustomerContextVDB/$metadata```     
-Management Console to view Virtual Database  
		```http://<DOCKER_HOST>:8080```  
-Dashboard  
		```http://<DOCKER_HOST>:8080/dashboard/``` 
 
As Easy as 1,2,3....  
