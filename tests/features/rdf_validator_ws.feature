# Created by Laurentiu Mandru at 9/30/20
Feature: Test functionality of rdf-validator-ws running in a docker container

  Scenario: Main success scenario for SPARQL endpoint and RDF validation report
    Given the baseURI "https://www.google.com"
    And the SHACL file "somefile"
    When I navigate to the location "/page"
    And I fill in the field "field_id_sparql" with "someendpointhere"
    And I fill in the field "field_id_datafile" with "somefile"
    And I click on the button with id "validate_button_id"
    Then I get the "200" response status code
    And the response contains an attachment in the "Turtle" format
    And the received file contains "something"

#  Scenario: Main success scenario for SPARQL endpoint and HTML validation report
  Scenario: Main success scenario for RDF file and HTML validation report
    Given the baseURI "http://xxxx"
    And the SHACL file "somefile"
    When I navigate to the location "/page"
    And I fill in the field "field_id_datafile" with "somefile"
    And I upload the "file" in the "upload_id" field
    And I click on the button with id "validate_button_id"
    Then I get the "200" response status code
    And the response contains an attachment in the "Turtle" format
    And the received file contains "something"


#  Scenario: Main success scenario for resource URI and HTML validation report - TBD ? - not critical just yet
