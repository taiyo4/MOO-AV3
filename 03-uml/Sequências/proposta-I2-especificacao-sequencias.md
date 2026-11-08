# Especificação das sequências SEQ-001 a SEQ-004 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.1 (proposta para o grupo; fechamento das ressalvas LAC-13, LAC-14 e LAC-15 da Fase 6).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.

| Diagrama | Fonte editável | Editável (draw.io) | Dossiê (PDF) | Caso de uso | RFs cobertos |
|---|---|---|---|---|---|
| SEQ-001 | [`proposta-I2-sequencia-seq-001-autenticar.mmd`](proposta-I2-sequencia-seq-001-autenticar.mmd) | `proposta-I2-sequencia-seq-001-autenticar.drawio.xml` | `proposta-I2-sequencia-seq-001-autenticar.pdf` | UC-001 | RF-001, RF-002, RF-032 |
| SEQ-002 | [`proposta-I2-sequencia-seq-002-agendar.mmd`](proposta-I2-sequencia-seq-002-agendar.mmd) | `proposta-I2-sequencia-seq-002-agendar.drawio.xml` | `proposta-I2-sequencia-seq-002-agendar.pdf` | UC-025 (+UC-024) | RF-024, RF-025, RF-026, RF-032, **RF-033**, **RF-034** |
| SEQ-003 | [`proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd`](proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd) | `proposta-I2-sequencia-seq-003-cancelar-confirmar.drawio.xml` | `proposta-I2-sequencia-seq-003-cancelar-confirmar.pdf` | UC-027 (+UC-035 `<<extend>>`) | RF-026, RF-027, **RF-028**, RF-030, RF-032, **RF-033**, **RF-035**, **RF-037** |
| SEQ-004 | [`proposta-I2-sequencia-seq-004-lista-espera.mmd`](proposta-I2-sequencia-seq-004-lista-espera.mmd) | `proposta-I2-sequencia-seq-004-lista-espera.drawio.xml` | `proposta-I2-sequencia-seq-004-lista-espera.pdf` | UC-034, UC-035, UC-036 | **RF-025, RF-026, RF-027, RF-032, RF-033, RF-034, RF-035, RF-036** |

> **Convenção de entrega:** o `.mmd` é a **fonte da verdade do conteúdo**; o `.drawio.xml` é a versão editável; o `.pdf` é a versão do dossiê. Os três arquivos têm o **mesmo nome-base**.

---

## 1. Objetivo

O plano da AV3 exige "pelo menos três diagramas de sequência para os casos de uso críticos aprovados" (§6.1, Integrante 2). Os **quatro** diagramas aqui propostos cobrem os caminhos críticos do domínio:

1. **SEQ-001 — entrar no sistema** (UC-001): precondição de tudo; inclui os desvios de erro E1/E2 e o caso de sucesso.
2. **SEQ-002 — obter e reservar um horário** (UC-025 + UC-024): caminho feliz de marcação, com a alternativa de conflito de horário e a alternativa de ausência de horários, que encaminha para a lista de espera (A1).
3. **SEQ-003 — cancelar, concluir e registrar falta** (UC-027): ciclo de vida do `Agendamento` depois de criado, com a guarda "antes do horário marcado", o envio obrigatório de e-mail e a oferta de vaga como `<<extend>>`.
4. **SEQ-004 — lista de espera e oferta de vaga** (UC-034 a UC-036): entrada na fila, consulta da posição e saída, oferta ao primeiro da fila com o horário **reservado durante o prazo**, aceite, recusa e vencimento (DEC-027).

Os quatro diagramas são **entrelaçados**: quem lê o conjunto entende o ciclo completo sem precisar decifrar um único diagrama isolado.

## 2. Regras de elegibilidade das mensagens (plano §6.1)

Toda mensagem de um diagrama de sequência deve corresponder a **uma operação conhecida** (OP-01…OP-28, propostos para o CLS-001 e para o incremento da lista de espera) ou a **uma responsabilidade de aplicação** (AP-01…AP-06, da revisão FASE5-REV-I2 §5.2). Não há mensagem "criada para satisfazer um diagrama futuro".

