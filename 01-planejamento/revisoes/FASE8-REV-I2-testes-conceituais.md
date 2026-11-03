# Fase 8 — Testes conceituais de casos de uso e comportamento (Integrante 2)

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais (Aquiles Angelo).
**Data:** 29/10/2026 · **Versão:** v1.0 (proposta para o grupo).
**Tarefa do plano atendida:** Fase 8, bloco do Integrante 2 (`01-planejamento/etapas-e-responsabilidades.md` §3): **testes conceituais de casos de uso e comportamento**, na convenção da **DEC-026** (aprovada em 28/10/2026).
**Natureza:** **PROPOSTA.** Os testes são **conceituais** (derivados de casos de uso, critérios de aceite e diagramas), não automatizados. A homologação na matriz mestra é do Integrante 5.

**Convenção aplicada (DEC-026):** o número do teste é o número do requisito — `CT-0RF`, como `UC-0RF`. Cada teste abre com **RF**, **caso de uso**, **critério de aceite**, **regras**, **evidência nos diagramas** e **cenários numerados**.

> **Relação com a matriz da Fase 5:** ela já registra `CT-001` a `CT-032` em uma linha cada (`06-rastreabilidade/matriz-rastreabilidade-fase5.md` §6). Este documento **não os reescreve**: detalha os testes dos casos de uso e do comportamento do Integrante 2 (CT-001, CT-002, CT-021, CT-024 a CT-028, CT-030, CT-032) e **cria a lacuna LAC-11** — **CT-033 a CT-037** — que a Fase 5 não tinha. Nenhum teste novo é criado para requisito que já tenha `CT` homologado.

---

## 0. Escopo e método

| Item | Conteúdo |
|---|---|
| **Casos de uso cobertos** | UC-001, UC-021, UC-024, UC-025, UC-027, UC-028, UC-030, UC-032, UC-033, UC-034, UC-035, UC-036, UC-037 |
| **Diagramas usados como evidência** | SEQ-001 a SEQ-004, ATV-001, COM-001, EST-001 (todos em `03-uml/`, v2.0/v2.1) |
| **Critérios** | CA-RF-001, 002, 021, 024 a 028, 030, 032 a 037 (`02-requisitos/criterios-aceite.md`) |
| **Regras** | RN-001 a RN-022 (DEC-016/017, DEC-011/028, DEC-009/029, DEC-025, DEC-027, DEC-030) |
| **Unidade de teste** | um **cenário** = um par Dado/Quando/Então verificável por inspeção do artefato (diagrama + texto do caso de uso + matriz) |
| **Resultado** | **15 testes**, **68 cenários**; nenhum cenário depende de decisão aberta |

**Como ler "evidência":** `SEQ-002 #5` é a mensagem 5 da tabela §2.2 da matriz da Fase 6; `EST T0` é a transição de criação; `ATV d3` é a decisão 3 do diagrama de atividades; `COM #10` é a mensagem 10 do diagrama de comunicação.

---

## 1. Identidade e acesso

### CT-001 — RF-001 · UC-001 — Autenticar usuário

**Critério de aceite:** CA-RF-001 · **Regras:** RN-001, RN-002, RNF-001, RNF-002 · **Evidência:** SEQ-001; COM-001; ATV-001 (`Autenticar`)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado usuário ativo e senha correta, quando autenticar, então a sessão é criada com as permissões do perfil | `podeAutenticar` = true e `confereCredencial` = true; sessão criada; `LOGIN_CONCEDIDO` auditado | SEQ-001 #1–#8; ATV-001 |
| C2 | Dado senha incorreta, quando autenticar, então o acesso é negado e a tentativa é auditada | `LOGIN_NEGADO` auditado; nenhuma sessão criada; mensagem genérica (não revela qual campo errou) | SEQ-001 (`alt` de credencial inválida) |
| C3 | Dado usuário **bloqueado** com senha correta, quando autenticar, então o acesso é negado | `podeAutenticar` = false (RN-001); `LOGIN_NEGADO` auditado | SEQ-001 #4–#7; EST de usuário |
| C4 | Dado usuário autenticado, quando encerrar a sessão, então o acesso corrente deixa de valer | `invalidarSessaoAtiva` (AP-01); novo acesso exige login | SEQ-001 (`opt` RF-002) |
| C5 | Dado qualquer tentativa, então nenhuma senha aparece em claro na auditoria ou na mensagem | `credencialProtegida` apenas; CA-RF-032 e CQ-SEG-01 | SEQ-001; matriz da Fase 6 §4 |

