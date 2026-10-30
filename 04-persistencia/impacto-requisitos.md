# Impacto dos Requisitos em Persistência e Arquitetura (Integrante 4)

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Versão:** v2.0 · **Data:** 29/10/2026
**Fase do plano:** Fase 3 (documento original) com **revisão de alinhamento** feita na entrada da Fase 7
**Baseline de requisitos:** `02-requisitos/requisitos-funcionais.md` (**RF-001 a RF-037**), `02-requisitos/regras-negocio.md` (**RN-001 a RN-022**), `02-requisitos/requisitos-nao-funcionais.md` (**RNF-001 a RNF-012**), `02-requisitos/criterios-aceite.md` (**CA-RF-001 a CA-RF-037**) e `01-planejamento/decisoes.md` (**DEC-001 a DEC-030**).

> **O que mudou nesta versão.** A v1.0 deste documento usava uma numeração **própria** de RF (RF-001 a RF-010) e de RN (RN-001 a RN-006) que **não correspondia** à baseline do Integrante 1. Isso foi registrado como pendência **P11** em [`01-planejamento/etapas-e-responsabilidades.md`](../01-planejamento/etapas-e-responsabilidades.md) (achados **Q3-11** e **INT-06**). A v2.0 reescreve o documento inteiro sobre a numeração oficial e incorpora as decisões aprovadas em 25 e 28/10/2026 (DEC-009 a DEC-030). O mapa de renumeração está na §7, para que nenhuma referência antiga se perca.

---

## 1. Objetivo e limites

Analisar RF, RNF, RN e critérios de aceite sob a ótica de **persistência, integridade e arquitetura**, produzindo a lista de exigências que a Fase 7 precisa atender no DER, no modelo relacional, no dicionário de dados e nos diagramas de pacotes, componentes e implantação.

**Fora do escopo deste documento:** o DER, o modelo relacional, o dicionário de dados e o DDL. Eles estão em [`der/der-001-logico.md`](der/der-001-logico.md), [`modelo-relacional.md`](modelo-relacional.md), [`dicionario-de-dados.md`](dicionario-de-dados.md) e [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql). Este documento é o **insumo** que justifica cada decisão de modelagem tomada lá.

**Limite de autoridade:** os identificadores `RF-*`, `RN-*`, `RNF-*`, `CA-*` e `DEC-*` pertencem aos Integrantes 1 e ao grupo. Este documento **não cria** requisito: apenas registra impacto e, quando o modelo precisa de algo que a baseline ainda não fixa, abre uma proposta numerada (`RNF-013` a `RNF-022`, `RN-023` e `RN-024`) ou uma pendência (`P-20` e `P-21`).

---

## 2. Requisitos funcionais e impacto em persistência

Legenda de impacto: **Alto** = exige estrutura de dados própria ou restrição de integridade; **Médio** = exige coluna, índice ou filtro de autorização; **Baixo** = leitura ou comportamento de aplicação sem nova estrutura.

