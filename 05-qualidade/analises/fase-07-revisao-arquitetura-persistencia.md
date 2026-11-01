# Fase 7 — Revisão de Qualidade da Arquitetura e da Persistência (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo); registro executado pelo Integrante 1 em 30/10/2026 (ver `07-dossie/processo/relatorio-atuacao-individual-modelo.md`)
**Data:** 30/10/2026 · **Versão:** v1.0
**Insumos:** `04-persistencia/` (DER-001, modelo relacional, dicionário, mapeamento, normalização, DDL), `03-uml/Pacotes/`, `Componentes/`, `Implantacao/` (entregues em 29/10/2026), `01-planejamento/revisoes/FASE7-REV-I2-…`, plano de qualidade ISO/IEC 25010.
**Normas:** ISO/IEC/IEEE 42010:2022 (descrição de arquitetura); ISO/IEC 25010:2023 (segurança, confiabilidade, compatibilidade, flexibilidade).

## 1. Critérios entregues ao Integrante 4 e resultado

| Critério | Resultado | Evidência |
|---|---|---|
| CQ-SEG-01 — nenhuma senha em texto puro | **Atende** | `usuario.hash_senha` com `CHECK (CHAR_LENGTH >= 20)`; o dicionário diz que a coluna "nunca" guarda senha em texto puro; `detalhe` da auditoria sem corpo de mensagem nem endereço |
| CQ-CON-04 — FK e restrições respeitam as multiplicidades | **Parcial** | 24 chaves estrangeiras no DDL; mas as multiplicidades do diagrama de classes oficial ainda estão `PENDENTE` (Q5-01), e o DER-001 tem 4 relações propostas (A18–A21) fora do oficial |
| CQ-CON-05 — dois agendamentos ativos no mesmo horário | **Atende** | `UNIQUE (slot_ativo)` por coluna gerada em `agendamento`; TRS-01 e TRS-04 usam `SELECT … FOR UPDATE` no slot |
| CQ-COM-02 — Serviço Externo de E-mail nos 4 diagramas | **Parcial (2 de 4)** | presente na implantação e nos componentes; ausente no contexto (CTX-001) e no diagrama de casos de uso oficial, segundo a última verificação (Q2-01, Q4-05) |
| CQ-FLE-03 — pacotes sem ciclo | **A conferir** | PAC-001 declara camadas com inversão de dependência; a ausência de ciclo ainda precisa ser conferida diagrama a diagrama na Fase 8 |

## 2. Descrição de arquitetura (ISO/IEC/IEEE 42010)

| Elemento da norma | Onde está | Situação |
|---|---|---|
| Stakeholders e interesses (concerns) | Stakeholders em `02-requisitos/stakeholders-atores.md`; interesses no plano ISO 25010 | **Parcial** — falta uma tabela que ligue cada interesse a uma visão |
| Pontos de vista e visões | PAC-001 (lógica), CMP-001 (componentes), IMP-001 (implantação), DER-001 (dados) | **OK** — quatro visões |
| Correspondência entre visões | Pacotes e componentes citam RF/RN; mapeamento objeto-relacional liga classe a tabela | **Parcial** — falta uma tabela única de correspondência entre as quatro visões |
| Decisões e justificativas | DEC-003, DEC-018, DEC-020 a DEC-024 e DEC-027 a DEC-029 citadas no esquema | **OK** |

## 3. Achados

| ID | Achado | Responsável sugerido | Situação |
|---|---|---|---|
| Q7-01 | Exportação em PDF de PAC-001, CMP-001 e IMP-001 pendente (DOD-Q04, barema §19). O Integrante 4 registrou a causa (diagrams.net indisponível) | Integrante 4 | Aberto |
| Q7-02 | DDL não executado; a verificação é só textual. Os critérios CQ-CON-04 e CQ-CON-05 só ficam firmes com um teste em MySQL 8.0 | Integrante 4 | Aberto |
| Q7-03 | Falta tabela ligando interesses dos stakeholders às visões e tabela de correspondência entre as quatro visões (42010) | Integrante 4, com Integrante 6 (seção 25) | Aberto |
| Q7-04 | CTX-001 e o diagrama de casos de uso oficial seguem sem o Serviço Externo de E-mail (CQ-COM-02); o desenho oficial é do Integrante 3 | Integrante 3 | Aberto |
| Q7-05 | DER-001 tem relações propostas (A18–A21) fora do diagrama de classes oficial; o Integrante 3 precisa aceitá-las ou o Integrante 4 as retira | Integrantes 3 e 4 | Aberto |
| Q7-06 | A "Revisão v2.0" nas análises das Fases 4 a 6 do Integrante 4 ainda não foi conferida contra DEC-013 a DEC-030 | Integrante 5 | Aberto |

## 4. Situação ao final da Fase 7

Persistência e arquitetura **entregues e coerentes com as decisões de 28/10/2026**. Pendências que seguram o fechamento: exportações em PDF (Q7-01), teste do DDL (Q7-02), tabelas de correspondência da 42010 (Q7-03) e a propagação aos desenhos oficiais do Integrante 3 (Q7-04, Q7-05). O gate de qualidade da Fase 7 fica **aberto** até Q7-01 a Q7-05 terem resposta.
