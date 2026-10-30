# Matriz de Rastreabilidade — Fase 6 (diagramas comportamentais)

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.1 (fechamento de LAC-13/14/15 e R6-11/12/13).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.
**Complementa (não altera):** [`matriz-rastreabilidade-fase5.md`](matriz-rastreabilidade-fase5.md) — a matriz da Fase 5 continua sendo a **matriz mestra** do projeto (RF → RN/RNF → UC → Classe → Operação → Sequência → Tabela → CT).

---

## 0. Por que uma matriz nova

O plano §6.1 (Integrante 2) pede que, após a modelagem comportamental, a matriz de rastreabilidade seja **atualizada com sequências, atividade, comunicação e estados**. A matriz da Fase 5 já tinha a coluna "Sequência", mas **não tinha** as colunas de diagrama de atividades, de comunicação e de máquina de estados, e **não rastreava** as mensagens dos diagramas.

Para **não mexer em artefato de fase anterior** (regra da AV3), esta matriz é um **documento novo e complementar**, com identificador próprio (`MT6`), referenciando a matriz da Fase 5 sempre que a coluna é herdada. Quando o grupo aprovar, as duas matrizes podem ser fundidas em uma só, na revisão do dossiê.

**Convenções:**

| Sigla | Significado |
|---|---|
| **SEQ-001…SEQ-004** | Diagramas de sequência (Fase 6). |
| **ATV-001** | Diagrama de atividades (Fase 6). |
| **COM-001** | Diagrama de comunicação (Fase 6). |
| **EST-001** | Máquina de estados do `Agendamento` (Fase 6). |
| **OP-xx** | Operação do modelo de classes: OP-01…OP-22 (Fase 5) e **OP-23…OP-28** (incremento da lista de espera, DEC-027). |
| **AP-xx** | Responsabilidade de aplicação (FASE5-REV-I2 §5.2) — **AP-01…AP-06**. |
| **IR-xx** | Interface de infraestrutura (Fase 7). |
| **INC-xx / TRS-xx / ARQ-xx** | Restrições e decisões da análise de persistência do Integrante 4. |

---

## 1. Matriz principal — requisito → regra → caso de uso → diagrama comportamental

