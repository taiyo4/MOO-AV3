# Especificação da máquina de estados EST-001 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.0 (proposta para o grupo; revisão do lote de ajustes da Fase 6).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.

| Artefato | Arquivo |
|---|---|
| Fonte editável (verdade do conteúdo) | [`proposta-I2-estados-est-001.mmd`](proposta-I2-estados-est-001.mmd) |
| Editável (draw.io) | `proposta-I2-estados-est-001.drawio.xml` |
| Dossiê (PDF) | `proposta-I2-estados-est-001.pdf` |
| Entidade modelada | `Agendamento` (CLS-001) · atributo `-situacao` : `SituacaoAgendamento` (4 valores — DEC-016) |
| **RFs cobertos** | **RF-025** (solicitar), **RF-026** (confirmar), **RF-027** (cancelar), **RF-030** (concluir), **RF-037** (não comparecimento), **RF-032** (auditoria) |
| Base de regras | RN-012, RN-013, RN-006, RN-009 · plano §5.4 · DEC-025 (falta manual) · DEC-027 (lista de espera) |

---

## 1. Objetivo

O plano da AV3 pede "a máquina de estados de Agendamento ou outra entidade relevante, incluindo eventos, condições e ações nas transições" (§6.1, Integrante 2). O EST-001 fixa o **ciclo de vida da situação do agendamento**, usando exatamente as **situações nomeadas** do enum `SituacaoAgendamento` (CLS-001 v2):

`CONFIRMADO` · `REALIZADO` · `CANCELADO` · `NAO_COMPARECEU`

Essas situações são o atributo `-situacao` do `Agendamento` — o que faz desta máquina **persistível** (o ponto de corte do plano: "estados × atributo/status persistível").

> **Mudança em relação à v1.0:** o lote de ajustes da Fase 6 eliminou a situação `SOLICITADO`. O agendamento **já nasce `CONFIRMADO`** (RF-025/RF-026), porque a confirmação é automática e ocorre no mesmo ato (RN-013). Com isso a máquina passa de **5 situações/6 transições** para **4 situações/4 transições de saída + a criação**.

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

## 7. Como ler e editar

- A **fonte editável** é o `.mmd` (Mermaid, `stateDiagram-v2`).
- As **hints de layout** `%% pos: <id> <x> <y>` posicionam o centro de cada estado (o Mermaid as ignora; o renderizador offline do repositório as usa — ver `03-uml/README.md`).
- As **notas** (`note left of` / `note right of`) explicam a situação inicial e as guardas.
- O `.drawio.xml` é a versão editável no draw.io; o `.pdf` é a versão do dossiê.