| Elemento | Origem da autorização | Onde aparece |
|---|---|---|
| `autenticar`, `criarSessao`, `invalidarSessaoAtiva` | AP-01 (`ServicoAutenticacao`) | SEQ-001 |
| `registrar(...)` (auditoria) | AP-02 (`ServicoAuditoria`) + `RegistroAuditoria.registrar` (RF-032) | SEQ-001/002/003/004 |
| `solicitar`/`cancelar`/`concluir`/`registrarFalta` | AP-03 (`ServicoAgenda`) + OP-13…OP-18 | SEQ-002/003/004 |
| `notificar(...)` | AP-04 (`ServicoEnvioMensagem`, fronteira externa) | SEQ-002/003/004 |
| `entrarNaFila`, `consultarPosicao`, `sairDaFila`, `ofertarVaga`, `aceitarOferta`, `recusarOferta`, `expirarOferta` | AP-06 (`ServicoListaEspera`) — **novo na Fase 6** | SEQ-004 |
| `registrarEntrada`, `proximoDaFila`, `abrirOferta`, `validarPrazo`, `encerrar` | OP-23…OP-27 (`SolicitacaoEspera`) — **novo na Fase 6** | SEQ-004 |
| `posicaoNaFila` | **OP-28** (`SolicitacaoEspera`) — **novo no fechamento da Fase 6** (LAC-13) | SEQ-004 |
| `podeAutenticar`, `confereCredencial` | OP-01, OP-02 | SEQ-001 |
| `estaAutorizado` (vínculo) | OP-22 | SEQ-002 |
| `consultarHorariosDisponiveis` | OP-11 | SEQ-002 |
| `verificarDisponibilidade` | `Agenda.verificarDisponibilidade` (modelo do I3) | SEQ-002 |
| `consultarMeus`, `podeSerCancelado`, `estaCancelada` | OP-19, OP-15, OP-16 | SEQ-003 |
| `Atendimento.registrar` | OP-20 | SEQ-003 |
| `obterPorIdentificacao`, `obterPermissoes` | IR-01, IR-02 (infraestrutura, Fase 7) | SEQ-001 |

**Limite proposital:** *sessão* e *notificação* **não** são entidades de domínio (P-07, DEC-022): aparecem como **comportamento de aplicação** (`AP-01`) ou como **fronteira externa** (`AP-04`), nunca como classe do modelo. A **lista de espera**, ao contrário, **passou a ser domínio** na Fase 6 (DEC-027): tem estado persistente (`AGUARDANDO`/`OFERTADA`/`ACEITA`/`RECUSADA`/`EXPIRADA`/`DESISTIU`), ordem de entrada e prazo, então é modelada como entidade `SolicitacaoEspera` + serviço de aplicação `ServicoListaEspera` (AP-06) — incremento a incorporar pelo Integrante 3.

## 3. SEQ-001 — Autenticar usuário (UC-001)

### 3.1 Cenário

> Um usuário (paciente, psicólogo ou administrador) informa identificação e senha. O sistema localiza a conta, verifica se pode autenticar, confere a credencial, carrega as permissões, cria a sessão e audita o evento. Em qualquer falha, o acesso é recusado **e** o evento é auditado.

### 3.2 Participantes

| Participante | Natureza | Papel |
|---|---|---|
| `Ator` | ator humano | Quem se autentica. |
| `ServicoAutenticacao` | serviço de aplicação (AP-01) | Coordena o caso de uso; fora do domínio. |
| `RepositorioUsuario` | infraestrutura (IR-01) | Obtém a conta por identificação (Fase 7). |
| `Usuario` | entidade de domínio | Decide **se pode** (OP-01) e **se a credencial confere** (OP-02). |
| `RepositorioAutorizacao` | infraestrutura (IR-02) | Devolve perfil e permissões (Fase 7). |
| `ServicoAuditoria` | serviço de aplicação (AP-02) | Registra o evento auditável. |
| `RegistroAuditoria` | entidade de domínio | Persiste a trilha (data, hora, operação, responsável). |

