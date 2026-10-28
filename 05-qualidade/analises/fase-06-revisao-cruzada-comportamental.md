# Fase 6 — Revisão Cruzada de Qualidade dos Diagramas Comportamentais (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 6 — Diagramas comportamentais (sequências, atividades, comunicação e máquina de estados)
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (ver Fase 1, cabeçalho)
**Insumos:** SEQ-001, SEQ-002, SEQ-003, ATV-001, COM-001 e EST-001 (`03-uml/*/proposta-I2-*`) e suas especificações; `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` (R6-01 a R6-08, LAC-01 a LAC-09); `06-rastreabilidade/matriz-rastreabilidade-fase6.md`; `04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md`; `07-dossie/secoes/fase6-secao-21-24.md`; `decisoes.md` (estado de 25/10/2026).
**Referências:** barema §8, §9 (regras 5, 6 e 10), §13 e §19; ISO/IEC 25010:2023 (Confiabilidade, Segurança, Capacidade de interação); ISO/IEC 19505-2 / UML 2.

---

## 1. Objetivo

1. Fazer a revisão cruzada por integrante diferente do autor, registrada como pendente na revisão da Fase 6 do Integrante 2 (§9 e §10).
2. Validar a seção "Revisão de qualidade (cota do Integrante 5)" que o Integrante 2 antecipou em `proposta-I2-especificacao-sequencias.md` §9.
3. Verificar o efeito das decisões de **25/10/2026** (DEC-009, DEC-010, DEC-011, DEC-016, DEC-017, DEC-025), aprovadas **depois** da entrega dos diagramas (22/10/2026).
4. Responder à decisão endereçada ao Integrante 5 na matriz da Fase 6 (§7 "Regras de manutenção desta matriz", item 3): fundir a matriz da Fase 6 na matriz mestra ou mantê-la como apêndice.

## 2. Resultado 1 — Exigências do barema para os diagramas comportamentais

| Exigência | Evidência | Resultado |
|---|---|---|
| Pelo menos três diagramas de sequência para casos críticos (§8) | SEQ-001 (UC-001), SEQ-002 (UC-025 + UC-024), SEQ-003 (UC-027) | **OK** |
| Diagrama de comunicação para cenário escolhido | COM-001 (ciclo do agendamento, 12 colaboradores, 14 mensagens) | **OK** |
| Atividades com decisões, paralelismo e responsabilidades | ATV-001 (4 pistas, 4 decisões, 3 forks/joins) | **OK** |
| Máquina de estados de entidade relevante | EST-001 (`Agendamento`) | **OK** na forma; **não conforme** no conteúdo (§3) |
| Mensagens correspondem a operações conhecidas (§9 regra 5) | 82/82 setas das sequências e 14/14 da comunicação com OP/AP/IR (revisão I2 §8) | **OK** — conferido por amostragem em SEQ-002 e COM-001 |
| Fonte editável e exportação legível (§19) | `.mmd` + `.drawio.xml` + `.pdf` para os seis | **OK** |
| Nenhum dado real (DEC-005) | Rótulos de operação e identificadores | **OK** |

## 3. Resultado 2 — Conformidade com as decisões de 25/10/2026

