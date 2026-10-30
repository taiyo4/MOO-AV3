# Fase 6 — Revisão dos diagramas comportamentais (Integrante 2)

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.1 (revisão do lote de ajustes da Fase 6 + fechamento de R6-11/12/13 e LAC-13/14/15).
**Tarefa do plano atendida:** Fase 6, bloco do Integrante 2 (plano §6.1):
criar pelo menos três diagramas de sequência para os casos de uso críticos aprovados; garantir que mensagens, retornos, alternativas e exceções sejam coerentes com os fluxos textuais; criar o diagrama de atividades com decisões, responsabilidades e paralelismo; criar o diagrama de comunicação para um cenário relevante; criar a máquina de estados de `Agendamento`; **comparar todos os diagramas comportamentais entre si e corrigir divergências**; atualizar a matriz de rastreabilidade com os diagramas.

> **O que mudou da v1.0 para a v2.0 (lote de ajustes do grupo):**
> 1. `SOLICITADO` **deixou de existir** — o agendamento nasce `CONFIRMADO` (DEC-016 + DEC-017, P-01 resolvida). EST-001 = **4 situações / 4 transições** (T0 criação + T1–T3).
> 2. A guarda de cancelamento é **`[antes do horário marcado]`**; não há antecedência mínima e o Administrador não cancela (DEC-011 + DEC-028; a DEC-012 não foi adotada).
> 3. O e-mail é **obrigatório nos três eventos** (confirmação, cancelamento, oferta de vaga); a falha **não desfaz** a operação, é **registrada na auditoria** e pode ser **repetida** (DEC-009 + DEC-029, RF-033). Nome único: **`ServicoEnvioMensagem`** (DEC-022).
> 4. Entraram **4 casos de uso novos** (UC-028, UC-033, UC-034, UC-036, UC-037) e a **SEQ-004** (lista de espera, DEC-027); a oferta de vaga é **`<<extend>>` do cancelamento** (UC-035).
> 5. A numeração dos casos passou a **`UC-0RF`** (DEC-026) e cada especificação abriu com **Objetivo** e **RFs cobertos**.
> 6. O ATV-001 ganhou a 4ª pista renomeada (**"Auditoria, notificação e extensão"**) e duas etapas sequenciais após o `join2`: **notificar → ofertar vaga**.

---

## 1. Objetivo, escopo e limites desta revisão

Esta é uma **revisão de consistência comportamental**. Ela não redesenha o modelo de domínio (Fase 5) nem a persistência (Integrante 4): ela verifica se os **sete diagramas da Fase 6 contam a mesma história**, se toda mensagem tem origem em operação ou responsabilidade conhecida, e se os diagramas respeitam as decisões do grupo — inclusive as que mudaram neste lote.

Limites declarados:

- Não se altera nenhum artefato de fase anterior: o modelo de classes oficial, o diagrama de casos de uso, os casos de uso da Fase 3/4 e as matrizes existentes permanecem como estão. Quando um artefato oficial precisa mudar, o achado é **registrado** (ex.: R6-09, enum `SituacaoAgendamento`).
- Não se aprovam requisitos, regras ou decisões: as divergências são **registradas e propostas**. O que o grupo já decidiu (DEC-022, DEC-025, DEC-026, DEC-027) é **aplicado**; o que continua aberto (P-05, multiplicidades) é **declarado**.
- **Exceção deliberada à v1.0:** esta fase **criou** operações, uma responsabilidade de aplicação e uma entidade — OP-23…OP-28, AP-06 e `SolicitacaoEspera` — porque a DEC-027 exigiu a lista de espera e não havia como desenhá-la com o vocabulário da Fase 5. A criação é declarada, rastreada e entregue ao Integrante 3 para incorporação (não é invenção silenciosa).
- Não há dados reais (DEC-005) em nenhum artefato: os diagramas usam rótulos de operação e identificadores de regra, nunca nomes, documentos ou e-mails.

Numeração de achados: **R6-xx** = achado desta revisão (local). Os demais prefixos são herdados da Fase 5 (**R5-xx**), do Integrante 3 (**PC-xx**), do Integrante 4 (**P-xx**, **INC-xx**, **TRS-xx**, **ARQ-xx**) e do grupo (**DEC-xxx**).

---

## 2. Fontes inspecionadas

