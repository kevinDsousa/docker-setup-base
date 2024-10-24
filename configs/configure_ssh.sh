#!/bin/bash

# Define usuário e senha padrão
usuario="developer"
senha="developer"

# Cria o usuário e configura a senha
useradd -ms /bin/bash "$usuario"
echo "$usuario:$senha" | chpasswd
echo "Usuário $usuario criado com sucesso."

# Configura o SSH
mkdir -p /var/run/sshd
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

# Inicia o SSH
/usr/sbin/sshd

# Mantém o contêiner em execução
tail -f /dev/null
