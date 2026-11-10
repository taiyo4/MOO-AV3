# Especificação das máquinas de estados EST-001 e EST-002 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 08/11/2026 · **Versão:** v2.1 (proposta para o grupo; acrescenta a **EST-002** — `SolicitacaoEspera`, alinhada ao CLS-001, à SEQ-004 e ao DDL — decisões **P10** e **Q5-09**).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.

| Artefato | Arquivo |
|---|---|
| Fonte editável (verdade do conteúdo) — EST-001 | [`proposta-I2-estados-est-001.mmd`](proposta-I2-estados-est-001.mmd) |
| Editável (draw.io) — EST-001 | `proposta-I2-estados-est-001.drawio.xml` |
| Dossiê (PDF) — EST-001 | `proposta-I2-estados-est-001.pdf` |
| Fonte editável (verdade do conteúdo) — EST-002 | [`proposta-I2-estados-est-002.mmd`](proposta-I2-estados-est-002.mmd) |
| Editável (draw.io) — EST-002 | `proposta-I2-estados-est-002.drawio.xml` |
| Dossiê (PDF) — EST-002 | `proposta-I2-estados-est-002.pdf` |
| Entidade modelada — EST-001 | `Agendamento` (CLS-001) · atributo `-situacao` : `SituacaoAgendamento` (4 valores — DEC-016) |
| Entidade modelada — EST-002 | `SolicitacaoEspera` (CLS-001) · atributo `-situacao` : `SituacaoFila` (6 valores — DEC-027) |
| **RFs cobertos** | **RF-025** (solicitar), **RF-026** (confirmar), **RF-027** (cancelar), **RF-030** (concluir), **RF-034** (lista de espera), **RF-035** (ofertar vaga), **RF-036** (responder oferta), **RF-037** (não comparecimento), **RF-032** (auditoria) |
| Base de regras | RN-012, RN-013, RN-006, RN-009, RN-010 · plano §5.4 · DEC-016 · DEC-025 (falta manual) · DEC-027 (lista de espera, 6 situações) |

---

## 1. Objetivo

O plano da AV3 pede "a máquina de estados de Agendamento ou outra entidade relevante, incluindo eventos, condições e ações nas transições" (§6.1, Integrante 2). O EST-001 fixa o **ciclo de vida da situação do agendamento**, usando exatamente as **situações nomeadas** do enum `SituacaoAgendamento` (CLS-001 v2):

`CONFIRMADO` · `REALIZADO` · `CANCELADO` · `NAO_COMPARECEU`

Essas situações são o atributo `-situacao` do `Agendamento` — o que faz desta máquina **persistível** (o ponto de corte do plano: "estados × atributo/status persistível").

> **Mudança em relação à v1.0:** o lote de ajustes da Fase 6 eliminou a situação `SOLICITADO`. O agendamento **já nasce `CONFIRMADO`** (RF-025/RF-026), porque a confirmação é automática e ocorre no mesmo ato (RN-013). Com isso a máquina passa de **5 situações/6 transições** para **4 situações/4 transições de saída + a criação**.

A **EST-002** cobre a segunda entidade com ciclo de vida relevante: a `SolicitacaoEspera`, cujo atributo `-situacao` : `SituacaoFila` tem **seis valores** (DEC-027). Ela é apresentada na seção 7 e usa exatamente os mesmos nomes do CLS-001, da SEQ-004 e do DDL (`04-persistencia/ddl/schema-mysql.sql`, linhas 443–484).

## 2. Estados

| Estado | Significado | Criado por | Pode sair? |
|---|---|---|---|
| `CONFIRMADO` | Horário reservado e confirmado; **situação inicial**. | `Agendamento.solicitar` (RF-025 / RF-026) | Sim (3 transições) |
| `REALIZADO` | Sessão realizada e registrada. | `Agendamento.concluir` (OP-17, RF-030) | **Não** (terminal) |
| `CANCELADO` | Agendamento cancelado antes do horário. | `Agendamento.cancelar` (OP-14, RF-027) | **Não** (terminal) |
| `NAO_COMPARECEU` | O paciente não compareceu. | `Agendamento.registrarFalta` (OP-18, RF-037) | **Não** (terminal) |