| Artefato | Caminho | Uso nesta revisão |
|---|---|---|
| Plano de execução | `00-plano/` (PDF do plano) | Fase 6, §5.3, §5.4, §6.1, §13, §16, §16.1, §19 |
| Especificações dos casos críticos | `03-uml/Casos de uso/especificacoes-casos-de-uso-criticos.md` | UC-001, UC-021, UC-025, UC-027 — fluxos textuais |
| Especificações dos demais casos | `03-uml/Casos de uso/especificacoes-casos-de-uso-demais.md` | UC-024, UC-028, UC-029, UC-032, UC-033 |
| **Casos de uso novos/revisados (I2)** | `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` | **UC-028, UC-033, UC-034, UC-035, UC-036, UC-037** + revisão de UC-025/UC-027 |
| Requisitos funcionais | `02-requisitos/requisitos-funcionais.md` | RF-001 a RF-032 + **RF-033 a RF-037** (§8) |
| Regras de negócio | `02-requisitos/regras-negocio.md` | RN-001 a RN-014 |
| Critérios de aceite | `02-requisitos/criterios-aceite.md` | CA-RF-xxx |
| Modelo de classes (oficial) | `03-uml/Classes/diagrama-classes.mmd` | Operações existentes, multiplicidades `PENDENTE` |
| Modelo de classes (proposta I2, Fase 5) | `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` §5.2 | OP-01…OP-22 e AP-01…AP-05 (as propostas em `.mmd` foram retiradas do repositório em 28/10/2026; ver R6-09) |
| Revisão da Fase 5 | `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` | §5.2 (AP-01…AP-05), §5.3 (mensagens previstas), §6.1 (transições), §9 |
| Análise de impacto comportamental (I4) | `04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md` | INC-13, TRS-02, ARQ-07, operações de infraestrutura |
| Matriz da Fase 5 | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` | Colunas herdadas (classe, operação, tabela, CT) |
| **Decisões do grupo** | `01-planejamento/decisoes.md` | DEC-001…DEC-030 — em especial **DEC-009 + DEC-029** (e-mail e falha), **DEC-010 + DEC-027** (lista de espera), **DEC-011 + DEC-028** (cancelamento), **DEC-016 + DEC-017** (situações e confirmação), **DEC-018** (slot discreto), **DEC-019** (conta—perfil), **DEC-020** (sessão), **DEC-022** (`ServicoEnvioMensagem`), **DEC-025** (falta manual), **DEC-026** (`UC-0RF`) e **DEC-030** (atendimento) |

---

## 3. Método e critérios

O método foi o de **confrontar cada artefato comportamental contra os outros**, na ordem que o plano §6.1 pede:

1. **Teste de elegibilidade da mensagem** — toda mensagem (sequência, comunicação) e toda atividade devem remeter a uma operação OP-xx, a uma responsabilidade de aplicação AP-xx ou a uma interface de infraestrutura IR-xx. Mensagem sem origem = **defeito**.
2. **Teste de cobertura do caso crítico** — para cada caso de uso (UC-001, UC-021, UC-025, UC-027 e os novos UC-028/033/034/035/036/037), o conjunto {SEQ, ATV, COM, EST} deve cobrir **todos os passos observáveis** do fluxo textual, incluindo **alternativas** e **exceções**.
3. **Teste de coerência cruzada** — um mesmo comportamento deve aparecer com **o mesmo nome de operação**, **a mesma regra** e **o mesmo efeito** nos sete diagramas.
4. **Teste de correspondência com a persistência** — as operações de infraestrutura citadas pelo Integrante 4 (`consultarPorLogin`, `compararHash`, `verificarSituacao`, `obterPermissoes`, `notificar`) devem ter um papel inequívoco frente às operações de domínio OP-xx.
5. **Teste de não invenção** — nenhum diagrama pode conter mensagem, estado ou atividade que não esteja ancorada em RF/RN/UC/DEC. O que foi criado neste lote (OP-23…OP-28, AP-06, `SolicitacaoEspera`) está ancorado na **DEC-027** e declarado.
6. **Teste de obrigatoriedade do efeito** — auditoria (RN-009) e e-mail (RF-033) **não podem** aparecer como condicionais ou opcionais onde a regra manda sempre executar.

Veredictos usados: **OK** · **DIVERGENTE** (corrigido nesta fase) · **PENDENTE** (decisão do grupo) · **NÃO DESSENHÁVEL** (bloqueado por decisão) · **NÃO INCORPORADO** (existe na proposta, falta no artefato oficial).

---

## 4. Resultado 1 — Cobertura dos casos de uso pelos diagramas

### 4.1 UC-001 — Autenticar usuário

| Passo do fluxo (fonte: UC-001) | Artefato | Veredicto | Observação |
|---|---|---|---|
| Usuário informa identificação e senha | SEQ-001, msg. 1 (`autenticar`) | **OK** | AP-01 — a entidade não autentica (plano §5.2). |
| Sistema busca a conta cadastrada | SEQ-001, msg. 2 (`obterPorIdentificacao`) | **OK** | IR-01 — infraestrutura, Fase 7. Ver R6-02. |
| Sistema valida se a conta está ativa/bloqueada | SEQ-001, msg. 3 (`podeAutenticar`) | **OK** | OP-01 — RN-001 materializado na entidade. Ver R6-03. |
| Sistema confere a credencial | SEQ-001, msg. 4 (`confereCredencial`) | **OK** | OP-02 — RN-002. Ver R6-01. |
| Sistema carrega perfil e permissões | SEQ-001, msg. 5 (`obterPermissoes`) | **OK** | IR-02 — sem divergência com o I4. |
| Sistema cria a sessão | SEQ-001, msg. 6 (`criarSessao`) | **OK** | AP-01 — sessão fora do domínio (P-07). |
| E1 — credencial inválida → recusa + auditoria | SEQ-001, `alt` "E1 - Credencial inválida" | **OK** | Recusa explícita ao ator **e** auditoria (`LOGIN_NEGADO`). |
| E2 — conta bloqueada → recusa + auditoria | SEQ-001, `alt` "E2 - Conta bloqueada ou inativa" | **OK** | Idem, com guarda RN-001. |
| A1 — encerrar sessão | SEQ-001, `opt` A1 | **OK** | `invalidarSessaoAtiva` (AP-01). |

**Conclusão:** UC-001 está integralmente coberto por SEQ-001. **Não há** diagrama de atividades, de comunicação ou de estados para a autenticação — e **não deve haver**: o objeto de interesse da Fase 6 é o ciclo de agendamento.

### 4.2 UC-021 — Vincular psicólogo a paciente

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Administrador seleciona o profissional e o paciente | — | **PENDENTE** | Depende de OP-05/OP-08 (consultas administrativas), fora do escopo comportamental crítico. |
| Sistema formaliza o vínculo | SEQ-002/SEQ-004 (uso de `estaAtivo`), ATV-001 (guarda de `d2`) | **OK (parcial)** | O vínculo aparece como **autorização consultada**, não como fluxo de cadastro — coerente com RN-003/RN-005. |
| Sistema encerra o vínculo | — | **PENDENTE** | OP-21 (`encerrar`) — fora do escopo desta fase; sem situação no modelo oficial (PC-06). |
| Auditoria do ato | COM-001 (msg. 8/9, por analogia) | **OK (modelo)** | O padrão "serviço → auditoria → registro" é o mesmo em todos os atos auditáveis. |

**Conclusão:** UC-021 é **coberto transversalmente** (o vínculo é condição de autorização no ciclo de agendamento) e **não é coberto longitudinalmente**. Registrado como lacuna de escopo, não como defeito.

### 4.3 UC-025 — Solicitar agendamento (nasce confirmado)

| Passo do fluxo | SEQ-002 | ATV-001 | COM-001 | EST-001 | Veredicto |
|---|---|---|---|---|---|
| Passo 1 — paciente consulta horários livres | `consultarHorariosDisponiveis` (OP-11) | `Consultar horários (OP-11)` + `d1` | msg. 4, 5 | — | **OK** |
| Passo 2 — paciente escolhe o horário | — | `Selecionar horário` | — | — | **OK** |
| Passo 3 — sistema valida vínculo e disponibilidade | `estaAtivo` (OP-22) + `verificarDisponibilidade` | `Validar vínculo e horário` + `d2` | msg. 3, 6 | guarda de T0 | **OK** |
| Passo 4 — sistema **cria o agendamento já confirmado** | `Agendamento.solicitar` → retorno `CONFIRMADO` | `Criar agendamento (CONFIRMADO)` | msg. 7 | **T0** (`[*] → CONFIRMADO`) | **OK** |
| Passo 5 — confirmação (mesmo ato) | *(não há mensagem separada)* | *(idem passo 4)* | *(idem)* | *(idem)* | **OK — confirmação automática** |
| Passo 6 — auditoria | `registrar("AGENDAMENTO_CONFIRMADO")` | `Auditar criação (RN-009)` | msg. 8, 9 | efeito de T0 | **OK** |
| Passo 7 — **e-mail sempre** | `notificar(confirmacao)` | `Notificar confirmação (RF-033)` (ramo *par 2* do `fork1`) | msg. 10 | efeito de T0 | **OK (obrigatório)** |
| A1 — não há horário disponível | `alt` A1 → **oferecer lista de espera** (RF-034) | `d1` [Não] → `Sem horários: oferecer lista de espera` | — | — | **OK (ampliado)** |
| E1 — conflito de horário | `alt` E1 — conflito | `d2` [Não] → `Recusar (E1)` | msg. 6 (retorno falso) | — | **OK** |
| **Ramo de aceite da oferta** (novo) | SEQ-004 (`aceitarOferta` → `agendar` → `solicitar` `CONFIRMADO`) | *(não passa pelo ATV — é extensão)* | msg. 7 | T0 | **OK (DEC-027)** |

**Conclusão:** UC-025 está coberto nos **quatro** diagramas e a confirmação deixou de ser um passo: `Agendamento.solicitar` devolve o agendamento **`CONFIRMADO`** (RF-025 + RF-026 / RN-013). A v1.0 desenhava `solicitar` → `confirmar` (OP-13) e um estado `SOLICITADO` que **não existem mais**; o achado foi corrigido nos cinco artefatos (EST, SEQ-002, SEQ-003, ATV-001, COM-001) e no dossiê.

### 4.4 UC-027 — Cancelar agendamento

| Passo do fluxo | SEQ-003 | ATV-001 | COM-001 | EST-001 | Veredicto |
|---|---|---|---|---|---|
| Ator consulta seus agendamentos | `consultarMeus` (OP-19, **UC-028**) | — | — | — | **OK** |
| Ator solicita o cancelamento | `cancelar(agendamento, motivo)` | `Cancelar (OP-14)` | msg. 11 | evento `cancelar` | **OK** |
| Sistema verifica se pode cancelar | `podeSerCancelado` (OP-15) → "hora marcada ainda não começou" | `d3` | — | guarda **`[antes do horário marcado]`** de T1 | **OK** |
| Sistema cancela | `cancelar(solicitante, motivo)` (OP-14) | — | msg. 11 | T1 | **OK** |
| Auditoria do cancelamento | `registrar("AGENDAMENTO_CANCELADO")` | `Auditar cancelamento (RN-009)` | msg. 8, 9 | efeito de T1 | **OK** |
| **E-mail do cancelamento (sempre)** | `notificar(cancelamento)` | `Notificar cancelamento (RF-033)` (etapa sequencial após o `join2`) | msg. 12 | efeito de T1 | **OK (obrigatório)** |
| **Oferta de vaga (`<<extend>>`)** | `opt <<extend>> UC-035` → `ofertarVaga` | `Ofertar vaga se houver fila (UC-035)` | msg. 13, 14, 15 | — (não é transição) | **OK (DEC-027)** |
| E1 — já realizado ou já cancelado | `alt` E1 | `d3` [Não] → `Manter agendamento` | — | estados terminais | **OK** |

**Conclusão:** UC-027 está coberto e **ampliado**: o cancelamento passou a ter três desdobramentos que a v1.0 não tinha — guarda sem valor numérico, e-mail obrigatório e oferta de vaga como extensão (não como caso independente). A recusa (E1) aparece nos dois diagramas com o mesmo significado.

### 4.5 UC-028 — Consultar os próprios agendamentos (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Ator abre "meus agendamentos" | SEQ-003, msg. 1 (`consultarMeus`, OP-19) | **OK** | O passo existia na v1.0 como "preparatório" do cancelamento; agora tem caso de uso próprio (LAC-09 fechada). |
| Sistema aplica autorização | COM-001 (msg. 2, OP-04) | **OK** | A autorização por operação é consultada, não presumida. |
| Sistema devolve lista com situação | SEQ-003, retorno "agendamentos do ator" | **OK** | As quatro situações do EST-001 são exibíveis. |
| A1 — nenhum agendamento | UC-028 (A1) | **OK** | Especificado; não exige diagrama novo. |
| E2 — consultar agendamento de outro paciente | UC-028 (E2) + RN-003 | **OK** | Recusa e auditoria; coberto por `estaAtivo`. |

### 4.6 UC-033 — Notificar os interessados por e-mail (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Operação de agenda concluída | SEQ-002/003/004 (o `notificar` vem **após** a auditoria) | **OK** | Pós-commit (TRS-02). |
| Mensagem do evento é montada | SEQ-002 (`confirmacao`), SEQ-003 (`cancelamento`), SEQ-004 (`ofertaVaga`, `confirmacao`) | **OK** | Três eventos distintos, um só serviço. |
| Chamada ao Serviço Externo | COM-001 (msg. 10, 12, 15) + `ServicoEnvioMensagem` no desenho | **OK** | Fronteira externa com rótulo "Serviço Externo de E-mail". |
| Retorno `entregue | falha` | SEQ-002/003/004 (`-->>`) | **OK** | Retorno **não** gera transição nem desfaz a operação. |
| A1 — sem e-mail cadastrado | UC-033 (A1) | **OK** | Registra e segue. |
| E1 — falha do serviço externo | UC-033 (E1) + nota das sequências | **OK** | Falha registrada; operação preservada. |

**Conclusão:** o e-mail deixou de ser "efeito implícito condicional" (DEC-009) e passou a **requisito e caso de uso** (RF-033 / UC-033), sempre incluído nos três eventos de agenda.

### 4.7 UC-034 — Entrar na lista de espera (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Paciente sem horário é convidado a entrar na fila | SEQ-002 (A1), ATV-001 (`Sem horários`) | **OK** | `<<extend>>` de UC-025. |
| Sistema valida vínculo e duplicidade | SEQ-004 (`entrarNaFila`) | **OK** | Duplicidade é exceção declarada em UC-034 (A1). |
| Sistema registra a entrada | `registrarEntrada` (OP-23) → `AGUARDANDO` + `dataHoraEntrada` | **OK** | Ordem de entrada (DEC-027). |
| Sistema audita | `registrar("ESPERA_REGISTRADA")` | **OK** | RN-009. |
| Sistema informa a posição | retorno "posicao na fila" | **OK** | — |

### 4.8 UC-035 — Ofertar vaga ao próximo (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Cancelamento libera o horário | SEQ-003 (T1), EST-001 (T1) | **OK** | Gatilho do `<<extend>>`. |
| Sistema verifica se já há oferta aberta | SEQ-004 (`alt` "Fila vazia ou oferta já aberta") | **OK** | Uma oferta por psicólogo (DEC-027). |
| Sistema escolhe o mais antigo | `proximoDaFila` (OP-24) | **OK** | Ordem de entrada, sem prioridade manual. |
| Sistema abre a oferta com prazo | `abrirOferta(prazoAceite)` (OP-25) → `OFERTADA` | **OK** | Prazo único do sistema. |
| Sistema audita e notifica | `registrar("OFERTA_VAGA_ABERTA")` + `notificar(ofertaVaga)` | **OK** | RF-032 + RF-033. |
| A1 — fila vazia | SEQ-004 (`else`) | **OK** | Horário permanece no catálogo. |
| Relação no diagrama de casos | `UC-035 --<<extend>>--> UC-027` | **NÃO INCORPORADO** | O diagrama oficial de casos é do Integrante 3; as relações estão especificadas em `proposta-I2-casos-de-uso-faltantes.md` §9. |

### 4.9 UC-036 — Responder à oferta de vaga (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Paciente recebe a oferta | SEQ-004 (`notificar(ofertaVaga)`) | **OK** | — |
| Aceite | `validarPrazo` (OP-26) → `agendar` → `solicitar` `CONFIRMADO` → `encerrar(ACEITA)` (OP-27) | **OK** | Reusa o caminho normal de agendamento. |
| Recusa | `encerrar(RECUSADA)` → reoferta | **OK** | Passa ao próximo. |
| Vencimento | `expirarOferta` → `EXPIRADA` → reoferta | **OK** | Passa ao próximo. |
| E1 — horário já tomado (corrida) | UC-036 (E1) | **OK** | Recusa o aceite e reoferta. |
| E2 — oferta inexistente/encerrada | UC-036 (E2) | **OK** | Não cria agendamento. |

### 4.10 UC-037 — Registrar não comparecimento (novo)

| Passo do fluxo | Artefato | Veredicto | Observação |
|---|---|---|---|
| Psicólogo identifica agendamento vencido | SEQ-003 (`opt RF-037`) | **OK** | Ação manual (DEC-025). |
| Sistema valida situação e horário | EST-001 (T3: só a partir de `CONFIRMADO`, após o horário) | **OK** | Não há expiração automática. |
| Sistema registra a falta | `registrarFalta` (OP-18) → `NAO_COMPARECEU` | **OK** | — |
| Sistema audita | `registrar("AGENDAMENTO_NAO_COMPARECEU")` | **OK** | RN-009. |
| Nenhum `Atendimento` é criado | SEQ-003 (não há `Atendimento.registrar` nesse `opt`) | **OK** | RN-006. |
| A1 — sessão atrasada, mas realizada | UC-037 (A1) → UC-027 (concluir) | **OK** | Desvio declarado. |

---

## 5. Resultado 2 — Comparação cruzada entre os sete diagramas

### 5.1 Matriz de coerência por comportamento

| Comportamento | Nome da operação (em todos os diagramas) | Regra | Seq | ATV | COM | EST | Coerente? |
|---|---|---|---|---|---|---|---|
| Buscar a conta | `obterPorIdentificacao` | — | SEQ-001 (IR-01) | — | — | — | **OK** (só SEQ-001) |
| Verificar se a conta pode autenticar | `podeAutenticar` (OP-01) | RN-001 | SEQ-001 | — | — | — | **OK** |
| Conferir a credencial | `confereCredencial` (OP-02) | RN-002 | SEQ-001 | — | — | — | **OK** |
| Carregar permissões da sessão | `obterPermissoes` (IR-02) | RF-007/008 | SEQ-001 | — | — | — | **OK** |
| Auditar | `registrar(...)` | RN-009 | SEQ-001/002/003/004 | 4 nós de auditoria | msg. 8, 9 | efeito de T0–T3 | **OK** (agora nos quatro) |
| Consultar horários disponíveis | `consultarHorariosDisponiveis` (OP-11) / `consultarHorarios` (COM) | RN-010 | SEQ-002 | `Consultar horários (OP-11)` | msg. 4 | — | **OK** (abreviação coerente) |
| Verificar o slot | `verificarDisponibilidade` | RN-005/RN-010 | SEQ-002 | `Validar vínculo e horário` | msg. 6 | guarda de T0 | **OK** |
| Verificar o vínculo | `estaAtivo` (OP-22) | RN-003/RN-005 | SEQ-002, SEQ-004 | `d2` | msg. 3 | guarda de T0 | **OK** |
| Criar o agendamento | `Agendamento.solicitar` (devolve `CONFIRMADO`) | RF-025 + RF-026 / RN-013 | SEQ-002, SEQ-004 | `Criar agendamento (CONFIRMADO)` | msg. 7 | **T0** | **OK** |
| Cancelar | `cancelar(solicitante, motivo)` (OP-14) | RN-012 | SEQ-003 | `Cancelar (OP-14)` | msg. 11 | T1 | **OK** |
| Pode cancelar | `podeSerCancelado()` (OP-15) | RN-012 | SEQ-003 | `d3` | — | guarda `[antes do horário marcado]` | **OK** |
| Concluir | `concluir(solicitante)` (OP-17) | RF-030, RN-006 | SEQ-003 | `Concluir (OP-17)` | msg. 16 | T2 | **OK** |
| Verificar se foi cancelado | `estaCancelada()` (OP-16) | RN-006 | SEQ-003 | — | — | — | **OK** (só SEQ-003) |
| Registrar atendimento | `registrar(agendamento, contextoSessao, solicitante)` (OP-20) | RF-030 | SEQ-003 | `Registrar atendimento (OP-20)` | msg. 17 | efeito de T2 | **OK** |
| Registrar falta | `registrarFalta(solicitante)` (OP-18) | RF-037 / DEC-025 | SEQ-003 | `Registrar falta (OP-18)` | — | T3 | **OK** |
| Notificar | `notificar(evento)` (AP-04) | RF-033 / DEC-022 | SEQ-002/003/004 | `Notificar confirmação`, `Notificar cancelamento` | msg. 10, 12, 15 | efeito de T1 | **OK (obrigatório)** |
| Entrar na fila | `entrarNaFila` / `registrarEntrada` (OP-23) | RF-034 / DEC-027 | SEQ-004 | `Sem horários: oferecer lista de espera` | — | — | **OK** |
| Ofertar vaga | `ofertarVaga` / `proximoDaFila` (OP-24) / `abrirOferta` (OP-25) | RF-035 / DEC-027 | SEQ-003 (`opt`), SEQ-004 | `Ofertar vaga se houver fila` | msg. 13, 14, 15 | — (não é transição) | **OK** |
| Responder à oferta | `validarPrazo` (OP-26) / `encerrar` (OP-27) | RF-036 / DEC-027 | SEQ-004 | — | — | — | **OK** |

**Resultado: 19 comportamentos comparados, 0 divergências de nome, 0 divergências de regra e 0 divergências de efeito.** A única assimetria é **intencional**: a oferta de vaga aparece no ATV/COM/SEQ, mas **não** no EST-001, porque não é situação do agendamento (§4.4 e §6.3).

### 5.2 Matriz de cobertura dos diagramas por requisito

| RF | SEQ | ATV | COM | EST | Total |
|---|---|---|---|---|---|
| RF-001, RF-002 | ✔ | — | — | — | 1 |
| RF-024 | ✔ | ✔ | ✔ | — | 3 |
| RF-025 | ✔ (2) | ✔ | ✔ | ✔ (T0) | 5 |
| RF-026 | ✔ (2) | ✔ | ✔ | ✔ (T0) | 5 |
| RF-027 | ✔ (2) | ✔ | ✔ | ✔ (T1) | 5 |
| RF-028 | ✔ | — | — | — | 1 |
| RF-030 | ✔ | ✔ | ✔ | ✔ (T2) | 4 |
| RF-032 | ✔ (4) | ✔ | ✔ | ✔ (efeito) | 6 |
| RF-033 | ✔ (3) | ✔ | ✔ | — (efeito) | 5 |
| RF-034 | ✔ (2) | ✔ | — | — | 3 |
| RF-035 | ✔ (2) | ✔ | ✔ | — (efeito) | 4 |
| RF-036 | ✔ | — | — | — | 1 |
| RF-037 | ✔ | ✔ | — | ✔ (T3) | 3 |

### 5.3 Verificação de não invenção (teste do plano §8)

| Verificação | Resultado |
|---|---|
| Mensagem de sequência sem OP/AP/IR | **0** (136 setas auditadas: 85 solicitações e 51 retornos — SEQ-001 31, SEQ-002 21, SEQ-003 32, SEQ-004 52) |
| Atividade sem origem em operação | **0** (37 nós: 1 início + 21 atividades + 4 decisões + 3 forks + 3 joins + 5 `Fim`; 39 arestas) |
| Mensagem de comunicação sem origem | **0** (17 mensagens auditadas, 14 colaboradores) |
| Transição de estado sem operação | **0** (4 transições: T0–T3) |
| Estado sem atributo persistível | **0** (`CONFIRMADO`/`REALIZADO`/`CANCELADO`/`NAO_COMPARECEU` = `SituacaoAgendamento` = `agendamento.status`) |
| Operação nova criada nesta fase | **6** — **OP-23…OP-28** (`SolicitacaoEspera`), exigidas pela **DEC-027**; declaradas e entregues ao I3 |
| Responsabilidade de aplicação nova | **1** — **AP-06** `ServicoListaEspera` (DEC-027) |
| Entidade nova criada nesta fase | **1** — **`SolicitacaoEspera`** (DEC-027), com estado persistente e prazo |
| Dado real exposto | **0** (DEC-005 respeitado: só rótulos de operação, regra e papel) |

> **Por que 6 operações e 1 entidade não violam o "teste de não invenção":** o teste proíbe mensagem **sem âncora**. OP-23…OP-28, AP-06 e `SolicitacaoEspera` estão ancorados na **DEC-027**, que é decisão do grupo, e cada um aparece na matriz (`06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.4) e na especificação da SEQ-004. O que não pode existir é mensagem "para satisfazer um diagrama futuro" — e não existe.

