#!/usr/bin/env bash
set -euo pipefail

if [[ ${EUID} -ne 0 ]]; then
  bootstrap_user="${SUDO_USER:-$USER}"
  bootstrap_home="$(getent passwd "$bootstrap_user" | cut -d: -f6)"

  echo "Elevando permisos con sudo..."
  exec sudo env BOOTSTRAP_USER="$bootstrap_user" BOOTSTRAP_HOME="$bootstrap_home" "$0" "$@"
fi

bootstrap_user="${BOOTSTRAP_USER:-${SUDO_USER:-$USER}}"
bootstrap_home="${BOOTSTRAP_HOME:-$(getent passwd "$bootstrap_user" | cut -d: -f6)}"

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
ansible-playbook site.yml -e "bootstrap_user=$bootstrap_user bootstrap_home=$bootstrap_home"
