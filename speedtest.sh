# Acessa a pasta speedtest
cd /speedtest

# Realiza o teste de velocidade
speedtest -f json-pretty > resultado.json

# Envia o resultado.json para o Zabbix.
# No parâmetro -s deve ser informado o "hostname" que está no Zabbix
zabbix_sender -z 127.0.0.1 -s "Teste de velocidade" -k speedtest.resultado -o "$(cat resultado.json)"

# Baixa o print do resultado
wget -qO print.png $(cat resultado.json | jq '.result.url' -r).png 

# Converte o print para base64
base64 print.png > img.b64

#Envia o print para o Zabbix
zabbix_sender -z 127.0.0.1 -s "Teste de velocidade" -k speedtest.print -o "$(cat img.b64)"