### 5.4 Divergências corrigidas neste lote

| # | Divergência (v1.0) | Correção aplicada | Evidência |
|---|---|---|---|
| D1 | `SOLICITADO` como situação inicial em EST-001, SEQ-002, SEQ-003, ATV-001, COM-001 e dossiê §24 | Situação removida; `[*] → CONFIRMADO : solicitar`; 4 situações / 4 transições | EST-001, §24, matriz |
| D2 | Passo `confirmar(solicitante)` (OP-13) na SEQ-002, ATV-001 (`Confirmar (OP-13)`) e COM-001 (msg. 8) | Removido; `Agendamento.solicitar` devolve `CONFIRMADO`; ATV tem `Criar agendamento (CONFIRMADO)`; COM renumerado | SEQ-002, ATV-001, COM-001 |
| D3 | Guarda de cancelamento `[prazo]` sem valor (2h na DEC-012) | Guarda `[antes do horário marcado]` em EST T1, SEQ-003 (`podeSerCancelado` → "hora marcada ainda não começou"), ATV `d3`, dossiê | EST-001, SEQ-003, ATV-001, §24 |
| D4 | Notificação "condicional" e nome `ServicoNotificacao` | `ServicoEnvioMensagem` em **todos** os artefatos; e-mail obrigatório nos três eventos; falha não desfaz | SEQ-002/003/004, ATV-001, COM-001, matriz |
| D5 | ATV sem "notificar cancelamento" e sem oferta de vaga | `join2 → Notificar cancelamento → Ofertar vaga se houver fila → Fim` | ATV-001 |
| D6 | Lista de espera inexistente; SEQ-004 bloqueada ("encaixe") | SEQ-004 criada com OP-23…OP-28, AP-06, `SolicitacaoEspera`; UC-034/035/036 criados | SEQ-004, UC-034…036 |
| D7 | Oferta de vaga tratada como caso independente | `<<extend>>` de UC-027 (`opt` na SEQ-003, nó no ATV, relação no doc de casos) | SEQ-003, ATV-001, UC-035 |
| D8 | RF-028 e RF-033 sem caso de uso; não comparecimento sem requisito | UC-028, UC-033 e UC-037 criados (DEC-026); RF-033…RF-037 na §8 dos requisitos | UC-028/033/037, RF-033…037 |
| D9 | Especificações sem "Objetivo" e "RFs cobertos" | Todas as quatro especificações v2.0 e o doc de casos abrem com **Objetivo** e **RFs cobertos** | `03-uml/*/proposta-I2-especificacao-*.md` |
| D10 | Dossiê dizia "seis diagramas" e citava DEC-009/010/012 como pendentes | Sete figuras; decisões resolvidas; contagens fechadas | `07-dossie/secoes/fase6-secao-21-24.md` |

