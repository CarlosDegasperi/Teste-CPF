# cpf.py
# Este módulo CALCULA os dois digitos verificadores do CPF
# OBS: Para o cálculo é o usado o MODULO11 de acordo com a RF

def digitos_cpf(cpf_parcial: str) -> str:
    if not cpf_parcial.isdigit() or len(cpf_parcial) != 9:
        raise ValueError("O CPF parcial deve conter exatamente 9 dígitos numéricos.")

    def calcular_digito(digitos, fator_inicial):
        soma = 0
        for digito in digitos:
            soma += int(digito) * fator_inicial
            fator_inicial -= 1
        resto = soma % 11
        return '0' if resto < 2 else str(11 - resto)

    primeiro_digito = calcular_digito(cpf_parcial, 10)
    segundo_digito = calcular_digito(cpf_parcial + primeiro_digito, 11)

    return primeiro_digito + segundo_digito

# Bloco para execução direta
if __name__ == "__main__":
    cpf_parcial = input("Digite os 9 primeiros dígitos do CPF (somente números): ").strip()
    try:
        digitos_verificadores = digitos_cpf(cpf_parcial)
        print(f"CPF completo: {cpf_parcial}{digitos_verificadores}")
    except ValueError as e:
        print(f"Erro: {e}")
