# Casos de uso faltantes e revisão de UC-025/UC-027 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v1.1 (proposta para o grupo; lote de ajustes da Fase 6 + consulta/saída da fila — LAC-13).
**Natureza:** **PROPOSTA.** Não substitui os artefatos oficiais (`especificacoes-casos-de-uso-criticos.md` e `especificacoes-casos-de-uso-demais.md`); complementa-os com os casos que faltavam e com a revisão das decisões novas.

> **Convenção de numeração (DEC-026):** cada caso de uso recebe o número do requisito que ele realiza — **`UC-0` + número do RF**. Assim, RF-028 → **UC-028**, RF-033 → **UC-033**, e assim por diante. Todo caso abre com **Objetivo** e **RFs cobertos**, como exige a revisão.

---

## 0. O que este documento resolve

| Lacuna da revisão FASE6-REV-I2 | Caso criado |
|---|---|
| RF-028 não tinha caso de uso ("consultar meus agendamentos" só aparecia como mensagem `OP-19`) | **UC-028** |
| RF-033 não existia (envio de e-mail era efeito implícito) | **UC-033** |
| Lista de espera não existia (a SEQ-004 estava bloqueada pela DEC-010) | **UC-034**, **UC-035**, **UC-036** |
| Não comparecimento não tinha requisito nem caso (era só transição do EST-001) | **UC-037** |

Além disso, este documento **revisa UC-025 e UC-027** (§7 e §8) para refletir: agendamento nasce `CONFIRMADO`, guarda `[antes do horário marcado]`, e-mail sempre enviado e oferta de vaga como `<<extend>>` do cancelamento.

---

## 1. UC-028 — Consultar os próprios agendamentos

**Objetivo:** permitir que o próprio Paciente (ou o Psicólogo, na agenda dele) veja a situação atual dos seus agendamentos, sem depender de outro ator.

**Atores:** Cliente/Paciente (titular); Psicólogo (para os agendamentos dele).

**RFs cobertos:** RF-028 (principal), RF-025, RF-026, RF-027, RF-030.

**Regras aplicadas:** RN-003 (vínculo), RNF-002 (autorização por perfil), RN-009 (consulta auditável conforme política).

**Pré-condições:** ator autenticado (RF-001); existir vínculo ATIVO quando a consulta é do Paciente.

**Pós-condições:** o ator recebe a lista dos **seus** agendamentos com situação (`CONFIRMADO`, `REALIZADO`, `CANCELADO`, `NAO_COMPARECEU`), data/hora e psicólogo. Nenhum dado de outro paciente é retornado.

**Fluxo principal:**

1. Ator solicita "meus agendamentos".
2. Sistema identifica o ator na sessão e aplica a autorização (OP-04).
3. Sistema consulta os agendamentos do ator (`Agendamento.consultarMeus`, OP-19).
4. Sistema devolve a lista ordenada por data/hora, com a situação de cada um.
5. A partir da lista, o ator pode iniciar UC-027 (cancelar) em um agendamento `CONFIRMADO`.

**Fluxos alternativos:**

- **A1 — Nenhum agendamento:** o sistema informa que não há agendamentos e oferece "solicitar horário" (UC-025).

**Exceções:**

- **E1 — Sessão inválida ou expirada:** o sistema recusa e redireciona para UC-001.
- **E2 — Tentativa de consultar agendamento de outro paciente:** o sistema recusa (RN-003) e audita a tentativa.

**Relacionamentos:** `UC-028` é **`<<include>>`** de UC-027 (cancelar parte da lista); não inclui UC-035 — a oferta chega por e-mail e por consulta, não pela lista.

**Rastreabilidade:** SEQ-003 (mensagem `consultarMeus` / OP-19), ATV-001 (implícito no caminho de cancelamento), matriz `MT6`.

---

## 2. UC-033 — Notificar os interessados por e-mail

**Objetivo:** garantir que confirmação, cancelamento e oferta de vaga cheguem ao interessado por e-mail, **sem que a falha de envio invalide a operação de agenda**.

**Atores:** Sistema (secundário: Serviço Externo de E-mail). Não é iniciado por ator humano.

