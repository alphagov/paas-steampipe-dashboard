# Data model

The data is decribed in detail in the [CF API documentation](http://v3-apidocs.cloudfoundry.org/version/3.122.0/index.html)

The `extract-data` target in the [Makefile](../Makefile) extracts flattens the json from the [CF V3 API](http://v3-apidocs.cloudfoundry.org/version/3.122.0/index.html) into CSV to make it available to steampipe using the [csv plugin](https://hub.steampipe.io/plugins/turbot/csv) 

The fields are defined in the [schemata](schemata.md)

The field names may include odd names like `relationships/organization/data` which is a result of taking the data from the api and flattening with [in2csv](https://csvkit.readthedocs.io/en/latest/scripts/in2csv.html) you will need to escape the names with double quotes in the SQL. 

`select "relationships/space/data/guid" from service_instances`

![data model](datamodel.png)
