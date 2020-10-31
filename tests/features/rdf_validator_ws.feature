# rdf_validator.ws.feature
# Date:  2020.10.13
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com

Feature: Test functionality of rdf-validator-ws running in a docker container

  Background:
    Given the baseURI RDF_VALIDATOR_UI_URL

  Scenario: Main success scenario for SPARQL endpoint and RDF validation report
    Given the SCHEMA file /tests/test_data/skosShapes.shapes.ttl
    And the URL with value http://localhost:3030/treaty-fragment/query
    When I navigate to the location /validate-sparql-endpoint
    And I upload in the field schema_files with SCHEMA
    And I fill in the field endpoint_url with URL
    And I click on the button with id report_extension-1
    And I click on the button with id submit
#    Then the field with id "id_of_successfull_div" is visible

  Scenario: Main success scenario for RDF file and HTML validation report
    Given the SHACL file /tests/test_data/skosShapes.shapes.ttl
    And the SCHEMA file /tests/test_data/skosShapes.shapes.ttl
    When I navigate to the location /validate-file
    And I upload in the field data_file with SHACL
    And I upload in the field schema_files with SCHEMA
    And I click on the button with id report_extension-1
    And I click on the button with id submit
#    Then the field with id "id_of_field_here" is visible


