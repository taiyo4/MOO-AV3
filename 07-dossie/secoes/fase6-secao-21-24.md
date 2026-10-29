# Dossiê — Seções 21, 22, 23 e 24 (texto pronto)

**Responsável:** Integrante 2 (Fase 6) · **Data:** 22/10/2026 · **Versão:** v2.0 (revisão do lote de ajustes da Fase 6).
**Uso:** texto para as seções 21 (Diagramas de sequência), 22 (Diagrama de comunicação), 23 (Diagrama de atividades) e 24 (Máquina de estados) do dossiê final (estrutura do plano §16).
**Regra de inserção de diagramas (plano §16.1):** cada diagrama entra no dossiê com título + identificador, objetivo, elementos principais, como interpretar, decisões de modelagem, relação com requisitos/classes/banco e **referência ao arquivo editável** no repositório. Os **sete** diagramas da Fase 6 têm **PDF e fonte editável (`.drawio.xml`)** versionados em `03-uml/` — ver a convenção de entrega em `03-uml/README.md`; se o grupo quiser PNG/SVG adicional, eles são gerados a partir do `.drawio.xml` no diagrams.net.

> **Estado dos diagramas na data deste texto:** os sete diagramas comportamentais estão em **fase de aprovação**. O que ainda **não** está incorporado é o incremento de domínio da lista de espera (`SolicitacaoEspera`, `ServicoListaEspera` — DEC-027) e as operações `OP-23…OP-27` no diagrama de classes oficial; além disso, o enum `SituacaoAgendamento` do CLS-001 v2 ainda lista `SOLICITADO` e precisa ser alinhado às quatro situações desta entrega (achado **R6-09**, pendência do Integrante 3). Enquanto o grupo não aprovar, o dossiê deve usar a formulação "proposta em revisão" e não "decidido".
>
> **Decisões já resolvidas que este texto aplica:** **DEC-022** (nome único `ServicoEnvioMensagem`), **DEC-025** (não comparecimento manual), **DEC-026** (numeração `UC-0RF`), **DEC-027** (fila por ordem de entrada, uma oferta por vez, prazo, recusa passa ao próximo). As antigas pendências DEC-009 (canal de notificação), DEC-010 ("encaixe") e DEC-012 (prazo de 2 horas) **não existem mais** nesta entrega: o e-mail é obrigatório, o "encaixe" foi substituído pela lista de espera e a guarda de cancelamento é `[antes do horário marcado]`.
>
> **Regra de ausência de dados reais (DEC-005):** nenhum diagrama desta seção contém nome, documento, e-mail ou qualquer identificador de pessoa real — apenas papéis, identificadores de operação e de regra.

---

## 21. Diagramas de sequência

### 21.1 Identificação e objetivo

O plano da AV3 pede "pelo menos três diagramas de sequência para os casos de uso críticos aprovados, garantindo que mensagens, retornos, alternativas e exceções sejam coerentes com os fluxos textuais" (§6.1, Integrante 2). A Fase 6 entrega **quatro** diagramas de sequência — um a mais que o mínimo, para cobrir a lista de espera:

| ID | Título | Caso de uso | RFs cobertos |
|---|---|---|---|
| **SEQ-001** | Autenticar usuário | UC-001 | RF-001, RF-002, RF-032 |
| **SEQ-002** | Agendar atendimento | UC-025 (+ UC-024) | RF-024, RF-025, RF-026, RF-032, RF-033, RF-034 |
| **SEQ-003** | Cancelar / concluir / registrar falta | UC-027 (+ UC-035 `<<extend>>`) | RF-026, RF-027, RF-028, RF-030, RF-032, RF-033, RF-035, RF-037 |
| **SEQ-004** | Lista de espera e oferta de vaga | UC-034, UC-035, UC-036 | RF-025, RF-026, RF-027, RF-032, RF-033, RF-034, RF-035, RF-036 |

O objetivo comum é mostrar **quem fala com quem, em que ordem e sob qual condição**, de modo que cada passo do texto do caso de uso possa ser lido como uma mensagem entre participantes identificados.

### 21.2 SEQ-001 — Autenticar usuário (UC-001)

**Linhas de vida (7):** Ator (paciente, psicólogo ou administrador) · `ServicoAutenticacao` (AP-01) · `RepositorioUsuario` (IR-01) · `Usuario` · `RepositorioAutorizacao` (IR-02) · `ServicoAuditoria` (AP-02) · `RegistroAuditoria`.

