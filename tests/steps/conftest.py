# conftest.py
# Date:  2020.09.30
# Author: Laurentiu Mandru
# Email: mclaurentiu79@gmail.com
import pathlib

import pytest
from selenium.webdriver.firefox.webdriver import WebDriver


@pytest.fixture(scope="session")
def scenario_context():
    return {}


@pytest.fixture(scope="session")
def browser():
    # dir_path = pathlib.Path(__file__).__dir__()
    _browser = WebDriver()  # WebDriver( pathlib.Path(__file__).__dir__() / "firefox.exe")
    yield _browser
    _browser.close()
    _browser.quit()
