# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com

import os

VALIDATOR_UI_URL = os.environ.get('VALIDATOR_UI_URL', 'http://localhost:8010')
DIFFER_UI_URL = os.environ.get('DIFFER_UI_URL', 'http://localhost:8030')
RUN_HEADLESS_UI_TESTS = os.environ.get('RUN_HEADLESS_UI_TESTS', False)