**RFs cobertos:** RF-033 (principal), RF-025, RF-026, RF-027, RF-035.

**Regras aplicadas:** DEC-022 (fronteira única `ServicoEnvioMensagem`), DEC-009 + DEC-029 (envio sempre solicitado; falha não desfaz, é auditada e repetível), TRS-02 do Integrante 4 (pós-commit).

**Pré-condições:** a operação de agenda (criação, cancelamento ou abertura de oferta) terminou com sucesso; o destinatário tem e-mail cadastrado.

**Pós-condições:** a mensagem é entregue ao Serviço Externo de E-mail e o resultado (entregue/falha) é registrado. **A operação de agenda permanece válida em qualquer caso.**

**Fluxo principal:**

1. `ServicoAgenda` (ou `ServicoListaEspera`) conclui a operação de agenda e o commit.
2. O serviço monta a mensagem do evento: **confirmação**, **cancelamento** ou **oferta de vaga**.
3. O serviço chama `ServicoEnvioMensagem.notificar(evento)` (AP-04).
4. O Serviço Externo de E-mail aceita a mensagem e devolve o resultado.
5. O resultado é registrado para rastreabilidade.

**Fluxos alternativos:**

- **A1 — E-mail não cadastrado:** o sistema registra "sem destinatário" e segue; a operação de agenda não é afetada.

**Exceções:**

- **E1 — Falha do Serviço Externo de E-mail:** o sistema registra a falha e **não** desfaz a operação. Não há retry automático obrigatório (pode ser operação de suporte).

**Relacionamentos:** é **`<<include>>`** de UC-025/UC-027/UC-035 (todo evento de agenda inclui a notificação). Não é `<<extend>>`: **não é opcional**.

**Rastreabilidade:** SEQ-002 (msg. `notificar(confirmacao)`), SEQ-003 (`notificar(cancelamento)`), SEQ-004 (`notificar(ofertaVaga)` e `notificar(confirmacao)`), COM-001 (mensagens 10, 12 e 15), ATV-001 (`Notificar confirmação`, `Notificar cancelamento`).

---

## 3. UC-034 — Entrar na lista de espera

**Objetivo:** permitir que o Paciente sem horário disponível registre formalmente o interesse, entrando em uma fila **por ordem de entrada**, consulte a própria posição e possa sair da fila a qualquer momento.

**Atores:** Cliente/Paciente.

**RFs cobertos:** RF-034 (principal), RF-021, RF-024.

**Regras aplicadas:** DEC-027 (fila por ordem de entrada, sem prioridade manual), RN-003 (vínculo).

**Pré-condições:** ator autenticado; vínculo ATIVO com o psicólogo; **não** existir entrada ativa (`AGUARDANDO` ou `OFERTADA`) do mesmo paciente para o mesmo psicólogo.

**Pós-condições:** existe uma `SolicitacaoEspera` com psicólogo, paciente, período desejado, `dataHoraEntrada` e situação `AGUARDANDO`. A posição do paciente é determinada exclusivamente por `dataHoraEntrada`. Se o paciente desistir, a solicitação passa a `DESISTIU` (terminal) e a posição deixa de existir.

**Fluxo principal:**

1. O paciente consulta horários (UC-024) e não há disponibilidade (A1 de UC-025).
2. O sistema oferece "entrar na lista de espera".
3. O paciente confirma o período desejado.
4. O sistema valida o vínculo e a inexistência de entrada ativa.
5. O sistema registra a solicitação (`SolicitacaoEspera.registrarEntrada`, OP-23) já em `AGUARDANDO`.
6. O sistema audita o evento (RN-009/AP-02).
7. O sistema informa a posição na fila.

**Fluxo de consulta e saída (a qualquer momento, enquanto a solicitação estiver ativa):**

1. O paciente solicita consultar a posição (`consultarPosicao`, AP-06).
2. O sistema calcula a posição pela ordem de `dataHoraEntrada` (`posicaoNaFila`, **OP-28**).
3. O paciente pode sair da fila (`sairDaFila`, AP-06).
4. O sistema encerra a solicitação como `DESISTIU` (`encerrar`, OP-27) e audita `"ESPERA_ENCERRADA"` (AP-02).