### CT-002 — RF-002 · UC-001 (A1) — Encerrar sessão

**Critério de aceite:** CA-RF-002 · **Regras:** RNF-002 · **Evidência:** SEQ-001 (`opt`), COM-001

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado usuário autenticado, quando encerrar a sessão, então a sessão é invalidada | `invalidarSessaoAtiva` executada; operação auditada | SEQ-001 |
| C2 | Dado sessão encerrada, quando tentar reutilizá-la, então o acesso é recusado | nova autenticação exigida | SEQ-001; RNF-002 |

---

## 2. Agenda e agendamento

### CT-021 — RF-021 · UC-021 — Vincular paciente a psicólogo

**Critério de aceite:** CA-RF-021 · **Regras:** RN-003, RN-007 · **Evidência:** matriz da Fase 5; SEQ-002 #2 (`estaAtivo`, OP-22)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado vínculo já ativo entre psicólogo e paciente, quando formalizar de novo, então o vínculo duplicado é recusado | nenhum segundo vínculo; operação recusada | OP-21; CA-RF-021 |
| C2 | Dado vínculo encerrado, quando o psicólogo consultar o paciente, então o acesso é negado | `estaAtivo` = false (OP-22); consulta recusada (RNF-006) | SEQ-002 #2; matriz §2.2 |

### CT-024 — RF-024 · UC-024 — Consultar horários disponíveis

**Critério de aceite:** CA-RF-024 · **Regras:** RN-010, RN-005 · **Evidência:** SEQ-002 #1; ATV-001 (`Consultar horários`); COM-001 #1–#2

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado paciente vinculado, quando consultar horários, então recebe os slots livres e **nada é reservado** | `consultarHorariosDisponiveis` (OP-11) somente leitura; nenhum agendamento criado | SEQ-002 #1; CA-RF-024 |
| C2 | Dado slot já ocupado por agendamento `CONFIRMADO`, quando consultar, então o slot não aparece | filtro pela situação ativa | OP-11; RN-010 |
| C3 | Dado slot **reservado por oferta de vaga aberta**, quando consultar, então o slot não aparece como livre | reserva vale até o prazo (DEC-027; R7-07) | SEQ-004 (`abrirOferta`); CA-RF-024 |
| C4 | Dado psicólogo **sem vínculo** com o paciente, quando consultar, então o acesso é recusado | `estaAtivo` = false | RNF-006; CT-021 C2 |

### CT-025 — RF-025 · UC-025 — Solicitar agendamento

**Critério de aceite:** CA-RF-025 · **Regras:** RN-005, RN-010, RN-013 · **Evidência:** SEQ-002; ATV-001 (`Criar agendamento`); COM-001 #3–#10; EST T0

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado paciente vinculado e slot livre, quando solicitar, então o agendamento é criado **`CONFIRMADO`** e ocupa o horário | `Agendamento.solicitar` cria e confirma no mesmo ato; `CONFIRMADO` auditado; e-mail de confirmação solicitado | SEQ-002 #5–#8; EST T0; CA-RF-025 |
| C2 | Dado slot já tomado entre a consulta e a reserva, quando solicitar, então **nada** é criado e o paciente recebe "horário indisponível" | `alt` de conflito: nenhum agendamento, nenhuma ocupação; mensagem de negócio (não erro técnico) | SEQ-002 (`E1`); CA-RF-025 |
| C3 | Dado paciente **sem vínculo ativo**, quando solicitar, então a solicitação é recusada | `estaAtivo` = false (OP-22); RN-003 | SEQ-002 #3–#4 |
| C4 | Dado que o envio do e-mail falhe, quando a solicitação concluir, então o agendamento **continua válido**, a falha é auditada e o envio pode ser repetido | `registrar("FALHA_ENVIO_EMAIL")`; `CONFIRMADO` mantido (DEC-029) | SEQ-002 (`alt` "Falha de envio") |
| C5 | Dado que não exista horário disponível, quando solicitar, então o sistema oferece a **lista de espera** | fluxo A1 encaminha para UC-034 (RF-034) | SEQ-002 #10; ATV-001 |

