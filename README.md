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
  
**STEP 1:** Clone the Repository and Download Data Virtualization  
-git clone https://github.com/jbossdemocentral/dv-gettingstarted.git  
-Download from jboss.org http://www.jboss.org/products/datavirt/download/  
Put the Data Virutalization Download, jboss-dv-installer-6.1.0.redhat-3.jar, into the software folder  
  
**STEP 2:** View Project, Preview Data and Deploy the VDB  
 
  
**STEP 3:** Browse the Data Virtualization and the Data  
-All Data  
		http://localhost:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContext?$format=json  
-Specific Entity  
		http://localhost:8080/odata/CustomerContextVDB/CustomerContext('123')?$format=json  
-Metadata  
		http://localhost:8080/odata/CustomerContextVDB/$metadata  
-Management Console to view Virtual Database  
		http://localhost:8080  
-Dashboard  
		http://localhost:8080/dashboard/  
  
**As Easy as 1,2,3....**

