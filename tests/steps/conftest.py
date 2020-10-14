# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com

import pytest
from selenium.webdriver.chrome.webdriver import WebDriver


@pytest.fixture(scope="session")
def scenario_context():
    return {}


@pytest.fixture(scope="session")
def browser():
    _browser = WebDriver()
    yield _browser
    _browser.close()
    _browser.quit()