**Fluxo:** `autenticar(email, senha)` → `obterPorIdentificacao(identificacao)` → `podeAutenticar()` (OP-01, RN-001) → `confereCredencial(senha)` (OP-02, RN-002) → `obterPermissoes(idUsuario)` → `criarSessao(usuario)` → `registrar("LOGIN_CONCEDIDO" | "LOGIN_NEGADO", …)`.

**Alternativas e exceções:** `alt` **E1 — credencial inválida** (recusa + auditoria `LOGIN_NEGADO`); `alt` **E2 — conta bloqueada ou inativa** (recusa por RN-001 + auditoria); `opt` **A1 — encerrar sessão** (`invalidarSessaoAtiva`, AP-01).

**Volume:** 31 setas (19 solicitações e 12 retornos).

### 21.3 SEQ-002 — Agendar atendimento (UC-025 + UC-024)

**Linhas de vida (8):** Ator (paciente) · `ServicoAgenda` (AP-03) · `Vinculo` · `Agenda` · `Agendamento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04).

**Fluxo:** consulta de horários (`consultarHorariosDisponiveis`, OP-11) → validação do vínculo (`estaAtivo`, OP-22) → escolha do horário → `verificarDisponibilidade(horario)` (RN-010) → `Agendamento.solicitar(...)` → **agendamento devolvido já `CONFIRMADO`** (RF-026 / RN-013) → auditoria → **e-mail de confirmação** → resposta ao ator.

**Alternativas e exceções:** `alt` **A1 — nenhum horário disponível** (informar e **oferecer a lista de espera**, RF-034 / SEQ-004); `alt` **E1 — conflito de horário** (recusa com sugestão de outro horário).

**Volume:** 18 setas (9 solicitações e 9 retornos).

> **Não há passo `confirmar`.** A v1.0 tinha `Agendamento.solicitar` → `confirmar(solicitante)` (OP-13) porque o agendamento nascia `SOLICITADO`. Com a remoção dessa situação, criar e confirmar passam a ser o **mesmo ato**: a mensagem `confirmar` desapareceu da sequência e a situação inicial do EST-001 é `CONFIRMADO`.

### 21.4 SEQ-003 — Cancelar / concluir / registrar falta (UC-027 + UC-035)

**Linhas de vida (8):** Ator (paciente ou psicólogo) · `ServicoAgenda` (AP-03) · `Agendamento` · `Atendimento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04) · `ServicoListaEspera` (AP-06).

**Fluxo do cancelamento:** `consultarMeus(solicitante)` (OP-19, RF-028 / UC-028) → `cancelar(agendamento, motivo)` → `podeSerCancelado()` (OP-15, RN-012) → **guarda `[antes do horário marcado]`** → `cancelar(solicitante, motivo)` (OP-14) → auditoria (`AGENDAMENTO_CANCELADO`) → **e-mail de cancelamento (sempre)** → `opt <<extend>> UC-035` oferta de vaga → resposta ao ator.

**Blocos `opt` alternativos (não são etapas obrigatórias em sequência):** conclusão da sessão realizada (`RF-030`, com `estaCancelada()` — OP-16/RN-006 —, `concluir` — OP-17 — e `Atendimento.registrar` — OP-20) e registro de não comparecimento (`RF-037`, `registrarFalta` — OP-18 — por ação do psicólogo, DEC-025).

**Alternativa:** `alt` **E1 — agendamento já realizado ou já cancelado** (recusa).

**Volume:** 29 setas (18 solicitações e 11 retornos).

> **A oferta de vaga é `<<extend>>`, não um caso de uso independente.** Ela aparece como `opt` **dentro** do ramo "pode ser cancelado" e só existe quando há cancelamento **e** fila (UC-035 / DEC-027). O detalhamento — uma oferta por vez, prazo de aceite, recusa passa ao próximo — está na SEQ-004.
>
> **A notificação do cancelamento é obrigatória e não bloqueante:** a mensagem `notificar(evento=cancelamento)` é sempre enviada; o retorno `entregue | falha de envio` deixa explícito que a falha **não desfaz** o cancelamento (RF-033 / DEC-022).

### 21.5 SEQ-004 — Lista de espera e oferta de vaga (UC-034 a UC-036)

