# rdf_differ.feature
# Date:  2020.10.13
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com


Feature: Test functionality of RDF Differ running in a Docker container
  
    Background:
    Given the baseURI http://localhost:8010

  Scenario: Main success scenario
    Given the OLD file /tests/test_data/skosShapes.shapes.ttl
    And the NEW file /tests/test_data/skosShapes.shapes.ttl
    When I navigate to the location /page
    And I fill in the field field_id_datafile with somefile
    And I fill in the field dataset_id with datasetid_field
    And I fill in the field dataseturi with dataseturi_field
    And I fill in the field newversionid with newversionid_field
    And I fill in the field oldversionid with oldversionid_field
    And I click on the button with id validate_button_id
    Then the resulting page contains ceva_aici in the element with id some_id
#
#  Scenario: Get the diff report for a calculated diff
#    Given the baseURI "http://rdfdiffer"
#    When I navigate to the location "/page"
#    And I click on the button with id "generate_id"
#    Then I get a file download
#    And the downloaded file contains "something"
#
