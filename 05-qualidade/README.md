# Qualidade, Normas e Processo — Integrante 5

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Escopo:** plano de qualidade baseado na ISO/IEC 25010:2023, aplicação das referências normativas, registro de processo para a autoavaliação (ISO/IEC/IEEE 12207 e família ISO/IEC 330xx) e revisão cruzada de qualidade dos artefatos de cada fase.

## Situação

As atividades do Integrante 5 nas **Fases 1 a 6** foram registradas em **28/10/2026**, como recuperação, sobre o estado do repositório nessa data e com as decisões formalizadas até 25/10/2026. Os documentos não alteram artefatos de outros integrantes: cada divergência é registrada como achado (`Q<fase>-<nn>`) e endereçada ao responsável.

## Análises por fase

| Documento | Fase do plano | O que verifica | Situação |
|---|---|---|---|
| [Análise inicial de qualidade](analises/fase-01-analise-inicial-qualidade.md) | Fase 1 — Organização | Papel, normas (atuais × retiradas), critérios mínimos DOD-Q01 a DOD-Q08, riscos RQ-01 a RQ-05 | Concluída |
| [Visão, escopo e contexto](analises/fase-02-qualidade-visao-escopo-contexto.md) | Fase 2 — Concepção | Elementos do documento de visão, coerência entre artefatos, seleção preliminar das características ISO/IEC 25010 e contexto de uso ISO/IEC 25019 | Concluída · achados Q2-01 a Q2-05 |
| [Verificação dos requisitos](analises/fase-03-verificacao-requisitos.md) | Fase 3 — Requisitos | ISO/IEC/IEEE 29148: cobertura, ambiguidade, verificabilidade, CA, RNF × ISO/IEC 25010 | Concluída · achados Q3-01 a Q3-11 |
| [Qualidade dos casos de uso](analises/fase-04-revisao-qualidade-casos-de-uso.md) | Fase 4 — Casos de uso | Completude das especificações, cobertura de RF, `include`/`extend`/generalização, coerência com decisões de 25/10 | Concluída · achados Q4-01 a Q4-10 |
| [Revisão cruzada do modelo de domínio](analises/fase-05-revisao-cruzada-modelo-dominio.md) | Fase 5 — Modelo OO | Exigências do barema para classes, manutenibilidade, resposta ao R5-15 (composição), segurança estrutural | Concluída · achados Q5-01 a Q5-10 |
| [Revisão cruzada comportamental](analises/fase-06-revisao-cruzada-comportamental.md) | Fase 6 — Comportamento | Exigências do barema, conformidade com DEC-009/010/011/016/017/025, confiabilidade e segurança, decisão sobre a matriz da Fase 6 | Concluída · achados Q6-01 a Q6-07 |
| [Arquitetura e persistência](analises/fase-07-revisao-arquitetura-persistencia.md) | Fase 7 — Arquitetura e persistência | CQ-SEG-01, CQ-CON-04, CQ-CON-05, CQ-COM-02, CQ-FLE-03 e ISO/IEC/IEEE 42010 | Concluída · achados Q7-01 a Q7-06 |

## Documentos transversais

| Documento | Conteúdo | Versão |
|---|---|---|
| [Plano de qualidade ISO/IEC 25010:2023](plano-qualidade-iso25010.md) | 7 características, 31 critérios com medida, alvo, evidência e situação na Fase 6 | v0.7 (preliminar; fecha na Fase 8) |
| [Referências normativas](normas-referencias.md) | Situação (atual/retirada), aplicação e evidência de cada norma do enunciado; referências completas | v0.6 |
| [Registro de processo](registro-processo.md) | Evidências por fase e quadro `Processo → Objetivo → Atividades → Produto → Evidência → Situação → Melhoria` | v0.6 |

## Fases ainda não executadas

| Fase | Tarefas do Integrante 5 | Artefato previsto |
|---|---|---|
| Fase 7 — Arquitetura e persistência | (feito em 30/10/2026: [`analises/fase-07-revisao-arquitetura-persistencia.md`](analises/fase-07-revisao-arquitetura-persistencia.md), achados Q7-01 a Q7-06) Fornecer ao Integrante 4 os critérios CQ-SEG-01, CQ-CON-04, CQ-CON-05, CQ-COM-02 e CQ-FLE-03; verificar a descrição de arquitetura segundo a ISO/IEC/IEEE 42010 | `analises/fase-07-*.md` |
| Fase 8 — Qualidade e rastreabilidade | Medição final do plano; matriz final sem órfãos; autoavaliação N/P/L/F; textos das seções 28, 29 e 30 do dossiê | `plano-qualidade-iso25010.md` v1.0, `registro-processo.md` v1.0, `06-rastreabilidade/matriz-rastreabilidade-final.md` |
| Fase 9 — Consolidação e pitch | Parte "Qualidade" do pitch; auditoria final do checklist do barema | `analises/fase-09-*.md` |

## Achados endereçados a outros integrantes (resumo)

| Responsável | Achados |
|---|---|
| Integrante 1 | Q2-04, Q2-05, Q3-01, Q3-02, Q3-04, Q3-06 a Q3-10 |
| Integrante 2 | Q2-01 a Q2-03, Q3-05, Q4-01 a Q4-07, Q4-09, Q4-10, Q5-02, Q5-03, Q5-06, Q5-07, Q5-10, Q6-01 a Q6-07 |
| Integrante 3 | Q5-01, Q5-03, Q5-04, Q5-05, Q5-08, Q5-09, Q5-10, Q6-07 |
| Integrante 4 | Q3-02, Q3-11, Q5-05, Q5-08 |
| Grupo | Q3-03, Q4-08, Q5-01 (as pendências PG-02 e PG-04 a PG-12 foram resolvidas em 28/10/2026, DEC-027 a DEC-030; as análises das Fases 1 a 6 descrevem o estado anterior a essa data) |

## Convenções

- `Q<fase>-<nn>`: achado de qualidade da fase; `DOD-Qnn`: critério mínimo de qualidade; `RQ-nn`: risco de qualidade; `CQ-<característica>-<nn>`: critério do plano de qualidade.
- Propostas de RNF feitas pelo Integrante 5 não recebem número: `RNF-013` a `RNF-020` estão reservados às propostas do Integrante 4 e a numeração oficial cabe ao Integrante 1.
- Nenhum documento usa dado real de paciente (DEC-005).
