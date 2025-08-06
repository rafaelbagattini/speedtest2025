#!/bin/bash

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

if [ "$(id -u)" -ne 0 ]; then
  whiptail --title "Permissão insuficiente" \
           --msgbox "Este script precisa ser executado como root." 12 60
  exit 1
fi



# Exibe a caixa de diálogo com tamanho fixo e título estilizado
whiptail --msgbox "Este instalador irá remover o speedtest-cli\n  e instalar o speedtest oficial da OOKLA." 8 50

# Confirmação
if ! whiptail --yesno "Deseja continuar com a instalação?" 8 50; then
    echo -e "❌ ${RED}Instalação cancelada.${NC}"
    exit 1
fi

# Progresso com mensagens completas e quebradas em linha
{
    echo "10"
    echo "XXX"
    echo -e "Etapa 1:\nRemovendo versão antiga do speedtest-cli..."
    echo "XXX"
    apt remove --purge speedtest-cli -y > /dev/null 2>&1
    sleep 2

    echo "30"
    echo "XXX"
    echo -e "Etapa 2:\nAdicionando repositorio da OOKLA..."
    echo "XXX"
    rm -f /etc/apt/sources.list.d/speedtest.list > /dev/null 2>&1
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash > /dev/null 2>&1
    sleep 2

    echo "50"
    echo "XXX"
    echo -e "Etapa 3:\nValidando compatibilidade..."
    echo "XXX"
    source /etc/os-release
    if [[ "$VERSION_CODENAME" =~ ^(noble|oracular)$ ]]; then
        sed -i "s/$VERSION_CODENAME/jammy/g" /etc/apt/sources.list.d/ookla_speedtest-cli.list > /dev/null 2>&1
    fi
    sleep 2

    echo "75"
    echo "XXX"
    echo -e "Etapa 4:\nAtualizando lista de pacotes..."
    echo "XXX"
    apt update -y > /dev/null 2>&1
    sleep 2

    echo "100"
    echo "XXX"
    echo -e "Etapa 5:\nInstalando nova versão do speedtest..."
    echo "XXX"
    apt install speedtest -y > /dev/null 2>&1
    sleep 2
} | whiptail --gauge "Instalando Speedtest CLI. Aguarde..." 8 50 0
echo
echo

# Mensagem final com cor
echo -e "${GREEN}✅ Speedtest CLI instalado ou atualizado com sucesso!${NC}"
echo -e "${CYAN}Execute 'speedtest' para testar sua conexão.${NC}"
echo
