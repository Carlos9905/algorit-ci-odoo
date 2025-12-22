"""Tests básicos para verificar el contenedor"""
import subprocess
import os

def test_python_available():
    """Verifica que Python está disponible"""
    result = subprocess.run(['python', '--version'], 
                          capture_output=True, text=True)
    assert result.returncode == 0
    assert 'Python' in result.stdout or 'Python' in result.stderr

def test_odoo_command_available():
    """Verifica que el comando odoo está disponible"""
    result = subprocess.run(['which', 'odoo'], 
                          capture_output=True, text=True)
    assert result.returncode == 0

def test_coverage_installed():
    """Verifica que coverage está instalado"""
    result = subprocess.run(['coverage', '--version'], 
                          capture_output=True, text=True)
    assert result.returncode == 0

def test_config_file_exists():
    """Verifica que el archivo de configuración existe"""
    odoo_rc = os.environ.get('ODOO_RC', '/etc/odoo/odoo.conf')
    assert os.path.exists(odoo_rc)
