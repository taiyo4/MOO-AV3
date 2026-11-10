# Especificação do diagrama de atividades ATV-001 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.0 (proposta para o grupo; revisão do lote de ajustes da Fase 6).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.

| Artefato | Arquivo |
|---|---|
| Fonte editável (verdade do conteúdo) | [`proposta-I2-atividade-atv-001.mmd`](proposta-I2-atividade-atv-001.mmd) |
| Editável (draw.io) | `proposta-I2-atividade-atv-001.drawio.xml` |
| Dossiê (PDF) | `proposta-I2-atividade-atv-001.pdf` |
| **RFs cobertos** | **RF-024, RF-025, RF-026, RF-027, RF-030, RF-032, RF-033, RF-034, RF-035, RF-037** |
| Base de regras | RN-003, RN-005, RN-009, RN-010, RN-012, RN-013 · DEC-022, DEC-025, DEC-027 |
| Casos de uso | UC-024, UC-025, UC-027, UC-035 |
| Diagramas correlatos | SEQ-002, SEQ-003, SEQ-004 (mesmo cenário) |

---

## 1. Objetivo

O plano da AV3 pede "o diagrama de atividades com decisões, responsabilidades e paralelismo quando aplicável" (§6.1, Integrante 2). O ATV-001 mostra **o ciclo completo do agendamento** — do pedido de horário até a conclusão, o cancelamento ou a falta — em **quatro pistas de responsabilidade**, com **quatro decisões**, **três blocos paralelos** e **duas etapas sequenciais** depois do cancelamento (notificação e oferta de vaga).

O cenário é o **mesmo** coberto por SEQ-002, SEQ-003 e SEQ-004, justamente para permitir a comparação cruzada exigida pelo plano ("comparar todos os diagramas comportamentais entre si e corrigir divergências").

## 2. Cenário

> O paciente solicita um agendamento. O sistema consulta os horários disponíveis e, se houver, o paciente escolhe um. O sistema valida o vínculo e o horário e **cria o agendamento já confirmado**, auditando e enviando o e-mail em paralelo. Se não houver horário, o sistema oferece a lista de espera. Mais tarde, o agendamento pode ser **cancelado** (com liberação do horário e auditoria em paralelo, seguida da notificação e, se houver fila, da **oferta da vaga ao próximo**) ou **mantido**; no caso de mantido, o paciente comparece e a sessão é **concluída** (registro de atendimento e auditoria em paralelo) ou registrada como **falta** (com auditoria).

## 3. Pistas (swimlanes) e responsabilidades

| Pista | Elementos | Responsabilidade |
|---|---|---|
| **Paciente** | Início, Solicitar agendamento, Selecionar horário, Comparecer à sessão | Ações do usuário (fronteira externa). |
| **Sistema (aplicação e domínio)** | Consultar horários, Validar vínculo e horário, Criar agendamento (CONFIRMADO), Sem horários, Recusar, Cancelar, Manter, Liberar horário, Registrar falta e as 4 decisões | Regras de negócio e orquestração (AP-03 + entidades de domínio). |
| **Psicólogo** | Registrar atendimento, Concluir | Ações do profissional (fronteira externa). |
| **Auditoria, notificação e extensão** | Auditar criação/cancelamento/conclusão/falta, Notificar confirmação/cancelamento, **Ofertar vaga** | Efeitos transversais (AP-02, AP-04) e a **extensão** da lista de espera (AP-06 / UC-035). |

> A separação entre "Sistema" e "Auditoria, notificação e extensão" existe porque **auditoria e notificação não são regra de negócio**: são efeitos transversais disparados pela aplicação (AP-02, AP-04). A oferta de vaga entra na mesma pista por ser um **`<<extend>>` do cancelamento** (só existe depois dele), e não uma regra do fluxo principal. Misturar tudo à pista de regra é o que produz a "classe onipotente" vedada pelo plano §5.2.

## 4. Decisões

| Nó | Texto | Condição detalhada | Regra |
|---|---|---|---|
| `d1` | Há horários? | A agenda do psicólogo tem slots livres no período pedido | RF-024 / UC-024 |
| `d2` | Vínculo OK? | Vínculo ATIVO entre paciente e psicólogo **e** slot ainda livre | RN-005, RN-010 (A17, slot discreto — DEC-018) |
| `d3` | Cancelamento? | O pedido de cancelamento é aceito: agendamento `CONFIRMADO` e **antes do horário marcado** | RF-027, RN-012, OP-15 |
| `d5` | Sessão realizada? | O atendimento chegou a acontecer (senão, falta manual pelo psicólogo) | RF-030, RF-037, RN-006, DEC-025 |

