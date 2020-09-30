# coding=utf-8
"""Test functionality of rdf-validator-ws running in a docker container feature tests."""
import time

from pytest_bdd import (
    given,
    scenario,
    then,
    when, parsers,
)
from selenium.webdriver.firefox.webdriver import WebDriver



# @scenario('../features/rdf_validator_ws.feature', 'Main success scenario for RDF file and HTML validation report')
# def test_main_success_scenario_for_rdf_file_and_html_validation_report():
#     """Main success scenario for RDF file and HTML validation report."""


@scenario('../features/rdf_validator_ws.feature', 'Main success scenario for SPARQL endpoint and RDF validation report')
def test_main_success_scenario_for_sparql_endpoint_and_rdf_validation_report():
    """Main success scenario for SPARQL endpoint and RDF validation report."""


@given(parsers.cfparse('the SHACL file "{somefile:String}"', extra_types=dict(String=str)))
def the_shacl_file_somefile(scenario_context, somefile):
    print(somefile)


@given(parsers.cfparse('the baseURI "{baseUri:String}"', extra_types=dict(String=str)))
def the_baseuri_httpxxxx(browser, scenario_context, baseUri):
    print(baseUri)
    browser.get(baseUri)
    time.sleep(10)



@when(parsers.cfparse('I click on the button with id "{control_id:String}"', extra_types=dict(String=str)))
def i_click_on_the_button_with_id_validate_button_id(scenario_context, control_id):
    print(control_id)


# @when('I fill in the field "field_id_datafile" with "somefile"')
# def i_fill_in_the_field_field_id_datafile_with_somefile():
#     """I fill in the field "field_id_datafile" with "somefile"."""
#     raise NotImplementedError


@when(parsers.cfparse('I fill in the field "{control_id:String}" with "{text_value:String}"', extra_types=dict(String=str)))
def i_fill_in_the_field_field_id_sparql_with_someendpointhere(scenario_context, control_id, text_value):
    print(control_id + " - " + text_value)


@when(parsers.cfparse('I navigate to the location "{pageLocation:String}"', extra_types=dict(String=str)))
def i_navigate_to_the_location_page(scenario_context, pageLocation):
    print(pageLocation)


@when(parsers.cfparse('I upload the "{file:String}" in the "{control_id:String}" field', extra_types=dict(String=str)))
def i_upload_the_file_in_the_upload_id_field(scenario_context, file, control_id):
    print(file + " - " + control_id)


@then(parsers.cfparse('I get the "{status_code:Number}" response status code', extra_types=dict(Number=int)))
def i_get_the_200_response_status_code(scenario_context, status_code):
    print(status_code)


@then(parsers.cfparse('the received file contains "{expected_content:String}"', extra_types=dict(String=str)))
def the_received_file_contains_something(scenario_context, expected_content):
    print(expected_content)


@then(parsers.cfparse('the response contains an attachment in the "{format:String}" format', extra_types=dict(String=str)))
def the_response_contains_an_attachment_in_the_turtle_format(scenario_context, format):
    print(format)