| RF | RN / RNF | UC | Operação / Responsabilidade | SEQ | ATV | COM (msg.) | EST (transição) | Status |
|---|---|---|---|---|---|---|---|---|
| RF-001 Autenticar usuário | RN-001, RN-002, RNF-001, RNF-002 | UC-001 | OP-01 `podeAutenticar`; OP-02 `confereCredencial`; AP-01 | **SEQ-001** | — | — | — | Proposto (Fase 5) |
| RF-002 Encerrar sessão | RNF-002 | UC-001 (A1) | AP-01 `invalidarSessaoAtiva` | **SEQ-001** (`opt`) | — | — | — | Fora do domínio (P-07) |
| RF-003 Cadastrar usuário | RN-002, RNF-001 | UC-003 | OP-03 `cadastrar` | — | — | — | — | Proposto (Fase 5) |
| RF-004 Alterar dados de usuário | RN-002 | UC-003 | `atualizarDadosPermitidos` | — | — | — | — | Coberto |
| RF-005 Ativar usuário | RNF-003 | UC-003 | `ativar` | — | — | — | — | Coberto |
| RF-006 Bloquear usuário | RN-001, RNF-003 | UC-003 | `bloquear` | — | — | — | — | Coberto |
| RF-007 Gerenciar perfis | RNF-002 | UC-003 | `adicionarPermissao`, `removerPermissao` | — | — | — | — | Parcial (PC-10) |
| RF-008 Gerenciar permissões | RNF-002 | UC-003 | — | — | — | — | — | Parcial |
| RF-009 Consultar painel | RNF-004 | UC-003 | AP-05 | — | — | — | — | Fora do domínio |
| RF-010 Consultar usuários | RNF-002 | UC-003 | OP-04 `consultarPermitidos` | — | — | **2** | — | Proposto (Fase 5) |
| RF-011 Consultar psicólogos | RNF-002 | UC-003 | OP-06 `consultarCadastros` | — | — | — | — | Proposto (Fase 5) |
| RF-012 Consultar pacientes | RNF-005 | UC-003 | OP-08 `consultarCadastros` | — | — | — | — | Proposto (Fase 5) |
| RF-013 Consultar auditoria | RN-008, RN-014 | UC-013 | OP-09 `consultar` | — | — | — | — | Proposto (Fase 5) |
| RF-014 Cadastrar psicólogo | RN-002, RNF-002 | UC-003 | OP-05 `cadastrar` | — | — | — | — | Proposto (Fase 5) |
| RF-015 Atualizar perfil profissional | RN-002 | UC-015 | `atualizarDadosProfissionais` | — | — | — | — | Coberto |
| RF-016 Associar área de atuação | RN-002 | UC-015 | `associarAreaAtuacao` | — | — | — | — | Coberto |
| RF-017 Consultar pacientes vinculados | RN-003, RNF-006 | UC-016 | `consultarPacientesVinculados` | — | — | — | — | Coberto |
| RF-018 Cadastrar paciente | RN-005 | UC-003 | OP-07 `cadastrar` | — | — | — | — | Proposto (Fase 5) |
| RF-019 Atualizar cadastro | RN-009 | UC-003 | `atualizarCadastro` | — | — | — | — | Coberto |
| RF-020 Alterar situação do paciente | RN-009 | UC-003 | `alterarSituacao` | — | — | — | — | Parcial (estados §6) |
| RF-021 Vincular paciente a psicólogo | RN-003, RN-007 | UC-021 | `formalizar`; OP-21 `encerrar` | — | — | — | — | Coberto (estado pendente) |
| RF-022 Consultar o próprio cadastro | RN-004, RNF-005 | UC-022 | `consultarCadastroPermitido` | — | — | — | — | Coberto |
| RF-023 Cadastrar disponibilidade | RN-005, RN-011 | UC-015 | OP-10 `cadastrarDisponibilidade` | — | — | — | — | Proposto (Fase 5) |
| **RF-024** Consultar horários disponíveis | RN-010, RNF-010 | UC-024 | OP-11 `consultarHorariosDisponiveis` | **SEQ-002** | **ATV-001** (`Consultar horários`) | **4, 5** | — | Proposto (Fase 5) |
| **RF-025** Solicitar agendamento | RN-005, RN-010, RN-013 | UC-025 / UC-036 (aceite) | `Agendamento.solicitar` (cria **`CONFIRMADO`**) | **SEQ-002**, **SEQ-004** | **ATV-001** (`Criar agendamento (CONFIRMADO)`) | **1, 7** | **T0** (`[*] → CONFIRMADO`) | Coberto |
| **RF-026** Confirmar agendamento automaticamente | RN-013 | UC-025 (efeito) / UC-036 | `Agendamento.solicitar` — a confirmação é **automática e simultânea** | **SEQ-002**, **SEQ-004** | **ATV-001** (`Criar agendamento (CONFIRMADO)`) | **7** | **T0** | Coberto (confirmação automática) |
| **RF-027** Cancelar agendamento | RN-012, DEC-011 + DEC-028 | UC-027 | OP-14 `cancelar`; OP-15 `podeSerCancelado` (guarda `[antes do horário marcado]`) | **SEQ-003**, **SEQ-004** (gatilho) | **ATV-001** (`Cancelar (OP-14)`) | **11** | **T1** (`CONFIRMADO → CANCELADO`) | Coberto |
| **RF-028** Consultar os próprios agendamentos | RN-004 | **UC-028** (novo) | OP-19 `consultarMeus` | **SEQ-003** | — | — | — | Coberto |
| RF-029 Consultar a agenda do psicólogo | RN-011 | UC-029 | OP-12 `consultarCompromissos` | — | — | — | — | Proposto (Fase 5) |
| **RF-030** Registrar conceitualmente um atendimento | RN-020, DEC-030 | UC-016 / UC-027 | OP-20 `registrar`; OP-17 `concluir` | **SEQ-003** (`opt`) | **ATV-001** (`Registrar atendimento`, `Concluir`) | **16, 17** | **T2** (`CONFIRMADO → REALIZADO`) | Coberto |
| RF-031 Consultar histórico de atendimentos | RN-003, RN-007, RNF-006 | UC-016 | `consultarHistoricoPermitido` | — | — | — | — | Coberto |
| **RF-032** Registrar evento de auditoria | RN-009, RN-014, RNF-004 | UC-032 (`<<include>>`) | `RegistroAuditoria.registrar` + AP-02 | **SEQ-001/002/003/004** | **ATV-001** (4 auditorias) | **8, 9** | efeito de T0–T3 | Coberto |
| **RF-033** Enviar notificação por e-mail | RN-022, RNF-004 | **UC-033** (novo) | AP-04 `ServicoEnvioMensagem.notificar` (fronteira externa) | **SEQ-002/003/004** | **ATV-001** (2 nós: confirmação e cancelamento) | **10, 12, 15** | efeito de T1 | Coberto (DEC-009 + DEC-029) |
| **RF-034** Entrar na lista de espera, consultar posição e sair | RN-021, DEC-027 | **UC-034** (novo) | AP-06 `entrarNaFila`/`consultarPosicao`/`sairDaFila`; OP-23 `registrarEntrada`; OP-28 `posicaoNaFila`; OP-27 `encerrar(DESISTIU)` | **SEQ-002** (A1), **SEQ-004** | **ATV-001** (`Sem horários: oferecer lista de espera`) | — | — | Coberto (incremento DEC-027) |
| **RF-035** Ofertar horário liberado à lista de espera | RN-021, DEC-027 | **UC-035** (`<<extend>>` de UC-027) | AP-06 `ofertarVaga`; OP-24 `proximoDaFila`; OP-25 `abrirOferta` | **SEQ-003** (`opt <<extend>>`), **SEQ-004** | **ATV-001** (`Ofertar vaga se houver fila`) | **13, 14, 15** | efeito de T1 | Coberto (incremento DEC-027) |
| **RF-036** Responder à oferta de vaga | RN-021, DEC-027 | **UC-036** (novo) | OP-26 `validarPrazo`; OP-27 `encerrar` (ACEITA/RECUSADA/EXPIRADA) | **SEQ-004** | — | — | — | Coberto (incremento DEC-027) |
| **RF-037** Registrar não comparecimento | RN-020, DEC-025 | **UC-037** (novo) | OP-18 `registrarFalta` | **SEQ-003** (`opt`) | **ATV-001** (`Registrar falta`) | — | **T3** (`CONFIRMADO → NAO_COMPARECEU`) | Coberto |

