# Bootstrap Linux con Ansible

Este repositorio te permite aprovisionar tu equipo Linux desde cero usando Ansible.

## Que hace este setup inicial

- Ejecuta en `localhost`.
- Instala paquetes base segun distro (Debian/Ubuntu, Fedora/RHEL, Arch).
- Crea `~/.local/bin`.
- Permite habilitar servicios.
- Permite clonar tu repo de dotfiles.
- Instala Docker y Docker Compose.

## Estructura

- `site.yml`: playbook principal.
- `inventory/hosts.yml`: inventario local.
- `group_vars/all.yml`: variables globales para personalizar setup.
- `roles/base`: rol base multi-distro.
- `roles/base/tasks/docker.yml`: tareas de Docker (servicio, grupo y Compose).
- `bootstrap.sh`: instalacion rapida en equipo nuevo.

## Uso rapido

1. Ajusta variables en `group_vars/all.yml`.
2. Dale permisos al script:

```bash
chmod +x bootstrap.sh
```

3. Ejecuta bootstrap:

```bash
./bootstrap.sh
```

## Personalizacion minima

Edita `group_vars/all.yml`:

- `base_packages_common`: paquetes para cualquier distro.
- `services_to_enable`: servicios a habilitar y arrancar.
- `dotfiles_repo_url`: URL de tu repo de dotfiles.
- `dotfiles_repo_dest`: destino local del clon.
- `docker_install`: activa instalacion de Docker y Compose.
- `docker_users`: usuarios que se agregan al grupo `docker`.
- `docker_compose_version`: version de fallback de Docker Compose.

## Proximo nivel recomendado

Cuando crezca tu setup, separa por roles:

- `roles/dev`: herramientas de desarrollo (sdk, runtimes, CLI).
- `roles/gui`: apps de escritorio.
- `roles/security`: hardening basico y firewall.
- `roles/shell`: zsh/fish, plugins y prompt.

Luego los agregas en `site.yml`.

## Buenas practicas

- Haz cambios en roles y variables, no en comandos manuales.
- Ejecuta seguido para validar idempotencia.
- Versiona este repo en Git.
- Mantener secretos fuera del repo (usar Ansible Vault si necesitas credenciales).
