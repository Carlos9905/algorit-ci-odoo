# 🚀 Algorit-CI-Odoo - CI/CD para Odoo Enterprise

**Imagen Docker optimizada para tests unitarios de módulos Odoo que dependen de Enterprise.** Personal y optimizada para mi workflow de desarrollo.

[![Docker Image Size](https://img.shields.io/docker/image-size/ghcr.io/carlos9905/algorit-ci-odoo/py3.10-odoo16.0)](https://ghcr.io/carlos9905/algorit-ci-odoo)
[![GitHub Workflow Status](https://github.com/Carlos9905/algorit-ci-odoo/workflows/Publish%2016.0/badge.svg)](https://github.com/Carlos9905/algorit-ci-odoo/actions)

## 🎯 **Características**

- ✅ **Enterprise nativo** (GITHUB_TOKEN auto-detectado)
- ✅ **1 comando** → `run_tests` = install + test + coverage
- ✅ **Coverage HTML/XML** (91%+)
- ✅ **Filtros** `INCLUDE/EXCLUDE`
- ✅ **Multi-versión** 16/17/18/19

## 🚀 **Uso en GitHub Actions**

```

name: CI Odoo 16.0
on: [pull_request, push]

jobs:
test:
runs-on: ubuntu-22.04
container: ghcr.io/carlos9905/algorit-ci-odoo:py3.10-odoo16.0:latest
services:
postgres:
image: postgres:14
env:
POSTGRES_USER: odoo
POSTGRES_PASSWORD: odoo
POSTGRES_DB: odoo
ports: ["5432:5432"]
options: >-
--health-cmd pg_isready
--health-interval 10s
--health-timeout 5s
--health-retries 5

    steps:
    - uses: actions/checkout@v4
    
    - name: Tests (1 comando = TODO)
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        PGHOST: postgres
        PGPORT: 5432
        PGUSER: odoo
        PGPASSWORD: odoo
        PGDATABASE: odoo
        ADDONS_DIR: .
      run: run_tests
    ```

## 🔧 **Comandos**

```


# Test completo (recomendado)

run_tests

# Solo instalar

install_addons

# Crear DB test

init_test_database

# Solo tests

run_tests --no-init

# Coverage HTML

run_tests --coverage-html

```

## ⚙️ **Variables de Entorno**

| Variable | Default | Descripción |
|----------|---------|-------------|
| `GITHUB_TOKEN` | - | **Enterprise repos** |
| `INCLUDE` | `*` | `module1,module2` |
| `EXCLUDE` | - | `exclude1,exclude2` |
| `PGHOST` | `postgres` | Host PostgreSQL |
| `ADDONS_DIR` | `/workspace/addons` | Ruta addons |

## 📦 **Versiones Disponibles**

| Odoo | Tag | Python | Status |
|------|-----|--------|--------|
| **16.0** | `py3.10-odoo16.0:latest` | 3.10 | ✅ **Production** |
| 17.0 | `py3.11-odoo17.0:latest` | 3.11 | 🔄 Soon |
| 18.0 | `py3.10-odoo18.0:latest` | 3.10 | 🔄 Soon |

## 🐳 **Docker Local**

```


# Pull

docker pull ghcr.io/carlos9905/algorit-ci-odoo:py3.10-odoo16.0:latest

# Test rápido

docker run --rm -e PGHOST=host.docker.internal ghcr.io/carlos9905/algorit-ci-odoo:py3.10-odoo16.0:latest run_tests

# Docker Compose

docker compose up --build

```

## 📊 **Coverage Report**

```

📁 coverage_data/htmlcov/index.html  ← HTML interactivo
📁 coverage_data/.coverage          ← XML/JSON

```

## 🤝 **Contribuir**

1. Fork → Clone → Branch
2. `docker compose up --build`
3. Tests → Commit → PR

## 📄 **Licencia**

MIT © [Carlos9905](https://github.com/Carlos9905)