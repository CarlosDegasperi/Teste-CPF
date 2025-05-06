# Projeto CPF (Clipper para Python)
- Disciplina: Qualidade e Teste de Software DSM-6 (Fatec Araras - 1.Semestre/2025)
- Prof Orlando Saraiva do Nascimento Junior

Este projeto tem como objetivo validar números de CPF (Cadastro de Pessoas Físicas) utilizando a linguagem Python. Inclui também testes unitários desenvolvidos com o framework `UnitTest`.

## 🧾 Sobre o CPF

O CPF é um número de 11 dígitos utilizado no Brasil para identificar contribuintes. Os dois últimos dígitos são verificadores, calculados a partir dos nove primeiros com base no cálculo de Módulo 11.

Este projeto implementa:

- Validação do formato e dos dígitos verificadores do CPF
- Rejeição de CPFs com formato inválido
- Testes automatizados para garantir a corretude do algoritmo

## 🚀 Tecnologias Utilizadas

- Python 3.8+
- `UnitTest` (biblioteca padrão do Python para testes)

## ✅ Como Usar

## Clonar o repositório

git clone https://github.com/CarlosDegasperi/Teste-CPF.git

cd Teste-CPF

## Executar a validação
python cpf.py

## Executar os Testes (UnitTest)
python -m unittest test_cpf.py

## Exemplos de Uso da Função
from cpf import validar_cpf

print(validar_cpf("123.456.789-09"))  # False

print(validar_cpf("529.982.247-25"))  # True