**Linhas de vida (8):** Ator (paciente) · `ServicoListaEspera` (AP-06) · `SolicitacaoEspera` · `ServicoAgenda` (AP-03) · `Agendamento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04).

**Fluxo — entrada na fila:** `entrarNaFila(psicologo, paciente, periodo)` → `registrarEntrada(...)` (OP-23) → solicitação `AGUARDANDO` com `dataHoraEntrada` → auditoria → resposta com a posição (ordem de entrada).

**Fluxo — oferta (`opt <<extend>>` do cancelamento):** `ServicoAgenda.ofertarVaga(horarioLiberado)` → `proximoDaFila(psicologo)` (OP-24) → `alt` **há solicitação e nenhuma oferta aberta** → `abrirOferta(prazoAceite)` (OP-25) → `OFERTADA` → **e-mail de oferta** → auditoria; `else` **fila vazia ou oferta já aberta** → nenhuma oferta é criada.

**Fluxo — resposta (`alt` de três ramos):**

| Ramo | Comportamento |
|---|---|
| **Aceite dentro do prazo** | `validarPrazo()` (OP-26) → `ServicoAgenda.agendar(...)` → `Agendamento.solicitar` **já `CONFIRMADO`** → auditoria → e-mail de confirmação → `encerrar(ACEITA)` (OP-27). |
| **Recusa** | `encerrar(RECUSADA)` (OP-27) → auditoria → **reoferta ao próximo** (`ofertarVaga` recursivo). |
| **Prazo vencido** | `expirarOferta(prazoAceite)` → `EXPIRADA` (OP-27) → auditoria → **reoferta ao próximo**. |

**Volume:** 36 setas (25 solicitações e 11 retornos).

> **Por que a SEQ-004 existe.** Na v1.0 a sequência do "encaixe" estava bloqueada pela DEC-010. A DEC-027 resolveu a questão: o "encaixe" foi **substituído pela lista de espera**, com regras explícitas, e por isso a quarta sequência passou a ser obrigatória — ela é a única que mostra `SolicitacaoEspera`, OP-23…OP-27 e AP-06.

### 21.6 Como interpretar

1. **A linha de vida é a unidade de responsabilidade.** `ServicoAgenda`, `ServicoAuditoria`, `ServicoAutenticacao`, `ServicoListaEspera` e `ServicoEnvioMensagem` são **responsabilidades de aplicação** (AP-01 a AP-06): concentram a orquestração e ficam **fora** do diagrama de classes de domínio, conforme o plano §5.2. As entidades (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `SolicitacaoEspera`, `RegistroAuditoria`) carregam as regras.
2. **Toda mensagem remete a uma operação ou responsabilidade conhecida.** As **114 setas** dos quatro diagramas (71 solicitações e 43 retornos) foram conferidas uma a uma contra as operações `OP-01…OP-27`, as responsabilidades `AP-01…AP-06` e as interfaces de infraestrutura `IR-01`/`IR-02`. Não existe mensagem "inventada para satisfazer um diagrama futuro" (plano §8).
3. **A seta tracejada é o retorno** (`-->>`) e não conta como mensagem nova na contagem.
4. **`alt` é alternativa de fluxo, `opt` é bloco condicional**, e ambos refletem o texto do caso de uso — nenhuma alternativa existe só no diagrama.
5. **As guardas aparecem entre colchetes** na própria mensagem (`[OP-15 / RN-012]`), de modo que a regra fica legível sem consultar a matriz.
6. **Repositórios são infraestrutura**, não domínio: aparecem como `RepositorioUsuario` e `RepositorioAutorizacao`, e apenas carregam dados.
7. **O e-mail é sempre solicitado** (RF-033) nos três eventos de agenda — confirmação, cancelamento e oferta de vaga. A resposta `entregue | falha de envio` é **retorno**, não desfaz a operação e não gera transição de estado.

### 21.7 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| A entidade decide, o repositório carrega | `podeAutenticar()` (OP-01) e `confereCredencial()` (OP-02) estão na entidade `Usuario`, não no repositório | plano §5.2, RN-001/RN-002 (achado **R6-03**) |
| Agendamento nasce `CONFIRMADO` | `Agendamento.solicitar` cria e confirma no mesmo ato; **não existe** mensagem `confirmar` nem situação `SOLICITADO` | RF-025 + RF-026, RN-013, DEC-016 revista |
| Notificação é fronteira externa **obrigatória** | `ServicoEnvioMensagem` é interface (DEC-022); o envio é sempre solicitado e a falha não bloqueia | RF-033, DEC-022, TRS-02 do Integrante 4 |
| Auditoria como efeito transversal | `registrar(...)` é sempre delegado a `ServicoAuditoria` e nunca executado "de dentro" da entidade | RN-009, RN-014 |
| Sessão fora do domínio | `criarSessao` / `invalidarSessaoAtiva` são responsabilidade de aplicação | RF-002, P-07 |
| Cancelamento exige verificação prévia | `podeSerCancelado()` (OP-15) é consultada antes de `cancelar` (OP-14), com guarda **`[antes do horário marcado]`** | RN-012, DEC-012 revista |
| Oferta de vaga é `<<extend>>` | o `opt` de UC-035 fica **dentro** do ramo de cancelamento, não é participante obrigatório | UC-035, DEC-027 |
| Lista de espera é domínio | `SolicitacaoEspera` tem estado persistente, ordem e prazo → entidade; `ServicoListaEspera` (AP-06) coordena | DEC-027 |
| "Não compareceu" é manual | bloco `opt` próprio, iniciado pelo psicólogo, sem expiração automática | RF-037, DEC-025 |

### 21.8 Relação com requisitos, classes e banco

Cada mensagem dos quatro diagramas corresponde a uma **operação do modelo de classes** (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `SolicitacaoEspera`, `RegistroAuditoria`), a uma responsabilidade de aplicação (`AP-01…AP-06`) ou a uma interface de infraestrutura (`IR-01`/`IR-02`) — a matriz completa está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (§2.1 a §2.4). No banco, os mesmos passos correspondem às tabelas `usuario`, `vinculo`, `agendamento`, `atendimento`, `solicitacao_espera` e `registro_auditoria` (seção 26 do dossiê); o envio de e-mail **não** tem tabela, por ser serviço externo (DEC-022).

### 21.9 Arquivos

| Artefato | Arquivo |
|---|---|
| SEQ-001 (fonte, editável e PDF) | `03-uml/Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-002 | `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-003 | `03-uml/Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-004 | `03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd` · `.drawio.xml` · `.pdf` |
| Especificação das quatro | `03-uml/Sequências/proposta-I2-especificacao-sequencias.md` |
| Casos de uso novos/revisados | `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` |
| Revisão da fase | `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` |