---

## 6. Resultado 3 — Cotejo com a análise de persistência do Integrante 4

O Integrante 4 produziu uma análise de impacto comportamental (`04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md`) com operações de infraestrutura que precisam de um papel inequívoco frente às operações de domínio OP-xx. Este é o cotejo.

| # | Operação do I4 | Onde entra na Fase 6 | Veredicto | Encaminhamento |
|---|---|---|---|---|
| 1.1 | `consultarPorLogin(login)` — repositório de usuário | SEQ-001, msg. 2 — `obterPorIdentificacao(identificacao)` (IR-01) | **DIVERGENTE (nomenclatura)** | **R6-02**: mesma responsabilidade (carregar a conta). **Proposta:** unificar em `obterPorIdentificacao`. |
| 1.2 | `compararHash(hashArmazenado, senha)` — serviço de autenticação (domínio) | SEQ-001, msg. 4 — `confereCredencial(senha)` (OP-02, entidade `Usuario`) | **DIVERGENTE (camada)** | **R6-01**: a comparação **não** acontece no repositório (RN-002) e sim no domínio; a diferença é *quem* compara. Manter OP-02 na entidade. |
| 1.3 | `verificarSituacao(usuario)` — repositório de usuário | SEQ-001, msg. 3 — `podeAutenticar()` (OP-01, entidade `Usuario`) | **DIVERGENTE (camada)** | **R6-03**: repositório carrega, entidade decide. |
| 1.4 | `obterPermissoes(idUsuario)` — repositório de autorização | SEQ-001, msg. 5 — `obterPermissoes(idUsuario)` (IR-02) | **OK — sem divergência** | Diferente de `consultarPermitidos` (OP-04) — ver R6-04. |
| 2.6 | `notificar(destinatario, evento)` — serviço externo | SEQ-002 (`confirmacao`), SEQ-003 (`cancelamento`), SEQ-004 (`ofertaVaga`, `confirmacao`); COM-001 msg. 10, 12, 15; ATV-001 `Notificar confirmação` / `Notificar cancelamento` | **OK — harmonizado** | **R6-06 (fechado)**: parâmetro `evento`, valores `confirmacao`, `cancelamento` e **`ofertaVaga`**. |
| — | **TRS-02** — notificação fora da transação de escrita (pós-commit) | SEQ-002/003/004 (a notificação aparece **depois** da gravação e da auditoria); ATV-001 (`fork1` par 2; etapa sequencial após o `join2`) | **OK — alinhado** | **R6-07**: os diagramas garantem a **ordem**, não a fronteira transacional (Fase 7). |
| — | **INC-13** — "Não compareceu" apenas a partir de "Confirmado" | EST-001 (T3); SEQ-003 (`opt RF-037`); ATV-001 (`d5` [Não]) | **OK — resolvido** | Não existe transição de `SOLICITADO` para `NAO_COMPARECEU` — nem `SOLICITADO`. Responde à P-14. |
| — | **ARQ-07** — *outbox* para eventos pós-commit | Não aparece nos diagramas | **PENDENTE / fora de escopo** | **R6-08**: infraestrutura de Fase 7. O ATV-001 já separa o ramo de notificação, o que facilita a inclusão. |
| — | Tabela/coluna para a **lista de espera** | SEQ-004 (`SolicitacaoEspera`) | **NÃO INCORPORADO** | **R6-10**: o I4 precisa de tabela `solicitacao_espera` (psicólogo, paciente, período, `dataHoraEntrada`, `situacao`, `prazoAceite`) no DER. |
| — | `Agendamento.confirmar()` e enumerado das situações no diagrama oficial | EST-001 (4 situações), §24 do dossiê | **NÃO INCORPORADO** | **R6-09**: o CLS-001 oficial ainda declara `confirmar()` e não fixa o enumerado; pela DEC-017 a criação já nasce confirmada e pela DEC-016 são quatro situações. O I3 precisa alinhar. |

