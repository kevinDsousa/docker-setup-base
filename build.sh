#!/bin/bash

# Construir a imagem de configuração
docker build -t configs -f configs/Dockerfile.config .

# (Opcional) Construir a imagem para os projetos
docker build -t projects -f Dockerfile.projects .

# Exemplo: Se você quiser construir uma imagem final que use as anteriores
docker build -t docker-setup-base -f Dockerfile .

# Adicionando uma mensagem de conclusão
echo "Construção concluída!"
