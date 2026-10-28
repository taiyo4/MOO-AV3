# Dossiê

Esta pasta armazena o dossiê de modelagem da AV3 e os textos que o compõem.

**Responsável pela integração:** Integrante 6 — Guilherme Freire.

## Como o dossiê é montado

O dossiê é **um documento único**, [`dossie.md`](dossie.md), **gerado** pelo script [`montar-dossie.py`](montar-dossie.py) a partir de:

- `secoes/` — textos preparados por fase e por integrante, com o número das seções;
- `02-requisitos/` — as tabelas de glossário, RF, RNF, RN e HU são geradas da baseline oficial, para não divergirem.

Para atualizar o dossiê, edite a seção de origem (ou a baseline) e rode, na raiz do repositório:

```bash
python3 07-dossie/montar-dossie.py
```

Não edite `dossie.md` à mão: a próxima montagem sobrescreve a alteração.

Quando uma decisão aprovada torna parte de um texto de origem desatualizada, o script coloca uma **nota de integração** logo abaixo do título da seção (dicionário `NOTAS_INTEGRACAO` no script). A correção do texto cabe ao autor; depois dela, a nota é removida.

## Seções e situação (28/10/2026, versão v0.6)

| Seções | Conteúdo | Arquivo de origem | Autor | Situação |
|---|---|---|---|---|
| 1–17 | Capa, resumo, equipe, contexto, objetivos, escopo, premissas, atores, glossário, decisões, contexto, RF, RNF, RN, HU/CA, casos de uso | [`secoes/fases1-4-secao-01-17.md`](secoes/fases1-4-secao-01-17.md) | Integrante 6 | Pronto para revisão |
| 18–20, 27 | Domínio, classes, objetos, princípios OO e SOLID | [`secoes/fase5-secao-18-20-27.md`](secoes/fase5-secao-18-20-27.md) | Integrante 2 | Integrado com notas de integração |
| 21–24 | Sequências, comunicação, atividades, estados | [`secoes/fase6-secao-21-24.md`](secoes/fase6-secao-21-24.md) | Integrante 2 | Integrado com notas de integração |
| 25, 26 | Arquitetura e persistência | [`secoes/fases7-9-secao-25-36.md`](secoes/fases7-9-secao-25-36.md) | Integrante 4 (Fase 7) | Estrutura e insumos |
| 28–30 | Qualidade, normas, processo | idem | Integrante 5 | Resumo da versão preliminar |
| 31–36 | Matriz, verificação, conclusão, limitações, referências, anexos | idem | Integrantes 1, 5 e 6 | Estrutura e texto disponível |

## Registros de integração (Integrante 6)

| Fase | Documento | Achados |
|---|---|---|
| 1 | [Estrutura do repositório e do dossiê](integracao/fase-01-estrutura-repositorio-e-dossie.md) | INT-01, INT-02 |
| 2 | [Visão, escopo e contexto](integracao/fase-02-integracao-visao-contexto.md) | INT-03, INT-04 |
| 3 | [Requisitos](integracao/fase-03-integracao-requisitos.md) | INT-05, INT-06 |
| 4 | [Casos de uso](integracao/fase-04-integracao-casos-de-uso.md) | INT-07, INT-08 |
| 5 | [Modelo de domínio](integracao/fase-05-integracao-modelo-dominio.md) | INT-09, INT-10 |
| 6 | [Diagramas comportamentais](integracao/fase-06-integracao-comportamental.md) | INT-11, INT-12 |

## Próximas etapas

| Fase | O que entra no dossiê |
|---|---|
| 7 | Seções 25 e 26 (Integrante 4) |
| 8 | Seções 28 a 31 finais (Integrante 5; matriz final) |
| 9 | Conclusão, limitações, relatório de funções, figuras embutidas, revisão editorial e exportação em PDF |

## Processo e controle (Integrante 6)

| Documento | Conteúdo |
|---|---|
| [Auditoria de arquivos editáveis e exportações](processo/auditoria-arquivos-editaveis-exportacoes.md) | Fonte editável × PDF por diagrama |
| [Backup e controle de versões](processo/convencao-backup-e-versoes.md) | Convenção de backup, marcas de versão e commits |
| [Modelo de ata de walkthrough](processo/ata-walkthrough-modelo.md) | Modelo; nenhuma ata realizada até 28/10/2026 |
| [Relatório de atuação individual](processo/relatorio-atuacao-individual-modelo.md) | Modelo e preenchimento parcial, com a recuperação das Fases 1 a 6 dos Integrantes 5 e 6 |
