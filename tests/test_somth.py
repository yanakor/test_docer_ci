import pytest
from playwright.sync_api import sync_playwright

@pytest.mark.smoke
def test_open_browser():
    pw = sync_playwright().start()

    browser = pw.chromium.launch(headless=True)
    page = browser.new_page()

    # page.wait_for_timeout(3000)


    page.goto('https://the-internet.herokuapp.com/add_remove_elements/')
    page.locator('//button[text()="Add Element"]').click(click_count=5, delay=2000)
    page.locator('//button[text()="Add Element"]').click(force=True)

    # page.locator('canvas').click(modifiers=['Shift'], position={'x':20, 'y': 32})

    # page.wait_for_timeout(3000)

    browser.close()
    pw.stop()