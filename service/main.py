from time import sleep
from selenium.webdriver.common.by import By
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
import socket

mensagem = open('mensagem.txt','r')
for m in mensagem:
    message_text = m
    
no_of_message = 1  # no. of time
contato_txt = open('contatos.txt','r') #[553183001068]  # list of phone number

name = []
moblie_no_list=[]
for reg in contato_txt:
    array = reg.split(';')
    name.append(array[0])
    moblie_no_list.append('55'+array[1])

print(name)
print(moblie_no_list)


def element_presence(by, xpath, time):
    element_present = EC.presence_of_element_located((By.XPATH, xpath))
    WebDriverWait(driver, time).until(element_present)


def is_connected():
    try:
        # connect to the host -- tells us if the host is actually
        # reachable
        socket.create_connection(("www.google.com", 80))
        return True
    except:
        is_connected()

options = webdriver.ChromeOptions()
options.binary_location = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
chrome_driver_binary = "chromedriver.exe"#/usr/local/bin/chromedriver"
driver = webdriver.Chrome(chrome_driver_binary, chrome_options=options)
 
#driver = webdriver.Chrome(executable_path="chromedriver.exe")
driver.get("http://web.whatsapp.com")
sleep(1)  # wait time to scan the code in second


def send_whatsapp_msg(phone_no, text):
    driver.get(
        "https://web.whatsapp.com/send?phone={}&source=&data=#".format(phone_no))
    try:
        driver.switch_to_alert().accept()
    except Exception as e:
        pass

    try:
        element_presence(
            By.XPATH, '//*[@id="main"]/footer/div[1]/div[2]/div/div[2]',30)
        txt_box = driver.find_element(
            By.XPATH, '//*[@id="main"]/footer/div[1]/div[2]/div/div[2]')
        global no_of_message
        for x in range(no_of_message):
            txt_box.send_keys(text)
            txt_box.send_keys("\n")

    except Exception as e:
        print("invailid phone no :"+str(phone_no))

for moblie_no in moblie_no_list:
    try:
        send_whatsapp_msg(moblie_no, message_text)
        sleep(15)

    except Exception as e:
        sleep(10)
        is_connected()