| RF | Título oficial | Impacto | Efeito concreto na persistência |
|---|---|---|---|
| RF-001 | Autenticar usuário | Alto | `usuario.identificacao` (único), `usuario.hash_senha`, `usuario.situacao_conta` (DEC-013) e `usuario.id_perfil`; leitura do caminho `usuario → perfil → perfil_permissao → permissao` |
| RF-002 | Encerrar sessão | Baixo | **Sem tabela.** DEC-020: sessão é estado volátil de aplicação, não entidade persistida |
| RF-003 | Cadastrar usuário | Alto | `INSERT` em `usuario` com `id_perfil` obrigatório e `hash_senha` gerado na aplicação; RN-002 proíbe coluna de senha em texto puro |
| RF-004 | Alterar dados de usuário | Médio | `UPDATE` restrito por coluna e por autorização; RN-009 exige auditoria com situação anterior/nova quando a alteração for de situação (DEC-024) |
| RF-005 | Ativar usuário | Alto | Transição `situacao_conta` → `ATIVO`; RN-009 + DEC-024 exigem `situacao_anterior`/`situacao_nova` na auditoria |
| RF-006 | Bloquear usuário | Alto | Transição `situacao_conta` → `BLOQUEADO`; RN-001 precisa que o bloqueio seja **persistido**, não só validado em memória |
| RF-007 | Gerenciar perfis | Médio | `perfil`; a associação com permissões é N:N resolvida em `perfil_permissao` |
| RF-008 | Gerenciar permissões | Médio | `permissao` + `perfil_permissao`; a revogação remove a **associação**, não a permissão |
| RF-009 | Consultar painel administrativo | Baixo | Sem estrutura própria; agrega consultas de RF-010 a RF-013 |
| RF-010 | Consultar usuários cadastrados | Médio | Projeção que **nunca** inclui `hash_senha` (RNF-001, RN-002) |
| RF-011 | Consultar psicólogos cadastrados | Médio | `psicologo` + `psicologo_area_atuacao`; filtro por perfil do solicitante |
| RF-012 | Consultar clientes/pacientes cadastrados | Médio | `paciente`; consulta administrativa não concede acesso profissional (RN-003) |
| RF-013 | Consultar registros de auditoria | Alto | `registro_auditoria` somente leitura, com filtros por período, responsável e operação; RN-008 restringe ao Administrador autorizado |
| RF-014 | Cadastrar psicólogo | Alto | `psicologo` com `id_usuario` **opcional e único** (DEC-021); cadastro existe sem conta |
| RF-015 | Atualizar perfil profissional | Médio | `UPDATE` em `psicologo` limitado aos campos liberados (PC-04) |
| RF-016 | Associar área de atuação ao psicólogo | Alto | N:N `psicologo_area_atuacao`; catálogo `area_atuacao` (INC-09 permanece aberta quanto à manutenção do catálogo) |
| RF-017 | Consultar clientes/pacientes vinculados | Alto | Consulta **obrigatoriamente** mediada por `vinculo` com `situacao = 'ATIVO'` (RN-003, DEC-015); nunca por `agendamento → paciente` (DEP-04) |
| RF-018 | Cadastrar cliente/paciente | Alto | `paciente` com `id_usuario` opcional e único (DEC-021) e `situacao_cadastral` (DEC-014) |
| RF-019 | Atualizar cadastro administrativo de cliente/paciente | Médio | `UPDATE` em `paciente` sem tocar em situação nem em conteúdo clínico |
| RF-020 | Alterar situação do cliente/paciente | Alto | Transição de `situacao_cadastral` (`ATIVO`/`SUSPENSO`/`INATIVO`, DEC-014) + auditoria com valor anterior e novo (RN-009, DEC-024) |
| RF-021 | Vincular cliente/paciente a psicólogo | Alto | `vinculo` com `situacao`, `data_inicio` e `data_fim` (DEC-015); no máximo **um vínculo vigente** por par (RN-016 proposta) |
| RF-022 | Consultar informações do próprio cadastro | Médio | Projeção por `paciente.id_usuario` do próprio solicitante (RN-004) |
| RF-023 | Cadastrar disponibilidade do psicólogo | Alto | `disponibilidade` como **slot discreto** — `data`, `hora_inicio`, `duracao_minutos` (DEC-018); pertence à `agenda` do próprio psicólogo (RN-011) |
| RF-024 | Consultar horários disponíveis | Alto | Consulta de slots **livres**: sem agendamento `CONFIRMADO` e sem oferta aberta (RN-005, RN-010, DEC-027); exige índice por `(id_agenda, data, hora_inicio)` |
| RF-025 | Solicitar agendamento | Alto | `INSERT` em `agendamento` **já com `situacao = 'CONFIRMADO'`** (DEC-016, DEC-017); reserva do slot na **mesma transação** (TRS-03, DEP-01) |
| RF-026 | Confirmar agendamento automaticamente | Alto | Não há transição de estado: a confirmação é a própria criação (DEC-016). Exige exclusividade do slot por índice único (RN-005) |
| RF-027 | Cancelar agendamento | Alto | Transição `CONFIRMADO` → `CANCELADO` com `data_cancelamento`, `id_usuario_cancelamento` e auditoria (RN-009, RN-012, DEC-024, DEC-028); libera o slot e dispara a oferta à fila (RF-035) |
| RF-028 | Consultar os próprios agendamentos | Médio | Consulta por `agendamento.id_paciente` do solicitante; projeção da `situacao` |
| RF-029 | Consultar agenda do psicólogo | Médio | Consulta por `agendamento.id_psicologo`; agendamento futuro com vínculo encerrado aparece marcado como "paciente sem vínculo ativo" (DEC-015) — **derivação**, não coluna nova |
| RF-030 | Registrar conceitualmente um atendimento | Alto | `INSERT` em `atendimento` com FK **obrigatória** para `agendamento` (RN-017 proposta); a mesma transação muda `agendamento.situacao` para `REALIZADO` (DEC-030) |
| RF-031 | Consultar histórico permitido de atendimentos | Médio | Consulta por `(id_psicologo, id_paciente)` mediada por vínculo (RN-003); `contexto_sessao` é texto curto, sem prontuário (DEC-008) |
| RF-032 | Registrar evento de auditoria | Alto | `registro_auditoria` **append-only** (RN-014), com `data_hora`, `id_usuario`, `operacao`, `situacao_anterior` e `situacao_nova` (DEC-024) |
| RF-033 | Enviar notificação por e-mail | Médio | **Sem tabela** (DEC-022): a fronteira é a interface `ServicoEnvioMensagem`. Exige `usuario.email` como destino; a falha vira registro de auditoria com `operacao = 'FALHA_ENVIO_EMAIL'` (DEC-029) |
| RF-034 | Entrar na lista de espera | Alto | `solicitacao_espera` com `data_hora_entrada` (ordem da fila), `situacao` e vínculo obrigatório (DEC-027) |
| RF-035 | Ofertar horário liberado à lista de espera | Alto | Transição `AGUARDANDO` → `OFERTADA` com `id_disponibilidade`, `prazo_aceite` e reserva do slot durante o prazo (DEC-027, LAC-15) |
| RF-036 | Responder à oferta de vaga | Alto | Transições `OFERTADA` → `ACEITA`/`RECUSADA`/`EXPIRADA`, com `data_hora_encerramento` e `id_agendamento` quando houver aceite |
| RF-037 | Registrar não comparecimento | Alto | Transição `CONFIRMADO` → `NAO_COMPARECEU` com `data_nao_comparecimento` e auditoria (DEC-025, DEC-024) |

