#!/bin/bash
# Script para extrair e calcular ciclo de caixa

# Dados de Liquidez_26 (Liquidez 2026) - Trimestres
# Período: 1º Trim, 2º Trim, 3º Trim, 4º Trim
# Clientes (dias): 29, 28, 34, 46
# Estoques (dias): 45, 51, 68, 91  
# Fornecedores (dias): 36, 41, 52, 70

declare -a periodos=("1º Trim 25" "2º Trim 25" "3º Trim 25" "4º Trim 25" "2T26")
declare -a clientes=(25 26 28 30 29)
declare -a estoques=(55 60 65 68 51)
declare -a fornecedores=(35 38 42 48 41)

echo "Ciclo de Caixa Recalculado:"
echo ""
echo "Período | Clientes | Estoques | Fornecedores | Ciclo"
echo "--------|----------|----------|--------------|------"

for i in "${!periodos[@]}"; do
  cli=${clientes[$i]}
  est=${estoques[$i]}
  for=${fornecedores[$i]}
  ciclo=$((cli + est - for))
  printf "%-12s | %8d | %8d | %12d | %5d\n" "${periodos[$i]}" "$cli" "$est" "$for" "$ciclo"
done
