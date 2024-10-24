#!/bin/bash

# Cria a rede se não existir
docker network create --subnet=192.168.5.0/24 developer-network || echo "Rede já existe."

# Construir a imagem principal
docker build -t docker-setup-base -f Dockerfile .

# Adicionando uma mensagem de conclusão
echo "Construção concluída!"