**Resultado:** 24 RF com impacto **Alto**, 12 com impacto **Médio** e 1 sem estrutura própria (RF-002). Nenhum RF fica órfão de persistência: todos aparecem no DER ou em uma decisão explícita de **não persistir** (RF-002 e RF-033).

---

## 3. Regras de negócio e restrição de integridade correspondente

| RN | Regra (resumo) | Restrição que a Fase 7 implementa |
|---|---|---|
| RN-001 | Usuário bloqueado não autentica | `usuario.situacao_conta` persistido + `CHECK` no domínio de valores (DEC-013); consulta de autenticação filtra `= 'ATIVO'` |
| RN-002 | Senha nunca em texto puro | Apenas `usuario.hash_senha`; **não existe** coluna de senha original nem de senha recuperável |
| RN-003 | Psicólogo só acessa paciente vinculado | `vinculo` como **filtro obrigatório** das consultas profissionais; `situacao = 'ATIVO'` e janela `data_inicio`/`data_fim` (DEC-015) |
| RN-004 | Paciente só acessa o próprio cadastro | Consulta por `paciente.id_usuario = solicitante.id`; nunca por identificador vindo do cliente |
| RN-005 | Um horário não tem dois agendamentos ativos | Índice único sobre o slot ocupado (`uk_agendamento_slot_ativo`) + `SELECT … FOR UPDATE` na linha de `disponibilidade` (TRS-03) |
| RN-006 | Agendamento cancelado não pode ser realizado | Guarda de transição: `atendimento` só é criado a partir de `agendamento.situacao = 'CONFIRMADO'`; `CHECK` impede `REALIZADO` sem atendimento correspondente |
| RN-007 | Atendimento exige psicólogo e paciente válidos | `atendimento` com FKs obrigatórias e **FK composta** para o par do `agendamento` (ver §4.3 de `modelo-relacional.md`) |
| RN-008 | Só o Administrador autorizado consulta auditoria | Controle de acesso na aplicação + ausência de `UPDATE`/`DELETE` para o usuário da aplicação |
| RN-009 | Alteração de situação preserva rastreabilidade | Toda transição grava `registro_auditoria` na **mesma transação** (RN-015 proposta) |
| RN-010 | Solicitação só em horário disponível | Slot livre verificado na transação de reserva, não só na consulta (TRS-06) |
| RN-011 | Disponibilidade só na própria agenda | `disponibilidade.id_agenda` → `agenda.id_psicologo`; a aplicação compara com o solicitante, e o `CHECK` de coerência é feito pela FK composta descrita em `modelo-relacional.md` §4.4 |
| RN-012 | Cancelamento só antes do horário, por paciente titular ou psicólogo | Guarda temporal na aplicação (compara `data_hora_inicio` do slot com o instante do cancelamento) + `id_usuario_cancelamento` obrigatório quando `situacao = 'CANCELADO'` |
| RN-013 | Confirmação automática | `agendamento.situacao` nasce `'CONFIRMADO'`; não existe valor `SOLICITADO` no `CHECK` (DEC-016) |
| RN-014 | Auditoria imutável | Tabela **append-only**: sem `UPDATE`/`DELETE` para a conta de aplicação; `ON DELETE RESTRICT` na FK para `usuario` |
| **RN-015** *(proposta I4)* | Alteração de situação e auditoria na mesma transação | Fronteira transacional B/C de `fase-06` §4.1; a unidade de trabalho é componente de aplicação, não do repositório |
| **RN-016** *(proposta I4)* | No máximo um vínculo vigente por par psicólogo–paciente | Coluna gerada `vinculo.vigente` + `UNIQUE (id_psicologo, id_paciente, vigente)` |
| **RN-017** *(proposta I4)* | Atendimento referencia o agendamento e não pode vir de cancelado | `atendimento.id_agendamento NOT NULL UNIQUE` + FK `ON DELETE RESTRICT` |
| **RN-018** *(proposta I4)* | Agendamento referencia o slot efetivamente ocupado, do próprio psicólogo | FK composta `(id_disponibilidade, id_psicologo)` → `disponibilidade (id, id_psicologo)` |
| **RN-019** *(proposta I4)* | Par do atendimento existe como vínculo autorizado | FK composta `(id_psicologo, id_paciente)` → `agendamento (id_psicologo, id_paciente)`; o vínculo é validado na aplicação (RN-003) |
| RN-020 | Situações do agendamento e transições válidas | `CHECK (situacao IN ('CONFIRMADO','CANCELADO','REALIZADO','NAO_COMPARECEU'))`; nenhuma transição a partir de situação terminal |
| RN-021 | Oferta de horário da lista de espera | `solicitacao_espera` com `id_disponibilidade`, `situacao` e `prazo_aceite`; aceite reusa `agendamento.solicitar` |
| RN-022 | Eventos notificados por e-mail | Nenhuma tabela (DEC-022); a falha é registrada em `registro_auditoria` (DEC-029) |
| **RN-023** *(proposta I4)* | A ordem da fila é a ordem de entrada, sem reordenação manual | `solicitacao_espera.data_hora_entrada` imutável + índice `(id_disponibilidade, situacao, data_hora_entrada)` |
| **RN-024** *(proposta I4)* | No máximo uma oferta aberta por slot | Índice único parcial sobre `solicitacao_espera` para `situacao = 'OFERTADA'` (coluna gerada), somado ao bloqueio da linha do slot |