> A transição inicial `[*] → CONFIRMADO` marca que **todo agendamento nasce confirmado**: não há passo intermediário de aprovação nem ator que confirme depois.

## 3. Transições: evento, condição e ação

| # | De → Para | Evento | Condição (guarda) | Efeito / ação | Origem |
|---|---|---|---|---|---|
| T0 (criação) | `[*]` → `CONFIRMADO` | `solicitar` | vínculo ATIVO e slot livre | cria o agendamento já confirmado; reserva o slot | RF-025 / RF-026 / RN-005 / RN-010 / RN-013 |
| T1 | `CONFIRMADO` → `CANCELADO` | `cancelar` | `[antes do horário marcado]` | libera o horário, audita, notifica e abre oferta de vaga se houver fila | OP-14/OP-15 / RN-012 / RF-033 / RF-035 |
| T2 | `CONFIRMADO` → `REALIZADO` | `concluir` | `[atendimento registrado]` | registra o atendimento, audita | OP-17/OP-20 / RF-030 |
| T3 | `CONFIRMADO` → `NAO_COMPARECEU` | `registrarFalta` | `[horário já passou, ação do psicólogo]` | audita | OP-18 / RF-037 / DEC-025 |

### 3.1 Estados terminais

`REALIZADO`, `CANCELADO` e `NAO_COMPARECEU` **não têm saída**. Um agendamento não é "des-realizado" nem "des-cancelado": a correção é um novo agendamento. Isso preserva a **imutabilidade do histórico auditável** (RN-009/RNF-004) e evita que a trilha de auditoria precise de "desfazer".

### 3.2 A guarda de cancelamento

> **`[antes do horário marcado]`** — o cancelamento só é aceito enquanto a hora marcada não começou. **Não existe antecedência mínima** (DEC-028; a DEC-012 não foi adotada).

A guarda e os atores são os da DEC-011: o **Paciente titular** e o **Psicólogo responsável**; o **Administrador não cancela** (DEC-028). Depois do início do horário, o compromisso só pode terminar como `REALIZADO` ou `NAO_COMPARECEU`.

### 3.3 Não comparecimento é manual

`NAO_COMPARECEU` só é alcançável de `CONFIRMADO`, por ação explícita do Psicólogo (DEC-025 / RF-037). Não há expiração automática: o sistema não infere falta por passagem de tempo. Isso evita registrar um fato falso quando o atendimento apenas atrasou o registro.

### 3.4 Oferta de vaga não é transição

A oferta de vaga (RF-035 / UC-035) é um **efeito colateral** de T1, não uma situação do agendamento. O agendamento cancelado permanece `CANCELADO`; a fila e o prazo de aceite vivem em `SolicitacaoEspera` (SEQ-004), fora do ciclo de vida do agendamento.

## 4. Correspondência com os demais diagramas

| Transição | SEQ-002 | SEQ-003 | SEQ-004 | ATV-001 | COM-001 (msg.) |
|---|---|---|---|---|---|
| T0 (criação) | `Agendamento.solicitar` → `CONFIRMADO` | — | `solicitar` no aceite da oferta | `Criar agendamento (CONFIRMADO)` | 7 |
| T2 | — | `concluir` (`opt`) | — | `Concluir (OP-17)` | 16/17 |
| T1 | — | `cancelar` (`alt`) | `ofertarVaga` (`opt` `<<extend>>`) | `Cancelar (OP-14)` → `Ofertar vaga` | 11/12 |
| T3 | — | `registrarFalta` (`opt`) | — | `Registrar falta (OP-18)` | — |

**Nenhuma transição sem origem e nenhuma mensagem sem transição.** As colunas acima são a evidência da comparação cruzada pedida pelo plano.

## 5. Decisões de modelagem

1. **As guardas são mostradas no rótulo da transição** entre colchetes (`[antes do horario marcado]`, `[atendimento]`) para que a máquina seja autossuficiente, e detalhadas nas notas do diagrama. Colchete = **condição**, sem colchete = **evento**.
2. **A transição inicial é `solicitar`, que já leva a `CONFIRMADO`**: não existe situação de pendência, nem ator responsável por confirmar depois.
3. **A máquina tem 4 situações e 4 transições de saída** (T1–T3 acima mais a criação). Qualquer contagem diferente em outro artefato é divergência a corrigir.
4. **Não há estado "pendente de pagamento"**, "lista de espera" nem "sessão": a fila é entidade própria (`SolicitacaoEspera`) e os demais conceitos estão fora do domínio (plano §5.2, P-07).

