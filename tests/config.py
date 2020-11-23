# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com

import os


RDF_VALIDATOR_UI_URL = os.environ.get('RDF_VALIDATOR_UI_URL', 'http://dev.meaningfy.ws:8010')
DIFFER_UI_URL = os.environ.get('DIFFER_UI_URL', 'http://dev.meaningfy.ws:8030')
LINKEDPIPES_ETL_UI_URL = os.environ.get('LINKEDPIPES_ETL_UI_URL', 'http://dev.meaningfy.ws:8060')
RUN_HEADLESS_UI_TESTS = os.environ.get('RUN_HEADLESS_UI_TESTS', False)
