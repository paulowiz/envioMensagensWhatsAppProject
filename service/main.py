from time import sleep
from selenium.webdriver.common.by import By
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import WebDriverWait
import socket
from datetime import datetime

data_e_hora_atuais = datetime.now()
data_e_hora_em_texto = data_e_hora_atuais.strftime('%d%m%Y-%H%M%S')
log = open('log-'+data_e_hora_em_texto+'.txt', 'w')

message_text = ''
mensagem = open('mensagem.txt','r', encoding="utf8")
for msg in mensagem:
    message_text = message_text + msg
    
mensagem.close()

no_of_message = 1  # no. of time
contato_txt = open('contatos.txt','r') #[553183001068]  # list of phone number

name = []
moblie_no_list=[]
for reg in contato_txt:
    array = reg.split(';')
    name.append(array[0])
    moblie_no_list.append(array[1])


def element_presence(by, xpath, time):
    element_present = EC.presence_of_element_located((By.XPATH, xpath))
    sleep(5)
    #WebDriverWait(driver, time).until(element_present)


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
sleep(20)  # wait time to scan the code in second


def send_whatsapp_msg(phone_no, text):
    driver.get(
        "https://web.whatsapp.com/send?phone={}&source=&data=#".format(phone_no))
    try:
        driver.switch_to_alert().accept()
    except Exception as e:
        pass

    try:
        element_presence(
            By.XPATH, '//*[@id="main"]/footer/div[1]/div[2]/div/div[2]', 30)
        txt_box = driver.find_element(
            By.XPATH, '//*[@id="main"]/footer/div[1]/div[2]/div/div[2]')
        global no_of_message
        for x in range(no_of_message):
            txt_box.send_keys(text)
            txt_box.send_keys("\n")
        logtext = str(phone_no)+';'+'Message sent successfully\n'
        logtext = logtext.replace('\n','')
        log.writelines(logtext+'\n')

    except Exception as e:
        logtext = str(phone_no)+';'+'Error Number'
        logtext = logtext.replace('\n','')
        log.writelines(logtext+'\n')
       


for moblie_no in moblie_no_list:
    try:
        send_whatsapp_msg(moblie_no, message_text)
        sleep(15)
    except Exception as e:
       sleep(5)
       is_connected()
driver.close
log.close()
contato_txt.close()