### 3.3 Fragmentos

| Fragmento | Tipo | Condição / efeito |
|---|---|---|
| `E1 - Conta inexistente` | `alt` | `RepositorioUsuario` devolve "conta inexistente" → auditoria de `LOGIN_NEGADO` e recusa (E1). |
| `E2 - Conta bloqueada ou inativa` | `alt` | `podeAutenticar()` = **false** (RN-001) → auditoria e recusa (E2). |
| `E1 - Credencial inválida` | `alt` | `podeAutenticar()` = true e `confereCredencial()` = **false** (RN-002) → auditoria e recusa (E1). |
| `Sucesso - credenciais válidas` | `alt` | Permissões carregadas, sessão criada, `LOGIN_CONCEDIDO` auditado. |
| `A1 (RF-002) - Encerramento de sessão` | `opt` | O usuário pode encerrar a sessão a qualquer momento; invalida a sessão ativa. |

### 3.4 Decisões de modelagem

- A **entidade `Usuario` não autentica**. Ela responde apenas "se pode" e "se a credencial confere" (plano §5.2, revisão FASE5-REV-I2 §7). Criar sessão, invalidar sessão e lidar com credencial protegida é responsabilidade da aplicação (AP-01) e da infraestrutura (IR-01).
- A auditoria é feita **nos quatro desfechos**, incluindo os negativos: é o que fecha RN-009/RNF-004 (PC-12).
- `criarSessao` e `invalidarSessaoAtiva` aparecem como mensagens **internas ao próprio `ServicoAutenticacao`**, porque sessão não é entidade e não pode ser mensagem para um colaborador de domínio.

### 3.5 Divergência a registrar

A análise de persistência do Integrante 4 (`04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md`) menciona `consultarPorLogin` e `compararHash`, enquanto o diagrama usa `obterPorIdentificacao` (IR-01) e `confereCredencial` (OP-02). **A divergência é de nome de operação de infraestrutura, não de comportamento**: a verificação do hash é responsabilidade da entidade `Usuario` (RN-002), e a busca da conta é do repositório. O cotejo está na revisão FASE6-REV-I2.

## 4. SEQ-002 — Agendar atendimento (UC-025 + UC-024/RF-024)

### 4.1 Cenário

> O paciente consulta os horários livres do seu psicólogo; escolhe um; o sistema valida o vínculo e a disponibilidade do slot; **cria o agendamento já `CONFIRMADO`** (RF-025/RF-026), audita e **sempre** solicita o e-mail de confirmação. Se não houver horário, o sistema oferece a entrada na lista de espera (RF-034).

### 4.2 Participantes

`Ator (Paciente)`, `ServicoAgenda` (AP-03), `Vinculo`, `Agenda`, `Agendamento`, `ServicoAuditoria` (AP-02), `RegistroAuditoria`, `ServicoEnvioMensagem` (AP-04).

### 4.3 Fragmentos

| Fragmento | Tipo | Condição / efeito |
|---|---|---|
| `Há horários disponíveis` | `alt` (1º ramo) | Caminho feliz: devolve a lista, segue para `solicitar`. |
| `Horário ainda disponível` | `alt` aninhado | `verificarDisponibilidade` = true → cria **já confirmado**, audita, solicita e-mail. |
| `E1 - Conflito de horário` | `alt` aninhado | O slot foi tomado entre a consulta e a reserva → recusa e sugere outro horário (RF-025). |
| `Envio aceito pelo serviço externo` | `alt` aninhado | `notificar` devolve `entregue`; o agendamento permanece `CONFIRMADO`. |
| `Falha de envio` | `alt` aninhado | `notificar` devolve `falha de envio` → `registrar("FALHA_ENVIO_EMAIL")`; **não desfaz** o agendamento e o envio pode ser repetido (DEC-029 / LAC-14). |
| `A1 - Nenhum horário disponível` | `alt` (2º ramo) | Informa a ausência de horários e oferece a **lista de espera** (RF-034); o fluxo completo está na SEQ-004. |

