# rdf_differ.feature
# Date:  2020.10.13
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com


Feature: Test functionality of RDF Differ running in a Docker container
  
    Background:
    Given the baseURI DIFFER_UI_URL

  Scenario: Main success scenario
    Given the OLD file /tests/test_data/skosShapes.shapes.ttl
    And the NEW file /tests/test_data/skosShapes.shapes.ttl
    And the DATASET_NAME with value A_DATASET_NAME
    And the DATASET_DESCRIPTION with value Dataset description
    And the DATASET_URI with value http://dataset.uri
    When I navigate to the location /create-diff
    And I fill in the field dataset_name with DATASET_NAME
    And I fill in the field dataset_description with DATASET_DESCRIPTION
    And I fill in the field dataset_uri with DATASET_URI
    And I upload in the field old_version_file_content with OLD
    And I upload in the field new_version_file_content with NEW
    And I click on the button with id submit
#    Then the resulting page contains something_here in the element with id some_id
