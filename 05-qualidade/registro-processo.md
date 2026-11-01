# Registro de Processo e Evidências (base da autoavaliação)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Versão:** v0.7 — registro das Fases 1 a 7, atualizado em 30/10/2026 a partir do histórico do repositório (86 commits)
**Fecha em:** Fase 8, como autoavaliação simplificada (seção 30 do dossiê)
**Referências:** ISO/IEC/IEEE 12207:2026 (processos do ciclo de vida); família ISO/IEC 330xx (avaliação de processo baseada em evidência, escala de atendimento N-P-L-F); barema §14.

> **Natureza:** registro de evidências, não nota final. A escala usada é a da ISO/IEC 33020 — **N** (não atendido, 0–15%), **P** (parcialmente, >15–50%), **L** (largamente, >50–85%), **F** (plenamente, >85–100%) — aplicada de forma simplificada e por julgamento do Integrante 5, a partir de evidências verificáveis (commits e arquivos). A avaliação final da Fase 8 deve ser revisada por pelo menos mais um integrante.

---

## 1. Evidências por fase (histórico do repositório)

| Fase | Período planejado | Evidências versionadas (commit) | Integrantes com evidência |
|---|---|---|---|
| 1 — Organização inicial | 01/09–14/09 | `a397cbe`, `3ba0d6e`, `a14b63c` (estrutura, planejamento, cronograma); `e7dc507`/`ee5be67` (nomes no README); `e296ff2`…`03c97cb` (atores e processos críticos) | 1, 2 |
| 2 — Visão, escopo e contexto | (até 14/09) | `09701bb`, `9450875`, `cfc7009`, `4274f10` (visão, escopo, stakeholders, glossário, decisões); `e127b78`…`5871f02` (contexto e interações) | 1, 2 |
| 3 — Requisitos | 15/09–28/09 | `454c9f4` (RF/RNF/RN/CA/HU/matriz); `1fca409`/`bbb003a` (revisão dos UC futuros); `e9a2874` (análise inicial e impacto, I4); `5bee1fa` (modelagem OO inicial, I3) | 1, 2, 3, 4 |
| 4 — Casos de uso | 29/09–05/10 | `79c128f`…`6a76b21` (especificações e diagrama UC-001); `8894961` (revisão de dados por caso de uso, I4) | 2, 4 |
| 5 — Modelo OO | 06/10–19/10 | `3892e37` (merge do modelo do I3); `904ce17`…`f63553c` (revisão, CLS-001 v2, OBJ-002, matriz, seções do dossiê, I2); `8894961` (viabilidade de persistência, I4) | 2, 3, 4 |
| 6 — Comportamento | 20/10–02/11 | `b6f1560`, `0ac21c1`, `2dda1a8` (seis diagramas, revisão, matriz, seções 21–24, I2); `8894961` (impacto comportamental, I4); `e0e3248`, `0fb9fb6` (formalização das decisões, I1) | 1, 2, 4 |
| 7 — Arquitetura e persistência | 09/11–13/11 (adiantada) | `4b3cf3e` (pacotes, componentes, implantação, DER, modelo relacional, dicionário, mapeamento, normalização e DDL, I4, 29/10); `febe8ea` (coerência arquitetura × casos de uso e fechamento de P1 a P6, I2) | 2, 4 |
| 8 — Testes conceituais | 14/11–18/11 (adiantada) | `4518250` (testes CT-0RF de casos de uso e comportamento, I2, 29/10) | 2 |
| 1 a 7 — Qualidade, normas, processo, integração e repositório | — | Registradas em 28/10/2026 como **recuperação** (`05-qualidade/`, `07-dossie/`, `08-pitch/`, README) | 5, 6 |

## 2. Quadro de processo (formato exigido pelo barema §14)

`Processo → Objetivo → Atividades → Produto de trabalho → Evidência → Situação → Melhoria proposta`