### 4.4 Decisões de modelagem

- **A consulta vai ao `ServicoAgenda`, não ao `Agendamento`.** O `ServicoAgenda` (AP-03) é o único coordenador do caso: ele consulta, decide, cria, audita e solicita o envio. É o que evita a classe onipotente vedada pelo plano §5.2.
- **O vínculo é consultado antes da agenda** (`estaAutorizado`, OP-22): sem vínculo ATIVO o paciente não tem agenda alheia — é a materialização de RN-003/RN-005.
- **Não há passo de confirmação.** `Agendamento.solicitar` devolve o agendamento **`CONFIRMADO`** (RF-026 / RN-013). A v1.0 tinha um passo `confirmar` separado; ele foi removido porque a situação `SOLICITADO` deixou de existir.
- **A reserva do slot não aparece como mensagem.** O modelo do horário é **slot discreto** (DEC-018) e a associação A17 `Disponibilidade`—`Agendamento` está habilitada; a reserva é interna a `Agendamento.solicitar` e não gera mensagem própria (§8).
- **O envio de e-mail é obrigatório e não bloqueante** (RF-033 / DEC-022): a resposta "entregue | falha de envio" deixa explícito que a falha **não desfaz** o agendamento. Na falha, o serviço registra `"FALHA_ENVIO_EMAIL"` na auditoria e o envio pode ser repetido (DEC-029 / LAC-14). Não existe mais o caráter "condicional" da v1.0.

## 5. SEQ-003 — Cancelar / concluir / registrar falta (UC-027 + UC-035)

### 5.1 Cenário

> O paciente ou o psicólogo consulta seus agendamentos (RF-028) e cancela um deles — desde que **antes do horário marcado**. O sistema audita, **sempre** solicita o e-mail de cancelamento e, se houver fila de espera, **estende** o comportamento ofertando a vaga ao próximo (UC-035). Em outros agendamentos, a sessão é concluída com registro de atendimento, ou registra-se a falta.

### 5.2 Participantes

`Ator (Paciente ou Psicólogo)`, `ServicoAgenda` (AP-03), `Agendamento`, `Atendimento`, `ServicoAuditoria` (AP-02), `RegistroAuditoria`, `ServicoEnvioMensagem` (AP-04), `ServicoListaEspera` (AP-06).

### 5.3 Fragmentos

| Fragmento | Tipo | Condição / efeito |
|---|---|---|
| `Pode ser cancelado` | `alt` (1º ramo) | `podeSerCancelado()` = true → cancela, audita, solicita e-mail e **abre a oferta de vaga** (`<<extend>>` UC-035). |
| `Envio aceito pelo serviço externo` / `Falha de envio` | `alt` aninhado | `entregue` mantém o cancelamento; `falha de envio` → `registrar("FALHA_ENVIO_EMAIL")`, sem desfazer o cancelamento e com envio repetível (DEC-029 / LAC-14). |
| `E1 - Agendamento já realizado ou já cancelado` | `alt` (2º ramo) | Recusa o cancelamento (E1 de UC-027). |
| `<<extend>> UC-035 - Ofertar vaga` | `opt` aninhado | `ServicoAgenda.ofertarVaga(...)` → `ServicoListaEspera` abre **uma** oferta ao primeiro da fila; detalhamento na SEQ-004. |
| `RF-030 - Conclusão da sessão realizada` | `opt` | `estaCancelada()` = false → conclui, registra atendimento (OP-20), audita. |
| `RF-037 - Não comparecimento` | `opt` | `registrarFalta` (OP-18) por ação do psicólogo (DEC-025), com auditoria. |

> Os blocos `opt` são **fluxos alternativos** do mesmo agendamento, não etapas obrigatórias em sequência. A confirmação **não** aparece aqui porque acontece na criação (SEQ-002).