**Fluxos alternativos:**

- **A1 — Já existe entrada ativa:** o sistema informa a posição atual e não cria duplicata.
- **A2 — Consulta da posição ou desistência:** a posição é devolvida por `posicaoNaFila` (OP-28); a desistência encerra como `DESISTIU` (OP-27) e audita o encerramento. O paciente pode entrar de novo depois — a desistência não gera punição.

**Exceções:**

- **E1 — Vínculo inativo:** o sistema recusa (RN-003).
- **E2 — Psicólogo inexistente ou inativo:** o sistema recusa e não cria a entrada.

**Relacionamentos:** **`<<extend>>` de UC-025** (A1): só acontece quando não há horário.

**Rastreabilidade:** SEQ-004 (primeiro bloco + `opt` "Consulta de posição e saída da fila"), ATV-001 (`Sem horários: oferecer lista de espera`), DEC-027, LAC-13.

---

## 4. UC-035 — Ofertar vaga ao próximo da lista de espera

**Objetivo:** aproveitar um horário liberado por cancelamento, ofertando-o ao **primeiro** da fila, com **uma única oferta aberta por vez** e **prazo de aceite**.

**Atores:** Sistema (decorrente do cancelamento). O paciente é notificado, mas não inicia o caso.

**RFs cobertos:** RF-035 (principal), RF-027, RF-033, RF-034, RF-036.

**Regras aplicadas:** DEC-027 (ordem de entrada, uma oferta por vez, prazo, recusa passa ao próximo), RN-010 (um horário, um agendamento).

**Pré-condições:** ocorreu cancelamento que liberou um horário (UC-027); existe `SolicitacaoEspera` em `AGUARDANDO` para o mesmo psicólogo.

**Pós-condições:** a solicitação mais antiga passa a `OFERTADA`, com `prazoAceite` registrado; o paciente é notificado por e-mail (UC-033). Se não houver fila, nenhuma oferta é aberta e o horário permanece no catálogo.

**Fluxo principal:**

1. UC-027 termina com o agendamento `CANCELADO` e o horário liberado.
2. `ServicoAgenda` chama `ServicoListaEspera.ofertarVaga(horarioLiberado)` (AP-06).
3. O serviço verifica se **já existe oferta aberta** para o psicólogo; se houver, encerra sem abrir outra.
4. O serviço obtém a solicitação `AGUARDANDO` mais antiga (`proximoDaFila`, OP-24).
5. O serviço abre a oferta com o prazo de aceite (`abrirOferta`, OP-25) → `OFERTADA`.
6. O serviço audita `OFERTA_VAGA_ABERTA` (AP-02) e solicita o e-mail de oferta (UC-033).
7. O paciente decide em UC-036.

**Fluxos alternativos:**

- **A1 — Fila vazia:** o serviço não abre oferta; o horário continua disponível para UC-025.
- **A2 — Já existe oferta aberta:** o serviço não abre uma segunda oferta (violaria DEC-027 e RN-010).

**Exceções:**

- **E1 — Falha no envio do e-mail da oferta:** a oferta continua válida; a falha é registrada (UC-033/E1).

**Relacionamentos:** **`<<extend>>` de UC-027** (cancelamento). **Não é caso de uso independente iniciado por ator** — é exatamente o que a revisão pediu. UC-035 **`<<include>>`** UC-033.

**Rastreabilidade:** SEQ-003 (`opt <<extend>> UC-035`), SEQ-004 (bloco `opt <<extend>> do cancelamento`), COM-001 (mensagens 13–15), ATV-001 (`Ofertar vaga se houver fila`).

---

## 5. UC-036 — Responder à oferta de vaga

**Objetivo:** permitir que o paciente aceite ou recuse a vaga ofertada dentro do prazo, garantindo que a vaga não fique presa.

**Atores:** Cliente/Paciente.

**RFs cobertos:** RF-036 (principal), RF-025, RF-026, RF-035.

**Regras aplicadas:** DEC-027 (recusa/vencimento passa ao próximo; aceite cria agendamento já confirmado), RN-013.

