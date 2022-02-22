#!/bin/sh -e

# Creates client certificates.
nginx_session_ticket --only-if-missing
nginx_install_cert --self-signed "/C=BR/ST=SaoPaulo/L=SaoPaulo/O=SuperSim/OU=Com/OU=Br/CN=client"

# Starts cron.
env > /etc/docker_env
chmod +x /etc/docker_env
service cron start

# Sync config.
nginx_sync_config --no-reload || true
nginx_variables --no-reload || true
nginx_update_intranet --no-reload || true
nginx_check_config --no-reload || true

# Runs original command.
exec "$@"