### 5.4 Decisões de modelagem

- **`podeSerCancelado()` é uma operação do `Agendamento` (OP-15)**, não uma condição no serviço: quem conhece a guarda e a situação é a entidade. A guarda agora é **`[antes do horário marcado]`** — **não existe prazo de 2 horas** (revisão da Fase 6; revoga o valor da DEC-012).
- **`estaCancelada()` (OP-16) é consultado antes de concluir**, para materializar **RN-006** (não há atendimento de sessão cancelada) sem duplicar a regra no serviço.
- **`NAO_COMPARECEU` só é alcançável a partir de `CONFIRMADO`** e só por ação do psicólogo (DEC-025 / RF-037). Não há expiração automática.
- **A oferta de vaga é `<<extend>>`, não um caso de uso independente**: ela só existe quando o cancelamento acontece **e** há fila. Por isso aparece como `opt` rotulado `<<extend>>`, e não como participante obrigatório do fluxo.
- **A falha de envio é auditada sem desfazer a operação**: o `alt` aninhado registra `"FALHA_ENVIO_EMAIL"` e o cancelamento segue válido; a repetição do envio é operação de suporte (DEC-029 / LAC-14).

## 6. SEQ-004 — Lista de espera e oferta de vaga (UC-034 a UC-036)

### 6.1 Cenário

> Sem horário disponível, o paciente entra na lista de espera do psicólogo, pode **consultar a própria posição** e **sair da fila** a qualquer momento. A posição é definida **exclusivamente pela ordem de entrada**. Quando um horário é liberado por cancelamento, o sistema oferta a vaga ao **primeiro** da fila, abrindo **uma única oferta** com prazo de aceite; **enquanto a oferta está aberta, o horário fica reservado**. O paciente aceita (o agendamento nasce `CONFIRMADO`), recusa, ou deixa o prazo vencer — nos dois últimos casos a vaga é ofertada ao **próximo**.

### 6.2 Participantes

`Ator (Paciente)`, `ServicoListaEspera` (AP-06), `SolicitacaoEspera`, `ServicoAgenda` (AP-03), `Agendamento`, `ServicoAuditoria` (AP-02), `RegistroAuditoria`, `ServicoEnvioMensagem` (AP-04).

### 6.3 Fragmentos

| Fragmento | Tipo | Condição / efeito |
|---|---|---|
| `<<extend>> do cancelamento` | `opt` | `ServicoAgenda.ofertarVaga(horarioLiberado)` → o serviço da fila é acionado (só existe quando há cancelamento e fila). |
| `Consulta da posição e saída da fila` | `opt` | `consultarPosicao` → `posicaoNaFila` (OP-28) devolve posição e `dataHoraEntrada`; `sairDaFila` → `encerrar(DESISTIU)` (OP-27), com auditoria `"ESPERA_ENCERRADA"` (LAC-13). |
| `Há solicitação na fila e nenhuma oferta aberta` | `alt` (1º ramo) | `proximoDaFila()` (OP-24) + `abrirOferta(horario, prazoAceite)` (OP-25) → `OFERTADA` com o **horário reservado até o prazo**, audita, solicita e-mail. |
| `Fila vazia ou oferta já aberta` | `alt` (2º ramo) | Nenhuma oferta é aberta; o horário permanece no catálogo. Materializa "uma oferta por vez". |
| `Aceite dentro do prazo` | `alt` (1º ramo) | `validarPrazo()` (OP-26) → `ServicoAgenda.agendar(...)` cria o agendamento `CONFIRMADO`, audita, notifica e encerra a solicitação como `ACEITA` (OP-27). |
| `Falha de envio na oferta ou no aceite` | `alt` aninhado | `notificar` devolve `falha de envio` → `registrar("FALHA_ENVIO_EMAIL")`; a oferta e o agendamento continuam válidos (DEC-029 / LAC-14). |
| `Recusa` | `alt` (2º ramo) | `encerrar(RECUSADA)` (OP-27), audita e **reoferta ao próximo** (`ofertarVaga` recursivo). |
| `Prazo de aceite vencido` | `alt` (3º ramo) | `expirarOferta(prazoAceite)` → `EXPIRADA`, audita e **reoferta ao próximo**. |

