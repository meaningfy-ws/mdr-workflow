# coding=utf-8
# test_rdf_validator.py
# Date:  2020.10.13
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com


import logging
from pathlib import Path

from pytest_bdd import (
    given,
    scenario,
    then,
    when, parsers,
)

logger = logging.getLogger(__name__)


@scenario('../features/rdf_validator_ws.feature', 'Main success scenario for RDF file and HTML validation report')
def test_main_success_scenario_for_rdf_file_and_html_validation_report():
    """Main success scenario for RDF file and HTML validation report."""


@scenario('../features/rdf_validator_ws.feature', 'Main success scenario for SPARQL endpoint and RDF validation report')
def test_main_success_scenario_for_sparql_endpoint_and_rdf_validation_report():
    """Main success scenario for SPARQL endpoint and RDF validation report."""


@given(parsers.cfparse('the {file_id:String} file {somefile:String}', extra_types=dict(String=str)))
def the_shacl_file_somefile(scenario_context, file_id, somefile):
    scenario_context[file_id] = somefile


@given(parsers.cfparse('the baseURI {baseUri:String}', extra_types=dict(String=str)))
def the_baseuri_httpxxxx(browser, scenario_context, baseUri):
    scenario_context["baseURI"] = baseUri


@when(parsers.cfparse('I click on the button with id {control_id:String}', extra_types=dict(String=str)))
def i_click_on_the_button_with_id_validate_button_id(browser, scenario_context, control_id):
    button = browser.find_element_by_id(control_id)
    button.click()


@when(parsers.cfparse('I fill in the field {control_id:String} with {text_value:String}',
                      extra_types=dict(String=str)))
def i_fill_in_the_field_field_id_sparql_with_someendpointhere(scenario_context, browser, control_id, text_value):
    browser.find_element_by_id(control_id).send_keys(scenario_context[text_value])


@when(parsers.cfparse('I upload in the field {field_id:String} with {file_name:String}',
                      extra_types=dict(String=str)))
def i_upload_in_the_field_schema_file_with_somefile(browser, scenario_context, field_id, file_name):
    file_button = browser.find_element_by_id(field_id)
    print(str(Path.cwd()) + scenario_context[file_name])
    file_button.send_keys(str(Path.cwd()) + scenario_context[file_name])


@when(parsers.cfparse('I navigate to the location {pageLocation:String}', extra_types=dict(String=str)))
def i_navigate_to_the_location_page(scenario_context, browser, pageLocation):
    browser.get(scenario_context["baseURI"] + pageLocation)


@then(parsers.cfparse('the field with id {field_id:String} is visible', extra_types=dict(String=str)))
def step_impl(browser, scenario_context, field_id):
    assert browser.find_element_by_id(field_id).is_displayed() is True


@given(parsers.cfparse('the {field:String} with value {value:String}', extra_types=dict(String=str)))
def step_impl(scenario_context, field, value):
    scenario_context[field] = value


@then(parsers.cfparse('the resulting page contains {content:String} in the element with id {field_id:String}', extra_types=dict(String=str)))
def the_result_page_contains(browser, scenario_context, content, field_id):
    pass