| Processo (ISO/IEC/IEEE 12207) | Objetivo | Atividades realizadas | Produto de trabalho | Evidência | Situação (N/P/L/F) | Melhoria proposta |
|---|---|---|---|---|---|---|
| Planejamento do projeto | Distribuir responsabilidades e prazos | Divisão em 6 papéis (DEC-004); cronograma por etapa; plano de recuperação em 24/10 | `cronograma.md`, `equipe.md`, `PLANEJAMENTO_AV3` | `3ba0d6e`, `a14b63c` | **L** — papéis claros; `equipe.md` ficou sem nomes até 28/10 e dois integrantes não produziram nas fases previstas | Revisão semanal do cronograma com registro em ata (`01-planejamento/atas/`) |
| Definição de necessidades dos stakeholders | Delimitar problema, escopo e atores | Visão, escopo, stakeholders, glossário, contexto | `02-requisitos/visao.md` e correlatos; CTX-001 | `09701bb`…`4274f10`; `e127b78` | **F** | Propagar decisões posteriores ao contexto (Q2-01) |
| Definição de requisitos | Especificar RF/RNF/RN verificáveis | 37 RF, 24 RNF (RNF-013 a RNF-024 incorporados em 30/10), 17 RN, 37 CA, 16 HU, matriz inicial e matriz final v0.7 | `02-requisitos/` | `454c9f4`, `e0e3248`, `0fb9fb6` | **L** — rastreável; RNF-010 sem métrica e CA sem cenários negativos (Q3-02, Q3-06) | Exigir cenário negativo em todo CA de segurança |
| Definição de arquitetura e de projeto (modelagem) | Modelos UML estruturais e comportamentais coerentes | UC, domínio, classes, objetos, 3 sequências, comunicação, atividades, estados | `03-uml/` | `5bee1fa`, `3892e37`, `79c128f`, `c7f15e0`, `b6f1560` | **L** — exigências formais atendidas; multiplicidades oficiais `PENDENTE` e decisões de 25/10 não propagadas (Q5-01, Q6-01) | Escolher um diagrama de classes oficial e propagar DEC-016 antes da Fase 7 |
| Gestão de configuração | Versionar artefatos e manter histórico | Repositório GitHub, pastas por área, convenção `.mmd` + `.drawio.xml` + `.pdf` | Repositório | 86 commits até 30/10; `e584823` (convenção) | **L** — histórico preservado; commits sem padrão de mensagem nas Fases 1–4; um merge por PR e o restante direto na `master` | Padronizar mensagens (`docs:`, `uml:`, `trace:`) e citar o integrante (I1…I6), como já ocorre desde a Fase 5 |
| Verificação | Conferir consistência entre artefatos | Revisões das Fases 5 e 6 (I2); análises das Fases 4–6 (I4); revisões de qualidade das Fases 2–6 (I5) | `01-planejamento/revisoes/`, `04-persistencia/analises/`, `05-qualidade/analises/` | `904ce17`, `0ac21c1`, `8894961` | **L** — verificação feita; revisão cruzada por segundo integrante só registrada em 28/10 | Definition of Done com revisor nomeado antes do fechamento de cada fase |
| Gestão de decisões | Registrar e propagar decisões | `decisoes.md` com DEC, propostas e pendências PG | `01-planejamento/decisoes.md` | `4274f10`, `e0e3248`, `0fb9fb6` | **L** — decisões formalizadas em 25/10; consenso por mensagem levou dias para ser registrado; propagação aos diagramas pendente | Registrar a decisão no mesmo dia e abrir lista de artefatos afetados (CQ-MAN-04) |
| Gestão de mudanças | Avaliar impacto de cada mudança | Atualização de RF/RN/CA/HU/matriz após decisões; propostas sem renumerar IDs | Requisitos atualizados | `e0e3248`, `0fb9fb6` | **L** — decisões de 25 e 28/10 propagadas aos requisitos (Integrante 1), aos diagramas comportamentais e casos de uso (Integrante 2, 29/10) e à persistência (Integrante 4, 29/10); falta o diagrama de classes oficial (Integrante 3) | Checklist de propagação por decisão (requisitos → UC → classes → estados → sequências → persistência → matriz → dossiê → pitch) |
| Validação | Validar com critérios de aceite | CA para 37 RF; testes conceituais CT para RF-001 a RF-032 nas matrizes | `criterios-aceite.md`, matrizes | `454c9f4`, `4fd8578` | **P** — testes conceituais escritos para 15 dos 37 RF (Integrante 2); os demais ainda a escrever; nenhuma validação em walkthrough registrada em ata (modelo de ata em `07-dossie/processo/`) | Walkthrough por fase com ata e checklist de aprovação |
| Gestão da informação / documentação | Consolidar dossiê e repositório | Seções 18–24 e 27 preparadas (I2); dossiê integrado v0.6 e README em 28/10 (I6) | `07-dossie/`, `README.md` | `5adca44`, `0ac21c1` | **L** — dossiê integrado a partir de 28/10 e regerado por script a cada mudança; faltam o texto final das seções 25, 26 e 33 | Integrar ao dossiê ao fim de cada fase, não só na consolidação |
| Lições aprendidas | Melhorar o próprio processo | Este registro | `05-qualidade/registro-processo.md` | — | **L** — lições registradas ao fim das Fases 6 e 7 | Registrar lições ao fim das Fases 7, 8 e 9 |