### 6.4 Decisões de modelagem

- **A fila é por `dataHoraEntrada`**, não por prioridade: `proximoDaFila` devolve sempre a solicitação `AGUARDANDO` mais antiga daquele psicólogo (DEC-027). Não há reordenação manual.
- **`SolicitacaoEspera` é entidade, não serviço.** O estado da fila (`AGUARDANDO`/`OFERTADA`/`ACEITA`/`RECUSADA`/`EXPIRADA`), o prazo e a ordem precisam sobreviver ao processo; guardá-los no serviço seria estado em memória. O serviço `ServicoListaEspera` (AP-06) **coordena**, a entidade **guarda a regra**.
- **"Uma oferta por vez" é verificada antes de abrir** (`opção Fila vazia ou oferta já aberta`): abrir uma segunda oferta violaria a DEC-027 e criaria duas reservas para o mesmo horário (RN-010).
- **O aceite reusa o caminho normal de agendamento** (`ServicoAgenda.agendar` → `Agendamento.solicitar`): não há criação "especial" de agendamento pela fila. Isso mantém RN-005/RN-010/RN-013 em um único lugar.
- **A recusa não pune o paciente**: apenas encerra aquela solicitação. Uma nova entrada futura na fila é permitida (RF-036).
- **Recusa e vencimento reusam a mesma operação** `encerrar(...)` (OP-27), variando a situação final; a reoferta é o mesmo `ofertarVaga`. Não há duplicação de regra.
- **A posição é consultável e a desistência é definitiva.** `consultarPosicao` (AP-06) delega a `posicaoNaFila` (OP-28), que lê a ordem por `dataHoraEntrada`; `sairDaFila` encerra como `DESISTIU` (OP-27) e audita `"ESPERA_ENCERRADA"`. Quem desiste pode entrar de novo — a desistência não pune (LAC-13).
- **A oferta reserva o horário.** `abrirOferta(horario, prazoAceite)` devolve `OFERTADA` com o horário **reservado até o prazo**: enquanto a oferta existir, o slot não aparece como livre. Se a fila acabar (recusa/vencimento sem próximo), o horário volta ao catálogo (LAC-15).

## 7. Cobertura de requisitos e regras

| RF / RN | SEQ-001 | SEQ-002 | SEQ-003 | SEQ-004 |
|---|---|---|---|---|
| RF-001 (autenticar) | ✔ | | | |
| RF-002 (sessão) | ✔ (`opt` A1) | | | |
| RF-024 (horários livres) | | ✔ | | |
| RF-025 (agendar) | | ✔ | | ✔ (aceite) |
| RF-026 (confirmar) | | ✔ | | ✔ (aceite) |
| RF-027 (cancelar) | | | ✔ | ✔ (gatilho) |
| RF-028 (meus agendamentos) | | | ✔ (`consultarMeus`, OP-19) | |
| RF-030 (registrar atendimento) | | | ✔ (`opt`) | |
| RF-032 (auditoria) | ✔ | ✔ | ✔ | ✔ |
| **RF-033 (e-mail)** | | ✔ | ✔ | ✔ |
| **RF-034 (entrar na fila, consultar posição e sair)** | | ✔ (A1) | | ✔ (entrada, `posicaoNaFila`/OP-28 e `DESISTIU`) |
| **RF-035 (ofertar vaga)** | | | ✔ (`<<extend>>`) | ✔ |
| **RF-036 (responder oferta)** | | | | ✔ |
| **RF-037 (não comparecimento)** | | | ✔ | |
| RN-001 (conta bloqueada) | ✔ (E2) | | | |
| RN-002 (credencial/senha) | ✔ (E1) | | | |
| RN-003 (vínculo autoriza acesso) | | ✔ | | ✔ |
| RN-005 (vínculo ATIVO) | | ✔ | | ✔ |
| RN-006 (cancelado ≠ atendido) | | | ✔ | |
| RN-009 (auditoria) | ✔ | ✔ | ✔ | ✔ |
| RN-010 (slot único) | | ✔ (E1) | | ✔ (uma oferta) |
| RN-012 (guarda de cancelamento) | | | ✔ | |
| RN-013 (confirmação automática) | | ✔ | | ✔ (aceite) |
| DEC-022 (nome da fronteira de envio) | | ✔ | ✔ | ✔ |
| DEC-027 (regras da fila) | | | ✔ | ✔ |

