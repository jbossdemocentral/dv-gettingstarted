## Data Virtualization Getting Started for a Developer Hello World Experience

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
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
-Install Data Virtualization enabling OData  
  
**STEP 2:** Import, Preview Data and Deploy  
-Download JBDS http://www.jboss.org/products/devstudio/download/  
-Install JBDS and the Integration Stack https://devstudio.jboss.com/updates/8.0/integration-stack/  
-Add and start a new server with the home directory of the installed DV from above  
-Verify management and jdbc connections on the Teiid instance  
-Refresh the server  
-Import the project into JBDS (should have JBDIS installed)  
-Verify default teiid instance from actions in Teiid perspective  
-Right click on the 3 views/tables and preview the data  
-Click on the VDB and execute the selected text ```SELECT * FROM CustomerContextView.CustomerContextTable;```  
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
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
Put the Data Virutalization Download, jboss-dv-installer-6.1.0.redhat-3.jar, into the software folder  
  
**STEP 2:** Run Scripts in the scripts folder  
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
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
Put the Data Virutalization Download, jboss-dv-installer-6.1.0.redhat-3.jar, into the software folder  

**STEP 2:** Create and Run Container  
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