### 6.1 Achados desta revisão (R6-01 … R6-10)

| ID | Sev. | Achado | Evidência | Ação recomendada | Responsável | Situação |
|---|---|---|---|---|---|---|
| R6-01 | M | `compararHash` (serviço) × `confereCredencial` (entidade `Usuario`) | I4 §1.2 × CLS-001 v2 (OP-02) × SEQ-001 msg. 4 | Unificar em OP-02 na entidade; atualizar a análise do I4 | I4 + I3 | **Aberto** |
| R6-02 | B | `consultarPorLogin` (I4) × `obterPorIdentificacao` (IR-01) | I4 §1.1 × SEQ-001 msg. 2 | Unificar o nome no glossário de infraestrutura | I4 + I2 | **Aberto** |
| R6-03 | M | `verificarSituacao` no repositório (I4) × `podeAutenticar` na entidade (OP-01) | I4 §1.3 × CLS-001 v2 (OP-01) × SEQ-001 msg. 3 | Repositório carrega, entidade decide | I4 + I3 | **Aberto** |
| R6-04 | M | `obterPermissoes` (IR-02, montar a sessão) × `consultarPermitidos` (OP-04, autorizar operação) | SEQ-001 msg. 5 × COM-001 msg. 2 | Manter os dois nomes; documentar a distinção | I2 + I3 | **Documentado** |
| R6-05 | B | ATV sem "notificar cancelamento" enquanto SEQ-003 notificava | ATV-001 `fork2` × SEQ-003 msg. 5 | **Corrigido na v1.0**, ampliado na v2.0 (`notificar → ofertar`) | I2 | **Fechado** |
| R6-06 | B | Nome do parâmetro da notificação (`evento` × valores) | I4 §2.6 × SEQ-002/003/004 | Parâmetro `evento`; valores `confirmacao`, `cancelamento`, `ofertaVaga` | I4 + I2 | **Fechado** |
| R6-07 | B | Diagramas não marcam fronteira de transação | SEQ-002/003/004, ATV-001 | Manter; a fronteira é da Fase 7 (TRS-02); a ordem já está explícita | I2 + I4 | **Documentado** |
| R6-08 | M | Análise do I4 da Fase 5 (R5-13) feita sobre a lista do plano, não sobre o modelo real | I4 §1 e R5-13 | Refazer a análise contra o modelo aprovado antes do DER | I4 | **Aberto** |
| **R6-09** | **M** | **O CLS-001 oficial ainda declara `Agendamento.confirmar()` e não fixa o enumerado das quatro situações** | `03-uml/Classes/diagrama-classes.mmd` × DEC-016/DEC-017 × EST-001 | Retirar `confirmar()` e incorporar o enumerado (`CONFIRMADO`, `CANCELADO`, `REALIZADO`, `NAO_COMPARECEU`) ao CLS-001 e ao `CHECK` de `agendamento.status` | **I3** | **Aberto (herdado)** |
| **R6-11** | **B** | **A falha de envio não é registrada na auditoria nos diagramas (DEC-029)** | SEQ-002/003/004 (`falha de envio`) × DEC-029 | **Corrigido na v2.1**: `alt` "Envio aceito" / "Falha de envio" com `registrar("FALHA_ENVIO_EMAIL")` e envio repetível — LAC-14 fechada | **I2** | **Fechado** |
| **R6-12** | **B** | **A saída da fila e a consulta de posição não estão desenhadas (DEC-027)** | SEQ-004 × DEC-027 ("o paciente pode consultar a própria posição e sair da lista") | **Corrigido na v2.1**: `opt` de consulta (`consultarPosicao` → OP-28 `posicaoNaFila`) e de saída (`sairDaFila` → `encerrar(DESISTIU)`, OP-27) — LAC-13 fechada | **I2** | **Fechado** |
| **R6-13** | **B** | **A reserva do horário durante o prazo da oferta não está desenhada (DEC-027)** | SEQ-004 (`abrirOferta`) × DEC-027 ("durante o prazo o horário fica reservado") | **Corrigido na v2.1**: `abrirOferta(horario, prazoAceite)` devolve `OFERTADA` com o horário reservado até o prazo e nota de retorno ao catálogo — LAC-15 fechada | **I2** | **Fechado** |
| **R6-10** | **M** | **A lista de espera exige tabela própria (`solicitacao_espera`) e coluna de prazo; o DER do I4 ainda não a tem** | SEQ-004 × DEC-027 × `04-persistencia/` | Incluir `solicitacao_espera` (psicólogo, paciente, período, `dataHoraEntrada`, `situacao`, `prazoAceite`) e o índice de ordem | **I4** | **Aberto** |

