# Mapa de fontes dos dados

## O que foi verificado

Não havia um documento único que relacionasse cada indicador dos slides ao seu arquivo de origem. Este mapa separa as fontes confirmadas no código das relações que ainda precisam ser validadas. A presença de um arquivo na pasta, por si só, não comprova que ele foi usado em determinado slide.

## Fontes confirmadas no código

| Arquivo ou artefato | Dados/uso confirmado | Evidência e limites |
|---|---|---|
| Imagem da aba `Alavancagem_Endiv` fornecida na conversa | Slide 15 (`15_estrutura_financeira.html`): estrutura financeira em 31/08/2026 versus 31/12/2025 e alavancagem em 31/08/2026. | Valores transcritos da imagem em R$ mil e apresentados em R$ milhões (divisão por 1.000). Mantidos os subtotais da fonte, inclusive diferenças de R$ 1 mil nas somas dos valores arredondados. Estrutura: dívida líquida inclui aplicações; alavancagem: 89.526 − 12.816 = 76.710, sem deduzir aplicações; EBITDA ajustado informado de 67.045 e índice de 1,14x. O período de apuração desse EBITDA ajustado não foi confirmado; não foi substituído pelo EBITDA mensal do slide 6. Índice de endividamento líquido: dívida líquida / capital total, reproduzido como (0,11) e (0,00). Anotação lateral de 3%/97% não incluída por estar pendente de confirmação na própria imagem. |
| Imagem da DFC de agosto/2026 fornecida na conversa | Tabela DFC à esquerda no slide 6 (`06_dfc.html`), em R$ milhões. | Estrutura vertical, valores, sinais e subtotais transcritos da imagem. As parcelas operacionais exibidas não conciliam integralmente com o subtotal informado; os valores não foram corrigidos por inferência. |
| `Apresentação_08_26.xlsx`, abas `EBITDA_BC_25` e `EBITDA_BC_26` | Tabela EBITDA à direita no slide 6 (`06_dfc.html`), agosto/2025 versus agosto/2026, em R$ mil. | Coluna L (cabeçalho `Ago` em L13), linhas visíveis na imagem: receitas L14:L18, deduções L20, receita líquida L21, variável L24:L25, contribuição L29:L30, lucro/margem bruta L31:L32, fixo L34:L35, outras receitas L40, receitas financeiras L41, EBITDA/margem L42:L43, depreciações L45/L48, resultado operacional L46, despesas financeiras L49, LAIR L50, IR/CSLL L52, lucro/margem líquida L53:L54 e bloco Check L57:L62. Mantidos os agrupamentos Variável/Fixo, sem expandir as linhas ocultas da imagem. Comparativo mensal, não acumulado. L61 confere com L42 e com L53 + SOMA(L57:L60) em ambas as abas. Variação relativa: (2026 − 2025) / valor absoluto de 2025; margens em pontos percentuais; base zero indicada por traço. Valores em cache, sem atualização dos vínculos externos. |
| `Apresentação_08_26.xlsx` | Arquivo de origem atual definido para as extrações financeiras e de liquidez. | `scripts/excel_to_json.py` lê `BP 06_2026`, `EBITDA_BC_25`, `EBITDA_BC_26`, `Alavancagem_Endiv`, `Liquidez_25` e `Liquidez_26`; `extract_ciclo_caixa.py` lê `Liquidez_25` e `Liquidez_26`. A troca do caminho no código não comprova que todos os valores hardcoded nos slides vieram destas abas. |
| `Apresentação_08_26.xlsx`, aba `Dep_apresent` | Slide 15, comparativo de despesas de agosto/2025 e agosto/2026. | Contas individuais lidas em cache das colunas D e F; subtotais oficiais nas linhas 8 (vendas), 69 (ADM), 73 + 80 (tributárias), 92 (outras despesas/receitas) e 104 (financeiro); total geral na linha 105. A aba identifica os períodos como `31/08/25` e `31/08/26`. |
| `site/public/dashboard.json` | Snapshot normalizado das abas selecionadas do arquivo de origem atual. | Gerado por `scripts/excel_to_json.py` com `data_only=True`, portanto usa os valores em cache da planilha. O resumo contém valores padrão se não localizar os rótulos esperados; a aba `BP 06_2026` é um balanço patrimonial e não foi validada como fonte desses quatro KPIs. O JSON não é consumido pelo frontend atual. |
| `Apresent_1ºSemestre26.xlsx` | Arquivo anteriormente usado pelos dois extratores acima. | Mantido no projeto como versão anterior; os extratores foram apontados para `Apresentação_08_26.xlsx`. |
| `data.xlsx` | Planilha inspecionada por um script auxiliar. | `scripts/review_excel_data.py` abre o arquivo e imprime nome das abas e parte das células. Não há evidência no código consultado de que ele alimente a apresentação. |
| Imagem da planilha “Diagnóstico Fiscal Federal \| 2022–2026” compartilhada na conversa | Valores anuais e consolidados de referência, pagamentos/compensações, gap potencial e excedente usados no slide 22. | Os valores foram transcritos da imagem fornecida. O arquivo original da planilha, a aba de origem e as fórmulas não foram identificados nem versionados neste repositório. O slide não deve ser tratado como validação contábil independente da planilha. |

## Relações prováveis, ainda sem rastreabilidade confirmada

