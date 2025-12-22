from odoo.tests.common import TransactionCase


class TestModelBasic(TransactionCase):
    
    def setUp(self):
        super(TestModelBasic, self).setUp()
        self.TestModel = self.env['test.model']
    
    def test_create_record(self):
        """Test: Crear un registro"""
        record = self.TestModel.create({
            'name': 'Test Record',
            'value': 10,
        })
        self.assertEqual(record.name, 'Test Record')
        self.assertEqual(record.value, 10)
        self.assertTrue(record.active)
    
    def test_compute_double_value(self):
        """Test: Campo computado double_value"""
        record = self.TestModel.create({
            'name': 'Test Compute',
            'value': 5,
        })
        self.assertEqual(record.double_value, 10)
    
    def test_multiply_method(self):
        """Test: Método multiply_value"""
        record = self.TestModel.create({
            'name': 'Test Method',
            'value': 7,
        })
        result = record.multiply_value(3)
        self.assertEqual(result, 21)
    
    def test_default_values(self):
        """Test: Valores por defecto"""
        record = self.TestModel.create({
            'name': 'Test Defaults',
        })
        self.assertEqual(record.value, 0)
        self.assertTrue(record.active)