### CT-026 — RF-026 · UC-025 / UC-036 — Confirmação automática

**Critério de aceite:** CA-RF-026 · **Regras:** RN-013, DEC-017 · **Evidência:** SEQ-002; SEQ-004 #18–#19; EST T0

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado solicitação válida, quando o sistema processar, então o agendamento nasce `CONFIRMADO` **sem ação manual** de outro ator | `Agendamento.solicitar` devolve `CONFIRMADO`; nenhuma mensagem `confirmar` | SEQ-002 #5; EST T0 |
| C2 | Dado aceite de oferta de vaga válido, quando o paciente aceitar, então o agendamento é criado `CONFIRMADO` | `validarPrazo` + `agendar` | SEQ-004 #17–#19 |
| C3 | Dado qualquer criação, então **não existe** situação `SOLICITADO` registrada antes de `CONFIRMADO` | enum com 4 valores (DEC-016) | EST-001; CA-RF-026 |
| C4 | Dado agendamento criado, então o e-mail de confirmação é **solicitado** | `notificar` sempre (RF-033) | SEQ-002 #8; CT-033 |

### CT-027 — RF-027 · UC-027 — Cancelar agendamento

**Critério de aceite:** CA-RF-027 · **Regras:** RN-006, RN-012, DEC-011, DEC-028 · **Evidência:** SEQ-003; EST T1; ATV-001 (d4); COM-001 #11–#17

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado agendamento `CONFIRMADO` **antes do horário marcado**, quando o paciente titular cancelar, então passa a `CANCELADO`, o horário é liberado, audita e o e-mail é solicitado | `podeSerCancelado` = true; `cancelar`; `AGENDAMENTO_CANCELADO`; `notificar` | SEQ-003 #1–#5; EST T1 |
| C2 | Dado agendamento `CONFIRMADO` antes do horário, quando o **psicólogo responsável** cancelar, então o cancelamento é aceito | mesma guarda e mesmo efeito | SEQ-003; CA-RF-027 |
| C3 | Dado horário marcado **já começou**, quando qualquer ator cancelar, então o cancelamento é recusado | `podeSerCancelado` = false | SEQ-003 (`alt`); EST T1 |
| C4 | Dado usuário que **não** é o titular nem o psicólogo, quando cancelar, então é recusado | autorização por vínculo/titularidade | SEQ-003; RNF-002 |
| C5 | Dado **Administrador**, quando cancelar, então é recusado; **não há antecedência mínima** | guarda só "antes do horário marcado" (DEC-028) | SEQ-003; CA-RF-027 |
| C6 | Dado cancelamento concluído **e fila com paciente**, então a vaga é ofertada (`<<extend>>` UC-035) | `ofertarVaga` (AP-06) | SEQ-003 #7; SEQ-004 |
| C7 | Dado que o e-mail de cancelamento falhe, então o cancelamento **não é desfeito** e a falha é auditada | `FALHA_ENVIO_EMAIL`; `CANCELADO` mantido | SEQ-003 #6 |
| C8 | Dado agendamento `CANCELADO`, quando tentar registrá-lo como atendimento, então o registro é recusado | `estaCancelada` (OP-16) | SEQ-003; RN-006 |

