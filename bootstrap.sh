#!/usr/bin/env bash
set -euo pipefail

if ! command -v ansible-playbook >/dev/null 2>&1; then
  echo "Ansible no encontrado. Instalando..."

  if command -v apt >/dev/null 2>&1; then
    sudo apt update
    sudo apt install -y ansible
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y ansible
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Sy --noconfirm ansible
  else
    echo "No se pudo detectar gestor de paquetes compatible."
    exit 1
  fi
fi

ansible-galaxy collection install -r requirements.yml
ansible-playbook site.yml --ask-become-pass
