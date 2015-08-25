## Data Virtualization Getting Started for a Developer Hellow World Experience

![alt text](https://raw.githubusercontent.com/jbossdemocentral/dv-gettingstarted/master/docs/images/dvdemo-gettingstarted2.png "Teiid VDBs")  

This Project contains a CSV file and XML File as datasources for a federated view in a Virtual Database.  You can view the project, preview data, deploy the VDB and browse to the OData URLs.
  
## Steps to Run the Demo

**Management Credentials:**  
admin/redhat1!  
**Datavirtualization Credentials:**  
teiidUser/redhat1!  
**Datavirtualization Dashboard Credentials:**  
dashboardAdmin/redhat1!

RUNNING AND PREVIEWING WITHIN JBDS:  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
-Install Data Virtualization enabling OData  
  
**STEP 2:** Import, Preview Data and Deploy  
-Add a new server with the home directory of the installed DV from above  
-Import the project into JBDS (should have JBDIS installed)  
-Click on the 3 views and preview data  
-Click on the VDB and execute the selected text SELECT * FROM CustomerContext.CustomerContextTable;  
-Deploy the VDB  
  
**STEP 3:** Browse the Data Virtualization and the Data  
-All Data  
		http://localhost:8080/odata/CustomerContext/CustomerContext.CustomerContext?$format=json  
-Specific Entity  
		http://localhost:8080/odata/CustomerContext/CustomerContext('123')?$format=json  
-Metadata  
		http://localhost:8080/odata/CustomerContext/$metadata  
-Management Console to view Virtual Database  
		http://localhost:8080  
-Dashboard  
		http://localhost:8080/dashboard/  
  
**As Easy as 1,2,3....**

Steps to Run without Preview in JBDS:  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
Put the Data Virutalization Download, jboss-dv-installer-6.1.0.redhat-3.jar, into the software folder  
  
**STEP 2:** Run Scripts  
-Run init.sh  
-Run run.sh   
  
**STEP 3:** Browse the Data Virtualization and the Data  
-All Data  
		http://localhost:8080/odata/CustomerContext/CustomerContext.CustomerContext?$format=json  
-Specific Entity  
		http://localhost:8080/odata/CustomerContext/CustomerContext('123')?$format=json  
-Metadata  
		http://localhost:8080/odata/CustomerContext/$metadata  
-Management Console to view Virtual Database  
		http://localhost:8080  
-Dashboard  
		http://localhost:8080/dashboard/  
  
**As Easy as 1,2,3....**