As condições foram mantidas **curtas** no desenho (rótulos de losango precisam caber); o detalhe completo está na tabela acima e nas especificações dos casos de uso.

## 5. Blocos paralelos (fork/join) e etapas sequenciais

| Bloco | Origem | Ramos paralelos | Join | Por que é paralelo |
|---|---|---|---|---|
| `fork1`/`join1` | após `Criar agendamento (CONFIRMADO)` | **par 1** auditar criação (RN-009) · **par 2** notificar confirmação (AP-04) | `join1` | A auditoria e o envio de e-mail são independentes entre si; o envio é pós-commit (TRS-02 do I4). |
| `fork2`/`join2` | após `Cancelar (OP-14)` | **par 1** liberar horário · **par 2** auditar cancelamento (RN-009) | `join2` | Devolver o slot ao catálogo e registrar a trilha não se bloqueiam. |
| `fork3`/`join3` | após `Registrar atendimento (OP-20)` | **par 1** concluir (OP-17) · **par 2** auditar conclusão (RN-009) | `join3` | Concluir o agendamento e escrever a trilha são operações distintas. |

Além dos três blocos paralelos, há **duas etapas sequenciais** depois do `join2`:

| Etapa | Posição | Origem | Por que é sequencial |
|---|---|---|---|
| `Notificar cancelamento (RF-033)` | entre `join2` e `Ofertar vaga` | AP-04 / RF-033 | O e-mail só pode ser solicitado **depois** que o cancelamento está gravado e auditado (pós-commit, TRS-02 do I4), e **antes** da oferta — é a ordem da SEQ-003 (`registrar` → `notificar` → `ofertar`). |
| `Ofertar vaga se houver fila (UC-035)` | entre `Notificar cancelamento` e `Fim` | AP-06 / DEC-027 | A vaga só pode ser ofertada **depois** que o slot foi liberado e o cancelamento notificado; e depende de existir fila (a condição está no rótulo, para não criar um 5º losango). A SEQ-004 detalha fila, prazo e recusa. |

> **Ressalva técnica (importante para a persistência):** a notificação é *pós-commit* (TRS-02 do Integrante 4) e, por isso, **não** pode estar na mesma transação que grava o agendamento. O paralelismo do ATV-001 é **lógico** (independência de regra), não uma transação única.

## 6. Caminhos (rotas de leitura)

### 6.1 Caminho feliz

`Início → Solicitar agendamento → Consultar horários (OP-11) → d1 [Sim] → Selecionar horário → Validar vínculo e horário → d2 [Sim] → Criar agendamento (CONFIRMADO) → fork1 → (auditar ‖ notificar) → join1 → d3`

### 6.2 Sem horários (A1 de UC-025 → RF-034)

`d1 [Não] → Sem horários: oferecer lista de espera (A1) → Fim` — a entrada na fila está detalhada na SEQ-004 / UC-034.

### 6.3 Conflito de horário (E1 de UC-025)

`d2 [Não] → Recusar (E1) → Fim`

### 6.4 Cancelamento (+ oferta de vaga)

`d3 [Sim] → Cancelar (OP-14) → fork2 → (liberar horário ‖ auditar cancelamento) → join2 → Notificar cancelamento (RF-033) → Ofertar vaga se houver fila (UC-035) → Fim`

### 6.5 Sessão realizada

`d3 [Não] → Manter agendamento → Comparecer à sessão → d5 [Sim] → Registrar atendimento (OP-20) → fork3 → (concluir ‖ auditar conclusão) → join3 → Fim`

### 6.6 Não compareceu

`d5 [Não] → Registrar falta (OP-18) → Auditar falta (RN-009) → Fim`

## 7. Correspondência com as sequências (verificação cruzada)

