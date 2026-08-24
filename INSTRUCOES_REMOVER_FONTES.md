# Instruções: Remover Fontes dos Slides

## Objetivo
Remover as importações de fontes do Google Fonts dos arquivos HTML para otimizar carregamento.

## Fontes Utilizadas
A apresentação atualmente usa as seguintes fontes importadas:

```css
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');
```

## Linhas a Remover

### 1. Remoção da importação
Remover estas linhas do `<style>`:
- `@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');`
- `@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');`

### 2. Manter fallbacks nos estilos
As declarações `font-family` devem manter fallbacks do sistema. Exemplos:
- `font-family: Inter, Arial, sans-serif;` (sem Google Fonts, usará Inter do sistema se disponível)
- `font-family: 'Bebas Neue', Impact, sans-serif;` (sem Google Fonts)

## Processo

1. Abrir cada arquivo HTML em `/site/public/slides/`
2. Localizar a linha `@import url('https://fonts.googleapis.com/...`
3. Deletar a linha inteira (incluindo ponto e vírgula)
4. Manter as propriedades `font-family` nos estilos CSS
5. Testar visualmente para garantir que as fontes alternativas funcionam

## Efeito Visual
- `Inter` será substituído por Arial (ou outra sans-serif disponível)
- `Bebas Neue` será substituída por Impact (ou Impact → serif genérico)

## Slides Afetados
Todos os arquivos em:
```
\\10.15.4.252\Controladoria - Automação\Fábrica de sonhos\Natanael_BI_py\Apresentacao_grupo_lider_trimestral\nova_apresentacao\site\public\slides\
```

Total: 17 slides (01 a 17)

## Verificação
Após remover, validar que:
- Não há erros no console do navegador
- Fontes alternativas aparecem corretamente
- Layout permanece inalterado
