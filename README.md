# Algorit CI Container

Imagen Docker para ejecutar tests de módulos Odoo (Community y Enterprise).

## Variables de Entorno

- `ODOO_VERSION`: Versión de Odoo (14.0, 15.0, 16.0, etc.)
- `ODOO_RC`: Ruta al archivo de configuración
- `PGHOST`: Host PostgreSQL (default: postgres)
- `PGUSER`: Usuario PostgreSQL (default: odoo)
- `PGPASSWORD`: Password PostgreSQL (default: odoo)
- `PGDATABASE`: Base de datos (default: odoo)

## Uso

docker build -t odoo-ci:16.0
--build-arg python_version=3.10
--build-arg odoo_version=16.0 .

## Estado

🚧 En desarrollo - Fase básica