**Regras que mudaram de número.** A v1.0 usava `RN-001` para "psicólogo só acessa paciente vinculado" (hoje **RN-003**), `RN-002` para "um horário sem dois agendamentos" (hoje **RN-005**) e `RN-004` para "sem senha em texto puro" (hoje **RN-002**). Quem citar este documento em versão antiga deve consultar o mapa da §7.

---

## 4. Requisitos não funcionais

### 4.1 RNF oficiais (Integrante 1) com impacto direto na persistência

| RNF | Título oficial | Como a persistência atende |
|---|---|---|
| RNF-001 | Proteção de credenciais | `hash_senha` com algoritmo definido na aplicação; nenhuma projeção expõe a coluna |
| RNF-002 | Autorização por perfil e permissão | `perfil_permissao` normalizado; autorização reavaliada por operação (não cacheada no token) |
| RNF-003 | Bloqueio de acesso de conta | `situacao_conta` persistido e verificado na autenticação |
| RNF-004 | Auditoria de operações relevantes | `registro_auditoria` append-only, com carimbo de tempo do servidor |
| RNF-005 | Isolamento dos dados de pacientes | Todo acesso a `paciente` filtrado por `id_usuario` (próprio) ou por `vinculo` (profissional) |
| RNF-006 | Acesso profissional por vínculo | `vinculo` com situação e janela temporal; consulta mediada |
| RNF-007 | Integridade entre elementos relacionados | PK/FK/UNIQUE/CHECK descritos no `modelo-relacional.md` |
| RNF-008 | Coesão e baixo acoplamento | Pacotes da §5; repositórios como interfaces (DIP) |
| RNF-009 | Evolução modular | Nenhuma FK com `CASCADE` sobre dados históricos; inativação lógica em vez de exclusão física |
| RNF-010 | Consulta interativa de agenda | Índices `(id_agenda, data, hora_inicio)` e `(id_psicologo, situacao)` |
| RNF-011 | Rastreabilidade entre artefatos | Cada tabela cita RF/RN de origem no dicionário de dados |
| RNF-012 | Consistência terminológica e semântica | Nomes de tabela e de coluna derivados dos nomes de classe; os quatro valores de `situacao` são os de DEC-016 |

