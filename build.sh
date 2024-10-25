#!/bin/bash

# Solicita o email e o username do GitHub
read -p "Digite seu email do GitHub: " github_email
read -p "Digite seu username do GitHub: " github_username

# Remove redes não utilizadas
docker network prune -f

# Cria a rede se não existir
docker network create --subnet=192.168.5.0/24 developer-network || echo "Rede já existe."

# Verifica se o contêiner já existe e remove se necessário
if [ "$(docker ps -a -q -f name=developer-container)" ]; then
    echo "Contêiner 'developer-container' já existe. Removendo..."
    docker rm -f developer-container
    echo "Contêiner removido."
fi

# Construir a imagem principal, passando variáveis de ambiente para o Dockerfile
docker build --build-arg GIT_EMAIL="$github_email" --build-arg GIT_USERNAME="$github_username" -t docker-setup-base -f Dockerfile .

# Adicionando uma mensagem de conclusão
echo "Construção concluída!"

# Criando o contêiner
docker run -d --name developer-container --net developer-network --ip 192.168.5.10 -p 2222:22 docker-setup-base

# Adicionando uma mensagem de conclusão
echo "Novo contêiner 'developer-container' criado com sucesso!"