**Leitura:** **14 dos 37 RFs** (RF-024 a RF-037) têm **cobertura comportamental de Fase 6**; os demais 23 são de **cadastro, consulta e administração** — declaradamente fora do escopo comportamental desta fase (plano §6.1: "casos de uso críticos aprovados"), e todos já estão cobertos pela matriz da Fase 5. Nenhum RF **crítico** ficou sem diagrama.

> **Mudança em relação à v1.0:** entraram RF-033, RF-034, RF-035, RF-036 e RF-037 (seção 8 de `02-requisitos/requisitos-funcionais.md`), RF-028 ganhou o **UC-028** (antes só existia como operação), `SOLICITADO` saiu do EST-001 (T0 substitui T1+T2) e o e-mail deixou de ser "condicional".

---

## 2. Mensagens dos diagramas → operação ou responsabilidade

### 2.1 SEQ-001 — Autenticar (UC-001)

| # | Mensagem | Origem | RN/RF |
|---|---|---|---|
| 1 | `autenticar(email, senha)` | **AP-01** `ServicoAutenticacao` | RF-001, RN-001/002 |
| 2 | `obterPorIdentificacao(identificacao)` | **IR-01** (infraestrutura, Fase 7) | RF-001 |
| 3 | `podeAutenticar()` | **OP-01** | RN-001 |
| 4 | `confereCredencial(senha)` | **OP-02** | RN-002, RNF-001 |
| 5 | `obterPermissoes(idUsuario)` | **IR-02** (infraestrutura, Fase 7) | RF-007/008 |
| 6 | `criarSessao(usuario)` / `invalidarSessaoAtiva()` | **AP-01** | RF-002 |
| 7 | `registrar("LOGIN_CONCEDIDO" / "LOGIN_NEGADO", …)` | **AP-02** + `RegistroAuditoria.registrar` | RF-032, RN-009 |

### 2.2 SEQ-002 — Agendar (UC-025 + UC-024)

| # | Mensagem | Origem | RN/RF |
|---|---|---|---|
| 1 | `consultarHorariosDisponiveis(periodo)` | ator → **AP-03** | RF-024 |
| 2 | `estaAtivo()` | **OP-22** `Vinculo` | RN-003, RN-005 |
| 3 | `consultarHorariosDisponiveis(paciente, periodo)` | **OP-11** `Agenda` | RF-024 |
| 4 | `verificarDisponibilidade(horario)` | `Agenda.verificarDisponibilidade` (modelo do I3) | RN-005, RN-010 |
| 5 | `Agendamento.solicitar(psicologo, paciente, horario, solicitante)` | entidade de domínio — devolve **`CONFIRMADO`** | RF-025, RF-026, RN-013 |
| 6 | `registrar("AGENDAMENTO_CONFIRMADO", …)` | **AP-02** | RF-032, RN-009 |
| 7 | `registrar(responsavel, data, hora, operacao)` | `RegistroAuditoria.registrar` | RF-032 |
| 8 | `notificar(evento=confirmacao)` | **AP-04** (fronteira externa, sempre) | RF-033, DEC-022 |
| 9 | `registrar("FALHA_ENVIO_EMAIL", …)` — `else` do envio | **AP-02** (falha auditada, sem desfazer) | RF-033, DEC-029, LAC-14 |
| 10 | *(A1)* informar ausência e **oferecer lista de espera** | **AP-06** / UC-034 | RF-034 |

> **Não existe** `confirmar(solicitante)` (OP-13) nesta sequência: a criação já produz `CONFIRMADO` (T0 do EST-001).

### 2.3 SEQ-003 — Cancelar / concluir / registrar falta (UC-027 + UC-035)