**Pré-condições:** existe oferta aberta (`OFERTADA`) para o paciente, dentro do `prazoAceite`.

**Pós-condições:**

- **Aceite:** agendamento criado já `CONFIRMADO` (RF-025/RF-026); solicitação encerrada como `ACEITA`; e-mail de confirmação solicitado.
- **Recusa:** solicitação encerrada como `RECUSADA`; vaga reofertada ao próximo (UC-035).
- **Vencimento:** solicitação encerrada como `EXPIRADA`; vaga reofertada ao próximo (UC-035).

**Fluxo principal (aceite):**

1. O paciente acessa a oferta recebida por e-mail.
2. O paciente escolhe "aceitar".
3. O sistema valida o prazo (`validarPrazo`, OP-26).
4. O sistema chama `ServicoAgenda.agendar(...)`, que cria o agendamento **já confirmado** (RF-025/RF-026).
5. O sistema audita o agendamento e encerra a solicitação como `ACEITA` (`encerrar`, OP-27).
6. O sistema solicita o e-mail de confirmação (UC-033).

**Fluxos alternativos:**

- **A1 — Recusa:** o sistema encerra como `RECUSADA`, audita e chama UC-035 para o próximo da fila.
- **A2 — Prazo vencido:** o sistema encerra como `EXPIRADA`, audita e chama UC-035 para o próximo da fila.

**Exceções:**

- **E1 — Horário já não está mais livre (corrida):** o sistema recusa o aceite, registra e reoferta ao próximo.
- **E2 — Oferta inexistente ou já encerrada:** o sistema informa e não cria agendamento.

**Relacionamentos:** **`<<include>>`** UC-025 (o aceite usa o caminho normal de agendamento) e UC-033 (confirmação). **`<<extend>>`** de UC-035 no tratamento de recusa/vencimento (a reoferta).

**Rastreabilidade:** SEQ-004 (blocos `alt Aceite dentro do prazo`, `Recusa`, `Prazo vencido`), DEC-027.

---

## 6. UC-037 — Registrar não comparecimento

**Objetivo:** permitir que o Psicólogo registre, **manualmente**, que o paciente não compareceu a um agendamento confirmado cujo horário já passou.

**Atores:** Psicólogo.

**RFs cobertos:** RF-037 (principal), RF-026, RF-030, RF-032.

**Regras aplicadas:** DEC-025 (registro manual, sem expiração automática), RN-006 (falta ≠ atendimento), RN-009 (auditoria).

**Pré-condições:** psicólogo autenticado e vinculado ao paciente; agendamento em `CONFIRMADO`; horário marcado já passou.

**Pós-condições:** situação `NAO_COMPARECEU` (terminal); **nenhum** `Atendimento` é registrado; operação auditada.

**Fluxo principal:**

1. O psicólogo abre a agenda e identifica o agendamento `CONFIRMADO` cujo horário passou.
2. O psicólogo escolhe "registrar não comparecimento".
3. O sistema valida a situação e o horário.
4. O sistema altera a situação para `NAO_COMPARECEU` (`registrarFalta`, OP-18).
5. O sistema audita `AGENDAMENTO_NAO_COMPARECEU` (AP-02).

**Fluxos alternativos:**

- **A1 — Sessão realizada (atraso):** o psicólogo escolhe UC-027 (concluir) e registra o atendimento.

**Exceções:**

- **E1 — Agendamento cancelado ou já encerrado:** o sistema recusa (a situação é terminal).
- **E2 — Horário ainda não chegou:** o sistema recusa; não se registra falta antes do horário.
- **E3 — Ator não é o psicólogo do agendamento:** o sistema recusa (RN-003).

**Relacionamentos:** `UC-037` **estende** UC-027 no sentido de comportamento alternativo; no diagrama de casos de uso é um caso **próprio** (tem ator e objetivo próprios), diferente da oferta de vaga, que é `<<extend>>` por ser automática.

**Rastreabilidade:** EST-001 (T3), SEQ-003 (`opt RF-037`), ATV-001 (`Registrar falta` → `Auditar falta`), DEC-025.

