# speedtest2025
Script de instalação do Speedtest CLI para Linux

* O script install_speedtest.sh remove a versão anterior (speedtest-cli que está no repositório padrão) e instala a versão oficial da OOKLA.

📰 Segundo esse artigo no site da OOKLA, não há repositório para o Ubuntu "noble" e a orientação é modificar no arquivo de noble para jammy.

https://support.ookla.com/hc/en-us/articles/32139787616141-Ubuntu-24-04-noble.

O <b>install_speedtest.sh</b> verifica a versão e adapta o arquivo, caso seja necessário.

Testado no Ubuntu 24.04 mas deve funcionar em outras distribuições que utilizem o APT para instalar pacotes.

<br>
<h2>🔵 COMO INSTALAR O SPEEDTEST</h2>

Execute o comando abaixo para executar o <b>install_speedtest.sh</b>
```bash
curl -fSSL https://raw.githubusercontent.com/rafaelbagattini/speedtest2025/refs/heads/main/install_speedtest.sh | bash
```
Após instalar o pacote do Speedtest, execute a primeira vez (apenas digite <b>speedtest</b> e pressione >ENTER<) e aceite os termos.

<img width="718" height="561" alt="image" src="https://github.com/user-attachments/assets/fbd17514-4536-4e04-a87b-3973a74bb892" />


<h2>🔵 COMO UTILIZAR O SCRIPT DE TESTE DE VELOCIDADE</h2>

1. Crie um diretório na raíz chamado 'speedtest'.
```bash
mkdir /speedtest
```
2. Baixe o arquivo <b>speedtest.sh</b> e salve nesse diretório.
```bash
wget -qO /speedtest/speedtest.sh https://raw.githubusercontent.com/rafaelbagattini/speedtest2025/refs/heads/main/speedtest.sh
```
3. Dê permissão de execução ao arquivo baixado.
```bash
chmod +x /speedtest/speedtest.sh
```
4. Verifique se as dependências estão instaladas:
* wget
* jq

Caso não estejam, instale-as para que o script execute normalmente.
```bash
apt install wget jq -y
```
5. Execute o script
```bash
./speedtest.sh
```
6. Se tudo deu certo, você deve ver três novos arquivos no seu diretório:
* <b>print.png</b> - Imagem com o resultado do teste de velocidade
* <b>resultado.txt</b> - Resultado do teste no formato json-pretty
* <b>imgbase64.txt</b> - Arquivo de texto contendo a imagem do print.png no formato BASE64