| # | Mensagem | Origem | RN/RF |
|---|---|---|---|
| 1 | `consultarMeus(solicitante)` | **OP-19** | RF-028, UC-028 |
| 2 | `podeSerCancelado()` | **OP-15** | RN-012, RF-027 |
| 3 | `cancelar(solicitante, motivo)` | **OP-14** | RF-027, RN-012 |
| 4 | `registrar("AGENDAMENTO_CANCELADO", …)` | **AP-02** | RF-032 |
| 5 | `notificar(evento=cancelamento)` | **AP-04** (sempre) | RF-033 |
| 6 | `registrar("FALHA_ENVIO_EMAIL", …)` — `else` do envio | **AP-02** (falha auditada, sem desfazer) | RF-033, DEC-029, LAC-14 |
| 7 | `ofertarVaga(agendamento)` — `opt <<extend>> UC-035` | **AP-06** | RF-035, DEC-027 |
| 8 | `estaCancelada()` | **OP-16** | RN-006 |
| 9 | `concluir(solicitante)` | **OP-17** | RF-030 |
| 10 | `registrar(agendamento, contextoSessao, solicitante)` | **OP-20** `Atendimento` | RF-030, RN-006/007 |
| 11 | `registrarFalta(solicitante)` | **OP-18** | RF-037, DEC-025 |
| 12 | `registrar("AGENDAMENTO_CONCLUIDO" / "AGENDAMENTO_NAO_COMPARECEU", …)` | **AP-02** | RF-032 |

### 2.4 SEQ-004 — Lista de espera e oferta de vaga (UC-034 a UC-036)

| # | Mensagem | Origem | RN/RF |
|---|---|---|---|
| 1 | `entrarNaFila(psicologo, paciente, periodo)` | ator → **AP-06** | RF-034 |
| 2 | `registrarEntrada(...)` | **OP-23** `SolicitacaoEspera` | RF-034, DEC-027 |
| 3 | `registrar("ESPERA_REGISTRADA", …)` | **AP-02** | RF-032 |
| 4 | `registrar(responsavel, data, hora, operacao)` | `RegistroAuditoria.registrar` | RF-032 |
| 5 | `consultarPosicao(psicologo, paciente)` — `opt` | ator → **AP-06** | RF-034, DEC-027 |
| 6 | `posicaoNaFila(psicologo, paciente)` | **OP-28** | RF-034, DEC-027 (LAC-13) |
| 7 | `sairDaFila(solicitacao)` — `opt` | ator → **AP-06** | RF-034, DEC-027 |
| 8 | `encerrar(DESISTIU)` | **OP-27** | RF-034, DEC-027 |
| 9 | `registrar("ESPERA_ENCERRADA", …)` | **AP-02** | RF-032 |
| 10 | `ofertarVaga(horarioLiberado)` — `opt <<extend>> do cancelamento` | **AP-06** | RF-035, DEC-027 |
| 11 | `proximoDaFila(psicologo)` | **OP-24** | RF-035 (ordem de entrada) |
| 12 | `abrirOferta(horario, prazoAceite)` | **OP-25** | RF-035 (oferta única + horário reservado, LAC-15) |
| 13 | `notificar(evento=ofertaVaga)` | **AP-04** (sempre) | RF-033 |
| 14 | `registrar("FALHA_ENVIO_EMAIL", …)` — `else` do envio | **AP-02** (falha auditada, sem desfazer) | RF-033, DEC-029, LAC-14 |
| 15 | `registrar("OFERTA_VAGA_ABERTA", …)` | **AP-02** | RF-032 |
| 16 | `aceitarOferta(solicitacao)` | ator → **AP-06** | RF-036 |
| 17 | `validarPrazo()` | **OP-26** | RF-036, DEC-027 |
| 18 | `agendar(psicologo, paciente, horario)` → `Agendamento.solicitar` | **AP-03** + entidade | RF-025, RF-026 |
| 19 | `notificar(evento=confirmacao)` | **AP-04** (sempre) | RF-033 |
| 20 | `registrar("FALHA_ENVIO_EMAIL", …)` — `else` do envio | **AP-02** | RF-033, DEC-029, LAC-14 |
| 21 | `encerrar(ACEITA / RECUSADA)` | **OP-27** | RF-036 |
| 22 | `expirarOferta(prazoAceite)` → `encerrar(EXPIRADA)` | **OP-27** | RF-036, DEC-027 |
| 23 | `registrar("OFERTA_RECUSADA" / "OFERTA_EXPIRADA", …)` | **AP-02** | RF-032 |
| 24 | `ofertarVaga(...)` recursivo (passa ao próximo) | **AP-06** | RF-035, DEC-027 |

> O aceite **reusa** o caminho normal de agendamento (linha 12): não há criação "especial" de agendamento pela fila. Recusa e vencimento reusam `encerrar` (OP-27) variando a situação final.