## 6. Pendência registrada (não é lacuna desta entrega)

| Pendência | Causa | Efeito |
|---|---|---|
| O CLS-001 oficial ainda declara `Agendamento.confirmar()` e não fixa o enumerado das quatro situações | artefato da Fase 3, sob responsabilidade do Integrante 3 | a máquina e os diagramas da Fase 6 já usam as quatro situações da DEC-016 e dispensam `confirmar()` (DEC-017); falta alinhar o CLS-001 (achado **R6-09**) |

## 7. EST-002 — Máquina de estados da `SolicitacaoEspera` (UC-034 a UC-036)

### 7.1 Objetivo

A EST-002 fixa o **ciclo de vida da solicitação de lista de espera**, usando exatamente as **situações nomeadas** do atributo `-situacao` : `SituacaoFila` do CLS-001 (DEC-027):

`AGUARDANDO` · `OFERTADA` · `ACEITA` · `RECUSADA` · `EXPIRADA` · `DESISTIU`

Como as demais máquinas, ela é **persistível**: cada nome corresponde a um valor do `CHECK` da tabela `solicitacao_espera` no DDL (`04-persistencia/ddl/schema-mysql.sql`, linhas 443–484). Nenhum nome é novo — todos vêm da DEC-027 e do CLS-001.

### 7.2 Estados

| Estado | Significado | Criado por | Pode sair? |
|---|---|---|---|
| `AGUARDANDO` | Solicitação registrada, aguardando vaga; **situação inicial**. | `SolicitacaoEspera.registrarEntrada(...)` (OP-23, RF-034) | Sim (2 transições) |
| `OFERTADA` | Vaga ofertada ao paciente; horário reservado até `prazoAceite`. | `SolicitacaoEspera.abrirOferta(...)` (OP-25, RF-035) | Sim (3 transições) |
| `ACEITA` | Oferta aceita e convertida em agendamento `CONFIRMADO`. | `SolicitacaoEspera.aceitar(solicitante)` (OP-27, RF-036) | **Não** (terminal) |
| `RECUSADA` | Oferta recusada pelo paciente. | `SolicitacaoEspera.recusar(solicitante)` (OP-27, RF-036) | **Não** (terminal) |
| `EXPIRADA` | Prazo de aceite vencido sem resposta. | `SolicitacaoEspera.expirar()` (OP-27, RF-036) | **Não** (terminal) |
| `DESISTIU` | Paciente saiu da fila antes da conversão. | `SolicitacaoEspera.encerrar("DESISTIU", solicitante)` (OP-27, RF-034) | **Não** (terminal) |

> A posição na fila é definida **exclusivamente por `dataHoraEntrada`** (DEC-027). `consultarPosicao()` (OP-28) é consulta e **não altera** a situação.

### 7.3 Transições: evento, condição e ação

| # | De → Para | Evento | Condição (guarda) | Efeito / ação | Origem |
|---|---|---|---|---|---|
| F0 (criação) | `[*]` → `AGUARDANDO` | `registrarEntrada(psicologo, paciente, horario, solicitante)` | paciente autorizado para o psicólogo | grava `dataHoraEntrada`; audita `"ESPERA_REGISTRADA"` | OP-23 / RF-034 / RN-003 |
| F1 | `AGUARDANDO` → `OFERTADA` | `abrirOferta(horario, prazoAceite)` | `[há vaga e nenhuma oferta aberta para o psicólogo]` | grava `prazoAceite`; **reserva o horário**; audita e notifica (RF-033) | OP-25 / RF-035 / RN-010 |
| F2 | `OFERTADA` → `ACEITA` | `aceitar(solicitante)` | `[dentro do prazoAceite]` | reusa `ServicoAgenda.agendar` → `Agendamento.solicitar` (`CONFIRMADO`); audita e notifica | OP-27 / RF-025 / RF-026 / RN-013 |
| F3 | `OFERTADA` → `RECUSADA` | `recusar(solicitante)` | — | audita; **reoferta ao próximo** (`ofertarVaga`) | OP-27 / RF-036 / DEC-027 |
| F4 | `OFERTADA` → `EXPIRADA` | `expirar()` | `[prazoAceite vencido]` | audita; **reoferta ao próximo** | OP-27 / RF-036 / DEC-027 |
| F5 | `AGUARDANDO` → `DESISTIU` | `encerrar("DESISTIU", solicitante)` | — | audita `"ESPERA_ENCERRADA"`; a posição deixa de existir | OP-27 / RF-034 |
| F6 | `OFERTADA` → `DESISTIU` | `encerrar("DESISTIU", solicitante)` | `[durante a oferta]` | audita `"ESPERA_ENCERRADA"`; libera o horário e reoferta ao próximo | OP-27 / RF-034 / DEC-027 |