---

## 22. Diagrama de comunicação

### 22.1 Identificação e objetivo

**COM-001 — Diagrama de comunicação: ciclo do agendamento.**
O diagrama de comunicação representa **a mesma informação** do diagrama de sequência, mas com o foco invertido: em vez de mostrar a ordem no tempo, mostra **quais objetos colaboram** e **qual objeto coordena a colaboração**. Ele atende ao item do plano §6.1 ("diagrama de comunicação para um cenário relevante") e cumpre a função de **checagem cruzada**: o cenário é o mesmo da SEQ-002, da SEQ-003, da SEQ-004 e do ATV-001, de modo que qualquer objeto ou mensagem que apareça em um e não em outro fica evidente.

**Cenário:** "Agendar, cancelar e concluir atendimento" (UC-024 + UC-025 + UC-027 + UC-035).

### 22.2 Elementos principais

**Quatorze colaboradores**, com natureza indicada pela forma:

| Colaborador | Natureza | Papel no cenário |
|---|---|---|
| `Paciente` | fronteira externa | solicita e cancela |
| `Psicólogo` | fronteira externa | conclui o atendimento |
| **`Serviço Externo de E-mail`** (`ServicoEnvioMensagem`) | **fronteira externa** | envia confirmação, cancelamento e oferta de vaga (AP-04 / RF-033) |
| `Usuario` | entidade de domínio | sobre o qual recai a autorização por operação (OP-04) |
| `ServicoAgenda` | **serviço de aplicação (hub)** | coordena o cenário (AP-03) |
| `ServicoAuditoria` | serviço de aplicação | trilha (AP-02) |
| **`ServicoListaEspera`** | **serviço de aplicação** (AP-06) | coordena a fila e a oferta de vaga (DEC-027) |
| `Vinculo` | entidade de domínio | autorização do vínculo (OP-22) |
| `Agenda` | entidade de domínio | catálogo de horários (OP-11) |
| `Disponibilidade` | entidade de domínio | slots ofertados (A09) |
| `Agendamento` | entidade de domínio | compromisso e seu ciclo (OP-14) |
| **`SolicitacaoEspera`** | **entidade de domínio** (DEC-027) | fila, ordem de entrada e prazo (OP-24) |
| `Atendimento` | entidade de domínio | registro da sessão (OP-20) |
| `RegistroAuditoria` | entidade de domínio | registro imutável (RF-032) |

**Leitura das formas:** `[ ]` entidade de domínio · `{ }` serviço de aplicação · `( )` fronteira (ator ou serviço externo).

> **Mudança em relação à v1.0:** `ServicoNotificacao` foi renomeado para **`ServicoEnvioMensagem`** (DEC-022) e ganhou o rótulo "Serviço Externo de E-mail"; entraram `ServicoListaEspera` e `SolicitacaoEspera` (DEC-027). O diagrama passa de **12 colaboradores e 14 mensagens** para **14 colaboradores e 17 mensagens**.

