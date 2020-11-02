# linkedpipes.feature
# Date:  2020.11.02
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com


Feature: Test functionality of LinkedPipes ETL running in a Docker container

    Background:
    Given the baseURI LINKEDPIPES_ETL_URL

  Scenario: Main landing page load scenario
    When I navigate to the location /#/executions
    Then the resulting page contains LinkedPipes ETL in the element with XPath /html/body/div[1]/md-toolbar/span/a[1]/b
