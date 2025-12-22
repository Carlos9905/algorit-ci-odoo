from odoo import models, fields, api


class TestModel(models.Model):
    _name = 'test.model'
    _description = 'Modelo de Prueba'

    name = fields.Char(string='Nombre', required=True)
    value = fields.Integer(string='Valor', default=0)
    active = fields.Boolean(string='Activo', default=True)

    @api.depends('value')
    def _compute_double_value(self):
        for record in self:
            record.double_value = record.value * 2

    double_value = fields.Integer(
        string='Valor Doble',
        compute='_compute_double_value',
        store=True
    )

    def multiply_value(self, factor):
        """Método simple para probar"""
        return self.value * factor
