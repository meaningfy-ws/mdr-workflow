# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com

import os

VALIDATOR_UI_URL = os.environ.get('FILENAME', 'http://localhost:8010')
DIFFER_UI_URL = os.environ.get('FILENAME', 'http://localhost:8030')
