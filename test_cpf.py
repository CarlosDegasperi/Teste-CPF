# test_cpf.py
# Execução de Testes Unitários utilizando o UnitTest

# Executar: python -m unittest test_cpf.py
import unittest
from cpf import digitos_cpf

class TestDigitosCPF(unittest.TestCase):

    def test_cpf_valido(self):
        # Casos que são já conhecidos
        self.assertEqual(digitos_cpf('060339528'), '71')
        self.assertEqual(digitos_cpf('109587348'), '28')
        self.assertEqual(digitos_cpf('123456789'), '09')
        self.assertEqual(digitos_cpf('060339528'), '99')

    def test_cpf_todos_zeros(self):
        self.assertEqual(digitos_cpf('000000000'), '00')
    def test_cpf_todos_uns(self):
        self.assertEqual(digitos_cpf('111111111'), '11')
    def test_entrada_invalida(self):
        with self.assertRaises(ValueError):
            digitos_cpf('12345678')  # Só 8 dígitos

        with self.assertRaises(ValueError):
            digitos_cpf('1234567890')  # 10 dígitos

        with self.assertRaises(ValueError):
            digitos_cpf('abcdefghi')  # Letras

        with self.assertRaises(ValueError):
            digitos_cpf('12345abcd')  # Alfanumérico

    def test_caracteres_especiais(self):
        with self.assertRaises(ValueError):
            digitos_cpf('123.456.789')  # Pontos
        
        with self.assertRaises(ValueError):
            digitos_cpf('123-456-789')  # Hífen
        
        with self.assertRaises(ValueError):
            digitos_cpf('!@#456789')    # Símbolos

if __name__ == "__main__":
    unittest.main()