### 22.3 Como interpretar

As **17 mensagens** estão numeradas na ordem de ocorrência, e cada seta carrega a identificação da operação e a regra/requisito que a origina:

| # | Emissor → Receptor | Mensagem | Origem |
|---|---|---|---|
| 1 | `Paciente` → `ServicoAgenda` | `solicitar(horario)` | RF-025 |
| 2 | `ServicoAgenda` → `Usuario` | `consultarPermitidos()` | OP-04 |
| 3 | `ServicoAgenda` → `Vinculo` | `estaAtivo()` | OP-22 / RN-003 |
| 4 | `ServicoAgenda` → `Agenda` | `consultarHorarios()` | OP-11 |
| 5 | `Agenda` → `Disponibilidade` | `slots livres` | A09 |
| 6 | `ServicoAgenda` → `Agenda` | `verificarDisponibilidade()` | RN-005 |
| 7 | `ServicoAgenda` → `Agendamento` | `solicitar(horario)` | RF-025 (cria `CONFIRMADO`) |
| 8 | `ServicoAgenda` → `ServicoAuditoria` | `registrar(criacao)` | AP-02 |
| 9 | `ServicoAuditoria` → `RegistroAuditoria` | `registrar(tabela)` | RF-032 |
| 10 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(confirmacao)` | RF-033 |
| 11 | `ServicoAgenda` → `Agendamento` | `cancelar(motivo)` | OP-14 (antes do horário) |
| 12 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(cancelamento)` | RF-033 |
| 13 | `ServicoAgenda` → `ServicoListaEspera` | `ofertarVaga()` | RF-035 / DEC-027 |
| 14 | `ServicoListaEspera` → `SolicitacaoEspera` | `proximoDaFila()` | OP-24 (ordem de entrada) |
| 15 | `ServicoListaEspera` → `Serviço Externo de E-mail` | `notificar(ofertaVaga)` | RF-033 |
| 16 | `Psicólogo` → `ServicoAgenda` | `concluir(agendamento)` | RF-030 |
| 17 | `ServicoAgenda` → `Atendimento` | `registrar(atendimento)` | OP-20 |

**Vínculos com mais de uma mensagem:** 4 e 6 (`ServicoAgenda`—`Agenda`), 7 e 11 (`ServicoAgenda`—`Agendamento`) e 10/12 (`ServicoAgenda`—`E-mail`) percorrem o **mesmo vínculo**. A ordem é dada pela **numeração**, não pela posição da seta — limitação do renderizador offline, que desenha retas sem deslocamento lateral. **Os retornos** (valores devolvidos pelos colaboradores, inclusive "agendamento `CONFIRMADO`" e "entregue | falha de envio") **não** geram seta própria: percorrem o vínculo no sentido inverso, como manda a notação de comunicação.

**O `ServicoAgenda` é o hub** do diagrama: todas as mensagens que disparam regra passam por ele, e é ele que aciona auditoria e envio de mensagem. Isso é proposital — é a materialização da regra do plano §5.2 contra a **classe onipotente**: o poder de decisão fica dividido entre `ServicoAgenda` (orquestração), as entidades (regras), `ServicoAuditoria`/`ServicoEnvioMensagem` (efeitos) e `ServicoListaEspera` (fila).

### 22.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Um único diagrama de comunicação | o plano pede "um cenário relevante"; o cenário do agendamento é o de maior densidade de objetos | plano §6.1 |
| `ServicoAgenda` como hub | concentração da coordenação sem concentração de regra | plano §5.2 (AP-03) |
| Retornos não geram seta | o grafo tem 17 arestas (mensagens), não 17 diálogos com resposta | notação de diagrama de comunicação |
| Notificação como fronteira externa | `ServicoEnvioMensagem` é interface, não entidade; o rótulo diz "Serviço Externo de E-mail" | DEC-022, RF-033 |
| A notificação sai do hub (10, 12) e da fila (15) | notificar é efeito de aplicação, não regra do domínio | RF-033, TRS-02 |
| Oferta de vaga vem do hub para `ServicoListaEspera` (13) | é `<<extend>>` do cancelamento, não um caso iniciado por ator | UC-035, DEC-027 |
| Autorização por operação (OP-04) separada das permissões da sessão | `consultarPermitidos` ≠ `obterPermissoes` | achado **R6-04** |

### 22.5 Relação com requisitos, classes e banco