### CT-028 — RF-028 · UC-028 — Consultar os próprios agendamentos

**Critério de aceite:** CA-RF-028 · **Regras:** RN-004, RNF-005 · **Evidência:** SEQ-003 #1; matriz da Fase 6

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado paciente autenticado, quando consultar seus agendamentos, então vê **somente** os do próprio cadastro, com a situação de cada um | `consultarMeus` (OP-19) filtra pelo titular; `CONFIRMADO`/`CANCELADO`/`REALIZADO`/`NAO_COMPARECEU` | SEQ-003 #1; CA-RF-028 |
| C2 | Dado agendamento de outro paciente, quando consultar, então ele não aparece | filtro por titular (RNF-005) | OP-19 |

---

## 3. Atendimento e auditoria

### CT-030 — RF-030 · UC-030 — Registrar atendimento

**Critério de aceite:** CA-RF-030 · **Regras:** RN-006, RN-007, DEC-030 · **Evidência:** SEQ-003 (`opt`); EST T2; ATV-001 (`Registrar atendimento`)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado agendamento `CONFIRMADO` e psicólogo com vínculo, quando registrar o atendimento, então o agendamento passa a `REALIZADO` e o `Atendimento` é criado | `concluir` (OP-17) + `Atendimento.registrar` (OP-20); auditoria; e-mail | SEQ-003 #8–#12; EST T2 |
| C2 | Dado agendamento `CANCELADO` ou `REALIZADO`, quando registrar, então é recusado | `estaCancelada` / situação não confirmada | SEQ-003; RN-006 |
| C3 | Dado registro criado, então ele **não** representa prontuário clínico completo | só psicólogo, paciente, data e contexto de sessão | OP-20; CA-RF-030 |

### CT-032 — RF-032 · UC-032 (`<<include>>`) — Auditoria

**Critério de aceite:** CA-RF-032 · **Regras:** RN-009, RN-014, RNF-004 · **Evidência:** SEQ-001/002/003/004 (mensagens de auditoria); ATV-001 (4 blocos); COM-001 #8–#9

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado qualquer operação auditável, quando concluir, então há registro com **responsável, data, hora e operação** em trilha cronológica | `RegistroAuditoria.registrar` (AP-02) | SEQ-001 #7; SEQ-002 #6; SEQ-003 #4; SEQ-004 #3 |
| C2 | Dado tentativa **negada**, então o evento também é registrado | `LOGIN_NEGADO`, `AGENDAMENTO_NAO_COMPARECEU` etc. | SEQ-001; SEQ-003 |
| C3 | Dado falha de envio de e-mail, então há registro `FALHA_ENVIO_EMAIL` | evento criado na Fase 6 (DEC-029) | SEQ-002 #9; SEQ-003 #6; SEQ-004 #14/#20 |
| C4 | Dado saída da fila, então há registro `ESPERA_ENCERRADA` | `encerrar(DESISTIU)` + auditoria | SEQ-004 #9 |
| C5 | Dado qualquer registro, então não há senha em texto puro nem dado clínico | CQ-SEG-01; CA-RF-033 | matriz da Fase 6 §4 |

---

## 4. Notificação e lista de espera (lacuna LAC-11)

### CT-033 — RF-033 · UC-033 — Notificar por e-mail

