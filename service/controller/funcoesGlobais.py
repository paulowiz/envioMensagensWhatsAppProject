import sys
import os
import io
from datetime import datetime
import requests
import zipfile
import time


class FucoesGlobais:

    def localiza_versao_chromedriver(self, pasta):
        versao = ''
        subpastas = list()
        if os.path.isdir(pasta):
            items = os.listdir(pasta)
            for item in items:
                novo_item = os.path.join(pasta, item)
                if os.path.isdir(novo_item):
                    subpastas.append(novo_item)
                    continue
                caminho_completo = pasta+'\\'+item
                # Exibe o nome de todos os arquivos percorridos
                print(pasta+'\\'+item)
                # exibe somente o arquivo com o nome da versão
                if caminho_completo.endswith(".manifest"):
                    item = item.split('.')
                    versao = item[0]+'.'+item[1]+'.'+item[2]
            return versao

    def baixar_arquivo(self, url, endereco):
        resposta = requests.get(url)
        if resposta.status_code == requests.codes.OK:
            with open(endereco, 'wb') as novo_arquivo:
                novo_arquivo.write(resposta.content)
            print("Download finalizado. Arquivo salvo em: {}".format(endereco))
        else:
            resposta.raise_for_status()

    def salvar_arquivo(self, binary, path):
        with open(path, 'wb') as novo_arquivo:
            novo_arquivo.write(binary)
        print("Download finalizado. Arquivo salvo em: {}".format(path))

    def atualiza_chromedrive(self):
        # Caminhos do google chrome x86 e x64
        X64path = 'C:\Program Files (x86)\Google\Chrome\Application/'
        X86path = 'C:\Program Files\Google\Chrome\Application/'
        # Verifica nas 2 pastas se existe o google chrome para pegar a versão
        try:
            pastas = os.listdir(X86path)
            path = X86path
        except:
            try:
                pastas = os.listdir(X64path)
                path = X64path
            except:
                print('Google Chrome não instalado no computador.')
                sys.exit(0)

            try:
                versao = ''
                for pasta in pastas:
                    if versao == '':
                        versao = self.localiza_versao_chromedriver(path+pasta)
                print('O chrome deste computador está com a versão: '+versao)
            except:
                print('Erro ao localizar versão do Google Chrome.')

            try:
                lastRelease = requests.get(
                    'https://chromedriver.storage.googleapis.com/LATEST_RELEASE_'+versao)
                print('A versão disponivel do webdriver do site é: '+lastRelease.text)
            except:
                print('Erro ao localizar versão online do chromedriver.')

            try:
                self.baixar_arquivo('https://chromedriver.storage.googleapis.com/' +
                                    lastRelease.text+'/chromedriver_win32.zip', 'chromedriver.zip')
                time.sleep(2)
                # Dezipa o zip
                print('Download de Chrome webdriver efetuado com sucesso.')
                with zipfile.ZipFile('chromedriver.zip', 'r') as zip_ref:
                    zip_ref.extractall('')
                print('Chrome webdriver descompactado com sucesso!')
                os.remove('chromedriver.zip')
            except:
                print('Erro de download do chromedriver.zip')


pass