## 3. Lições aprendidas até a Fase 6

1. **Consenso por mensagem não é decisão registrada.** As decisões combinadas pelo grupo só chegaram a `decisoes.md` em 25/10; até lá, diagramas da Fase 6 foram desenhados com `SOLICITADO`, que o grupo depois descartou. Custo: retrabalho em pelo menos quatro artefatos.
2. **Propostas paralelas precisam de dono para a escolha.** Existem dois diagramas de classes (oficial e proposta). Sem uma decisão de qual é o oficial, a persistência (Fase 7) não tem base estável.
3. **Revisão cruzada precisa de revisor nomeado.** As revisões das Fases 5 e 6 registraram "revisão cruzada por outro integrante pendente"; ela só foi feita em 28/10.
4. **Integração documental contínua evita acúmulo.** O dossiê integrado começou na Fase 6; as seções das Fases 1 a 4 tiveram de ser montadas de uma vez.

5. **Uma lista de propagação com dono acelera a correção.** Depois de 28/10, a lista P1 a P13 (`etapas-e-responsabilidades.md`) levou o Integrante 2 a fechar P1 a P6 e o Integrante 4 a entregar a Fase 7 em um dia.
6. **O trabalho de um dono bloqueia o seguinte.** Enquanto o diagrama de classes oficial (Integrante 3) não incorpora as decisões, a matriz final, o DER (relações propostas A18–A21) e os testes do domínio ficam em v0.7.
7. **Papel sem participação precisa de plano de cobertura.** Os papéis de qualidade e de documentação/integração (Integrantes 5 e 6) foram executados pelo Integrante 1 a partir de 28/10; o relatório de atuação precisa dizer isso com precisão.

## 4. Autoavaliação consolidada até a Fase 7 (30/10/2026)

Escala ISO/IEC 33020 aplicada de forma simplificada. Resultado por julgamento do Integrante 5 (executado pelo Integrante 1), sobre as evidências da §2; **ainda sem a revisão de um segundo integrante (DOD-Q08)**.

| Situação | Processos |
|---|---|
| **F** (plenamente) | Definição de necessidades dos stakeholders |
| **L** (largamente) | Planejamento do projeto; definição de requisitos; arquitetura e projeto; gestão de configuração; verificação; gestão de decisões; gestão de mudanças; gestão da informação e documentação; lições aprendidas |
| **P** (parcialmente) | Validação (testes conceituais em 15 de 37 RF; sem ata de walkthrough) |
| **N** | nenhum |

Nota final desta versão: **11 processos avaliados, 1 F, 9 L, 1 P**. A melhoria prioritária é a validação: escrever os testes conceituais restantes (Integrantes 3 e 4) e registrar ao menos um walkthrough em ata.

## 5. Pendências para a autoavaliação final (Fase 8)

- Repetir a classificação N/P/L/F com as evidências das Fases 7 e 8.
- Revisão desta autoavaliação por pelo menos mais um integrante (DOD-Q08).
- Incluir as atas de walkthrough, se forem produzidas.
