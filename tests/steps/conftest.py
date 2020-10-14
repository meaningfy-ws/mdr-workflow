# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com
import os

import pytest
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.webdriver import WebDriver


@pytest.fixture(scope="session")
def scenario_context():
    return {}


@pytest.fixture(scope="session")
def browser():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_driver_args = ["--whitelisted-ips=", "--log-path=cd.log"]
    _browser = WebDriver(chrome_options=chrome_options, service_args=chrome_driver_args)
    yield _browser
    _browser.close()
    _browser.quit()
