#!/bin/bash
clear

# Função para mensagens coloridas
print_info() {
    echo -e "\033[0;34m[INFO]\033[0m \n $1 \n"
}
print_success() {
    echo -e "\e[32m[SUCCESSO]\033[0m \n $1 \n"
}
print_warning() {
    echo -e "\e[33m[AVISO]\033[0m \n $1 \n"
}
print_action() {
    echo -e "\e[31m[A ^g ^cO]\033[0m \n $1 \n"
}

# Verifica e remove speedtest & speedtest-cli
print_info "Verificando pacotes speedtest e speedtest-cli..."
if dpkg -l | grep -q speedtest; then
    print_action "Removendo pacote speedtest..."
    sudo apt remove -y speedtest >/dev/null 2>&1
    print_success "speedtest removido com sucesso."
else
    print_info "Pacote speedtest não instalado."
fi

if dpkg -l | grep -q speedtest-cli; then
    print_action "Removendo pacote speedtest-cli..."
    sudo apt remove -y speedtest-cli >/dev/null 2>&1
    print_success "speedtest-cli removido com sucesso."
else
    print_info "Pacote speedtest-cli n  o instalado."
fi

# Verifica e remove speedtest.list
print_info "Verificando arquivo de repositório speedtest.list..."
if [ -f /etc/apt/sources.list.d/speedtest.list ]; then
    print_action "Removendo arquivo speedtest.list..."
    sudo rm -f /etc/apt/sources.list.d/speedtest.list
    print_success "Arquivo speedtest.list removido."
else
    print_info "Arquivo speedtest.list não encontrado."
fi

# Verifica e instala curl
print_info "Verificando se o curl está instalado..."
if ! command -v curl >/dev/null 2>&1; then
    print_action "Instalando curl..."
    sudo apt update >/dev/null 2>&1
    sudo apt install curl -y >/dev/null 2>&1
    print_success "curl instalado com sucesso."
else
    print_info "curl já está instalado."
fi

# Adiciona repositório do speedtest da Ookla
print_action "Adicionando repositório oficial da Ookla..."
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash >/dev/null 2>&1
print_success "Repositório adicionado com sucesso."

# Verifica e ajusta arquivo de repositório speedtest.list
print_info "Verificando arquivo de repositório speedtest.list..."
if [ -f /etc/apt/sources.list.d/ookla_speedtest-cli.list ]; then
    print_action "Verificando versão do Ubuntu..."
    distro_codename=$(lsb_release -c | awk '{print $2}')
    if [ "$distro_codename" == "noble" ]; then
        print_action "Substituindo 'noble' por 'jammy' em speedtest.list..."
        sudo sed -i 's/noble/jammy/g' /etc/apt/sources.list.d/ookla_speedtest-cli.list
        print_success "'noble' substituído por 'jammy'."
    else
        print_info "Não é necessário ajustar o arquivo: versão do Ubuntu    '$distro_codename'."
    fi
else
    print_info "Arquivo speedtest.list não encontrado."
fi

# Atualiza repositórios
print_action "Atualizando lista de pacotes..."
sudo apt update >/dev/null 2>&1
print_success "Lista de pacotes atualizada."

# Instala o speedtest
print_action "Instalando o speedtest..."
sudo apt install speedtest -y >/dev/null 2>&1
print_success "speedtest instalado com sucesso  ^=^n^i \n"