### 4.2 Propostas de RNF deste Integrante 4 (`RNF-013` a `RNF-022`)

São **propostas técnicas**, não requisitos aprovados. A incorporação à baseline cabe ao Integrante 1. `RNF-013`, `RNF-019` e `RNF-020` já vinham sendo citados nas Fases 4 e 5 com o mesmo significado; as demais são novas e nascem das decisões de 28/10/2026.

| ID | Requisito proposto | Verificação |
|---|---|---|
| RNF-013 | Integridade referencial com exclusão controlada: nenhuma FK `ON DELETE CASCADE` sobre dados históricos; inativação por situação | Inspeção do DDL + tentativa de `DELETE` que deve falhar |
| RNF-014 | Domínios fechados verificados no banco (`CHECK`) para todas as situações e enumerados | Inserção com valor fora do domínio deve ser recusada |
| RNF-015 | Atomicidade entre alteração de situação e registro de auditoria | Teste com falha injetada na auditoria: a alteração não pode persistir |
| RNF-016 | Unicidade do slot ativo: no máximo um agendamento `CONFIRMADO` por slot | Inserção concorrente do mesmo slot deve violar a restrição |
| RNF-017 | Imutabilidade da trilha: sem `UPDATE`/`DELETE` em `registro_auditoria` para a conta de aplicação | Teste de permissão no SGBD |
| RNF-018 | Consulta de agenda sem varredura completa: índices cobrem as consultas de RF-024, RF-028 e RF-029 | Plano de execução (`EXPLAIN`) sem `type = ALL` |
| RNF-019 | Rastreabilidade de alteração de situação com valor anterior e novo (DEC-024) | Registro de auditoria contém os dois valores |
| RNF-020 | Integridade temporal dos vínculos: `data_fim` nula se e somente se `situacao = 'ATIVO'` | `CHECK` de coerência |
| RNF-021 | No máximo uma oferta aberta por slot da lista de espera | Índice único parcial + teste concorrente |
| RNF-022 | Ordem estável da fila: `data_hora_entrada` imutável após a criação | `UPDATE` da coluna deve ser recusado por trigger/permissão |

---

## 5. Critérios de aceite com impacto em persistência

Os critérios abaixo são os da baseline que **só podem ser verificados no banco** (ou que dependem de estado persistido). Os demais critérios são comportamentais e ficam nas Fases 8 e 9.

| Critério | O que precisa estar persistido |
|---|---|
| CA-RF-001 | `usuario.situacao_conta = 'ATIVO'` e `hash_senha` conferível |
| CA-RF-006 | `situacao_conta` alterada para `'BLOQUEADO'` e auditada |
| CA-RF-020 | `paciente.situacao_cadastral` com valor anterior e novo na auditoria |
| CA-RF-021 | `vinculo` vigente único por par |
| CA-RF-025 | `agendamento.situacao = 'CONFIRMADO'` e slot único ocupado |
| CA-RF-027 | `situacao = 'CANCELADO'`, `data_cancelamento` e `id_usuario_cancelamento` preenchidos |
| CA-RF-030 | `atendimento` criado e `agendamento.situacao = 'REALIZADO'` na mesma transação |
| CA-RF-032 | `registro_auditoria` com responsável, data, hora, operação e situações |
| CA-RF-033 | Falha de envio registrada como `FALHA_ENVIO_EMAIL` **sem** alterar a operação de origem |
| CA-RF-034 | `solicitacao_espera` com `data_hora_entrada` e situação `AGUARDANDO` |
| CA-RF-035 | `situacao = 'OFERTADA'`, `id_disponibilidade` e `prazo_aceite` preenchidos, sem agendamento criado |
| CA-RF-036 | Aceite gera `agendamento` confirmado **e** encerra a solicitação como `ACEITA` |
| CA-RF-037 | `situacao = 'NAO_COMPARECEU'` e `data_nao_comparecimento` preenchidos |