| Arquivo presente no projeto | Possível relação | Situação |
|---|---|---|
| `Apresentação_06V002.xlsx` | Versão anterior de material de apoio ou dados de indicadores. | Não foi encontrada referência de leitura a este arquivo nos scripts consultados; abas e uso efetivo nos slides precisam ser conferidos. |
| `Agendas_Perdas&Danos_2025_2026.xlsx` | Agenda, perdas e danos. | O arquivo está presente. `informacoes_adicionais.md` anota “483 recuperação” e “520 perdas e danos”, mas não identifica aba, período, cálculo ou slide relacionado. |
| `Enderecos_Lojas_e_Restaurantes_Lider.xlsx` | Cadastro de endereços de lojas e restaurantes. | Uso provável pelo nome do arquivo; nenhum vínculo com slides ou processamento foi confirmado no código consultado. |
| `Filial_Por_Segmento_2026.xlsx` | Relacionamento entre filiais e segmentos em 2026. | Uso provável pelo nome do arquivo; nenhum vínculo com slides ou processamento foi confirmado no código consultado. |
| `Diretrizes.pdf` | Documento de diretrizes. | Arquivo presente; não foi confirmado como fonte de valores ou indicadores da apresentação. |

## Slides sem vínculo individual confirmado

- `research.md` contém uma análise loja a loja de 1S2025 versus 1S2026, critérios de consolidação, fórmulas e abas mensais (`Jan25`–`Jun26`), mas não registra o nome do arquivo Excel usado como entrada. A origem exata dessa análise precisa ser confirmada antes de atribuí-la a um workbook específico.
- Os HTMLs dos slides contêm muitos números incorporados diretamente no conteúdo. Não foi encontrada uma referência automática que rastreie cada número até uma célula de uma planilha. Portanto, as relações entre slides e os arquivos listados como “prováveis” acima são hipóteses, não uma linhagem comprovada.
- Para o diagnóstico fiscal do slide 22, a imagem compartilhada identifica os dados, mas não preserva o caminho do arquivo original ou a aba. O `Gap potencial` é reproduzido como informado na fonte e permanece sujeito à validação dessa planilha.

## Validação de `Apresentação_08_26.xlsx`

- O arquivo foi aberto para leitura. Contém 12 abas; inclui as seis abas solicitadas pelo gerador atual e adiciona `Dep_apresent`.
- A inspeção leu os valores armazenados em cache; não atualizou vínculos externos nem recalculou fórmulas.
- O pacote contém 131 registros de vínculo com outras pastas de trabalho. Sem esses arquivos externos disponíveis e reconciliados, não é possível confirmar se os valores em cache refletem a versão mais recente das fontes.
- Foram encontrados 8 erros `#REF!` em `NE's DRE`. As fórmulas afetadas usam `VLOOKUP` com intervalo `DRE!$A:$G` e índice de coluna 8, embora o intervalo tenha apenas 7 colunas.
- Foram encontrados 5 erros `#REF!` em `Alavancagem_Endiv`, em fórmulas que dependem de `NE's BP`. A aba `NE's BP` também contém 286 erros `#REF!` nesta versão, presentes também no arquivo anterior.
- O slide `05_bp_dre_comparativo.html` foi atualizado com os valores em cache da aba `DRE`, comparando as colunas de período `31/08/2026` e `31/08/2025`, sem ajustes. O cabeçalho textual da própria aba ainda menciona junho; para o slide foram usados os cabeçalhos de data das colunas, que correspondem a agosto.
- O mesmo slide compara o BP pelas colunas datadas de `31/08/2026` e `31/08/2025`, em vez das colunas de dezembro. Na aba `BP`, os totais de ativo e de passivo mais patrimônio líquido diferem em R$ 1 mil em cada data (1.676.250 contra 1.676.251 em 2026; 1.509.923 contra 1.509.922 em 2025); os totais aparecem iguais no slide por arredondamento para R$ milhões com uma casa decimal. A diferença permanece para conciliação na fonte.
- O slide `16_avalicao_despesas_evolucao.html` compara agosto/2025 (coluna D) com agosto/2026 (coluna F) da aba `Dep_apresent`. Totais de grupo e total geral reproduzem os subtotais da planilha, inclusive a linha 105; as percentagens das contas são calculadas contra o subtotal oficial do grupo. A soma das contas detalhadas difere do subtotal em ADM em R$ 170,15 e em tributárias em R$ 30,86 em 2025, e em resultado financeiro em R$ 0,16 (2025) e R$ 2,52 (2026). Essas diferenças estão sinalizadas no slide e permanecem para conciliação na fonte.
- O resumo de `dashboard.json` procura rótulos de DRE dentro de `BP 06_2026` e usa números padrão caso não os encontre. A atualização do arquivo de entrada, por si só, não valida esses KPIs nem altera os valores hardcoded nos HTMLs dos slides.
- Usar os dados em cache é uma opção operacional, não uma confirmação contábil. As referências quebradas, vínculos externos, KPIs padrão e números fixos nos slides precisam ser reconciliados antes de considerar a apresentação validada.

## Como completar a rastreabilidade

Para confirmar cada relação pendente, registrar o arquivo de origem, a aba, o período, as células ou campos utilizados, os cálculos aplicados e o slide consumidor. Para o diagnóstico fiscal, guardar também a planilha original e identificar a aba da imagem usada para a transcrição.