**Critério de aceite:** CA-RF-033 · **Regras:** DEC-009, DEC-022, DEC-029 · **Evidência:** SEQ-002 #8–#9; SEQ-003 #5–#6; SEQ-004 #13–#14 e #19–#20

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado confirmação, cancelamento **ou** oferta de vaga, quando a operação concluir, então o envio é **solicitado** ao Serviço Externo de E-mail para os envolvidos | `notificar` sempre (AP-04); três eventos cobertos | SEQ-002/003/004 |
| C2 | Dado que o serviço externo esteja indisponível, quando a operação concluir, então **a operação não é desfeita** e a falha é registrada | `registrar("FALHA_ENVIO_EMAIL")`; estado mantido | SEQ-002 #9; SEQ-003 #6; SEQ-004 #14 |
| C3 | Dado falha registrada, quando o envio for repetido, então a repetição é possível sem refazer a operação de agenda | retorno `falha de envio` é tratado como evento repetível (DEC-029) | SEQ-002/003/004 (nota do `alt`) |
| C4 | Dado qualquer mensagem, então o conteúdo não inclui senha nem informação clínica | só evento, data/hora e identificação mínima | CA-RF-033; CQ-SEG-01 |
| C5 | Dado o envio, então **não existe** classe de domínio nem tabela de notificação | fronteira `ServicoEnvioMensagem` (DEC-022) | 03-uml/Classes; §2 da FASE7-REV-I2 |

### CT-034 — RF-034 · UC-034 — Entrar, consultar e sair da lista de espera

**Critério de aceite:** CA-RF-034 · **Regras:** DEC-027, RN-003 · **Evidência:** SEQ-002 (A1); SEQ-004 #1–#9; ATV-001

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado paciente **vinculado** e sem horário, quando entrar na fila, então a solicitação é registrada `AGUARDANDO` com `dataHoraEntrada` e a posição é informada | `registrarEntrada` (OP-23); auditoria `ESPERA_REGISTRADA` | SEQ-004 #1–#4 |
| C2 | Dado paciente **sem vínculo** com o psicólogo, quando entrar na fila, então é recusado | `estaAtivo`; RN-003 | CA-RF-034 |
| C3 | Dado paciente já na fila, quando consultar a posição, então o sistema devolve a posição **pela ordem de entrada** | `posicaoNaFila` (OP-28) | SEQ-004 #5–#6 |
| C4 | Dado paciente na fila, quando solicitar a saída, então a entrada é encerrada como `DESISTIU`, auditada, e deixa de ocupar posição | `encerrar(DESISTIU)` (OP-27) + `ESPERA_ENCERRADA` | SEQ-004 #7–#9 |
| C5 | Dado paciente que desistiu, quando entrar de novo, então é permitido (sem punição) | nova `SolicitacaoEspera` `AGUARDANDO` | DEC-027; CA-RF-034 |
| C6 | Dado paciente já ativo na fila, quando tentar entrar de novo, então não há duplicata — recebe a posição atual | fluxo A1 de UC-034 | UC-034 §A1 |

### CT-035 — RF-035 · UC-035 — Ofertar horário liberado

**Critério de aceite:** CA-RF-035 · **Regras:** DEC-027 · **Evidência:** SEQ-003 #7; SEQ-004 #10–#15; ATV-001

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado cancelamento que libera horário futuro **e** fila com paciente elegível, quando o horário for liberado, então a oferta é registrada ao **primeiro** da fila e o e-mail de oferta é solicitado | `proximoDaFila` (OP-24) + `abrirOferta` (OP-25) + `notificar` | SEQ-004 #10–#13 |
| C2 | Dado vários pacientes na fila, quando ofertar, então **um por vez**, na ordem de entrada | `proximoDaFila` só por `dataHoraEntrada` | SEQ-004; CA-RF-035 |
| C3 | Dado oferta aberta, quando outro paciente consultar horários, então o horário **não aparece livre** (reservado até o prazo) | reserva na oferta (R7-07) | SEQ-004 #12; CT-024 C3 |
| C4 | Dado o cancelamento feito **pelo psicólogo**, quando liberar o horário, então a oferta é disparada do mesmo modo | mesmo `ofertarVaga` | SEQ-003 #7 |
| C5 | Dado apenas a oferta, então **nenhum agendamento confirmado** é criado | `OFERTADA` ≠ `CONFIRMADO` | SEQ-004; CA-RF-035 |
| C6 | Dado que o e-mail de oferta falhe, então a oferta continua aberta e a falha é auditada | `FALHA_ENVIO_EMAIL` | SEQ-004 #14 |