> **Nota de numeração:** R6-08 reativa o achado R5-13, porque ele **bloqueia a Fase 7** e agora tem consequência direta nos diagramas: enquanto o Integrante 3 não incorporar OP-01…OP-28, os diagramas da Fase 6 estão apoiados em um modelo que ainda não é o oficial.

### 6.2 Correções aplicadas neste lote

**a) R6-05 (herdado) — ordem do cancelamento.** O SEQ-003 mostra **auditar → notificar → ofertar → responder**. O ATV-001 passou a reproduzir exatamente essa ordem: `fork2` (liberar ‖ auditar) → `join2` → `Notificar cancelamento` → `Ofertar vaga se houver fila` → `Fim`. A notificação **não** é um terceiro ramo do `fork2`: ela é sequencial, porque só pode ocorrer com o cancelamento gravado e auditado (TRS-02), e a oferta só pode ocorrer depois dela.

**b) `SOLICITADO` eliminado.** A transição `[*] → CONFIRMADO : solicitar` substitui T1+T2; o passo `confirmar` desapareceu da SEQ-002 e do ATV-001; o COM-001 foi renumerado (a antiga msg. 8 virou `registrar(criacao)`). O dossiê §24 passou de "5 situações / 6 transições" para **4 situações / 4 transições**. O diagrama de classes oficial ainda declara `confirmar()` — achado **R6-09**, do Integrante 3.

**c) E-mail obrigatório.** `notificar(...)` aparece nos **três** eventos e em **todos** os diagramas que os contêm; a resposta `entregue | falha de envio` é retorno, sem transição. A especificação de ATV-001 e o dossiê §21 deixam de tratar o envio como condicional.

**d) Lista de espera como domínio.** `SolicitacaoEspera` (entidade) + `ServicoListaEspera` (AP-06) + OP-23…OP-28; SEQ-004 com consulta/saída da fila, reserva do horário e os três desfechos (aceite, recusa, vencimento). O ATV-001 ganhou o nó `Ofertar vaga` na pista de extensão, **sem** criar um quinto losango: a condição "se houver fila" está no rótulo.

**e) Casos de uso e numeração.** UC-028, UC-033, UC-034, UC-035, UC-036 e UC-037 criados/revisados com **Objetivo** e **RFs cobertos** e numeração `UC-0RF` (DEC-026).

**f) Falha de envio auditada (R6-11 / LAC-14).** As três sequências que notificam ganharam o `alt` aninhado "Envio aceito pelo serviço externo" / "Falha de envio - não desfaz a operação", com `registrar("FALHA_ENVIO_EMAIL")` e a nota de repetição (DEC-029). A falha continua sendo **retorno**, não transição de estado; o COM-001 não ganha mensagem nova porque é caminho de exceção sobre o mesmo vínculo.

**g) Consulta e saída da fila (R6-12 / LAC-13).** A SEQ-004 ganhou o `opt` "Consulta de posição e saída da fila": `consultarPosicao` (AP-06) → `posicaoNaFila` (**OP-28**) e `sairDaFila` → `encerrar(DESISTIU)` (OP-27), com auditoria `"ESPERA_ENCERRADA"`. A situação `DESISTIU` entrou no vocabulário de `SolicitacaoEspera`.

**h) Reserva do horário na oferta (R6-13 / LAC-15).** `abrirOferta(horario, prazoAceite)` devolve `OFERTADA` com o **horário reservado até o prazo**; enquanto a oferta existir, o slot não aparece como livre; se a fila acabar (recusa/vencimento sem próximo), o horário volta ao catálogo.

---

## 7. Resultado 4 — Lacunas e decisões: o que fechou e o que resta

### 7.1 Lacunas fechadas neste lote