Os quatorze colaboradores são **dez classes do modelo de domínio** (`Usuario`, `Vinculo`, `Agenda`, `Disponibilidade`, `Agendamento`, `SolicitacaoEspera`, `Atendimento`, `RegistroAuditoria` e demais) e **responsabilidades de aplicação/fronteira** (`ServicoAgenda`, `ServicoAuditoria`, `ServicoListaEspera`, `ServicoEnvioMensagem`) — nenhuma classe nova foi criada além do incremento da DEC-027. As mensagens 1 a 17 correspondem, uma a uma, aos passos da SEQ-002, da SEQ-003, da SEQ-004 e às atividades do ATV-001; a correspondência está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.5.

### 22.6 Arquivos

| Artefato | Arquivo |
|---|---|
| COM-001 (fonte, editável e PDF) | `03-uml/Comunicação/proposta-I2-comunicacao-com-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Comunicação/proposta-I2-especificacao-comunicacao.md` |

---

## 23. Diagrama de atividades

### 23.1 Identificação e objetivo

**ATV-001 — Diagrama de atividades: ciclo do agendamento.**
O plano §6.1 pede "o diagrama de atividades com decisões, responsabilidades e paralelismo quando aplicável". O ATV-001 representa o **fluxo de negócio** do agendamento — do pedido do horário até a conclusão, o cancelamento ou a falta — destacando **quem** executa cada passo (**responsabilidade**) e **onde** a regra decide (**decisões**).

### 23.2 Elementos principais

- **Quatro pistas (swimlanes):** *Paciente* · *Sistema (aplicação e domínio)* · *Psicólogo* · **Auditoria, notificação e extensão**. A quarta pista mudou de nome na v2.0 porque passou a conter também a **oferta de vaga** (a extensão do cancelamento), além de auditoria e notificação.
- **Quatro decisões:** `d1` (Há horários?), `d2` (Vínculo OK?), `d3` (Cancelamento? — inclui a guarda "antes do horário marcado"), `d5` (Sessão realizada?).
- **Três blocos paralelos (fork/join):**

| Bloco | Gatilho | Ramos paralelos | Join |
|---|---|---|---|
| `fork1`/`join1` | Criar agendamento (CONFIRMADO) | auditar criação ‖ notificar confirmação | `join1` |
| `fork2`/`join2` | Cancelar (OP-14) | liberar horário ‖ auditar cancelamento | `join2` |
| `fork3`/`join3` | Registrar atendimento (OP-20) | concluir (OP-17) ‖ auditar conclusão | `join3` |

- **Duas etapas sequenciais** entre o `join2` e o fim do bloco de cancelamento: `Notificar cancelamento (RF-033)` → `Ofertar vaga se houver fila (UC-035)`. A notificação só pode ocorrer depois que o cancelamento está gravado e auditado (pós-commit, TRS-02) e antes da oferta; a oferta só pode ocorrer depois do slot liberado e da notificação (ordem idêntica à da SEQ-003: `registrar` → `notificar` → `ofertar`).
- **A condição "se houver fila" fica no rótulo do nó**, e não em um quinto losango: o `<<extend>>` é opcional por definição e não altera o caminho principal.

### 23.3 Como interpretar

1. **A pista mostra a responsabilidade, não o objeto.** Uma atividade pode ser executada por uma entidade de domínio (`Criar agendamento (CONFIRMADO)`) ou por um serviço de aplicação (`Auditar criação`).
2. **O losango é uma decisão da regra**, e o texto no losango é curto por limitação de espaço; a condição completa está na especificação do diagrama e no caso de uso.
3. **A barra de paralelismo indica independência de regra**, não transação única: o paralelismo é lógico. A fronteira transacional é responsabilidade da camada de persistência (Fase 7) e é explicitamente o que o TRS-02 do Integrante 4 restringe.
4. **Cada rota tem um `Fim`** — a notação de atividade exige fim explícito em cada rota terminal (sem horários, recusa, cancelamento, sessão realizada e falta = 5 nós `Fim`).
5. **O cancelamento e a sessão realizada são alternativas**, não etapas em sequência: `d3` separa "o paciente cancela" de "o paciente mantém".
6. **Não existe atividade de "confirmar".** A criação já produz o agendamento `CONFIRMADO`; o antigo par `Criar → Confirmar (OP-13)` foi colapsado em um único nó.