### CT-036 — RF-036 · UC-036 — Responder à oferta

**Critério de aceite:** CA-RF-036 · **Regras:** DEC-027, RN-005 · **Evidência:** SEQ-004 #16–#24; EST T0

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado oferta válida com horário ainda livre, quando aceitar dentro do prazo, então o agendamento é criado `CONFIRMADO` e a solicitação é encerrada `ACEITA` | `validarPrazo` (OP-26) + `agendar` + `encerrar(ACEITA)` (OP-27) | SEQ-004 #16–#21 |
| C2 | Dado oferta válida com horário já ocupado, quando aceitar, então **nenhum** agendamento é criado | conflito tratado como em CT-025 C2 | SEQ-004; CA-RF-036 |
| C3 | Dado oferta válida, quando recusar, então a recusa é registrada e a oferta passa ao **próximo** | `encerrar(RECUSADA)` + `ofertarVaga` recursivo | SEQ-004 #21–#24 |
| C4 | Dado oferta **sem resposta** até o prazo, quando o prazo vencer, então a oferta **expira** e passa ao próximo | `expirarOferta` → `encerrar(EXPIRADA)` | SEQ-004 #22–#24 |
| C5 | Dado recusa/vencimento **sem próximo na fila**, então o horário volta a ficar livre | nota de retorno ao catálogo (DEC-027) | SEQ-004; CA-RF-036 |
| C6 | Dado aceite, então o e-mail de confirmação é solicitado; se falhar, o agendamento permanece | `FALHA_ENVIO_EMAIL` | SEQ-004 #19–#20 |

### CT-037 — RF-037 · UC-037 — Registrar não comparecimento

**Critério de aceite:** CA-RF-037 · **Regras:** DEC-025, RN-020 · **Evidência:** SEQ-003 (`opt`); EST T3; ATV-001 (`Registrar falta`)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | Dado agendamento `CONFIRMADO` cujo horário **já passou**, quando o psicólogo responsável registrar, então passa a `NAO_COMPARECEU` e a operação é auditada | `registrarFalta` (OP-18); `AGENDAMENTO_NAO_COMPARECEU` | SEQ-003; EST T3 |
| C2 | Dado agendamento `CANCELADO` ou `REALIZADO`, quando registrar, então é recusado | guarda de situação | SEQ-003; EST T3 |
| C3 | Dado horário ainda **não** passou, quando registrar, então é recusado | guarda temporal | SEQ-003; CA-RF-037 |
| C4 | Dado usuário que não é o psicólogo responsável, quando registrar, então é recusado | autorização | SEQ-003; RNF-002 |
| C5 | Dado registro concluído, então o horário é liberado e o não comparecimento não gera atendimento | sem `Atendimento`; liberação do slot | OP-18; EST T3 |

---

## 5. Cobertura dos diagramas comportamentais

Cada teste acima é ancorado em um elemento dos sete diagramas. A tabela mostra **onde** o cenário aparece — é a prova de que os testes não são genéricos.

| Teste | SEQ | ATV-001 | COM-001 | EST-001 |
|---|---|---|---|---|
| CT-001 | SEQ-001 | Autenticar | #5–#9 | — |
| CT-002 | SEQ-001 (`opt`) | — | #10 | — |
| CT-021 | SEQ-002 | — | — | — |
| CT-024 | SEQ-002 #1 | Consultar horários | #1–#2 | — |
| CT-025 | SEQ-002 | Criar agendamento | #3–#10 | T0 |
| CT-026 | SEQ-002; SEQ-004 | Criar agendamento | #10 | T0 |
| CT-027 | SEQ-003; SEQ-004 | d4; Ofertar vaga | #11–#17 | T1 |
| CT-028 | SEQ-003 #1 | — | — | — |
| CT-030 | SEQ-003 (`opt`) | Registrar atendimento | — | T2 |
| CT-032 | SEQ-001/002/003/004 | 4 blocos de auditoria | #8–#9 | — |
| CT-033 | SEQ-002/003/004 | 2 nós de e-mail | #10, #12, #15 | — |
| CT-034 | SEQ-004 #1–#9 | Lista de espera | — | — |
| CT-035 | SEQ-004 #10–#15; SEQ-003 #7 | Ofertar vaga | — | — |
| CT-036 | SEQ-004 #16–#24 | Ofertar vaga | — | T0 |
| CT-037 | SEQ-003 (`opt`) | Registrar falta | — | T3 |

