#!/bin/bash
clear

# Função para mensagens coloridas
print_info() {
    echo -e "\033[0;34m\e[1m[INFO]\033[0m \n\e[1m $1 \033[0m\n"
}
print_success() {
    echo -e "\e[32m\e[1m[SUCCESSO]\033[0m \n\e[1m $1 \033[0m\n"
}
print_warning() {
    echo -e "\e[33m\e[1m[AVISO]\033[0m \n\e[1m $1 \033[0m\n"
}
print_action() {
    echo -e "\e[31m\e[1m[AÇÃO]\033[0m \n\e[1m $1 \033[0m\n"
}
# Verifica e remove speedtest & speedtest-cli
print_info "Verificando pacotes speedtest e speedtest-cli..."
if dpkg -l | grep -q speedtest; then
    print_action "Removendo pacote speedtest..."
    apt remove -y speedtest >/dev/null 2>&1
    print_success "speedtest removido com sucesso."
else
    print_info "Pacote speedtest não instalado."
fi

if dpkg -l | grep -q speedtest-cli; then
    print_action "Removendo pacote speedtest-cli..."
    apt remove -y speedtest-cli >/dev/null 2>&1
    print_success "speedtest-cli removido com sucesso."
else
    print_info "Pacote speedtest-cli n  o instalado."
fi

# Verifica e remove speedtest.list
print_info "Verificando arquivo de repositório speedtest.list..."
if [ -f /etc/apt/sources.list.d/speedtest.list ]; then
    print_action "Removendo arquivo speedtest.list..."
    rm -f /etc/apt/sources.list.d/speedtest.list
    print_success "Arquivo speedtest.list removido."
else
    print_info "Arquivo speedtest.list não encontrado."
fi

# Verifica e instala curl
print_info "Verificando se o curl está instalado..."
if ! command -v curl >/dev/null 2>&1; then
    print_action "Instalando curl..."
    apt update >/dev/null 2>&1
    apt install curl -y >/dev/null 2>&1
    print_success "curl instalado com sucesso."
else
    print_info "curl já está instalado."
fi

# Adiciona repositório do speedtest da Ookla
print_action "Adicionando repositório oficial da Ookla..."
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash >/dev/null 2>&1
print_success "Repositório adicionado com sucesso."

# Verifica e ajusta arquivo de repositório speedtest.list
print_info "Verificando arquivo de repositório speedtest.list..."
if [ -f /etc/apt/sources.list.d/ookla_speedtest-cli.list ]; then
    print_action "Verificando versão do Linux..."
    distro_codename=$(source /etc/os-release && echo "$VERSION_CODENAME")
    if [[ "$distro_codename" == "noble" || "$distro_codename" == "oracular" ]]; then
        print_action "Substituindo $distro_codename por 'jammy' em speedtest.list..."
        sed -i "s/$distro_codename/jammy/g" /etc/apt/sources.list.d/ookla_speedtest-cli.list
        print_success "$distro_codename substituído por 'jammy'."
    #else
    #    print_info "Não foi necessário ajustar o arquivo."
    fi
else
    print_info "Arquivo speedtest.list não encontrado."
fi

# Atualiza repositórios
print_action "Atualizando lista de pacotes..."
apt update >/dev/null 2>&1
print_success "Lista de pacotes atualizada."

# Instala o speedtest
print_action "Instalando o speedtest..."
apt install speedtest -y >/dev/null 2>&1
print_success "speedtest instalado com sucesso!! \n"