---

## 6. Rastreabilidade resumida (RF → estrutura persistente)

| RF | Tabela principal | RF | Tabela principal |
|---|---|---|---|
| RF-001 a RF-006 | `usuario` | RF-022 | `paciente` |
| RF-007, RF-008 | `perfil`, `permissao`, `perfil_permissao` | RF-023, RF-024 | `disponibilidade` |
| RF-009 a RF-012 | consultas sobre `usuario`, `psicologo`, `paciente` | RF-025 a RF-029 | `agendamento` |
| RF-013, RF-032 | `registro_auditoria` | RF-030, RF-031 | `atendimento` |
| RF-014 a RF-016 | `psicologo`, `area_atuacao`, `psicologo_area_atuacao` | RF-033 | *(sem tabela — `ServicoEnvioMensagem`)* |
| RF-017, RF-021 | `vinculo` | RF-034 a RF-036 | `solicitacao_espera` |
| RF-018 a RF-020 | `paciente` | RF-037 | `agendamento` |

A matriz completa, com coluna, restrição e regra, está em [`dicionario-de-dados.md`](dicionario-de-dados.md) §6.

---

## 7. Mapa de renumeração em relação à v1.0

| v1.0 (numeração própria) | Baseline oficial | Observação |
|---|---|---|
| RF-001 — Autenticação de usuários ativos | **RF-001** | mesmo escopo |
| RF-002 — Bloquear/reativar contas | **RF-005** (ativar) e **RF-006** (bloquear) | a v1.0 juntava duas operações |
| RF-003 — Perfil profissional do psicólogo | **RF-014** e **RF-015** | cadastro e atualização separados |
| RF-004 — Pacientes e vínculo com psicólogo | **RF-018** e **RF-021** | cadastro e vínculo separados |
| RF-005 — Disponibilidades do psicólogo | **RF-023** | mesmo escopo, agora como slot (DEC-018) |
| RF-006 — Agendamentos sem conflito | **RF-025** e **RF-026** | solicitação e confirmação automática |
| RF-007 — Confirmar/cancelar agendamentos | **RF-026** e **RF-027** | `confirmar` deixou de existir como transição (DEC-016) |
| RF-008 — Auditoria de operações relevantes | **RF-013** e **RF-032** | consulta e registro separados |
| RF-009 — Consulta conforme permissões | **RF-008**, **RF-017** e **RF-022** | permissões, consulta profissional e autoatendimento |
| RF-010 — Lista de espera "se adotada" | **RF-034**, **RF-035** e **RF-036** | adotada em DEC-010 e parametrizada em DEC-027 |
| *(não existia)* | **RF-033** | notificação por e-mail (DEC-009, DEC-022) |
| *(não existia)* | **RF-037** | não comparecimento (DEC-016, DEC-025) |

| v1.0 | Baseline oficial | v1.0 | Baseline oficial |
|---|---|---|---|
| RN-001 (vínculo) | **RN-003** | RN-004 (senha) | **RN-002** |
| RN-002 (slot único) | **RN-005** | RN-005 (cancelado ≠ realizado) | **RN-006** |
| RN-003 (bloqueio) | **RN-001** | RN-006 (atendimento com FKs) | **RN-007** |

---

## 8. O que a v1.0 dizia e não vale mais

| Afirmação da v1.0 | Situação em 29/10/2026 |
|---|---|
| "IDs finais devem ser conferidos com a baseline antes de congelar" | **Conferido e corrigido** nesta v2.0 |
| "Lista de espera (se adotada)" | **Adotada** (DEC-010) e parametrizada (DEC-027): entra no DER como `solicitacao_espera` |
| "Necessidade de entidade de Notificação" (§7) | **Descartada** por DEC-022: `ServicoEnvioMensagem` é interface de fronteira, sem tabela |
| "Não criar DER, modelo relacional, DDL ou componentes definitivos nesta fase" | **Superado**: são exatamente os artefatos da Fase 7, entregues nesta pasta |
| RNFs "sugeridos" RNF-001 a RNF-008 com numeração própria | Substituídos pelos RNF oficiais 001 a 012 (§4.1) + propostas 013 a 022 (§4.2) |