### 2.5 COM-001 — Comunicação (14 colaboradores, 17 mensagens)

| # | Mensagem | Origem | Diagrama correspondente |
|---|---|---|---|
| 1 | `solicitar(horario)` | AP-03 | SEQ-002 (1) |
| 2 | `consultarPermitidos()` | **OP-04** | SEQ-001 (autorização por operação) |
| 3 | `estaAtivo()` | **OP-22** | SEQ-002 (2) |
| 4 | `consultarHorarios()` | **OP-11** | SEQ-002 (3) |
| 5 | `slots livres` | A09 (`Agenda`—`Disponibilidade`) | SEQ-002 (3) |
| 6 | `verificarDisponibilidade()` | `Agenda.verificarDisponibilidade` | SEQ-002 (4) |
| 7 | `solicitar(horario)` | `Agendamento.solicitar` (cria `CONFIRMADO`) | SEQ-002 (5), SEQ-004 (12) |
| 8 | `registrar(criacao)` | **AP-02** | SEQ-002 (6) |
| 9 | `registrar(tabela)` | `RegistroAuditoria.registrar` | SEQ-002 (7) |
| 10 | `notificar(confirmacao)` | **AP-04** | SEQ-002 (8) |
| 11 | `cancelar(motivo)` | **OP-14** | SEQ-003 (3) |
| 12 | `notificar(cancelamento)` | **AP-04** | SEQ-003 (5) |
| 13 | `ofertarVaga()` | **AP-06** | SEQ-003 (6), SEQ-004 (5) |
| 14 | `proximoDaFila()` | **OP-24** | SEQ-004 (6) |
| 15 | `notificar(ofertaVaga)` | **AP-04** | SEQ-004 (8) |
| 16 | `concluir(agendamento)` | RF-030 (fluxo do ator) | SEQ-003 (8) |
| 17 | `registrar(atendimento)` | **OP-20** | SEQ-003 (9) |

### 2.6 ATV-001 — Atividades

| Nó do diagrama | Origem | Diagrama correspondente |
|---|---|---|
| Solicitar agendamento | RF-025 (ator) | SEQ-002 (1) |
| Consultar horários (OP-11) | **OP-11** | SEQ-002 (3), COM-001 (4) |
| Validar vínculo e horário | **OP-22** + `Agenda.verificarDisponibilidade` | SEQ-002 (2, 4), COM-001 (3, 6) |
| Criar agendamento (CONFIRMADO) | `Agendamento.solicitar` | SEQ-002 (5), SEQ-004 (12), COM-001 (7), EST T0 |
| Auditar criação (RN-009) | **AP-02** | SEQ-002 (6), COM-001 (8/9) |
| Notificar confirmação (RF-033) | **AP-04** | SEQ-002 (8), COM-001 (10) |
| Sem horários: oferecer lista de espera (A1) | **AP-06** / UC-034 | SEQ-002 (9), SEQ-004 (1) |
| Cancelar (OP-14) | **OP-14** | SEQ-003 (3), COM-001 (11), EST T1 |
| Liberar horário | RN-012/RN-010 (efeito no catálogo) | SEQ-003 (implícito), EST T1 |
| Auditar cancelamento | **AP-02** | SEQ-003 (4) |
| Notificar cancelamento (RF-033) | **AP-04** | SEQ-003 (5), COM-001 (12) |
| Ofertar vaga se houver fila (UC-035) | **AP-06** / OP-24 / OP-25 | SEQ-003 (6), SEQ-004 (5–8), COM-001 (13, 14, 15) |
| Registrar atendimento (OP-20) | **OP-20** | SEQ-003 (9), COM-001 (17) |
| Concluir (OP-17) | **OP-17** | SEQ-003 (8), COM-001 (16), EST T2 |
| Registrar falta (OP-18) | **OP-18** | SEQ-003 (10), EST T3 |
| Auditar falta / conclusão | **AP-02** | SEQ-003 (11) |
| Decisões `d1`, `d2`, `d3`, `d5` | RN-010, RN-005/RN-010, RN-012, RN-006/RN-003 | SEQ-002/003 (fragmentos `alt`) |

### 2.7 EST-001 — Transições

| # | Transição | Evento | Guarda | Operação | Sequência |
|---|---|---|---|---|---|
| **T0** | `[*] → CONFIRMADO` | `solicitar` | vínculo ATIVO e slot livre | `Agendamento.solicitar` | SEQ-002 (5), SEQ-004 (12) |
| **T1** | `CONFIRMADO → CANCELADO` | `cancelar` | **`[antes do horário marcado]`** | **OP-14** / **OP-15** | SEQ-003 (3) |
| **T2** | `CONFIRMADO → REALIZADO` | `concluir` | `[atendimento registrado]` | **OP-17** / **OP-20** | SEQ-003 (8, 9) |
| **T3** | `CONFIRMADO → NAO_COMPARECEU` | `registrarFalta` | `[horário já passou; ação do psicólogo]` | **OP-18** | SEQ-003 (10) |

