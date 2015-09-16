echo "Get Sepcific Entity From CustomerContextView.CustomerContextTable"
curl -# -u teiidUser:redhat1! "http://localhost:8080/odata/CustomerContextVDB/CustomerContextTable('123')" | xmllint --format -

echo "Get All Data From CustomerContextView.CustomerContextTable"
curl -# -u teiidUser:redhat1! "http://localhost:8080/odata/CustomerContextVDB/CustomerContextView.CustomerContextTable/" | xmllint --format -

echo "Get Metadata provided in the VDB"
curl -# -u teiidUser:redhat1! "http://localhost:8080/odata/CustomerContextVDB/$metadata" | xmllint --format -