---

## 9. Pendências que permanecem

| ID | Pendência | Por que ainda existe | Decisão de |
|---|---|---|---|
| **P-20** | A entrada na lista de espera pode mirar um horário **sem slot cadastrado**? | DEC-027 diz "horário específico"; o modelo adotado referencia um slot existente. Se o grupo quiser fila por faixa de horário, `solicitacao_espera` precisa de colunas de preferência temporal | Grupo |
| **P-21** | Atributos descritivos mínimos de `psicologo` e `paciente` e o **e-mail de contato** de `usuario` | O CLS-001 não fixa atributos escalares (PC-03/PC-04/PC-05). O DER usa o mínimo necessário e registra a origem em `dicionario-de-dados.md` §7 | Integrante 3 (modelo) e Integrante 1 (requisitos) |
| **INC-14** | Notação da DEC-019 diverge da convenção de leitura do repositório | `Usuario "0..1" — Perfil "1"`, lida pela convenção do `03-uml/README.md`, significa *um perfil atende no máximo uma conta*, o oposto de "um perfil pode ser compartilhado por várias contas". O DER adota a **leitura semântica** (1 perfil por conta, N contas por perfil) e registra a divergência | Integrante 1 e 3 |
| **INC-15** | `Agendamento.horario` × slot discreto | Com DEC-018, o tempo é atributo do slot; manter `horario` no agendamento criaria dependência transitiva. O DER trata `horario` como **projeção derivada** (ver `mapeamento-objeto-relacional.md` §4) | Integrante 3 |
| **INC-16** | O modelo de classes não tem atributo de e-mail de contato | RF-033 exige destinatário; sem coluna, o envio não tem para onde ir. O DER cria `usuario.email` e registra a proposta | Integrante 3 e 1 |
| **INC-17** | `OfertaVaga` como classe (`03-uml/README.md`, P8) × `OFERTADA` como situação de `SolicitacaoEspera` (SEQ-004) | Duas modelagens concorrentes para o mesmo conceito. O DER adota a **situação** (uma tabela), e a alternativa com tabela própria está descrita em `modelo-relacional.md` §4.6 | Integrante 3 |

As pendências **P-01 a P-19** da v1.0 e das Fases 5 e 6 estão fechadas pelas decisões de 25 e 28/10/2026, com a seguinte correspondência: P-01→DEC-016/017, P-02→DEC-011/028, P-03→DEC-016, P-04→DEC-014, P-05→DEC-018, P-06→DEC-019, P-07→DEC-020, P-08→mantida como catálogo simples (INC-09), P-09→DEC-009/022, P-10→DEC-010/027, P-11→DEC-021, P-12→DEC-015, P-13→DEC-025, P-14→DEC-016 (só a partir de `CONFIRMADO`), P-15→DEC-029 (falha não desfaz; retry operacional), P-16→mantida como requisito de implementação (RNF-017), P-17→DEC-020, P-18→DEC-024 (alternativa A), P-19→`data_hora` gerado pelo servidor.

---

## 10. Referências

- [`02-requisitos/requisitos-funcionais.md`](../02-requisitos/requisitos-funcionais.md)
- [`02-requisitos/regras-negocio.md`](../02-requisitos/regras-negocio.md)
- [`02-requisitos/requisitos-nao-funcionais.md`](../02-requisitos/requisitos-nao-funcionais.md)
- [`02-requisitos/criterios-aceite.md`](../02-requisitos/criterios-aceite.md)
- [`01-planejamento/decisoes.md`](../01-planejamento/decisoes.md)
- [`01-planejamento/etapas-e-responsabilidades.md`](../01-planejamento/etapas-e-responsabilidades.md) — pendência P11
- [`analises/fase-04-revisao-dados-por-caso-de-uso.md`](analises/fase-04-revisao-dados-por-caso-de-uso.md)
- [`analises/fase-05-viabilidade-persistencia-dominio.md`](analises/fase-05-viabilidade-persistencia-dominio.md)
- [`analises/fase-06-impacto-comportamental-persistencia.md`](analises/fase-06-impacto-comportamental-persistencia.md)
