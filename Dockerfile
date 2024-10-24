# Primeiro estágio: Configuração
FROM ubuntu:latest AS base

# Definindo variáveis de ambiente
ENV DEBIAN_FRONTEND=noninteractive

# Atualiza os pacotes e instala as dependências
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

# Adiciona a chave GPG do Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Adiciona o repositório do Docker
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Instala o Docker
RUN apt-get update && apt-get install -y \
    docker-ce docker-ce-cli containerd.io \
    && rm -rf /var/lib/apt/lists/*

# Copia o script de configuração do SSH
COPY configs/configure_ssh.sh /usr/local/bin/configure_ssh.sh
RUN chmod +x /usr/local/bin/configure_ssh.sh

# Segundo estágio: Execução
FROM ubuntu:latest

# Instala o openssh-server no estágio final também
RUN apt-get update && apt-get install -y openssh-server && mkdir /var/run/sshd

# Expor a porta 22 para o SSH
EXPOSE 22

# Copia as configurações do estágio anterior
COPY --from=base /usr/local/bin/configure_ssh.sh /usr/local/bin/configure_ssh.sh

# Define volumes para persistir dados
VOLUME ["/etc/ssh", "/var/log", "/home/developer"]

# Comando para executar o script ao iniciar o contêiner
CMD ["/usr/local/bin/configure_ssh.sh"]