| Nó do ATV-001 | SEQ-002 | SEQ-003 | SEQ-004 | Operação/responsabilidade |
|---|---|---|---|---|
| Consultar horários (OP-11) | `consultarHorariosDisponiveis` | — | — | OP-11 |
| Validar vínculo e horário | `estaAutorizado` + `verificarDisponibilidade` | — | `estaAutorizado` (aceite) | OP-22 + `Agenda.verificarDisponibilidade` |
| Criar agendamento (CONFIRMADO) | `Agendamento.solicitar` | — | `solicitar` no aceite | `Agendamento.solicitar` / RF-025 + RF-026 |
| Auditar criação | `registrar("AGENDAMENTO_CONFIRMADO")` | — | `registrar("AGENDAMENTO_CONFIRMADO")` | AP-02 / RN-009 |
| Notificar confirmação (RF-033) | `notificar(confirmacao)` | — | `notificar(confirmacao)` | AP-04 / RF-033 |
| Sem horários (A1) | ramo "Nenhum horário disponível" | — | `entrarNaFila` | RF-034 / AP-06 |
| Cancelar (OP-14) | — | `podeSerCancelado` + `cancelar` | — | OP-15 + OP-14 |
| Auditar cancelamento | — | `registrar("AGENDAMENTO_CANCELADO")` | — | AP-02 |
| Notificar cancelamento (RF-033) | — | `notificar(cancelamento)` | — | AP-04 / RF-033 |
| Ofertar vaga (UC-035) | — | `opt <<extend>> ofertarVaga` | `ofertarVaga` + `proximoDaFila(psicologo)` + `abrirOferta` | AP-06 / OP-25 / RF-035 (P10) |
| Liberar horário | — | *(implícito em RN-012)* | *(horário liberado)* | regra do catálogo de disponibilidade |
| Registrar atendimento (OP-20) | — | `Atendimento.registrar` | — | OP-20 / RF-030 |
| Concluir (OP-17) | — | `concluir` | — | OP-17 |
| Registrar falta (OP-18) | — | `registrarFalta` | — | OP-18 / RF-037 / DEC-025 |
| Auditar falta | — | `registrar("AGENDAMENTO_NAO_COMPARECEU")` | — | AP-02 |

**Resultado:** nenhuma atividade do ATV-001 existe sem origem em uma operação ou responsabilidade conhecida; nenhuma mensagem de SEQ-002/SEQ-003/SEQ-004 está sem atividade correspondente.

## 8. Decisões de modelagem e ressalvas

1. **Cancelamento e sessão realizada são alternativas**, não etapas em sequência: `d3` separa "o paciente cancela" de "o paciente mantém". O `Fim` existe em cada rota terminal, como manda a notação de atividades.
2. **"Liberar horário"** aparece apenas no cancelamento. O catálogo de disponibilidade é do domínio; a liberação é consequência da regra (RN-012/RN-010), não uma mensagem para um serviço de aplicação — por isso não há operação correspondente no CLS-001 v2, e isso está anotado na revisão.
3. **A notificação não é condicional** (RF-033): os e-mails de confirmação, cancelamento e oferta de vaga **sempre** são solicitados; a falha de envio não desfaz a operação. O nome do colaborador é `ServicoEnvioMensagem` (DEC-022).
4. **A notificação do cancelamento é sequencial, não paralela.** O SEQ-003 mostra a ordem *auditar → notificar → ofertar → responder ao ator*; o ATV-001 reproduz essa ordem.
5. **Não há atividade separada de confirmação**: criar o agendamento já o deixa `CONFIRMADO` (RF-025/RF-026). A v1.0 tinha `Criar agendamento` → `Confirmar (OP-13)`; esse par foi colapsado.
6. **A oferta de vaga não é um quinto losango.** A condição "se houver fila" está no rótulo da atividade porque o `<<extend>>` é opcional por definição e não altera o caminho principal; a decisão detalhada (uma oferta por vez, prazo, recusa passa ao próximo) está na SEQ-004.
7. **Não há sessão como atividade**: sessão está fora do domínio (plano §5.2, P-07).
8. **`Fim` é um nó genérico** repetido nas rotas terminais — é a notação de atividade, não uma entidade.

## 9. Pendências registradas (não são lacunas desta entrega)

| Pendência | Causa | Tratamento no desenho |
|---|---|---|
| Reserva do slot (A17) | DEC-018 (slot discreto) — decidida | "Validar vínculo e horário" cobre a verificação; a reserva é interna a `Agendamento.solicitar`. |
| Prazo de cancelamento | resolvido: `[antes do horário marcado]` | `d3` registra a existência da guarda; **não há valor de 2 horas**. |
| Incremento `SolicitacaoEspera` + AP-06 | DEC-027 aprovada na Fase 6 | o nó `Ofertar vaga` já usa a responsabilidade; o Integrante 3 precisa incorporar a entidade e a AP-06 ao CLS-001. |
| Canal de notificação | resolvido: e-mail (RF-033) | `Notificar confirmação/cancelamento` são fronteira externa (`ServicoEnvioMensagem`), não entidade do domínio. |

## 10. Como ler e editar

- A **fonte editável** é o `.mmd` (Mermaid, `flowchart TD` com `subgraph` por pista).
- As **hints de layout** `%% pos: <id> <x> <y>` posicionam o centro de cada nó; o Mermaid as ignora como comentário, e o renderizador offline do repositório as usa (ver `03-uml/README.md`).
- As barras de paralelismo usam a forma `[||]`, desenhada como barra vertical.
- O `.drawio.xml` é a versão editável no draw.io; o `.pdf` é a versão do dossiê.