---

## 7. Revisão de UC-025 — Solicitar agendamento

| Item | v1.0 (Fase 4) | v2.0 (Fase 6) |
|---|---|---|
| Situação inicial | "solicitado", com confirmação posterior | **`CONFIRMADO`** já na criação (RF-025 + RF-026 / RN-013) |
| Ator que confirma | pendente de decisão | **ninguém**: a confirmação é automática e simultânea |
| Sem horários (A1) | apenas informa a ausência | informa e **oferece a lista de espera** (UC-034) |
| E-mail | não previsto | **sempre** solicita o e-mail de confirmação (UC-033) |
| Conflito (E1) | recusa e sugere outro horário | mantido |

**Objetivo (revisado):** reservar um horário do psicólogo vinculado, criando o agendamento **já confirmado**, com auditoria e notificação.

**RFs cobertos:** RF-024, RF-025, RF-026, RF-032, RF-033, RF-034.

## 8. Revisão de UC-027 — Cancelar agendamento

| Item | v1.0 (Fase 4) | v2.0 (Fase 6) |
|---|---|---|
| Guarda | "prazo de antecedência" (pendente, DEC-012) | **`[antes do horário marcado]`** — não existe antecedência mínima (DEC-028) |
| Confirmar | caso de uso separado incluído | **removido**: a confirmação ocorre na criação (UC-025) |
| E-mail | efeito implícito | **sempre** solicita o e-mail de cancelamento (UC-033) |
| Oferta de vaga | não existia | **`<<extend>>` UC-035** quando há fila |
| Não comparecimento | citado como pendência "DEC-5" | **UC-037** (registro manual, DEC-025) |
| Consulta prévia | implícita | **`<<include>>` UC-028** (o ator escolhe na lista) |

**Objetivo (revisado):** cancelar um agendamento confirmado antes do horário marcado, liberando o horário, auditando, notificando e — se houver fila — ofertando a vaga ao próximo.

**RFs cobertos:** RF-027, RF-028, RF-032, RF-033, RF-035, RF-037.

## 9. Diagrama de casos de uso — relações a incorporar

O diagrama de casos de uso oficial (Fase 3) precisa passar a mostrar:

- **Serviço Externo de E-mail** como **ator secundário** (participa de UC-033).
- **`UC-035 --<<extend>>--> UC-027`** (oferta de vaga estende o cancelamento).
- **`UC-034 --<<extend>>--> UC-025`** (lista de espera estende o agendamento, no ramo "sem horários").
- **`UC-033 --<<include>>--`** em UC-025, UC-027 e UC-035 (o e-mail não é opcional).
- **`UC-028 --<<include>>--`** em UC-027 (a lista de agendamentos é o ponto de partida do cancelamento).

> **Escopo:** o desenho do diagrama de casos de uso é do Integrante 3 (artefato oficial da Fase 3). Esta proposta **especifica as relações** e as representa nos diagramas comportamentais (`opt <<extend>>` na SEQ-003 e na SEQ-004), para que a atualização do diagrama seja mecânica.

---

## 10. Quadro-resumo

| UC | Nome | Ator principal | RFs cobertos | Relacionamento |
|---|---|---|---|---|
| UC-028 | Consultar os próprios agendamentos | Paciente / Psicólogo | RF-028, RF-025, RF-026, RF-027, RF-030 | include em UC-027 |
| UC-033 | Notificar os interessados por e-mail | Sistema | RF-033, RF-025, RF-026, RF-027, RF-035 | include em UC-025/027/035 |
| UC-034 | Entrar na lista de espera | Paciente | RF-034, RF-021, RF-024 | extend de UC-025 |
| UC-035 | Ofertar vaga ao próximo | Sistema | RF-035, RF-027, RF-033, RF-034, RF-036 | **extend de UC-027** |
| UC-036 | Responder à oferta de vaga | Paciente | RF-036, RF-025, RF-026, RF-035 | include de UC-025; extend de UC-035 |
| UC-037 | Registrar não comparecimento | Psicólogo | RF-037, RF-026, RF-030, RF-032 | caso próprio (alternativo a UC-027) |