| ID | Lacuna (v1.0) | Como foi fechada |
|---|---|---|
| **LAC-01** | SEQ-004 ("Preencher encaixe") não produzida | **Fechada**: a DEC-027 substituiu o "encaixe" pela **lista de espera**; a SEQ-004 existe e cobre UC-034 a UC-036. |
| **LAC-03** | Prazo e atores do cancelamento (DEC-012 / P-02) | **Fechada**: guarda **`[antes do horário marcado]`**, sem antecedência mínima (DEC-028), e atores definidos (DEC-011): paciente titular e psicólogo responsável; o Administrador **não** cancela. |
| **LAC-04** | Canal de notificação (DEC-009) | **Fechada**: e-mail; RF-033; `ServicoEnvioMensagem` (DEC-022). |
| **LAC-05** | Mecanismo da confirmação (P-01) | **Fechada**: confirmação automática e simultânea (DEC-017); o agendamento nasce `CONFIRMADO`. |
| **LAC-06** | "Não compareceu": manual ou automático? | **Fechada**: manual, pelo psicólogo (DEC-025 / RF-037 / UC-037). |
| **LAC-09** | `consultarMeus` e RF-028 sem caso de uso | **Fechada**: **UC-028** criado (DEC-026). |
| **LAC-13** | Saída da fila e consulta posterior da posição (DEC-027) | **Fechada na v2.1**: `opt` na SEQ-004 com `consultarPosicao`/`posicaoNaFila` (OP-28) e `sairDaFila`/`encerrar(DESISTIU)` (OP-27). |
| **LAC-14** | Registro da falha de envio na auditoria e repetição (DEC-029) | **Fechada na v2.1**: `alt` de falha em SEQ-002/003/004 com `registrar("FALHA_ENVIO_EMAIL")` e nota de repetição. |
| **LAC-15** | Reserva do horário durante o prazo da oferta (DEC-027) | **Fechada na v2.1**: `abrirOferta(horario, prazoAceite)` devolve o horário reservado e a nota de retorno ao catálogo. |
| **LAC-02** | Reserva do slot (A17 `Disponibilidade`—`Agendamento`) | **Fechada na decisão**: a **DEC-018** aprovou o **slot discreto**; a reserva continua interna a `Agendamento.solicitar` (não é mensagem) e a associação A17 fica habilitada para o I3/I4. |
| **LAC-07** | UC-027 cita **DEC-011 e DEC-012** "que não existem" | **Fechada**: as duas existem no registro oficial (DEC-011 aprovada; DEC-012 registrada como **não adotada**, substituída pela DEC-028). |
| **LAC-08** | Multiplicidades `PENDENTE` no diagrama oficial | **Parcialmente fechada**: a **DEC-019** fixa `Usuario "0..1" — Perfil "1"`; as demais multiplicidades seguem `PENDENTE` (R5-10/PC-09). |

### 7.2 Lacunas e pendências que permanecem

| ID | Lacuna | Causa | Efeito nos diagramas | Quem fecha |
|---|---|---|---|---|
| **LAC-08** | Multiplicidades ainda `PENDENTE` no diagrama oficial (exceto conta—perfil, DEC-019) | R5-10 / PC-09 | Os diagramas **não dependem** de multiplicidades | Grupo + I3 |
| **LAC-10** | `SolicitacaoEspera`, AP-06 e OP-23…OP-27 fora do CLS-001 oficial | DEC-027 aprovada na Fase 6 | Todos os artefatos da fila são **proposta**; falta incorporação | **I3** |
| **LAC-11** | RF-033…RF-036 sem teste conceitual na matriz da Fase 5 | os RFs foram criados na Fase 6 | Nenhum — os diagramas evidenciam os cenários; faltam os CT | **I5** |
| **LAC-12** | Diagrama de casos de uso oficial sem o ator "Serviço Externo de E-mail" e sem os `<<extend>>`/`<<include>>` novos | artefato da Fase 3 (I3) | As relações estão especificadas e desenhadas nos diagramas comportamentais; falta o desenho oficial | **I3** |

---

## 8. Checklist do plano §13 aplicado à Fase 6

| Regra | Verificação | Resultado |
|---|---|---|
| Todo ator do diagrama de casos está definido na documentação | Ator, Paciente, Psicólogo, Administrador, Serviço Externo de E-mail | **OK** — `Ator` (genérico) nas sequências; atores concretos nos casos de uso; o serviço externo é fronteira declarada |
| Todo caso de uso possui requisito/objetivo rastreável | UC-001, UC-024, UC-025, UC-027, UC-028, UC-033…UC-037 | **OK** — todos abrem com **Objetivo** e **RFs cobertos** (DEC-026) |
| Conceitos relevantes dos casos aparecem nos diagramas | 12 classes do modelo + incremento da fila | **OK** — 8 classes do modelo (`Usuario`, `Vinculo`, `Agenda`, `Disponibilidade`, `Agendamento`, `Atendimento`, `RegistroAuditoria`, `SolicitacaoEspera`) aparecem como participante/colaborador; `Perfil`/`Permissao` entram por IR-02; `Psicologo`/`Paciente`/`AreaAtuacao` são de cadastros |
| Cada entidade/objeto tem responsabilidade clara; sem classes onipotentes | 7 diagramas | **OK** — coordenação em `ServicoAgenda` (AP-03) e `ServicoListaEspera` (AP-06); nenhuma entidade "sistema" |
| **Mensagens de sequência correspondem a operações conhecidas** | §5.3 | **OK** — 136/136 setas com origem em OP/AP/IR |
| **Notificação obrigatória e falha não bloqueante** | DEC-009 + DEC-029 | **OK** — o envio é sempre solicitado, a falha não desfaz, é registrada na auditoria (`"FALHA_ENVIO_EMAIL"`) e pode ser repetida (LAC-14 fechada) |
| **Mensagens de comunicação correspondem a operações conhecidas** | §5.3 | **OK** — 17/17 |
| Estados e transições têm eventos, condições ou ações coerentes | EST-001 | **OK** — **4 situações, 4 transições** (T0–T3), todas com evento; 3 com guarda |
| Atividades têm decisões, responsabilidades e paralelismo | ATV-001 | **OK** — 4 decisões, 4 pistas, 3 blocos paralelos e **2 etapas sequenciais** (notificar → ofertar) |
| Entidades persistentes têm correspondência com classes | 7 diagramas | **OK** — situações = enum = `agendamento.status`; a fila = `SolicitacaoEspera` (pendente de incorporação — LAC-10) |
| FKs e cardinalidades respeitam as multiplicidades do domínio | — | **Não se aplica** — multiplicidades seguem `PENDENTE` (LAC-08) |
| Mudanças em um artefato provocam revisão dos relacionados | esta revisão + matriz da Fase 6 | **Aplicado** — §5.4, §6 e `06-rastreabilidade/matriz-rastreabilidade-fase6.md` |
| Nenhum dado real nos artefatos | DEC-005 | **OK** — verificado por inspeção do texto extraído dos **7 PDFs** |
| Diagramas têm título + identificador, objetivo, elementos, interpretação, decisões, relação com requisitos/classes/banco e referência ao arquivo editável | plano §16.1 | **OK** — as 4 especificações v2.0/v2.1 e o doc de casos seguem a ordem do plano |

---

## 9. Pendências que permanecem após esta revisão