## 8. Pendências registradas (não são lacunas desta entrega)

| Pendência | Causa | Efeito no diagrama |
|---|---|---|
| **Incremento de domínio `SolicitacaoEspera` + AP-06** | DEC-027 aprovada na Fase 6 | a SEQ-004 já os usa; o Integrante 3 precisa incorporá-los ao CLS-001 (não existem na Fase 5). |
| **Reserva do slot (A17)** | DEC-018 (slot discreto) — decisão do grupo | a reserva é interna a `Agendamento.solicitar`; na fila, `abrirOferta` devolve o horário **reservado até o prazo** (LAC-15 fechada). |
| **Ressalvas LAC-13, LAC-14 e LAC-15** | **fechadas na v2.1** | a SEQ-004 desenha consulta/saída da fila (`posicaoNaFila`/OP-28, `DESISTIU`) e a reserva; as três sequências desenham `"FALHA_ENVIO_EMAIL"` e a repetição do envio. |
| **Prazo de aceite (valor)** | parâmetro de configuração (DEC-027) | a operação `abrirOferta(prazoAceite)` aparece sem valor numérico; o valor é configuração, não regra de negócio variável por caso. |
| **Prazo de cancelamento** | resolvido: `[antes do horário marcado]` | a guarda não tem valor numérico **por decisão** (não existe prazo de 2 horas). |
| **Canal de notificação** | resolvido: e-mail (RF-033) | `ServicoEnvioMensagem` é fronteira externa (interface), não entidade. |
| **"Preencher encaixe"** | substituído pela lista de espera | a SEQ-004 ocupa o lugar que a v1.0 deixava em aberto; não há mais sequência "não produzida". |

## 9. Como ler e editar

1. A **fonte editável** é o `.mmd` (Mermaid). Ele pode ser aberto em qualquer editor de texto ou renderizado por Mermaid Live.
2. As **hints de layout** `%% pos: <id> <x> <y>` são comentários Mermaid válidos: o Mermaid as ignora, e o renderizador offline do repositório as usa para posicionar os participantes. Ver `03-uml/README.md`.
3. O `.drawio.xml` é gerado a partir do `.mmd` e é o arquivo a ser editado no **draw.io** quando for preciso ajustar o desenho sem mexer no conteúdo.
4. O `.pdf` é a versão congelada para o dossiê.

## 10. Revisão de qualidade (cota do Integrante 5)

- **Confiabilidade:** todos os caminhos de erro das sequências terminam em recusa explícita ao ator e em registro de auditoria — não há caminho de erro silencioso.
- **Exceções:** as exceções de infraestrutura (repositório, envio de mensagem) aparecem como retorno alternativo ("conta inexistente", "falha de envio"), sem criar entidade de exceção no domínio.
- **Segurança/autorização:** a autorização é consultada no serviço (`OP-04`, `OP-22`) e não é assumida pelo ator.
- **Auditoria:** toda operação auditável do plano (RN-009) tem uma mensagem correspondente nos quatro diagramas.
- **Consistência de nomes:** `ServicoEnvioMensagem` é o único nome da fronteira de envio (DEC-022); `ServicoNotificacao` não é mais usado em nenhum artefato da Fase 6.
- **Fila:** a consulta de posição (OP-28), a desistência (`DESISTIU`) e a reserva do horário durante o prazo estão desenhadas; a falha de envio é auditada nos três eventos (DEC-029).
