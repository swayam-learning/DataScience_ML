from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

import time
# options = webdriver.ChromeOptions()
# options.add_argument('--ignore-certificate-errors')
# options.add_argument('--proxy-server=http://your.proxy:port')
service = Service(executable_path="C:/Users/hp/Downloads/chrome-win64/chrome-win64/chrome.exe")
driver = webdriver.Chrome()

driver.get("https://www.google.com/")
WebDriverWait(driver,10).until(EC.presence_of_element_located((By.CLASS_NAME,"gLFyf"))) # if we donot find what we needed then just go ahead and crash the program

input_element = driver.find_element(By.CLASS_NAME,"gLFyf")
input_element.clear() # we do this to clear anything already present
input_element.send_keys("learning swayam"+Keys.ENTER) #because this just appends rather than clearing and writting again

link = driver.find_element(By.PARTIAL_LINK_TEXT,"Swayam Central")#we are going to access alink if it has the text 
# if we use By.LINK_TEXT then we try to find the exact text
link.click()
time.sleep(10)
driver.quit()