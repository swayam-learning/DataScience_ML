# from selenium import webdriver
# from selenium.webdriver.common.by import By
# from selenium.webdriver.common.keys import Keys  # Import Keys module
# import time

# # Initialize the Chrome driver
# driver = webdriver.Chrome()

# driver.get('https://www.google.com/')

# search = driver.find_element(By.NAME, 'q')
# search.send_keys("Selenium")

# search.send_keys(Keys.ENTER)  # Simulate pressing the Enter key
# time.sleep(10)  # Reduce sleep time to 10 seconds for better practice
# driver.close()
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver import Keys
import time
service = Service(executable_path="C:/Users/hp/Downloads/chrome-win64/chrome-win64/chrome.exe")
driver = webdriver.Chrome()

driver.get('https://www.google.com/')

search = driver.find_element(By.NAME, 'q')

#enter search text
search.send_keys("Pandas")
time.sleep(10)
search.send_keys(Keys.ENTER)

# from selenium import webdriver
# from selenium.webdriver.chrome.service import Service
# from selenium.webdriver.common.by import By

# DRIVER_PATH = 'path to chromedriver'

# # Create a Service object
# service = Service(executable_path=DRIVER_PATH)

# # Initialize the Chrome driver with the Service object
# driver = webdriver.Chrome(service=service)

# driver.get('https://www.google.com/')

# search = driver.find_element(By.NAME, 'q')

# #enter search text
# m.send_keys("Pandas")
# time.sleep(0.2)
# #perform Google search with Keys.ENTER
# m.send_keys(Keys.ENTER)