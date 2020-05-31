## 📚  Descrição 

O software tem o objetivo de enviar uma mensagem padrão para uma lista de contatos via whatsapp web automaticamente usando Delphi + Python

## 📢 Como executar

Requisitos:

Google Chrome v83 <br> (Caso queria usar as verões 80 ou 81, deve renomear o arquivo chromedriver para chromedriver83 e retirar o codigo da versão do chromedriver desejado para ficar com o nome de chromedriver)
Microsoft Excel ou Similar<br>

Baixar o arquivo <a href ="https://github.com/paulowiz/envioMensagensWhatsAppProject/blob/feature/countryCode/Software.rar"><b>Software.rar</b></a> e executar o <b>WhatsAppSender.exe</b>, preencher a <b>planilha_padrão(Default Sheet).xls</b> com os nomes e números desejados , usar o <b>SistemaDeEnvio</b> aberto para importar o xls, digite a mensagem 

![WhatsAppSender](https://user-images.githubusercontent.com/18649504/83356376-2ad21e00-a33c-11ea-9bf8-b385c6c43861.gif)

## 🚀 Tecnologias Usadas 

<img src="https://user-images.githubusercontent.com/18649504/66262823-725cd600-e7be-11e9-9cea-ea14305079db.png" width = "100">

<img src="https://user-images.githubusercontent.com/18649504/82679757-bbfd1280-9c21-11ea-9502-fc5cad416018.png" width = "200">

## 📌 Estrutura do Projeto 
    |-- dprInterfaceWhatsap.dproj ( Projeto de Interface do software e lógicas)
    |-- Service/main.py ( Serviço feito em python que chama whatsapp web)
    
   <br>
   <p>O sistema feito em delphi recebe a planilha padrão, valida os números e gera os txts contato.txt e mensage.txt,acionando o serviço em python para ler os txts,encaminhando as mensagens.</p>
   <p>Observações</p>
   - O intervalo entre uma mensagem e outra ( Mesmo com erro no número é de 15s)<br> 
   - Na coluna dos numeros, somente colocar codigo de área + número

## 🔓 Licença 
MIT © [Paulo Mota](https://www.linkedin.com/in/paulo-mota-955218a2/)
