# Acessa a pasta speedtest
cd /speedtest

# Realiza o teste de velocidade
speedtest -f json-pretty -s 42769 > resultado.txt

# Baixa o print do resultado
wget -qO print.png $(cat resultado.txt | jq '.result.url' -r).png 

# Converte o print para base64
base64 print.png > imgbase64.txt
