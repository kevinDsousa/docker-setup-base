#!/bin/bash

# Pergunta se deseja configurar o SSH
read -p "Deseja configurar um usuário SSH? (s/n): " resposta

if [[ "$resposta" == "s" ]]; then
    read -p "Digite o nome do usuário: " usuario
    read -sp "Digite a senha do usuário: " senha
    echo

    # Cria o usuário e configura a senha
    useradd -ms /bin/bash "$usuario"
    echo "$usuario:$senha" | chpasswd
    echo "Usuário $usuario criado com sucesso."
else
    echo "Configuração de SSH pulada."
fi

# Configura o SSH
mkdir /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

# Inicia o SSH
service ssh start

# Mantém o contêiner em execução
tail -f /dev/null
