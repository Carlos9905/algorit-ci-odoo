#!/bin/bash
set -e

# Script para ejecutar los tests del contenedor

export PATH="./bin:${PATH}"

echo "=== Ejecutando tests del contenedor CI ==="

# Instalar pytest si no está
pip install pytest pytest-cov

# Ejecutar tests
pytest tests/ "$@"

echo "=== Tests completados ==="
