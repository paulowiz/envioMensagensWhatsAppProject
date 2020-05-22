## 📚  Descrição 

O software tem o objetivo de enviar uma mensagem padrão para uma lista de contatos via whatsapp web automaticamente usando Delphi + Python

## 📢 Como executar

Requisitos:

Google Chrome <br>
Microsoft Excel ou Similar<br>

Baixar o arquivo Software Compilado.rar e executar o SistemaDeEnvio.exe, preencher a planilha_padrão.xls com os nomes e números desejados , usar o SistemaDeEnvio aberto para importar o xls, digite a mensagem 

![gif](https://user-images.githubusercontent.com/18649504/82680684-059a2d00-9c23-11ea-980f-055d88dc8bc2.gif)

## 🚀 Tecnologias Usadas 

<img src="https://user-images.githubusercontent.com/18649504/66262823-725cd600-e7be-11e9-9cea-ea14305079db.png" width = "100">

<img src="https://user-images.githubusercontent.com/18649504/82679757-bbfd1280-9c21-11ea-9502-fc5cad416018.png" width = "200">

## 📌 Estrutura do Projeto 
    |-- dprInterfaceWhatsap.dproj ( Projeto de Interface do software e lógicas)
    |-- Service/main.py ( Serviço feito em python que chama whatsapp web)
    
   <br>
   <p>O sistema feito em delphi recebe a planilha padrão, valida os números e gera os txts contato.txt e mensage.txt,acionando o serviço em python para ler os txts,encaminhando as mensagens.</p>



## 🔓 Licença 
MIT © [Paulo Mota](https://www.linkedin.com/in/paulo-mota-955218a2/)