**Nenhuma mensagem de sequência, nenhuma mensagem de comunicação e nenhuma atividade está sem origem em operação ou responsabilidade.** Este é o critério de elegibilidade adotado no plano §6.1 ("mensagens, retornos, alternativas e exceções coerentes com os fluxos textuais") e na revisão FASE5-REV-I2 §5.2.

---

## 3. Matriz de consistência cruzada (exigida pelo plano §6.1)

Cada linha cruza os quatro diagramas comportamentais e as três fontes textuais (casos de uso, modelo de classes, requisitos).

| Comportamento | Caso de uso | Classe / operação | SEQ | ATV | COM | EST | RF | RN |
|---|---|---|---|---|---|---|---|---|
| Autenticar | UC-001 | `Usuario.podeAutenticar` (OP-01), `confereCredencial` (OP-02) | SEQ-001 | — | — | — | RF-001 | RN-001, RN-002 |
| Encerrar sessão | UC-001 (A1) | AP-01 | SEQ-001 (`opt`) | — | — | — | RF-002 | RNF-002 |
| Consultar horários | UC-024 | `Agenda.consultarHorariosDisponiveis` (OP-11) | SEQ-002 | ATV-001 | COM-001 (4, 5) | — | RF-024 | RN-010 |
| Solicitar agendamento | UC-025 | `Agendamento.solicitar` (cria `CONFIRMADO`) | SEQ-002, SEQ-004 | ATV-001 | COM-001 (1, 7) | EST-001 (T0) | RF-025, RF-026 | RN-005, RN-010, RN-013 |
| Cancelar | UC-027 | `Agendamento.cancelar` (OP-14), `podeSerCancelado` (OP-15) | SEQ-003 | ATV-001 | COM-001 (11) | EST-001 (T1) | RF-027 | RN-012, RN-006 |
| Consultar meus agendamentos | **UC-028** | `Agendamento.consultarMeus` (OP-19) | SEQ-003 | — | — | — | RF-028 | RN-004 |
| Registrar atendimento | UC-016 / UC-027 | `Atendimento.registrar` (OP-20), `Agendamento.concluir` (OP-17) | SEQ-003 (`opt`) | ATV-001 | COM-001 (16, 17) | EST-001 (T2) | RF-030 | RN-006, RN-007 |
| Registrar falta | **UC-037** | `Agendamento.registrarFalta` (OP-18) | SEQ-003 (`opt`) | ATV-001 | — | EST-001 (T3) | RF-037 | RN-006, DEC-025 |
| Notificar | **UC-033** | AP-04 `ServicoEnvioMensagem.notificar` (fronteira externa) | SEQ-002, SEQ-003, SEQ-004 | ATV-001 (2 nós) | COM-001 (10, 12, 15) | efeito de T1 | RF-033 | DEC-022, RNF-004 |
| Entrar, consultar e sair da lista de espera | **UC-034** | AP-06 `entrarNaFila`/`consultarPosicao`/`sairDaFila`, OP-23 `registrarEntrada`, OP-28 `posicaoNaFila`, OP-27 `encerrar(DESISTIU)` | SEQ-002 (A1), SEQ-004 | ATV-001 | — | — | RF-034 | RN-003, DEC-027 |
| Ofertar vaga | **UC-035** (`<<extend>>` de UC-027) | AP-06 `ofertarVaga`, OP-24 `proximoDaFila`, OP-25 `abrirOferta(horario, prazoAceite)` — horário reservado | SEQ-003 (`opt`), SEQ-004 | ATV-001 | COM-001 (13, 14, 15) | efeito de T1 | RF-035 | RN-010, DEC-027 |
| Responder à oferta | **UC-036** | OP-26 `validarPrazo`, OP-27 `encerrar` | SEQ-004 | — | — | — | RF-036 | DEC-027 |
| Auditar | UC-032 (`<<include>>`) | `RegistroAuditoria.registrar` + AP-02 | SEQ-001/002/003/004 | ATV-001 (4 nós) | COM-001 (8, 9) | efeito de T0–T3 | RF-032 | RN-009, RN-014 |
| Autorização | UC-001, UC-016 | `Usuario.consultarPermitidos` (OP-04), `Vinculo.estaAtivo` (OP-22) | SEQ-002 | ATV-001 (`d2`) | COM-001 (2, 3) | guarda de T0 | RF-010, RF-017, RF-021 | RN-003, RN-005 |

**Divergências detectadas: 0.** A verificação detalhada (incluindo o cotejo com a análise de persistência do Integrante 4) está em `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md`.

---

## 4. Verificação de órfãos da Fase 6