### 7.4 Correspondência com os demais artefatos

| Transição | CLS-001 (`SolicitacaoEspera`) | SEQ-004 | DDL `solicitacao_espera` | EST-002 |
|---|---|---|---|---|
| F0 | `registrarEntrada(psicologo, paciente, horario, solicitante)` | `registrarEntrada(...)` | `situacao` inicia `AGUARDANDO` | `[*] → AGUARDANDO` |
| F1 | `abrirOferta(horario, prazoAceite)` | `abrirOferta(horario, prazoAceite)` | `ck_se_prazo` exige `prazoAceite` em `OFERTADA` | `AGUARDANDO → OFERTADA` |
| F2 | `aceitar(solicitante)` | `aceitar(solicitante)` | `ACEITA` aceito pelo `CHECK` | `OFERTADA → ACEITA` |
| F3 | `recusar(solicitante)` | `recusar(solicitante)` | `RECUSADA` aceito pelo `CHECK` | `OFERTADA → RECUSADA` |
| F4 | `expirar()` | `expirar()` | `EXPIRADA` aceito pelo `CHECK` | `OFERTADA → EXPIRADA` |
| F5/F6 | `encerrar(motivo, solicitante)` | `encerrar("DESISTIU", solicitante)` | `DESISTIU` aceito pelo `CHECK` | `AGUARDANDO`/`OFERTADA → DESISTIU` |

Os **seis nomes** (`AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU`) são idênticos nos quatro artefatos. `proximoDaFila(psicologo)` **não** é transição: é consulta da coleção em `ServicoListaEspera` (AP-06, **decisão P10**).

### 7.5 Decisões de modelagem

1. **`proximoDaFila` fica no serviço, não na entidade (P10).** A escolha da solicitação mais antiga é uma consulta sobre a **coleção** de solicitações; por isso pertence a `ServicoListaEspera` (AP-06) e não gera transição de estado.
2. **`validarPrazo()` é consulta da entidade (OP-26, P10).** O atributo `prazoAceite` já existe no CLS-001; a operação apenas responde se a oferta ainda é válida. A inclusão formal no CLS-001 está encaminhada ao Integrante 3.
3. **`aceitar`, `recusar`, `expirar` e `encerrar` são operações distintas (Q5-09).** Não há mais `encerrar(ACEITA)`/`encerrar(RECUSADA)`/`expirarOferta`: cada transição usa o nome que o CLS-001 declara, e `encerrar(motivo, solicitante)` fica reservado à desistência.
4. **Todos os terminais são definitivos, mas não punem.** `ACEITA`, `RECUSADA`, `EXPIRADA` e `DESISTIU` não têm saída; recusa, vencimento e desistência apenas encerram **aquela** solicitação — uma nova entrada futura é permitida (RF-036).
5. **A recusa/vencimento não deixa o horário preso.** O horário reservado volta ao catálogo ou é reofertado ao próximo (`ofertarVaga`), conforme DEC-027.

## 8. Como ler e editar

- A **fonte editável** é o `.mmd` (Mermaid, `stateDiagram-v2`).
- As **hints de layout** `%% pos: <id> <x> <y>` posicionam o centro de cada estado (o Mermaid as ignora; o renderizador offline do repositório as usa — ver `03-uml/README.md`).
- As **notas** (`note left of` / `note right of`) explicam a situação inicial e as guardas.
- O `.drawio.xml` é a versão editável no draw.io; o `.pdf` é a versão do dossiê.