| Decisão | O que os diagramas mostram (22/10) | Situação | Onde |
|---|---|---|---|
| DEC-016 — `SOLICITADO` não é persistente; o agendamento nasce `Confirmado` | EST-001 tem o estado `SOLICITADO`, a transição inicial `[*] → SOLICITADO` e as transições T2 (`SOLICITADO → CONFIRMADO`) e T3 (`SOLICITADO → CANCELADO`); SEQ-002 retorna `agendamento (SOLICITADO)` e depois chama `confirmar` | **Não conforme** | EST-001, SEQ-002, especificação de estados, seção 24 do dossiê, matriz da Fase 6 §4 |
| DEC-017 — confirmação automática | ATV-001, COM-001 e SEQ-002 confirmam sem ator humano | **Conforme no efeito**; o passo `confirmar` separado deve virar parte da criação (não há estado intermediário) | SEQ-002, ATV-001, COM-001 |
| DEC-011 — cancelamento antes do horário marcado, por paciente ou psicólogo | Guarda `[prazo]` ligada à proposta DEC-012 (2 h, não aprovada) | **Parcial** — a guarda deve ser `[antes do horário marcado]`; prazo adicional fica como pendência `PG-02` | EST-001 T4, SEQ-003, ATV-001 |
| DEC-025 — Psicólogo registra `Não compareceu` após o horário marcado | T6 sem guarda; gatilho tratado como pendente (LAC-06) | **Parcial** — falta guarda `[após o horário marcado]` e o ator Psicólogo | EST-001 T6, SEQ-003 |
| DEC-009 — e-mail para confirmação, cancelamento e oferta | Notificação tratada como fronteira **condicional** ("DEC-009 não decidido") | **Parcial** — passa a ser obrigatória nos três eventos; falha de envio continua pendente (`PG-11`) | SEQ-002, SEQ-003, ATV-001, COM-001, especificação de sequências §7 |
| DEC-010 — lista de espera é a inovação | Nenhum diagrama; LAC-01 registra a SEQ-004 "bloqueada por DEC-010" | **Lacuna crítica** — a inovação está aprovada e não tem representação comportamental | — |

**Leitura de qualidade:** o barema penaliza "diagramas sem relação entre si" (§19). Hoje os requisitos (RF-025, RF-026, RN-020, CA-RF-026) dizem que não há `SOLICITADO`, e a máquina de estados diz que há. Essa divergência é a **não conformidade de maior risco** da Fase 6, porque aparece em quatro artefatos que serão mostrados no dossiê e no pitch.

## 4. Resultado 3 — Confiabilidade, segurança e capacidade de interação

Validação da "cota do Integrante 5" antecipada pelo Integrante 2:

| Afirmação da especificação de sequências §9 | Verificação do Integrante 5 | Resultado |
|---|---|---|
| "Todos os caminhos de erro terminam em recusa explícita ao ator e em registro de auditoria" | Correto para conta bloqueada (SEQ-001 E2) e horário indisponível (SEQ-002 E1). Não se aplica ao cancelamento após o horário: a recusa existe, mas o registro de tentativa recusada não foi decidido (DUV-006, Q3-03) | **Confirmada com ressalva** |
| "Exceções de infraestrutura aparecem como retorno alternativo, sem entidade de exceção" | Correto (`conta inexistente`, `falha de entrega`) | **Confirmada** |
| "A autorização é consultada no serviço (OP-04, OP-22)" | Correto; o ator nunca é presumido autorizado | **Confirmada** |
| "Toda operação auditável tem mensagem correspondente" | Correto para as operações desenhadas; operações da lista de espera e o `registrarFalta` após DEC-025 ainda não existem | **Confirmada com ressalva** |

Complementos do Integrante 5:

| Característica (ISO/IEC 25010:2023) | Evidência nos diagramas | Lacuna |
|---|---|---|
| Confiabilidade — tolerância a falhas | `falha de entrega` do e-mail modelada como retorno | Efeito da falha sobre a operação (`PG-11`) |
| Confiabilidade — integridade sob concorrência | SEQ-002 revalida o horário antes de criar | A reserva atômica do horário depende de DEC-018 (slot discreto, proposta); ver Q3-09 |
| Segurança — responsabilização | Auditoria em todas as transições de estado (RN-009) | — |
| Segurança — autenticidade | SEQ-001 nega conta bloqueada antes de conferir credencial | — |
| Capacidade de interação — prevenção de erro | Nenhum diagrama mostra confirmação explícita antes de cancelar | Ver Q3-08 |

## 5. Resultado 4 — Decisão sobre a matriz da Fase 6

A matriz da Fase 6 (`MT6`) diz que fundi-la na matriz mestra ou mantê-la como apêndice "é decisão do Integrante 5". **Decisão do Integrante 5 (sobre o formato do documento, não sobre conteúdo do grupo):**

1. Até a Fase 7, `matriz-rastreabilidade-fase6.md` continua **documento complementar**, como está.
2. Na Fase 8 (Qualidade e rastreabilidade), será produzida **uma única matriz final** (`06-rastreabilidade/matriz-rastreabilidade-final.md`) com todas as colunas exigidas pelo barema §7 — requisito, caso de uso, classe, interação, persistência, qualidade e teste conceitual —, já com os IDs aprovados. As matrizes das Fases 5 e 6 passam a ser **apêndices históricos** (evidência de processo) e não são apagadas.
3. A matriz final só é fechada depois que DEC-016 for propagada aos diagramas (Q6-01), para não congelar a divergência de estados.