| Verificação exigida pelo plano | Resultado | Observação |
|---|---|---|
| RF sem diagrama comportamental | **Sim — 23** | RF-003 a RF-023 (exceto RF-024) e RF-029, RF-031 são de cadastro/consulta/administração: **fora do escopo comportamental** desta fase (plano §6.1 — "casos de uso críticos"). Cobertos pela matriz da Fase 5 e pelos diagramas de classes/objetos. |
| RF crítico sem diagrama comportamental | **Não** | RF-001, RF-002, RF-024 a RF-028, RF-030, RF-032, RF-033, RF-034, RF-035, RF-036 e RF-037 têm pelo menos um diagrama. |
| Caso de uso crítico sem diagrama | **Não** | UC-001 → SEQ-001 · UC-021 → coberto indiretamente por SEQ-002/004 (`estaAtivo`) · UC-024/UC-025 → SEQ-002 + ATV-001 + COM-001 · UC-027 → SEQ-003 + ATV-001 + COM-001 + EST-001 · **UC-028 → SEQ-003** · **UC-033 → SEQ-002/003/004** · **UC-034/UC-035/UC-036 → SEQ-004** · **UC-037 → SEQ-003 + ATV-001 + EST-001**. |
| Mensagem de sequência sem operação/responsabilidade | **Não** | Ver §2.1–2.4 (todas as mensagens remetem a OP/AP/IR). |
| Atividade sem origem | **Não** | Ver §2.6. |
| Mensagem de comunicação sem origem | **Não** | Ver §2.5. |
| Transição de estado sem operação | **Não** | Ver §2.7 (T0–T3). |
| Situação de estado sem atributo persistível | **Não** | `CONFIRMADO`, `REALIZADO`, `CANCELADO`, `NAO_COMPARECEU` = as quatro situações da **DEC-016** e a coluna `agendamento.status` (`IMP-DER-02` do I4). **Pendência R6-09:** o CLS-001 oficial não fixa o enumerado e ainda declara `confirmar()`; o Integrante 3 precisa alinhar. |
| Transição sem caso de uso | **Não** | T0–T3 mapeadas na §3. |
| Diagrama sem requisito | **Não** | Todos os **sete** diagramas declaram RF/RN no cabeçalho do `.mmd` e na especificação correspondente. |
| Diagrama comportamental sem classe | **Não** | Todos os participantes/atividade/colaboradores pertencem a uma classe do CLS-001 v2, ao incremento `SolicitacaoEspera` (DEC-027) ou a uma responsabilidade AP/IR declarada. |
| Sequência sem par pedido/resposta | **Não** | Toda mensagem de solicitação tem o retorno correspondente (`-->>`), com exceção das chamadas internas de auto-mensagem (`ServicoListaEspera → ServicoListaEspera` na reoferta), rotuladas como tal. |

---

## 5. Cobertura por requisito (contagem de artefatos comportamentais)

| # | RF | SEQ | ATV | COM | EST | Total de artefatos |
|---|---|---|---|---|---|---|
| 1 | RF-001 | 1 | 0 | 0 | 0 | 1 |
| 2 | RF-002 | 1 | 0 | 0 | 0 | 1 |
| 24 | RF-024 | 1 | 1 | 1 | 0 | 3 |
| 25 | RF-025 | 2 | 1 | 1 | 1 | 5 |
| 26 | RF-026 | 2 | 1 | 1 | 1 | 5 |
| 27 | RF-027 | 2 | 1 | 1 | 1 | 5 |
| 28 | RF-028 | 1 | 0 | 0 | 0 | 1 |
| 30 | RF-030 | 1 | 1 | 1 | 1 | 4 |
| 32 | RF-032 | 4 | 1 | 1 | 0 | 6 |
| 33 | RF-033 | 3 | 1 | 1 | 0 | 5 |
| 34 | RF-034 | 2 | 1 | 0 | 0 | 3 |
| 35 | RF-035 | 2 | 1 | 1 | 0 | 4 |
| 36 | RF-036 | 1 | 0 | 0 | 0 | 1 |
| 37 | RF-037 | 1 | 1 | 0 | 1 | 3 |

---

## 6. Testes conceituais seccionados (complementam CT-001…CT-032)

A matriz da Fase 5 (§6) define os testes conceituais por RF. A Fase 6 **não cria** testes novos: ela indica **qual artefato comportamental materializa** cada cenário de teste.