| ID | Pendência | Fecha com |
|---|---|---|
| R6-01, R6-03 | Camada da comparação de credencial e da verificação de situação | I4 + I3 (OP-02/OP-01) |
| R6-02 | Nome da operação de busca da conta | I4 + I2 (glossário) |
| R6-04 | Distinção `obterPermissoes` × `consultarPermitidos` | I2 (glossário do dossiê) |
| R6-08 / R5-13 | Reanálise de persistência contra o modelo aprovado | I4 |
| **R6-09** | **Remover `SOLICITADO` do enum, do diagrama de objetos e do `CHECK`** | **I3** |
| **R6-10** | **Tabela `solicitacao_espera` no DER** | **I4** |
| LAC-08 | Multiplicidades `PENDENTE` (exceto conta—perfil, DEC-019) | Grupo + I3 |
| LAC-10 | Incorporação de `SolicitacaoEspera`, AP-06 e OP-23…OP-28 | **I3** |
| LAC-11 | CT-033…CT-036 na matriz da Fase 5 | **I5** |
| LAC-12 | Diagrama de casos de uso: ator E-mail + `<<extend>>`/`<<include>>` | **I3** |
| PC-02, PC-05, PC-06, PC-07, PC-08, PC-09, PC-10, PC-12 | Incorporação pelo Integrante 3 das OP-xx e das situações | I3 |
| Revisão cruzada por outro integrante | Definition of Done do plano §13.1 | Grupo |

---

## 10. Checklist de aprovação (para a ata do walkthrough)

- [ ] Grupo aprova os **sete diagramas** (SEQ-001/002/003/**004**, ATV-001, COM-001 e EST-001) como artefatos comportamentais da Fase 6.
- [x] Decisões **já ratificadas pelo grupo** e aplicadas nesta entrega: **DEC-009 + DEC-029** (e-mail obrigatório, falha não desfaz), **DEC-010 + DEC-027** (lista de espera), **DEC-011 + DEC-028** (guarda `[antes do horário marcado]`, sem Administrador), **DEC-016 + DEC-017** (nasce `CONFIRMADO`), **DEC-018** (slot discreto), **DEC-022** (`ServicoEnvioMensagem`), **DEC-025** (falta manual), **DEC-026** (`UC-0RF`) e **DEC-030** (atendimento).
- [x] **DEC-018** (modelo do horário) — aprovada em 28/10/2026; fecha LAC-02.
- [ ] Integrante 3 incorpora **OP-01…OP-28**, **AP-06**, `SolicitacaoEspera` (com `DESISTIU`), as **4 situações** da DEC-016 e retira `Agendamento.confirmar()` do CLS-001 (**R6-09** / LAC-10).
- [ ] Integrante 3 atualiza o **diagrama de casos de uso** com o ator E-mail e as relações `<<extend>>`/`<<include>>` (**LAC-12**).
- [ ] Integrante 4 atualiza a análise de impacto com **R6-01, R6-02, R6-03** e inclui a tabela `solicitacao_espera` (**R6-10**).
- [ ] Integrante 5 abre **CT-033…CT-036** (LAC-11) e revisa a matriz.
- [ ] Integrante 1 homologa `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (ou a funde na matriz mestra).
- [ ] Integrante 6 insere no dossiê as seções **21 a 24** a partir de `07-dossie/secoes/fase6-secao-21-24.md` (**7 figuras**).

**Registro de participação desta revisão:** Integrante 2 (Aquiles Angelo) — confronto dos **7 diagramas** comportamentais contra **37 RFs**, 14 RNs, os casos de uso da Fase 3/4 e os 6 novos/revisados, 12 classes, 16 associações, **28 operações** (OP-01…OP-28), **6 responsabilidades de aplicação** (AP-01…AP-06) e a análise de impacto do Integrante 4. Revisão cruzada por outro integrante ainda **pendente** (Definition of Done do plano §13.1).

---

## 11. Entregáveis desta Fase 6 (Integrante 2)

| Arquivo | Conteúdo | Situação |
|---|---|---|
| `03-uml/Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` (+ `.drawio.xml`, `.pdf`) | **SEQ-001** — autenticar usuário (UC-001), com E1/E2 e A1 | Pronto para walkthrough |
| `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` (+ `.drawio.xml`, `.pdf`) | **SEQ-002** — agendar (UC-025 + UC-024), nasce `CONFIRMADO`, e-mail obrigatório, A1 → lista de espera | Pronto para walkthrough |
| `03-uml/Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` (+ `.drawio.xml`, `.pdf`) | **SEQ-003** — cancelar / concluir / registrar falta (UC-027), guarda nova, `<<extend>> UC-035` | Pronto para walkthrough |
| **`03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd`** (+ `.drawio.xml`, `.pdf`) | **SEQ-004** — lista de espera, oferta, aceite, recusa e vencimento (UC-034 a UC-036, DEC-027) | **Novo** — pronto para walkthrough |
| `03-uml/Atividade/proposta-I2-atividade-atv-001.mmd` (+ `.drawio.xml`, `.pdf`) | **ATV-001** — 4 pistas, 4 decisões, 3 blocos paralelos e 2 etapas sequenciais (notificar → ofertar) | Pronto para walkthrough |
| `03-uml/Comunicação/proposta-I2-comunicacao-com-001.mmd` (+ `.drawio.xml`, `.pdf`) | **COM-001** — 14 colaboradores, 17 mensagens, hub `ServicoAgenda` (AP-03) | Pronto para walkthrough |
| `03-uml/Estados/proposta-I2-estados-est-001.mmd` (+ `.drawio.xml`, `.pdf`) | **EST-001** — máquina de estados do `Agendamento` (**4 situações, 4 transições**) | Pronto para walkthrough |
| `03-uml/Sequências/proposta-I2-especificacao-sequencias.md` | Especificação das **quatro** sequências: participantes, fragmentos, decisões, lacunas, RFs cobertos | v2.1 — pronto |
| `03-uml/Atividade/proposta-I2-especificacao-atividade.md` | Especificação do ATV-001: pistas, decisões, paralelismo, rotas, RFs cobertos | v2.0 — pronto |
| `03-uml/Comunicação/proposta-I2-especificacao-comunicacao.md` | Especificação do COM-001: 14 colaboradores, 17 mensagens, hub | v2.0 — pronto |
| `03-uml/Estados/proposta-I2-especificacao-estados.md` | Especificação do EST-001: 4 situações, T0–T3, guardas | v2.0 — pronto |
| **`03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md`** | **UC-028, UC-033, UC-034, UC-035, UC-036, UC-037** + revisão de UC-025/UC-027 + relações para o diagrama de casos | **Novo** — pronto |
| `06-rastreabilidade/matriz-rastreabilidade-fase6.md` | Matriz RF/RN/UC × SEQ/ATV/COM/EST, mensagens × OP/AP, verificação de órfãos | v2.1 — pronto para homologação do I1 |
| `07-dossie/secoes/fase6-secao-21-24.md` | Texto pronto para as seções 21, 22, 23 e 24 (**sete figuras**) | v2.1 — para o I6 consolidar |
| `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` | Esta revisão: cobertura, comparação cruzada, cotejo com o I4, R6-01…R6-13, checklist | v2.1 — pronto para walkthrough |

**Sequência sugerida ao grupo:** (1) walkthrough desta revisão e dos sete diagramas; (2) incorporação pelo I3 de OP-01…OP-28, AP-06, `SolicitacaoEspera` (com `DESISTIU`), das quatro situações e da retirada de `confirmar()` (R6-09/LAC-10), além do diagrama de casos (LAC-12); (3) atualização das análises do I4 com R6-01…R6-03, R6-10 e os insumos desatualizados (`IMP-DER-02`, `IMP-DER-10`, `ARQ-02`); (4) Fase 7 (pacotes, componentes, DER) com a matriz da Fase 6 e a revisão de coerência do I2 como insumos; (5) Fase 8 (CT-033…CT-037) e Fase 9 (pitch).
