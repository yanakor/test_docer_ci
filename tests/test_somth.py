import pytest
from playwright.sync_api import sync_playwright
import allure

@allure.title('Open browser')
@allure.description('click on btn 5 times')
@pytest.mark.smoke
def test_open_browser():
    pw = sync_playwright().start()
    with allure.step('launch browser'):
        browser = pw.chromium.launch(headless=True)
    with allure.step('open new page'):
        page = browser.new_page()

    page.goto('https://the-internet.herokuapp.com/add_remove_elements/')
    page.locator('//button[text()="Add Element"]').click(click_count=5, delay=2000)
    page.locator('//button[text()="Add Element"]').click(force=True)


    browser.close()
    pw.stop()