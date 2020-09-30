## Created by laur at 9/30/20
#Feature: # Enter feature name here
#  # Enter feature description here
#
#  Scenario: Main success scenario
#    Given the baseURI "http://rdfdiffer"
#    When I navigate to the location "/page"
#    And I upload the "oldFile" in the "upload_id1" field
#    And I upload the "newFile" in the "upload_id2" field
#    And I fill in the field "field_id_datafile" with "somefile"
#    And I fill in the field "dataset_id" with "datasetid_field"
#    And I fill in the field "dataseturi" with "dataseturi_field"
#    And I fill in the field "newversionid" with "newversionid_field"
#    And I fill in the field "oldversionid" with "oldversionid_field"
#    And I click on the button with id "validate_button_id"
#    Then the resulting page contains "ceva_aici"
##
##  Scenario: Get the diff report for a calculated diff
##    Given the baseURI "http://rdfdiffer"
##    When I navigate to the location "/page"
##    And I click on the button with id "generate_id"
##    Then I get a file download
##    And the downloaded file contains "something"
##