Motivo: uma única matriz é o que o barema pede ("matriz de rastreabilidade não possui elementos órfãos", §21); as matrizes de fase continuam valendo como **evidência de processo** para a autoavaliação (ISO/IEC 330xx).

## 6. Achados

| ID | Achado | Responsável sugerido |
|---|---|---|
| Q6-01 | EST-001 e SEQ-002 mantêm `SOLICITADO`, contrariando DEC-016; corrigir estados, transições (remover T2 e T3; transição inicial `[*] → CONFIRMADO` com guarda `[horário disponível e sem conflito]`), especificações, seção 24 do dossiê e matriz da Fase 6 | Integrante 2 |
| Q6-02 | Guarda `[prazo]` baseada em DEC-012 (não aprovada) → `[antes do horário marcado]`; prazo adicional como nota de pendência `PG-02` | Integrante 2 |
| Q6-03 | T6 (`registrarFalta`) sem guarda e sem ator → `[após o horário marcado]`, ator Psicólogo (DEC-025) | Integrante 2 |
| Q6-04 | Notificação ainda condicional; DEC-009 aprovada para confirmação, cancelamento e oferta | Integrante 2 |
| Q6-05 | Lista de espera (DEC-010) sem diagrama comportamental — produzir ao menos a sequência do fluxo cancelar → ofertar → aceitar/recusar (SEQ-004) e incluir a oferta na ATV-001, marcando como pendentes os parâmetros `PG-04` a `PG-09` | Integrante 2 (+ Integrante 3 para as classes, Q5-05) |
| Q6-06 | Revisão da Fase 6 e matriz da Fase 6 ainda citam DEC-009/DEC-010/DEC-012 como pendentes (LAC-01 a LAC-07) | Integrante 2 |
| Q6-07 | `confirmar` como passo separado de `solicitar` sugere estado intermediário; com DEC-016, recomenda-se uma única operação de criação confirmada (ex.: `Agendamento.criarConfirmado`) ou nota explícita de que `confirmar` ocorre na mesma transação | Integrante 2 + Integrante 3 |

## 6.1 Controle de correção dos achados (gate de qualidade)

O plano de execução pede que o Integrante 5 registre as não conformidades **e confirme a correção**. Situação em 28/10/2026, medida sobre os arquivos do repositório:

| Achado | Situação | Como será confirmado |
|---|---|---|
| Q6-01 | **Aberto** — `SOLICITADO` ainda no EST-001 e na SEQ-002 | `grep SOLICITADO` em `03-uml/` sem ocorrência fora de notas históricas |
| Q6-02 | **Aberto** | Guarda `[antes do horário marcado]` em EST-001, SEQ-003, ATV-001 |
| Q6-03 | **Aberto** | Guarda `[após o horário marcado]` e ator Psicólogo em T6 |
| Q6-04 | **Aberto** | Notificação sem marca de "condicional" nos quatro diagramas |
| Q6-05 | **Aberto** | Existência de SEQ-004 e da oferta na ATV-001 |
| Q6-06 | **Aberto** | Revisão e matriz sem DEC-009/010/012 como pendentes |
| Q6-07 | **Aberto** | `confirmar` integrado à criação ou nota explícita |

Gate: a Fase 6 só será dada como fechada pelo Integrante 5 quando Q6-01 a Q6-05 estiverem corrigidos ou justificados pelo grupo. Esta tabela deve ser atualizada a cada correção, com o commit do responsável.

## 7. Situação ao final da Fase 6

A Fase 6 atende às exigências **formais** do barema (quantidade, tipos de diagrama, fontes editáveis, mensagens com origem). A qualidade de **conteúdo** depende de propagar as decisões de 25/10/2026 (Q6-01 a Q6-04) e de modelar a inovação (Q6-05). Revisão cruzada da Fase 6 **registrada**; aprovação do grupo continua pendente.