| CT | RF | Artefato que evidencia o cenário |
|---|---|---|
| CT-001 | RF-001 | SEQ-001 (`alt` E2 — conta bloqueada) |
| CT-002 | RF-002 | SEQ-001 (`opt` A1) |
| CT-024 | RF-024 | SEQ-002 (`alt` "Há horários disponíveis" / A1), ATV-001 (`d1`), COM-001 (4, 5) |
| CT-025 | RF-025 | SEQ-002, SEQ-004 (aceite), ATV-001 (`d2`, `Criar agendamento (CONFIRMADO)`), COM-001 (1, 7), EST-001 (T0) |
| CT-026 | RF-026 | SEQ-002 (agendamento devolvido `CONFIRMADO`), SEQ-004 (aceite), ATV-001 (`Criar agendamento (CONFIRMADO)`), COM-001 (7), EST-001 (T0) |
| CT-027 | RF-027 | SEQ-003 (`alt` "Pode ser cancelado" / E1), ATV-001 (`d3`), COM-001 (11), EST-001 (T1) |
| CT-028 | RF-028 | SEQ-003 (`consultarMeus`, OP-19) |
| CT-030 | RF-030 | SEQ-003 (`opt` conclusão), ATV-001 (`d5` [Sim]), COM-001 (16, 17), EST-001 (T2) |
| CT-032 | RF-032 | SEQ-001/002/003/004 (mensagens de auditoria), ATV-001 (4 nós de auditoria), COM-001 (8, 9) |
| — | RF-037 | SEQ-003 (`opt` "Não comparecimento"), ATV-001 (`d5` [Não] → `Registrar falta`), EST-001 (T3) |

> **Fase 8 (Integrante 2):** os testes conceituais dos RF-033 a RF-037 foram propostos em `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md` como **CT-033…CT-037** (e-mail obrigatório e falha auditada; entrada/consulta/saída da fila; oferta única com prazo e horário reservado; aceite/recusa/expiração; não comparecimento). A homologação na matriz mestra é do **Integrante 5** (LAC-11).

---

## 7. Regras de manutenção desta matriz

1. Toda mudança em RF, RN, UC, operação, diagrama comportamental ou situação **atualiza esta matriz e a matriz da Fase 5 no mesmo commit** (plano §6.1 e §13).
2. Nenhuma mensagem pode ser adicionada a um diagrama comportamental sem uma linha nesta matriz (§2) — a regra é o mecanismo que impede "mensagem inventada para satisfazer um diagrama futuro".
3. Ao aprovar o grupo as propostas, as colunas `Sequência` da matriz da Fase 5 devem ser completadas com ATV/COM/EST e esta matriz deve ser **fundida** na matriz mestra (ou mantida como apêndice, o que é decisão do Integrante 5).
4. Mudança nas **situações** (`CONFIRMADO`…`NAO_COMPARECEU`) altera simultaneamente: o enumerado do CLS-001, o `CHECK` de `agendamento.status` (`IMP-DER-02` do I4) e o EST-001. **O valor `SOLICITADO` não existe** (DEC-016 / R6-09).
5. Mudança nas **regras da fila** (DEC-027) altera simultaneamente `SolicitacaoEspera`, `ServicoListaEspera` (AP-06), OP-23…OP-28 e a SEQ-004.
6. O **e-mail é obrigatório** nos três eventos (RF-033): qualquer diagrama que trate o envio como condicional está divergente e deve ser corrigido. A falha de envio não desfaz a operação, é registrada na auditoria e pode ser repetida (DEC-029).

---

## 8. Índice dos artefatos rastreados

| Artefato | Arquivo | Especificação |
|---|---|---|
| SEQ-001 | `03-uml/Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` (+`.drawio.xml`, `.pdf`) | `03-uml/Sequências/proposta-I2-especificacao-sequencias.md` |
| SEQ-002 | `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` (+`.drawio.xml`, `.pdf`) | idem |
| SEQ-003 | `03-uml/Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` (+`.drawio.xml`, `.pdf`) | idem |
| **SEQ-004** | `03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd` (+`.drawio.xml`, `.pdf`) | idem |
| ATV-001 | `03-uml/Atividade/proposta-I2-atividade-atv-001.mmd` (+`.drawio.xml`, `.pdf`) | `03-uml/Atividade/proposta-I2-especificacao-atividade.md` |
| COM-001 | `03-uml/Comunicação/proposta-I2-comunicacao-com-001.mmd` (+`.drawio.xml`, `.pdf`) | `03-uml/Comunicação/proposta-I2-especificacao-comunicacao.md` |
| EST-001 | `03-uml/Estados/proposta-I2-estados-est-001.mmd` (+`.drawio.xml`, `.pdf`) | `03-uml/Estados/proposta-I2-especificacao-estados.md` |
| Casos de uso novos/revisados | `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` | (documento único) |
| Requisitos novos | `02-requisitos/requisitos-funcionais.md` (§8 — RF-033 a RF-037) | — |
| Decisões | `01-planejamento/decisoes.md` (DEC-022, DEC-025, DEC-026, DEC-027) | — |
| Revisão | `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` | — |
| Dossiê | `07-dossie/secoes/fase6-secao-21-24.md` | — |
