# speedtest2025
Script de instalação do Speedtest CLI para Linux

O script install_speedtest.sh remove a versão anterior e instala a versão oficial da OOKLA.

Segundo o artigo no site da OOKLA, não há repositório para o Ubuntu "noble", e a orientação é modificar no arquivo de noble para jammy.
https://support.ookla.com/hc/en-us/articles/32139787616141-Ubuntu-24-04-noble. O script verifica a versão e adapta o arquivo necessário.

Testado no Ubuntu 24.04 mas deve funcionar em outras distribuições que utilizem o APT para instalar pacotes.


O script speedtest.sh realiza o teste de velocidade e deve estar em /speedtest.

Dependências:
* wget
* jq
* base64