### 23.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Quatro pistas, e não duas | separa a regra de negócio dos efeitos transversais e da extensão | plano §5.2 |
| "Liberar horário" aparece só no cancelamento | é consequência da regra (RN-012/RN-010) sobre o catálogo de disponibilidade, não uma mensagem a um serviço de aplicação | RN-010, RN-012 |
| Notificação do cancelamento sequencial, antes da oferta | mantém a ordem *auditar → notificar → ofertar* do SEQ-003 | TRS-02, RF-033, achado **R6-05** |
| Oferta de vaga na pista de extensão e **sem 5º losango** | é `<<extend>>` do cancelamento; a condição "se houver fila" está no rótulo | UC-035, DEC-027 |
| Auditoria e notificação sempre executadas | efeitos obrigatórios: auditoria (RN-009) e e-mail (RF-033), sem caráter condicional | RN-009, RF-033 |
| Sem sessão como atividade | sessão está fora do domínio | plano §5.2, P-07 |
| Decisões `d1`, `d2`, `d3`, `d5` | uma decisão por desvio de rota do caso de uso | UC-024, UC-025, UC-027 |

### 23.5 Relação com requisitos, classes e banco

Cada atividade do ATV-001 corresponde a uma operação de domínio, a uma responsabilidade de aplicação ou a um efeito de regra (matriz `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.6). Nenhuma atividade existe sem origem: os **37 nós** do diagrama são **1 início + 21 atividades + 4 decisões + 3 forks + 3 joins + 5 nós `Fim`**, ligados por **39 arestas**. As atividades de consulta de horário e de registro de atendimento correspondem, no banco, a leituras e escritas em `disponibilidade`, `agendamento` e `atendimento` (seção 26); a oferta de vaga corresponde a `solicitacao_espera`.

### 23.6 Arquivos

| Artefato | Arquivo |
|---|---|
| ATV-001 (fonte, editável e PDF) | `03-uml/Atividade/proposta-I2-atividade-atv-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Atividade/proposta-I2-especificacao-atividade.md` |

---

## 24. Máquina de estados

### 24.1 Identificação e objetivo

**EST-001 — Máquina de estados do `Agendamento`.**
O §6.1 do plano pede a máquina de estados de uma entidade relevante, com **eventos, condições e ações nas transições**. O EST-001 fixa o ciclo de vida da situação do compromisso, usando exatamente as **quatro situações** do enumerado `SituacaoAgendamento` (CLS-001 v2): `CONFIRMADO`, `REALIZADO`, `CANCELADO` e `NAO_COMPARECEU`.

### 24.2 Elementos principais

**Quatro situações** — os valores do enumerado `SituacaoAgendamento` e da coluna `agendamento.status` do banco:

| Situação | Significado | Pode sair? |
|---|---|---|
| `CONFIRMADO` | horário reservado e confirmado — **situação inicial** | Sim (3 transições) |
| `REALIZADO` | sessão realizada e registrada | **Não** (terminal) |
| `CANCELADO` | cancelamento antes do horário marcado | **Não** (terminal) |
| `NAO_COMPARECEU` | falta registrada pelo psicólogo | **Não** (terminal) |

**Quatro transições** (uma de criação + três de saída):

| # | Transição | Evento | Guarda | Operação |
|---|---|---|---|---|
| **T0** (criação) | `[*] → CONFIRMADO` | `solicitar` | `[vínculo ATIVO e slot livre]` | `Agendamento.solicitar` (RF-025 / RF-026 / RN-013) |
| **T1** | `CONFIRMADO → CANCELADO` | `cancelar` | **`[antes do horário marcado]`** | OP-14 / OP-15 (RN-012) |
| **T2** | `CONFIRMADO → REALIZADO` | `concluir` | `[atendimento registrado]` | OP-17 / OP-20 (RF-030) |
| **T3** | `CONFIRMADO → NAO_COMPARECEU` | `registrarFalta` | `[horário já passou; ação do psicólogo]` | OP-18 (RF-037 / DEC-025) |

### 24.3 Como interpretar

1. **`CONFIRMADO` é o estado inicial** e `REALIZADO`, `CANCELADO` e `NAO_COMPARECEU` são **terminais**: não há retorno de um compromisso encerrado.
2. **O evento é a causa; a guarda é a condição.** `cancelar` só se aplica a `CONFIRMADO` e **antes do horário marcado**; depois do início, o compromisso só pode terminar como `REALIZADO` ou `NAO_COMPARECEU`.
3. **A ausência de transição é uma informação**: não existe `CONFIRMADO → SOLICITADO` nem qualquer retorno a `CONFIRMADO`; a correção de um encerramento é um **novo agendamento**.
4. **Não existe transição de cancelamento a partir de `REALIZADO`**: um atendimento realizado não é "des-cancelado" nem "des-realizado".
5. **A oferta de vaga não é transição**: é efeito colateral de T1 (ver §24.5).

### 24.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| **Quatro situações, três terminais** | o compromisso encerrado não volta | plano §5.4, DEC-016 revista |
| **`CONFIRMADO` é a situação inicial** | não há passo de aprovação; criação e confirmação são o mesmo ato | RF-025 + RF-026, RN-013 |
| `NAO_COMPARECEU` só a partir de `CONFIRMADO` | fecha a INC-13 do Integrante 4 e a pergunta P-14 | INC-13, RF-037, DEC-025 |
| **Guarda `[antes do horário marcado]`** | não existe prazo de 2 horas; a condição é o início do horário | RN-012, DEC-012 revista |
| **Sem situação "aguardando aprovação"/`SOLICITADO`** | não há aprovação manual nem confirmação posterior no escopo | RN-013 |
| **A máquina tem 4 situações e 4 transições** (T0–T3) | qualquer contagem diferente em outro artefato é divergência a corrigir | esta entrega |

### 24.5 Relação com requisitos, classes e banco

As quatro situações são os valores do enumerado `SituacaoAgendamento` (modelo de classes, seção 19) e correspondem à coluna `agendamento.status` do modelo relacional (seção 26, com a restrição de domínio correspondente). Cada transição tem operação de origem (Tabela §2.7 da matriz da Fase 6) e caso de uso associado (UC-025, UC-027 ou UC-037). Nenhuma situação existe sem atributo persistível e nenhuma transição existe sem operação.

**A oferta de vaga não é transição:** o agendamento cancelado permanece `CANCELADO`; a fila e o prazo de aceite vivem em `SolicitacaoEspera` (SEQ-004). Tentar representá-la como estado do agendamento duplicaria o ciclo de vida em duas entidades.

**Pendência registrada (não é lacuna desta entrega):** o enum `SituacaoAgendamento` do CLS-001 v2 e o diagrama de objetos da Fase 5 ainda listam `SOLICITADO`. A máquina e os diagramas da Fase 6 já estão alinhados às quatro situações; o **Integrante 3** precisa remover o valor do enum e do diagrama de objetos ao incorporar a proposta (achado **R6-09**).

### 24.6 Arquivos

| Artefato | Arquivo |
|---|---|
| EST-001 (fonte, editável e PDF) | `03-uml/Estados/proposta-I2-estados-est-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Estados/proposta-I2-especificacao-estados.md` |

---

## Nota de consolidação para o Integrante 6

Ao montar o dossiê final:

1. **Inserir as sete figuras** nas seções 21 a 24, usando o `.pdf` correspondente e **mantendo a identificação** (`SEQ-001`, `SEQ-002`, `SEQ-003`, `SEQ-004`, `COM-001`, `ATV-001`, `EST-001`) nas legendas, para que a matriz de rastreabilidade (seção 31) possa referenciá-las.
2. **Conservar as ressalvas de estado**: o texto deve continuar dizendo "proposta em revisão" enquanto o Integrante 3 não incorporar ao CLS-001 o incremento da lista de espera (`SolicitacaoEspera`, `ServicoListaEspera`/AP-06, `OP-23…OP-27`) e não remover `SOLICITADO` do enum e do diagrama de objetos (achado **R6-09**). As antigas pendências DEC-009, DEC-010 e DEC-012 **não devem ser citadas** como abertas: foram resolvidas ou revogadas por este lote.
3. **Não remeter lacunas que já não existem.** A sequência do "encaixe" foi substituída pela **SEQ-004** (lista de espera, DEC-027); o prazo de cancelamento é a guarda `[antes do horário marcado]`; o canal de notificação é o e-mail (RF-033); e a reserva de slot continua registrada como pendência de P-05. O que sobra vai para a seção de revisões/decisões, não para o corpo dos diagramas.
4. **Não inserir PNG/SVG separados**: o repositório entrega `.mmd` (fonte do conteúdo), `.drawio.xml` (editável) e `.pdf` (dossiê), com o **mesmo nome-base**. Se uma versão vetorial for necessária, gerar a partir do `.drawio.xml` no diagrams.net.
5. **Conferências automáticas feitas na Fase 6:** XML bem formado nos **sete** arquivos, **1 página por PDF**, ausência de sobreposição de caixas e de arestas atravessando caixas, e conferência do texto extraído de cada PDF contra o conteúdo do `.mmd`.
6. **Contagens fechadas nesta versão** (para conferência rápida do revisor): sequências **4** (7 + 8 + 8 + 8 linhas de vida; **114 setas** = 71 solicitações + 43 retornos); comunicação **14 colaboradores / 17 mensagens**; atividades **4 pistas / 37 nós / 39 arestas** (1 início, 21 atividades, 4 decisões, 3 forks, 3 joins, 5 fins); estados **4 situações / 4 transições** (T0 criação + T1–T3).
