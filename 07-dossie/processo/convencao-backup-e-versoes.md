# Convenção de backup e controle de versões (Integrante 6)

**Versão:** v0.6 · **Data:** 28/10/2026

## 1. Backup

| Item | Regra |
|---|---|
| Fonte da verdade | O repositório `Pinho47/MOO-AV3`, ramo `master`. Nada de definitivo fica só no computador de alguém |
| Diagramas | Sempre a fonte editável (`.mmd` ou `.drawio.xml`) e o PDF exportado, versionados juntos |
| Arquivos do enunciado e do plano de execução | Ficam **fora** do repositório; cada um mantém uma cópia local. Uma cópia do plano está na pasta de arquivos do projeto |
| Antes da entrega (Fase 9) | Gerar o dossiê (`python3 07-dossie/montar-dossie.py`), exportar o PDF final e guardar uma cópia compactada do repositório em dois lugares |
| Dado real | Nenhum dado real de paciente (DEC-005); nenhuma senha em texto puro |

## 2. Controle de versões dos artefatos

| Marca | Significado |
|---|---|
| `v0.x` | Preliminar, em revisão; pode mudar |
| `v1.0` | Aprovada pelo grupo na fase de fechamento |
| `proposta-I2-…` | Proposta do Integrante 2 ainda não aprovada pelo grupo; **não** substitui o artefato oficial |

Regras: identificadores nunca são renumerados (DOD-Q01); mudança de artefato gera revisão dos relacionados (DOD-Q06); o histórico do git é o registro de quem alterou e quando; as datas dos documentos são as datas reais de versionamento.

## 3. Mensagens de commit

`<tipo>: descrição curta (Ix)`, com tipo em `docs`, `quality`, `uml`, `req` ou `fix`; `Ix` indica o integrante responsável pelo conteúdo.
