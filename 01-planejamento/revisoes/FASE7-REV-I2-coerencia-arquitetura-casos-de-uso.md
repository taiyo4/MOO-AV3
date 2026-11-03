# Fase 7 — Coerência entre a arquitetura e os casos de uso (Integrante 2)

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais (Aquiles Angelo).
**Data:** 29/10/2026 · **Versão:** v1.0 (proposta para o grupo).
**Tarefa do plano atendida:** Fase 7, bloco do Integrante 2 (`01-planejamento/etapas-e-responsabilidades.md` §3): **concluir P1 a P6** e **revisar a coerência dos diagramas de arquitetura com os casos de uso**.
**Natureza:** **PROPOSTA.** Não substitui os artefatos oficiais nem os diagramas de arquitetura do Integrante 4; registra achados para os donos corrigirem.

**Insumos lidos:**

- casos de uso — `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` (UC-028, UC-033 a UC-037 e revisão de UC-025/UC-027) e as especificações oficiais das Fases 3/4 (`especificacoes-casos-de-uso-criticos.md`, `especificacoes-casos-de-uso-demais.md`);
- comportamento — SEQ-001 a SEQ-004, ATV-001, COM-001 e EST-001 (`03-uml/`), com as especificações v2.0/v2.1;
- rastreabilidade — `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (v2.1) e `matriz-rastreabilidade-fase5.md`;
- arquitetura e persistência — `04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md` (ARQ-01 a ARQ-08, DEP-01 a DEP-06, TRS-01 a TRS-06, IMP-DER-01 a IMP-DER-10, IMP-CMP-01 a IMP-CMP-09) e `04-persistencia/analises/fase-05-viabilidade-persistencia-dominio.md`;
- requisitos — RF-001 a RF-037, RN-001 a RN-022, RNF-001 a RNF-012 e critérios de aceite CA-RF-001 a CA-RF-037;
- decisões — `01-planejamento/decisoes.md` (DEC-001 a DEC-030 vigentes).

> **O que este documento não faz:** não desenha pacotes, componentes, implantação, DER, dicionário nem DDL (dono: Integrante 4) e não altera a análise dele. Onde a arquitetura planejada divergir do comportamento aprovado, o achado é registrado como **R7-xx** com dono e correção proposta.

---

## 0. Como a revisão foi feita

| Etapa | O que foi confrontado | Resultado |
|---|---|---|
| 1 | P1 a P6 (propagação das decisões de 25 e 28/10/2026 aos casos de uso e diagramas) | **6 de 6 fechados** no que é do Integrante 2 (§1) |
| 2 | Cada caso de uso × classes de domínio × operações (OP-01…OP-28) × serviços de aplicação (AP-01…AP-06) × fronteiras de infraestrutura (IR-01/IR-02) × tabelas previstas | mapa UC → arquitetura (§2) |
| 3 | Exigências arquiteturais ARQ-01 a ARQ-08, dependências DEP-01 a DEP-06, fronteiras transacionais TRS-01 a TRS-06 e impactos IMP-DER/IMP-CMP × sequências v2.1 | **12 achados R7-01 a R7-12** (§3) |
| 4 | Candidatos a pacote e componente para o Integrante 4, com regra de dependência e verificação de "classe onipotente" | §4 |
| 5 | Checklist de coerência arquitetura × casos de uso | **8 OK, 4 parciais, 3 pendentes e 1 a verificar** (§5) |

Método: cada linha do mapa da §2 cita a **evidência** (diagrama, operação, mensagem) e cada achado da §3 cita o **artefato de origem** e o **critério de qualidade** afetado. Nenhuma mensagem foi inventada: as 136 setas das quatro sequências já estão ancoradas em OP/AP/IR na matriz da Fase 6 (§2.1 a §2.4).

---

## 1. Fechamento de P1 a P6

P1 a P6 são as pendências de propagação das decisões de 25 e 28/10/2026 atribuídas ao Integrante 2. Todas foram executadas no lote de ajustes da Fase 6 e estão **verificadas** nos artefatos abaixo.

| # | Exigência (P) | Como foi atendida | Evidência | Situação | Resíduo (dono) |
|---|---|---|---|---|---|
| **P1** | Tirar `SOLICITADO` de EST-001, SEQ-002 e das seções 19, 21 e 24 (DEC-016) | EST-001 com **4 situações e 4 transições** (T0 criação + T1–T3); `Agendamento.solicitar` cria **`CONFIRMADO`**; `confirmar()` não é mensagem | EST-001 v2.1; SEQ-002 v2.1; dossiê §21 e §24 v2.1; matriz §2.2 | **Fechado** | CLS-001 oficial ainda declara `Agendamento.confirmar()` e não fixa o enumerado (**I3**, R6-09) |
| **P2** | Trocar a guarda `[prazo]` por **"antes do horário marcado"** (DEC-011, DEC-028) | Guarda `[antes do horário marcado]` em `podeSerCancelado()`; sem antecedência mínima; Administrador **não** cancela | SEQ-003 (`alt` da guarda); EST-001 (T2); ATV-001 (d4); dossiê §21/§24 | **Fechado** | — |
| **P3** | Notificação por e-mail deixa de ser condicional (DEC-009, DEC-029) | `ServicoEnvioMensagem.notificar` é **sempre** solicitado nos três eventos; falha **não desfaz**, é auditada (`"FALHA_ENVIO_EMAIL"`) e repetível | SEQ-002/003/004 (`alt` "Envio aceito"/"Falha de envio"); matriz §2.2–2.4 | **Fechado** | Análise do I4 ainda trata a notificação como **condicional** e cita `notificacao` (**R7-03**) |
| **P4** | Casos de uso para RF-028 e RF-033 a RF-037; ator **Serviço Externo de E-mail**; `<<extend>>` da oferta ao cancelamento | UC-028 e UC-033 a UC-037 criados com **Objetivo** e **RFs cobertos**; ator externo citado em UC-033; UC-035 é `<<extend>>` de UC-027 (SEQ-003, `opt`) | `proposta-I2-casos-de-uso-faltantes.md` §1–§8; SEQ-003 (`opt <<extend>> UC-035`) | **Fechado** (texto) | Ator e `<<extend>>` ainda **não desenhados** no diagrama de casos oficial (**I3**, LAC-12) |
| **P5** | Campo "Objetivo" e "RFs cobertos" nas especificações; IDs `UC-0RF` (DEC-026) | Casos novos/revisados abrem com **Objetivo** e **RFs cobertos**; numeração `UC-0RF` aplicada também aos testes (`CT-0RF`) | `proposta-I2-casos-de-uso-faltantes.md`; §2 da FASE6-REV-I2 | **Parcial** | Especificações **oficiais** das Fases 3/4 seguem sem os dois campos e citam `DEC-4`/`DEC-5`/`DEC-012` (**R7-06**, I2 na Fase 9) |
| **P6** | Diagrama comportamental da lista de espera (SEQ-004) com os parâmetros da DEC-027 | SEQ-004 com entrada por ordem, consulta/saída, oferta única, prazo, reserva do horário, aceite/recusa/vencimento e reoferta; `SolicitacaoEspera`/AP-06/OP-23…OP-28 | SEQ-004 v2.1 (52 setas); matriz §2.4 | **Fechado** | Classe `SolicitacaoEspera` e `DESISTIU` ainda fora do CLS-001 (**I3**, LAC-10); tabela `solicitacao_espera` fora do DER (**I4**, R7-04) |

**O que P1–P6 não podiam fechar sozinhos (registrado, não corrigido em silêncio):** a incorporação ao **modelo oficial** (I3), a **persistência** da fila e o `CHECK` das situações (I4) e a homologação dos achados na tabela do I5. Os resíduos acima estão encaminhados na §6.

---

## 2. Mapa caso de uso → classes → operações → serviços → fronteiras → persistência

Legenda: **OP** = operação do modelo de classes; **AP** = responsabilidade de aplicação (FASE5-REV §5.2, atualizada na Fase 6 com AP-06); **IR** = interface de infraestrutura citada na matriz da Fase 6; **tabela** = tabela prevista para o DER da Fase 7 (proposta, não DER).

| Caso de uso | RF | Classes de domínio | Operações | Serviço de aplicação | Fronteira / infraestrutura | Tabela prevista | Evidência |
|---|---|---|---|---|---|---|---|
| **UC-001** Autenticar | RF-001, RF-002 | `Usuario`, `Perfil`, `Permissao`, `RegistroAuditoria` | OP-01 `podeAutenticar`, OP-02 `confereCredencial` | **AP-01** `ServicoAutenticacao` | **IR-01** (usuário), **IR-02** (autorização) | `usuario`, `perfil`, `permissao`, `perfil_permissao`, `auditoria` | SEQ-001 |
| **UC-024** Consultar horários | RF-024 | `Agenda`, `Disponibilidade`, `Agendamento` | OP-11 `consultarHorariosDisponiveis` | **AP-03** `ServicoAgenda` (leitura) | IR de disponibilidade | `disponibilidade`, `agendamento`, `solicitacao_espera` (oferta aberta reserva o slot) | SEQ-002 (msg. 1) |
| **UC-025** Solicitar agendamento | RF-025, RF-026 | `Agendamento`, `Vinculo` | OP-22 `estaAtivo`, `Agendamento.solicitar` (cria `CONFIRMADO`), OP-13 como **efeito** | **AP-03** | IR de agendamento (reserva atômica — R7-07), AP-04 (e-mail), AP-02 (auditoria) | `agendamento`, `disponibilidade`, `auditoria` | SEQ-002; ATV-001; EST-001 (T0); COM-001 |
| **UC-027** Cancelar | RF-027 (+RF-035) | `Agendamento`, `Atendimento`, `SolicitacaoEspera` | OP-15 `podeSerCancelado`, OP-14 `cancelar`, OP-16 `estaCancelada`, OP-27 `encerrar` (via fila) | **AP-03** | AP-02, AP-04, **AP-06** (`ofertarVaga`) | `agendamento`, `disponibilidade`, `auditoria` | SEQ-003; EST-001 (T2); ATV-001; COM-001 |
| **UC-028** Consultar os próprios agendamentos | RF-028 | `Agendamento` | OP-19 `consultarMeus` | **AP-05** `ServicoConsulta` (projeção) | IR de agendamento | `agendamento` (projeção `read-only`) | SEQ-003 (msg. 1) |
| **UC-030 / UC-032** Registrar atendimento / auditoria (`<<include>>`) | RF-030, RF-032 | `Atendimento`, `RegistroAuditoria` | OP-17 `concluir`, OP-20 `Atendimento.registrar`, `RegistroAuditoria.registrar` | **AP-02** `ServicoAuditoria` | IR de auditoria | `atendimento`, `auditoria` | SEQ-003 (`opt`); ATV-001 |
| **UC-033** Notificar por e-mail | RF-033 | *(nenhuma — fronteira)* | — | **AP-04** `ServicoEnvioMensagem.notificar` | **Adaptador** do Serviço Externo de E-mail (DEC-009/DEC-022) | *(nenhuma tabela — DEC-022)* | SEQ-002/003/004 (`alt` de envio) |
| **UC-034** Entrar, consultar e sair da fila | RF-034 | `SolicitacaoEspera`, `Vinculo` | OP-23 `registrarEntrada`, OP-28 `posicaoNaFila`, OP-27 `encerrar(DESISTIU)` | **AP-06** `ServicoListaEspera` | IR da fila | `solicitacao_espera` | SEQ-004 (`opt` de consulta/saída); ATV-001 |
| **UC-035** Ofertar vaga | RF-035 | `SolicitacaoEspera`, `Disponibilidade` | OP-24 `proximoDaFila`, OP-25 `abrirOferta(horario, prazoAceite)` | **AP-06** (acionado por **AP-03**) | AP-04 (e-mail de oferta) | `solicitacao_espera` (+ reserva do slot) | SEQ-004 (`opt <<extend>>`); SEQ-003 (`opt`) |
| **UC-036** Responder à oferta | RF-036 | `SolicitacaoEspera`, `Agendamento` | OP-26 `validarPrazo`, OP-27 `encerrar(ACEITA/RECUSADA/EXPIRADA)`, `Agendamento.solicitar` | **AP-06** + **AP-03** (aceite) | AP-02, AP-04 | `solicitacao_espera`, `agendamento` | SEQ-004 (aceite/recusa/vencimento) |
| **UC-037** Registrar não comparecimento | RF-037 | `Agendamento` | OP-18 `registrarFalta` | **AP-03** | AP-02 | `agendamento` (`data_nao_comparecimento`) | SEQ-003 (`opt`); EST-001 (T3) |

### 2.1 Leitura do mapa

1. **Toda mensagem dos diagramas tem dono.** As 136 setas das quatro sequências (85 solicitações e 51 retornos) passam por uma operação (OP-01…OP-28), uma responsabilidade de aplicação (AP-01…AP-06) ou uma interface de infraestrutura (IR-01/IR-02). Não há mensagem sem âncora — requisito do "teste de não invenção" da FASE5-REV.
2. **A fronteira de e-mail é a única sem classe de domínio.** UC-033 é um caso de uso de **fronteira**: `ServicoEnvioMensagem` é interface de aplicação/infraestrutura, não entidade. Por isso a coluna "tabela" fica vazia (DEC-009 + DEC-022) e o adaptador do Serviço Externo de E-mail entra no diagrama de componentes da Fase 7, não no DER.
3. **A fila é o único conjunto de casos com estado próprio fora de `Agendamento`.** `SolicitacaoEspera` tem situação (6 valores com `DESISTIU`), `dataHoraEntrada` e prazo — é ela que sustenta RF-034 a RF-036 e que precisa de tabela (R7-04).
4. **UC-029 e UC-031 não têm diagrama comportamental.** São consultas que aparecem na matriz da Fase 5, mas não foram desenhadas nas sequências da Fase 6. Não é lacuna de requisito (têm CA e CT), é **lacuna de comportamento** — declarada como parcial no checklist (§5, item 12), porque a arquitetura da consulta de pacientes por vínculo (DEP-04 / IMP-CMP-07) depende delas.

---

## 3. Coerência com a arquitetura planejada — achados R7

Cada achado compara uma **exigência/afirmação da arquitetura e persistência** (análise do I4) com o **comportamento aprovado** (sequências, estados, casos de uso v2.1). Severidade: **A** = impede fechar a Fase 7 sem correção; **B** = corrige texto/consistência antes da entrega; **C** = observação de projeto.

| ID | Sev. | Divergência | Evidência | Correção proposta | Dono |
|---|---|---|---|---|---|
| **R7-01** | **A** | A análise do I4 ainda inventaria as mensagens **antigas** das sequências: `verificarConflito` (2.3), `notificar` como "condicional" e `confirmar(agendamento)` (3.1), além de "SEQ-004 — preencher encaixe" fora de escopo | `fase-06-impacto-comportamental-persistencia.md` §3.1 (linhas 2.3, 2.6, 3.1, 3.5 e o parágrafo da SEQ-004) × SEQ-002/003/004 v2.1 | Reescrever o inventário §3.1 com as mensagens atuais: `Agendamento.solicitar` (cria `CONFIRMADO`), `notificar` obrigatório, `registrar("FALHA_ENVIO_EMAIL")`, `posicaoNaFila`, `abrirOferta(horario, prazoAceite)` e `encerrar(DESISTIU)` | **I4** |
| **R7-02** | **A** | `IMP-DER-02` pede `CHECK` com **5 a 6 valores** para `situacao`; o comportamento fixa **4** (DEC-016) e a fila precisa de `CHECK` próprio | IMP-DER-02 × EST-001 v2.1 (4 situações) e DEC-016 | `agendamento.situacao` ∈ {`CONFIRMADO`,`CANCELADO`,`REALIZADO`,`NAO_COMPARECEU`}; `solicitacao_espera.situacao` ∈ {`AGUARDANDO`,`OFERTADA`,`ACEITA`,`RECUSADA`,`EXPIRADA`,`DESISTIU`}; enum do CLS-001 igual | **I4** (+I3 no enum) |
| **R7-03** | **A** | `ARQ-02`, `IMP-DER-09` e `IMP-CMP-01` tratam a notificação como **pendente** (DEC-009) e usam `IGatewayNotificacao`; a decisão está tomada | ARQ-02/IMP-DER-09/IMP-CMP-01 × DEC-009, DEC-022 e DEC-029 | Fronteira única `ServicoEnvioMensagem` (interface) + adaptador do Serviço Externo de E-mail; **sem** tabela `notificacao`; falha auditada e repetível; renomear `IGatewayNotificacao` | **I4** |
| **R7-04** | **A** | `IMP-DER-10` mantém a fila **fora do DER** ("enquanto DEC-010 não for decidido"); a DEC-027 foi aprovada e a SEQ-004 existe | IMP-DER-10 × DEC-027, SEQ-004, UC-034 a UC-036 | Criar `solicitacao_espera` (`id`, FK psicólogo, FK paciente, período, `data_hora_entrada`, `situacao`, `horario_ofertado` ↔ `disponibilidade`, `prazo_aceite`, `data_hora_resposta`); ordem por `data_hora_entrada` | **I4** |
| **R7-05** | **A** | A tabela §5.1 do I4 modela **6 transições** com `SOLICITADO` inicial e coluna `data_confirmacao`; o EST-001 tem **4 transições** e não tem "confirmar" | §5.1 × EST-001 v2.1 (T0–T3) e DEC-016/DEC-017 | Transições T0 (criação → `CONFIRMADO`), T1 (`CONFIRMADO`→`CANCELADO`), T2 (`CONFIRMADO`→`REALIZADO`), T3 (`CONFIRMADO`→`NAO_COMPARECEU`); remover `data_confirmacao` (a confirmação é simultânea à criação) | **I4** |
| **R7-06** | **B** | **P5 parcial:** as especificações oficiais de casos de uso (Fases 3/4) não têm "Objetivo"/"RFs cobertos", não usam `UC-0RF` e citam `DEC-4`, `DEC-5` e a **DEC-012 (não adotada)** | `03-uml/Casos de uso/especificacoes-casos-de-uso-criticos.md` e `-demais.md` | **Corrigido no lote da Fase 9 (dono I2):** os dois arquivos foram para a **v1.1**, com Objetivo/RFs cobertos, `UC-0RF` onde o caso é de um RF só, E1 da DEC-4 resolvido, DEC-5 e DEC-012 fechadas e `<<include>>` do e-mail apontando para UC-033; o conteúdo dos fluxos foi preservado | **I2** |
| **R7-07** | **B** | **Reserva do horário em dois lugares.** `IMP-CMP-03` exige `reservarSeLivre` atômico (DEP-01); a SEQ-002 reserva via `Agendamento.solicitar` e a SEQ-004 (aceite) reserva via o mesmo `agendar`, mas a **oferta aberta** também reserva | DEP-01/IMP-CMP-03 × SEQ-002, SEQ-004 (`abrirOferta`) | Um **único caminho** de reserva (`reservarSeLivre`) usado por solicitação e por aceite; a oferta aberta marca o slot como reservado com prazo e o libera ao encerrar sem próximo. O índice único é a última defesa (RN-005) | **I4** (+I3 se houver operação nova) |
| **R7-08** | **B** | **Notificação dentro do fluxo × pós-commit.** As sequências mostram `notificar` logo após a auditoria; `TRS-02`/`ARQ-07`/`IMP-CMP-08` exigem envio **fora** da transação (outbox) | SEQ-002/003/004 × TRS-02, DEP-02, ARQ-07 | Declarar no texto da seção 25 que a ordem das sequências é **lógica**; na arquitetura, a gravação do evento (*outbox*) é transacional e o envio é pós-commit. A auditoria da falha usa **transação independente** (TRS-05) | **I4** + I6 (§25) |
| **R7-09** | **B** | **Consulta de paciente fora do vínculo.** DEP-04/IMP-CMP-07 exigem que toda consulta de paciente passe por `vinculo`; **UC-029 não tem diagrama** e UC-028 não explicita o filtro | DEP-04, IMP-CMP-07, RNF-006 × UC-028 (OP-19) e UC-029 (ausente) | `consultarMeus` filtra pelo **titular autenticado** (RNF-005); toda consulta profissional passa por `IConsultaPacientesVinculados`; desenhar UC-029 na Fase 9 se o grupo quiser fechar o comportamento | **I2** (UC-029) + **I4** (componente) |
| **R7-10** | **B** | **Auditoria recebendo entidade.** DEP-03/DEP-06/IMP-CMP-04 exigem que `ServicoAuditoria` receba **identificadores**; as sequências escrevem `registrar(operacao, responsavel, …)` e o termo "responsável" é ambíguo | SEQ-001/002/003/004 × DEP-03/DEP-06 | Parâmetro `idUsuarioResponsavel` (nunca objeto), + `situacaoAnterior`/`situacaoNova` quando houver transição (IMP-DER-05); texto das sequências não muda, o contrato é detalhado no dicionário (Fase 7) | **I4** + I3 (contrato da operação) |
| **R7-11** | **C** | **Risco de "hub onipotente".** COM-001 concentra 12 das 17 mensagens no `ServicoAgenda`; se ele também autenticar, auditar internamente, enviar e-mail e gerir fila, vira classe onipotente (proibida pelo plano §5.2) | COM-001 × AP-01…AP-06 | `ServicoAgenda` coordena **apenas** o ciclo do agendamento e delega: AP-01 (autenticação), AP-02 (auditoria), AP-04 (e-mail), AP-06 (fila). Nenhum serviço chama a apresentação; dependências apontam para dentro | **I4** (componentes) + I3 (SRP) |
| **R7-12** | **C** | **Fonte de tempo única.** A guarda `[antes do horário marcado]` (DEC-011/028), o prazo de aceite (DEC-027) e a expiração da oferta dependem de relógio; `ARQ-06`/`IMP-CMP-05` propõem `IServicoTempo`, mas P-05/P-19 seguem abertas | SEQ-003/004, EST-001 × ARQ-06, IMP-CMP-05, P-05, P-19 | Declarar no dossiê (§25/§26) que a comparação de tempo é feita pelo **servidor**, via `ServicoTempo` (fuso único), e que o prazo da oferta é persistido com a data/hora do servidor | **I4** + I1 (P-05/P-19) |

### 3.1 Achados que **não** são divergências (verificados e coerentes)

| Ponto | Verificação |
|---|---|
| Auditoria em toda operação de escrita (RN-009/RF-032) | SEQ-001 7, SEQ-002 6/9, SEQ-003 4/12, SEQ-004 3/9/15/23 — todas com `ServicoAuditoria` |
| Fronteira de e-mail sem tabela (DEC-022) | Nenhuma classe `Notificacao` em `03-uml/Classes`/`Dominio`; UC-033 é caso de fronteira |
| Reserva atômica (RN-005) | `Agendamento.solicitar` é a única operação de criação; **R7-07** pede o caminho único com a fila |
| Estado do agendamento idêntico em domínio, sequência, estados e dossiê | 4 situações nos quatro artefatos de I2; o oficial (CLS-001) é resíduo do I3 |
| Filas sem prioridade manual (DEC-027) | `proximoDaFila` ordena só por `dataHoraEntrada`; nenhuma mensagem de prioridade |

---

## 4. Candidatos a pacote e componente (para o Integrante 4)

Esta seção é **insumo**, não desenho: o Integrante 4 decide nomes finais e produz PAC/CMP/IMP. A regra de dependência segue RNF-006 (acesso por vínculo), CQ-FLE-03 (sem ciclo entre pacotes) e a separação apresentação/aplicação/domínio/persistência.

### 4.1 Pacotes (quatro, sem ciclo)

| Pacote | Contém | Depende de | Não pode conter |
|---|---|---|---|
| `apresentacao` | telas/controladores, DTOs de entrada e saída | `aplicacao` | regra de negócio, SQL, acesso direto a repositório |
| `aplicacao` | AP-01…AP-06, unidade de trabalho, *outbox*, orquestração de casos de uso | `dominio` | entidade de domínio, SQL, chamada direta ao provedor de e-mail |
| `dominio` | `Usuario`, `Perfil`, `Permissao`, `Psicologo`, `Paciente`, `Vinculo`, `Agenda`, `Disponibilidade`, `Agendamento`, `Atendimento`, `SolicitacaoEspera`, `RegistroAuditoria`, enumerações e **interfaces** de repositório (ARQ-01) | — *(ninguém)* | infraestrutura, framework, `confirmar()` |
| `infraestrutura` | implementações dos repositórios, adaptador de e-mail, *outbox*, relógio, acesso ao SGBD | `dominio` (implementa as interfaces) | regra de negócio |

### 4.2 Componentes e responsabilidades

| Componente | Pacote | Responsabilidade | Casos atendidos | Dependências permitidas | Origem |
|---|---|---|---|---|---|
| `ServicoAutenticacao` (AP-01) | aplicação | autenticar, criar/invalidar sessão, obter permissões | UC-001 | IR-01, IR-02, `ServicoAuditoria` | AP-01 |
| `ServicoAgenda` (AP-03) | aplicação | ciclo do agendamento: consultar, solicitar, cancelar, concluir, registrar falta | UC-024, UC-025, UC-027, UC-028, UC-036 (aceite), UC-037 | repositórios, `ServicoAuditoria`, `ServicoEnvioMensagem`, `ServicoListaEspera`, `ServicoTempo` | AP-03 |
| `ServicoListaEspera` (AP-06) | aplicação | entrar, consultar posição, sair, ofertar, aceitar, recusar, expirar | UC-034, UC-035, UC-036 | repositório da fila, `ServicoAgenda` (no aceite), `ServicoAuditoria`, `ServicoEnvioMensagem` | AP-06 |
| `ServicoAuditoria` (AP-02) | aplicação | registrar evento com ator, data/hora, operação e situação anterior/nova | UC-032 (`<<include>>` de todos) | repositório de auditoria | AP-02, ARQ-04 |
| `ServicoEnvioMensagem` (AP-04) | aplicação (interface) + infraestrutura (adaptador) | solicitar envio de confirmação, cancelamento e oferta; devolver `entregue \| falha` | UC-033 | adaptador do Serviço Externo de E-mail | AP-04, DEC-009/022 |
| `ServicoConsulta` / projeções (AP-05) | aplicação | listagens e consultas de leitura, sem poluir entidades | UC-028, UC-029, UC-031 | repositórios (leitura) | AP-05 |
| `ConsultaPacientesVinculados` | aplicação | resolver paciente **somente** via vínculo | UC-017, UC-029, UC-031 | repositório de vínculo | DEP-04, IMP-CMP-07 |
| Repositórios (IR-01/IR-02 + ARQ-01) | domínio (interface) / infraestrutura (implementação) | persistir e consultar; `reservarSeLivre` atômico no de agendamento | todos | SGBD (só na implementação) | ARQ-01, IMP-CMP-03 |
| `UnidadeTrabalho` | aplicação | fronteira transacional das escritas | UC-001, UC-025, UC-027, UC-030, UC-036 | repositórios | ARQ-03, TRS-01/03/04 |
| `Outbox` | aplicação/infraestrutura | evento pós-commit para envio | UC-033 | repositório de outbox | ARQ-07, TRS-02 |
| `ServicoTempo` | aplicação (interface) | data/hora e fuso do servidor | UC-024, UC-027, UC-036, UC-037 | — | ARQ-06, IMP-CMP-05 |
| `ServicoAutorizacao` | aplicação | permissão e vínculo por operação | UC-001, UC-017, UC-028, UC-029 | IR-02, repositório de vínculo | ARQ-05 |

### 4.3 Teste de "classe onipotente" nos candidatos

| Pergunta | Resposta |
|---|---|
| Algum componente autentica **e** agenda **e** audita **e** envia e-mail **e** gerencia fila? | **Não.** `ServicoAgenda` coordena o ciclo; autenticação é AP-01, auditoria AP-02, envio AP-04, fila AP-06 |
| Algum componente de domínio conhece infraestrutura? | **Não.** As interfaces de repositório ficam no domínio; as implementações, na infraestrutura (DIP) |
| Algum componente acumula UI + regra + SQL? | **Não.** Quatro pacotes com dependência em uma direção |
| Há chamada de apresentação a partir de domínio/aplicação? | **Não.** Nenhuma mensagem das sequências sai do domínio/aplicação para a tela |

---

## 5. Checklist de coerência arquitetura × casos de uso

| # | Item verificado | Situação | Evidência / ressalva |
|---|---|---|---|
| 1 | Todo caso de uso desenhado tem classe de domínio identificada | **OK (12 de 12)** | §2; UC-033 é fronteira, sem classe de propósito (DEC-022) |
| 2 | Toda mensagem de sequência corresponde a operação, serviço ou interface conhecida | **OK (136/136)** | matriz da Fase 6 §2.1–2.4 |
| 3 | Nenhuma operação pertence a uma classe "Sistema"/"Gerenciador" | **OK** | OP-01…OP-28 distribuídas nas 12 classes + AP-01…AP-06 |
| 4 | Todo caso de escrita gera evento de auditoria (RN-009) | **OK** | SEQ-001/002/003/004; RF-032 |
| 5 | Todo efeito externo tem fronteira declarada (sem classe de domínio) | **OK** | UC-033/AP-04/DEC-022 |
| 6 | Nenhum componente candidato é onipotente | **OK** | §4.3 |
| 7 | Fronteira de e-mail sem tabela de notificação | **OK no comportamento; divergente na análise do I4** | **R7-03** |
| 8 | Situações do agendamento idênticas em estados, sequências, classes e banco | **Parcial** | EST/SEQ OK; CLS-001 oficial e `CHECK` pendentes (**R7-02**, I3/I4) |
| 9 | Fila com estado, ordem e prazo persistíveis | **Pendente** | **R7-04** (I4) |
| 10 | Reserva de horário por um único caminho atômico (RN-005) | **Parcial** | **R7-07** (I4) |
| 11 | Notificação pós-commit, sem segurar a transação | **Pendente** | **R7-08**; depende de P-15 (outbox) |
| 12 | Toda consulta de paciente profissional passa por vínculo (RNF-006) | **Parcial** | **R7-09**; UC-029 sem diagrama |
| 13 | Guardas temporais com fonte de tempo única e fuso definido | **Pendente** | **R7-12**; P-05/P-19 abertas |
| 14 | Pacotes sem ciclo de dependência (CQ-FLE-03) | **OK no mapa proposto** | §4.1; conferir no diagrama final do I4 |
| 15 | Rastreabilidade UC → RF → CA → CT sem órfãos | **OK** | matriz da Fase 6 v2.1 + testes da Fase 8 |
| 16 | Documentação de arquitetura conforme ISO/IEC/IEEE 42010 (visões, stakeholders, preocupações) | **A verificar no I4/I5** | seções 25/26 e CQ-COM-02 |

**Resumo:** **8 itens OK**, **4 parciais** (7, 8, 10 e 12), **3 pendentes** (9, 11 e 13) e **1 a verificar no I4/I5** (16). Nenhum parcial/pendente é do Integrante 2 — todos estão nos achados R7-02, R7-04, R7-07, R7-08, R7-09 e R7-12, com dono definido.

---

## 6. Encaminhamentos por dono

| Dono | O que fazer | Achados |
|---|---|---|
| **I3** | incorporar OP-01…OP-28, AP-06, `SolicitacaoEspera` + `DESISTIU`, as 4 situações; retirar `Agendamento.confirmar()`; desenhar ator Serviço Externo de E-mail e `<<extend>>` | R6-09, LAC-10, LAC-12, R7-02 (enum), R7-11 (SRP) |
| **I4** | revisar o inventário §3.1 e a tabela §5.1; fixar `CHECK` de 4 situações; criar `solicitacao_espera`; renomear a fronteira de e-mail; caminho único de reserva; declarar outbox e tempo do servidor | **R7-01 a R7-05, R7-07, R7-08, R7-10, R7-11, R7-12** |
| **I5** | homologar Q6-01…Q6-07 (Fase 6) e LAC-11 (CT-033…CT-037) na matriz mestra; medir CQ-ADE-04/CQ-CON-04/CQ-CON-05/CQ-COM-01/CQ-COM-02/CQ-FLE-03 depois da Fase 7 | Q6, LAC-11 |
| **I6** | usar este documento como insumo das seções 25 e 26; corrigir a lista de pendências da seção 25–36 (ainda cita `SOLICITADO`) | INT-12, R7-06 |
| **I1** | fechar P-05 (modelo de tempo), P-15 (outbox) e P-19 (origem do carimbo de tempo) | R7-08, R7-12 |
| **I2** | revisar as especificações oficiais de casos de uso (Objetivo/RFs cobertos, `UC-0RF`, remoção da DEC-012) e, se o grupo quiser, desenhar UC-029 | R7-06, R7-09 |

---

## 7. Rastreabilidade deste documento

| Seção | Origem |
|---|---|
| §1 | `etapas-e-responsabilidades.md` §2 (P1–P6); FASE6-REV-I2 §6 e §7; dossiê §21–24 v2.1 |
| §2 | matriz da Fase 6 §2.1–2.4 (mensagens × OP/AP/IR); FASE5-REV-I2 §5.2 (AP-01…AP-05); FASE6-REV-I2 (AP-06) |
| §3 | `fase-06-impacto-comportamental-persistencia.md` §3.1, §4.1, §4.2, §5.1, §6.1, §6.2; DEC-009, DEC-016, DEC-017, DEC-022, DEC-027, DEC-028, DEC-029 |
| §4 | ARQ-01 a ARQ-08; IMP-CMP-01 a IMP-CMP-09; RNF-006; CQ-FLE-03; plano §15 (DIP) |
| §5 | plano §16.1 (conteúdo de arquitetura); ISO/IEC/IEEE 42010; critérios CQ-* citados |
| §6 | `etapas-e-responsabilidades.md` §1 (donos) |

**Relação com o dossiê:** este documento é insumo das seções **25** (arquitetura) e **26** (persistência) e não as substitui; o texto final continua sendo do Integrante 4, consolidado pelo Integrante 6.

**Registro de participação:** Integrante 2 (Aquiles Angelo) — fechamento de P1 a P6, mapa de **12 casos de uso** (11 linhas, com UC-030 e UC-032 na mesma) para classes/operações/serviços/fronteiras/tabelas, 12 achados R7 e checklist de 16 itens contra a arquitetura planejada.
