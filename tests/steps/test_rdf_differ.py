# # coding=utf-8
# """Test functionality of rdf-validator-ws running in a docker container feature tests."""
#
# from pytest_bdd import (
#     given,
#     scenario,
#     then,
#     when, parsers,
# )
#
#
# @scenario('../features/rdf_differ.feature', 'Main success scenario')
# def test_main_success_scenario():
#     """Main success scenario for SPARQL endpoint and RDF validation report."""
#
#
# @then(parsers.cfparse('the resulting page contains "{expected_content:String}"', extra_types=dict(String=str)))
# def the_resulting_page_contains_something(expected_content):
#     print(expected_content)