**Transições do EST-001 cobertas:** T0 por CT-025/CT-026/CT-036; T1 por CT-027; T2 por CT-030; T3 por CT-037 — **4 de 4**. Nenhum estado fica sem teste.

---

## 6. Cenários transversais (exceção e concorrência)

| ID | Cenário | Testes que o exercitam | Resultado esperado |
|---|---|---|---|
| **X1** | Falha do Serviço Externo de E-mail nos três eventos | CT-025 C4, CT-027 C7, CT-033 C2/C3, CT-035 C6, CT-036 C6 | operação mantida; `FALHA_ENVIO_EMAIL`; repetição possível (DEC-029) |
| **X2** | Duas solicitações concorrentes para o mesmo slot | CT-025 C2, CT-036 C2 | apenas uma reserva; a outra recebe "horário indisponível" (RN-005) |
| **X3** | Oferta aberta disputada por dois pacientes | CT-024 C3, CT-035 C2/C3, CT-036 C1 | uma oferta por vez; slot reservado; aceite único (DEC-027) |
| **X4** | Cancelamento no limite do horário | CT-027 C1/C3 | aceito antes do início; recusado a partir do início (DEC-011/028) |
| **X5** | Consulta de paciente por profissional sem vínculo | CT-021 C2, CT-024 C4, CT-028 C2 | negada (RNF-006) |
| **X6** | Operação negada | CT-001 C2/C3, CT-027 C5, CT-032 C2 | auditada mesmo quando recusada (TRS-05) |

---

## 7. O que fica para o Integrante 5 (homologação)

| Item | Situação |
|---|---|
| `CT-001`, `CT-002`, `CT-021`, `CT-024`…`CT-028`, `CT-030`, `CT-032` | já constam da matriz mestra (`matriz-rastreabilidade-fase5.md` §6) em uma linha; este documento **detalha os cenários** e não altera a numeração |
| **`CT-033` a `CT-037`** | **novos** (LAC-11); precisam ser homologados na matriz mestra e marcados como cobertos em RF-033 a RF-037 |
| `CT-038` em diante | **não existem** — nenhum RF-038 ou superior; não há órfão de teste |
| Tabela de achados Q6 | a coluna "Situação" de Q6-01…Q6-07 precisa passar de **Aberto** para **Corrigido** (a Fase 6 já corrigiu os artefatos; a tabela é do I5) |
| Matriz final (Fase 8, I1) | deve incorporar as colunas `UC` e `CT` com os 15 testes deste documento |

---

## 8. Rastreabilidade deste documento

| Seção | Origem |
|---|---|
| Convenção `CT-0RF` | DEC-026 (aprovada em 28/10/2026) |
| §1–§4 | CA-RF-001…CA-RF-037; RF-001…RF-037; RN-001…RN-022; UC-001, 021, 024–028, 030, 032–037 |
| §5 | SEQ-001 a SEQ-004, ATV-001, COM-001 e EST-001 (v2.0/v2.1); matriz da Fase 6 §2.1–2.4 |
| §6 | TRS-01…TRS-06 e DEP-01/DEP-04; DEC-011/028, DEC-016/017, DEC-027, DEC-029 |
| §7 | LAC-11 (FASE6-REV-I2 §7.2); matriz da Fase 5 §6 e §7 |

**Registro de participação:** Integrante 2 (Aquiles Angelo) — 15 testes conceituais, **68 cenários**, 6 cenários transversais e tabela de cobertura dos sete diagramas comportamentais.
