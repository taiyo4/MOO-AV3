# Dicionário de dados

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Fase do plano:** Fase 7 — Persistência
**Versão:** v1.0 · **Data:** 29/10/2026
**Deriva de:** [`modelo-relacional.md`](modelo-relacional.md) · **Implementação:** [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql)
**SGBD:** MySQL 8.0 (DEC-003)

---

## 1. Objetivo

Descrever **cada coluna** de cada uma das 15 tabelas: tipo, nulidade, valor padrão, domínio, origem no requisito e observação. É o documento que permite a alguém que nunca leu o DER entender o que pode ser gravado e o que o banco recusa.

**Relação com os outros documentos:**

| Documento | Responde |
|---|---|
| [`der/der-001-logico.md`](der/der-001-logico.md) | **quais** entidades existem e como se relacionam |
| [`modelo-relacional.md`](modelo-relacional.md) | **quais restrições** o banco declara (PK, FK, UK, CHECK) |
| **este documento** | **quais colunas** existem, com que tipo e com que domínio |
| [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql) | o mesmo, em SQL executável |

---

## 2. Convenções

| Convenção | Regra |
|---|---|
| Identificador | `BIGINT UNSIGNED NOT NULL AUTO_INCREMENT` em todas as tabelas, exceto as duas associativas puras (`perfil_permissao`, `psicologo_area_atuacao`), cuja PK é composta |
| `UNSIGNED` | identificadores, durações e contadores não são negativos |
| Texto | `VARCHAR(n)` com `n` dimensionado pelo conteúdo real; `TEXT` não é usado (não há prontuário — DEC-008) |
| Instante | `DATETIME` (sem fuso), sempre gravado pelo servidor |
| Data civil | `DATE` (aniversário, início e fim de vínculo) |
| Hora do dia | `TIME` (início do slot) |
| Booleano | `TINYINT` gerado com valor `1`/`NULL`; não há coluna booleana de negócio |
| Enumeração | `VARCHAR` + `CHECK`; nunca `ENUM` nativo |
| Nulidade | `NULL` só quando o conceito é opcional por decisão registrada |
| Carimbo técnico | `criado_em` e `atualizado_em` em todas as tabelas **que não têm** carimbo de negócio equivalente; nas demais, o carimbo de negócio é o único (§2.1) |

### 2.1 Regra do carimbo único

Quando a criação da linha **é** o evento de negócio, não há dois carimbos:

| Tabela | Carimbo único | Motivo |
|---|---|---|
| `atendimento` | `data_hora_registro` | o instante do registro **é** o instante de criação |
| `solicitacao_espera` | `data_hora_entrada` | o instante de entrada na fila **é** o instante de criação, e precisa ser imutável (RN-023) |
| `registro_auditoria` | `data_hora` | o instante do evento **é** o instante da linha |
| `disponibilidade` | `criado_em` | não há evento de negócio na criação do slot |

Duplicar o carimbo criaria duas colunas que nunca podem divergir — e uma delas acabaria divergindo.

---

## 3. Dicionário por tabela

### 3.1 `perfil`

Catálogo de perfis de acesso (RF-007). **Origem:** `Perfil` (CLS-001).

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `nome` | `VARCHAR(60)` | não | — | `UNIQUE`; não vazio | RF-007 |
| `descricao` | `VARCHAR(255)` | sim | `NULL` | texto livre curto | RF-007 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

### 3.2 `permissao`

Catálogo de operações autorizáveis (RF-008). **Origem:** `Permissao`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `codigo` | `VARCHAR(60)` | não | — | `UNIQUE`; `^[A-Z][A-Z0-9_]*$` | RF-008 |
| `descricao` | `VARCHAR(255)` | sim | `NULL` | texto livre curto | RF-008 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |

**Exemplos de `codigo`:** `USUARIO_CRIAR`, `USUARIO_BLOQUEAR`, `AUDITORIA_CONSULTAR`, `AGENDA_CONSULTAR`, `PACIENTE_VINCULAR`. O catálogo é dado, não esquema: incluir uma permissão nova não exige `ALTER TABLE`.

### 3.3 `perfil_permissao`

Associativa do N:N A02. **Origem:** associação `Perfil` × `Permissao`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id_perfil` | `BIGINT UNSIGNED` | não | — | PK parte 1; FK → `perfil.id` | RF-007 |
| `id_permissao` | `BIGINT UNSIGNED` | não | — | PK parte 2; FK → `permissao.id` | RF-008 |

### 3.4 `usuario`

Conta de acesso (RF-001 a RF-006). **Origem:** `Usuario`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `identificacao` | `VARCHAR(80)` | não | — | `UNIQUE`; não vazio | RF-001, RF-003 |
| `hash_senha` | `VARCHAR(255)` | não | — | `CHAR_LENGTH >= 20`; **nunca** senha em texto puro | RN-002, RNF-001 |
| `situacao_conta` | `VARCHAR(12)` | não | `'ATIVO'` | `ATIVO` \| `BLOQUEADO` \| `INATIVO` | DEC-013, RN-001 |
| `id_perfil` | `BIGINT UNSIGNED` | não | — | FK → `perfil.id`; **sem** `UNIQUE` | DEC-019, RF-007 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

**Não existe** coluna de e-mail em `usuario`. O destinatário de RF-033 é a **pessoa do cadastro** (`psicologo.email_contato`, `paciente.email_contato`), que pode existir sem conta (DEC-021). Ver INC-16.

### 3.5 `area_atuacao`

Catálogo de especialidades (RF-016). **Origem:** `AreaAtuacao`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `nome` | `VARCHAR(80)` | não | — | `UNIQUE`; não vazio | RF-016 |
| `descricao` | `VARCHAR(255)` | sim | `NULL` | texto livre curto | RF-016 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |

### 3.6 `psicologo`

Cadastro profissional (RF-014, RF-015). **Origem:** `Psicologo`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_usuario` | `BIGINT UNSIGNED` | **sim** | `NULL` | `UNIQUE`; FK → `usuario.id` | DEC-021, RF-014 |
| `nome` | `VARCHAR(120)` | não | — | não vazio | RF-014 |
| `registro_profissional` | `VARCHAR(40)` | sim | `NULL` | conselho + número | RF-015 |
| `email_contato` | `VARCHAR(160)` | sim | `NULL` | `LIKE '%_@_%._%'`; destino de RF-033 | RF-033, INC-16 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

**Campos provisórios (P-21):** `nome`, `registro_profissional` e `email_contato` não estão fixados no CLS-001 (pendências PC-04/PC-05 do Integrante 3). Foram introduzidos porque sem eles o cadastro de RF-014 não tem conteúdo e RF-033 não tem destinatário.

### 3.7 `psicologo_area_atuacao`

Associativa do N:N A05. **Origem:** associação `Psicologo` × `AreaAtuacao`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | PK parte 1; FK → `psicologo.id` | RF-016 |
| `id_area_atuacao` | `BIGINT UNSIGNED` | não | — | PK parte 2; FK → `area_atuacao.id` | RF-016 |

### 3.8 `paciente`

Cadastro do cliente/paciente (RF-018 a RF-020). **Origem:** `Paciente`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_usuario` | `BIGINT UNSIGNED` | **sim** | `NULL` | `UNIQUE`; FK → `usuario.id` | DEC-021, RF-018 |
| `nome` | `VARCHAR(120)` | não | — | não vazio | RF-018 |
| `email_contato` | `VARCHAR(160)` | sim | `NULL` | `LIKE '%_@_%._%'`; destino de RF-033 | RF-033, INC-16 |
| `situacao_cadastral` | `VARCHAR(10)` | não | `'ATIVO'` | `ATIVO` \| `SUSPENSO` \| `INATIVO` | DEC-014, RF-020 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

**Nenhum dado clínico.** `paciente` guarda identificação e contato administrativo. Não há diagnóstico, queixa, prontuário nem evolução — DEC-008 e DEC-005.

### 3.9 `vinculo`

Autorização do profissional sobre o paciente (RF-017, RF-021). **Origem:** `Vinculo`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | FK → `psicologo.id`; parte do `uk_vinculo_vigente` | RN-003, RN-016 |
| `id_paciente` | `BIGINT UNSIGNED` | não | — | FK → `paciente.id`; parte do `uk_vinculo_vigente` | RN-003, RN-016 |
| `situacao` | `VARCHAR(10)` | não | `'ATIVO'` | `ATIVO` \| `ENCERRADO` | DEC-015 |
| `data_inicio` | `DATE` | não | — | data civil de início | DEC-015, RNF-020 |
| `data_fim` | `DATE` | sim | `NULL` | obrigatória se `ENCERRADO`; `>= data_inicio` | DEC-015, RNF-020 |
| `vigente` | `TINYINT UNSIGNED` | sim (gerada) | — | `1` se `ATIVO`, `NULL` caso contrário | RN-016 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

### 3.10 `agenda`

Agenda do profissional (RF-023, RF-029). **Origem:** `Agenda`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | `UNIQUE`; FK → `psicologo.id` | A08, RN-011 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

A agenda **não** tem coluna de horário: os horários são os slots de `disponibilidade` (DEC-018).

### 3.11 `disponibilidade`

Slot ofertado pelo profissional (RF-023, RF-024). **Origem:** `Disponibilidade`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_agenda` | `BIGINT UNSIGNED` | não | — | FK → `agenda.id`; parte de `uk_disp_slot` | A09, RN-011 |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | FK composta → `agenda(id, id_psicologo)` | RN-011 |
| `data` | `DATE` | não | — | data civil do slot | DEC-018, RF-023 |
| `hora_inicio` | `TIME` | não | — | hora local de início | DEC-018, RF-023 |
| `duracao_minutos` | `SMALLINT UNSIGNED` | não | — | `BETWEEN 5 AND 480` | DEC-018 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |

**`id_psicologo` é desnormalizado de propósito.** Ver [`normalizacao.md`](normalizacao.md) §4: a FK composta `(id_agenda, id_psicologo) → agenda(id, id_psicologo)` impede divergência.

### 3.12 `agendamento`

Compromisso (RF-025 a RF-029, RF-037). **Origem:** `Agendamento`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_disponibilidade` | `BIGINT UNSIGNED` | não | — | FK composta → `disponibilidade(id, id_psicologo)` | A17, RN-005, RN-018 |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | FK → `psicologo.id`; parte de `uk_agendamento_tripla` | A11 |
| `id_paciente` | `BIGINT UNSIGNED` | não | — | FK → `paciente.id`; parte de `uk_agendamento_tripla` | A12 |
| `situacao` | `VARCHAR(16)` | não | `'CONFIRMADO'` | `CONFIRMADO` \| `CANCELADO` \| `REALIZADO` \| `NAO_COMPARECEU` | DEC-016, RN-020 |
| `data_cancelamento` | `DATETIME` | sim | `NULL` | obrigatória se `CANCELADO`; proibida nas demais | RF-027, RN-012 |
| `id_usuario_cancelamento` | `BIGINT UNSIGNED` | sim | `NULL` | obrigatória se `CANCELADO`; FK → `usuario.id` | RF-027, DEC-028 |
| `data_nao_comparecimento` | `DATETIME` | sim | `NULL` | obrigatória se `NAO_COMPARECEU` | RF-037, DEC-025 |
| `slot_ativo` | `BIGINT UNSIGNED` | sim (gerada) | — | `id_disponibilidade` se `CONFIRMADO`, senão `NULL` | RN-005 |
| `criado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP` | — | — |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

**Não há coluna de horário.** `Agendamento.horario` do CLS-001 é projeção de `disponibilidade (data, hora_inicio)` — INC-15 e [`mapeamento-objeto-relacional.md`](mapeamento-objeto-relacional.md) §4.

**Não há coluna de `SOLICITADO`.** O agendamento nasce `CONFIRMADO` (DEC-016, DEC-017).

### 3.13 `atendimento`

Sessão realizada (RF-030, RF-031). **Origem:** `Atendimento`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_agendamento` | `BIGINT UNSIGNED` | não | — | `UNIQUE`; FK composta → `agendamento(id, id_psicologo, id_paciente)` | A15, RN-017, RN-019 |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | FK → `psicologo.id`; coerente com o agendamento | A13, RN-019 |
| `id_paciente` | `BIGINT UNSIGNED` | não | — | FK → `paciente.id`; coerente com o agendamento | A14, RN-019 |
| `data_hora_registro` | `DATETIME` | não | `CURRENT_TIMESTAMP` | instante do registro | RF-030 |
| `contexto_sessao` | `VARCHAR(500)` | sim | `NULL` | texto curto; **não** é prontuário | RF-030, DEC-008 |

`contexto_sessao` é limitado a 500 caracteres **por decisão**: o escopo não prevê prontuário eletrônico (DEC-008). Um campo `TEXT` livre convidaria a guardar conteúdo clínico que o projeto decidiu não guardar.

### 3.14 `solicitacao_espera`

Entrada na fila e oferta de vaga (RF-034 a RF-036). **Origem:** `EntradaListaEspera` / `SolicitacaoEspera` (P8).

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_psicologo` | `BIGINT UNSIGNED` | não | — | FK → `psicologo.id` | A18, DEC-027 |
| `id_paciente` | `BIGINT UNSIGNED` | não | — | FK → `paciente.id` | A19, RF-034 |
| `id_disponibilidade` | `BIGINT UNSIGNED` | não | — | FK composta → `disponibilidade(id, id_psicologo)` | A20, DEC-027, RN-018 |
| `situacao` | `VARCHAR(12)` | não | `'AGUARDANDO'` | `AGUARDANDO` \| `OFERTADA` \| `ACEITA` \| `RECUSADA` \| `EXPIRADA` \| `DESISTIU` | SEQ-004, DEC-027 |
| `data_hora_entrada` | `DATETIME` | não | `CURRENT_TIMESTAMP` | ordem da fila; imutável | RN-023, DEC-027 |
| `prazo_aceite` | `DATETIME` | sim | `NULL` | obrigatória se `OFERTADA` | DEC-027, RF-035 |
| `data_hora_encerramento` | `DATETIME` | sim | `NULL` | obrigatória nas situações terminais | RF-036 |
| `id_agendamento` | `BIGINT UNSIGNED` | sim | `NULL` | `UNIQUE`; obrigatória se `ACEITA` | A21, RF-036 |
| `fila_ativa` | `TINYINT UNSIGNED` | sim (gerada) | — | `1` em `AGUARDANDO`/`OFERTADA`, senão `NULL` | RN-023, RN-024 |
| `oferta_aberta` | `TINYINT UNSIGNED` | sim (gerada) | — | `1` em `OFERTADA`, senão `NULL` | RN-024 |
| `atualizado_em` | `DATETIME` | não | `CURRENT_TIMESTAMP ON UPDATE` | — | — |

**Uma linha por tentativa.** Recusar e voltar para o fim da fila cria **nova** linha; a anterior permanece com `situacao = 'RECUSADA'`. É o que preserva o histórico de ofertas sem tabela `OfertaVaga` (INC-17).

### 3.15 `registro_auditoria`

Trilha de auditoria (RF-013, RF-032). **Origem:** `RegistroAuditoria`.

| Coluna | Tipo | Null | Default | Regra / domínio | Origem |
|---|---|---|---|---|---|
| `id` | `BIGINT UNSIGNED` | não | `AUTO_INCREMENT` | PK | — |
| `id_usuario` | `BIGINT UNSIGNED` | **sim** | `NULL` | FK → `usuario.id`; nulo em falha de autenticação | A16, DEC-024 |
| `data_hora` | `DATETIME` | não | `CURRENT_TIMESTAMP` | carimbo do servidor | RF-032, RN-014 |
| `operacao` | `VARCHAR(60)` | não | — | não vazio; catálogo em §4 | RF-032, DEC-024 |
| `entidade` | `VARCHAR(40)` | não | — | nome da tabela afetada | RF-032, DEC-024 |
| `id_entidade` | `BIGINT UNSIGNED` | sim | `NULL` | identificador afetado (polimórfico) | RF-032, DEC-024 |
| `situacao_anterior` | `VARCHAR(20)` | sim | `NULL` | preenchida em par com `situacao_nova` | DEC-024, RN-009 |
| `situacao_nova` | `VARCHAR(20)` | sim | `NULL` | preenchida em par com `situacao_anterior` | DEC-024, RN-009 |
| `resultado` | `VARCHAR(10)` | não | `'SUCESSO'` | `SUCESSO` \| `FALHA` | DEC-029 |
| `detalhe` | `VARCHAR(255)` | sim | `NULL` | motivo da falha, sem dado sensível | DEC-029 |

**Sem senha, sem conteúdo clínico.** O `detalhe` de uma falha de e-mail registra o provedor e o código de erro, nunca o corpo da mensagem nem o endereço completo (LGPD por minimização).

---

## 4. Domínios e catálogos de valores

### 4.1 Enumerações verificadas por `CHECK`

| Domínio | Valores | Onde |
|---|---|---|
| Situação da conta | `ATIVO`, `BLOQUEADO`, `INATIVO` | `usuario.situacao_conta` |
| Situação cadastral | `ATIVO`, `SUSPENSO`, `INATIVO` | `paciente.situacao_cadastral` |
| Situação do vínculo | `ATIVO`, `ENCERRADO` | `vinculo.situacao` |
| Situação do agendamento | `CONFIRMADO`, `CANCELADO`, `REALIZADO`, `NAO_COMPARECEU` | `agendamento.situacao` |
| Situação da fila | `AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU` | `solicitacao_espera.situacao` |
| Resultado da auditoria | `SUCESSO`, `FALHA` | `registro_auditoria.resultado` |

### 4.2 Catálogo de `registro_auditoria.operacao`

Não é `CHECK` (o catálogo cresce com o sistema); é **dado** e a aplicação valida contra a lista.

| `operacao` | `entidade` | Situações registradas | Origem |
|---|---|---|---|
| `USUARIO_CRIADO` | `usuario` | — | RF-003 |
| `USUARIO_ATIVADO` | `usuario` | `BLOQUEADO`/`INATIVO` → `ATIVO` | RF-005 |
| `USUARIO_BLOQUEADO` | `usuario` | `ATIVO` → `BLOQUEADO` | RF-006 |
| `USUARIO_INATIVADO` | `usuario` | → `INATIVO` | DEC-013 |
| `PERFIL_ALTERADO` | `usuario` | — | RF-007 |
| `PACIENTE_CRIADO` | `paciente` | — | RF-018 |
| `PACIENTE_SITUACAO_ALTERADA` | `paciente` | `ATIVO`/`SUSPENSO`/`INATIVO` | RF-020, DEC-014 |
| `VINCULO_CRIADO` | `vinculo` | — → `ATIVO` | RF-021 |
| `VINCULO_ENCERRADO` | `vinculo` | `ATIVO` → `ENCERRADO` | DEC-015 |
| `DISPONIBILIDADE_CRIADA` | `disponibilidade` | — | RF-023 |
| `AGENDAMENTO_CONFIRMADO` | `agendamento` | — → `CONFIRMADO` | RF-025 |
| `AGENDAMENTO_CANCELADO` | `agendamento` | `CONFIRMADO` → `CANCELADO` | RF-027 |
| `AGENDAMENTO_NAO_COMPARECEU` | `agendamento` | `CONFIRMADO` → `NAO_COMPARECEU` | RF-037 |
| `ATENDIMENTO_REGISTRADO` | `agendamento` | `CONFIRMADO` → `REALIZADO` | RF-030 |
| `LISTA_ESPERA_ENTRADA` | `solicitacao_espera` | — → `AGUARDANDO` | RF-034 |
| `LISTA_ESPERA_OFERTA` | `solicitacao_espera` | `AGUARDANDO` → `OFERTADA` | RF-035 |
| `LISTA_ESPERA_ACEITE` | `solicitacao_espera` | `OFERTADA` → `ACEITA` | RF-036 |
| `LISTA_ESPERA_RECUSA` | `solicitacao_espera` | `OFERTADA` → `RECUSADA` | RF-036 |
| `LISTA_ESPERA_EXPIRACAO` | `solicitacao_espera` | `OFERTADA` → `EXPIRADA` | DEC-027 |
| `LISTA_ESPERA_DESISTENCIA` | `solicitacao_espera` | `AGUARDANDO`/`OFERTADA` → `DESISTIU` | DEC-027 |
| **`FALHA_ENVIO_EMAIL`** | `agendamento` ou `solicitacao_espera` | — | DEC-029, RF-033 |

### 4.3 Colunas geradas

| Tabela | Coluna | Expressão | Para que serve |
|---|---|---|---|
| `vinculo` | `vigente` | `CASE WHEN situacao = 'ATIVO' THEN 1 ELSE NULL END` | índice único parcial de RN-016 |
| `agendamento` | `slot_ativo` | `CASE WHEN situacao = 'CONFIRMADO' THEN id_disponibilidade ELSE NULL END` | índice único parcial de RN-005 |
| `solicitacao_espera` | `fila_ativa` | `CASE WHEN situacao IN ('AGUARDANDO','OFERTADA') THEN 1 ELSE NULL END` | impede dupla entrada ativa |
| `solicitacao_espera` | `oferta_aberta` | `CASE WHEN situacao = 'OFERTADA' THEN 1 ELSE NULL END` | índice único parcial de RN-024 |

Todas são `STORED` (materializadas), porque participam de índice único.

---

## 5. Volume e dimensionamento

Estimativa para justificar os tipos e os índices. Não é requisito de desempenho — é ordem de grandeza.

| Tabela | Ordem estimada | Cresce com | Retenção |
|---|---|---|---|
| `usuario` | centenas | cadastros | indefinida (inativação) |
| `psicologo` / `paciente` | centenas a milhares | cadastros | indefinida |
| `vinculo` | milhares | relações ao longo do tempo | indefinida |
| `agenda` | 1 por psicólogo | — | indefinida |
| `disponibilidade` | dezenas por psicólogo por mês | oferta de horários | indefinida |
| `agendamento` | milhares por ano | uso | indefinida |
| `atendimento` | ~ igual a `agendamento` realizado | uso | indefinida |
| `solicitacao_espera` | centenas por mês | fila | indefinida |
| `registro_auditoria` | **maior tabela** | toda operação relevante | indefinida (imutável) |

`VARCHAR(255)` em `hash_senha` comporta Argon2id, bcrypt e PBKDF2 com folga. `VARCHAR(500)` em `contexto_sessao` é o teto decidido, não uma média.

---

## 6. Rastreabilidade RF → coluna

| RF | Tabela(s) e coluna(s) que atendem |
|---|---|
| RF-001 | `usuario.identificacao`, `usuario.hash_senha`, `usuario.situacao_conta`, `usuario.id_perfil` |
| RF-002 | *(nenhuma — DEC-020)* |
| RF-003 | `usuario.*` (INSERT) |
| RF-004 | `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em` |
| RF-005 | `usuario.situacao_conta` |
| RF-006 | `usuario.situacao_conta` |
| RF-007 | `perfil.nome`, `perfil_permissao.*` |
| RF-008 | `permissao.codigo`, `perfil_permissao.*` |
| RF-009 | *(consulta agregada)* |
| RF-010 | `usuario.identificacao`, `usuario.situacao_conta`, `usuario.id_perfil` |
| RF-011 | `psicologo.nome`, `psicologo_area_atuacao.*` |
| RF-012 | `paciente.nome`, `paciente.situacao_cadastral` |
| RF-013 | `registro_auditoria.*` |
| RF-014 | `psicologo.id_usuario`, `psicologo.nome`, `psicologo.registro_profissional` |
| RF-015 | `psicologo.*` (UPDATE) |
| RF-016 | `psicologo_area_atuacao.*`, `area_atuacao.nome` |
| RF-017 | `vinculo.id_psicologo`, `vinculo.id_paciente`, `vinculo.situacao` |
| RF-018 | `paciente.id_usuario`, `paciente.nome`, `paciente.situacao_cadastral` |
| RF-019 | `paciente.nome`, `paciente.email_contato` |
| RF-020 | `paciente.situacao_cadastral` |
| RF-021 | `vinculo.*` |
| RF-022 | `paciente.id_usuario` |
| RF-023 | `disponibilidade.data`, `disponibilidade.hora_inicio`, `disponibilidade.duracao_minutos` |
| RF-024 | `disponibilidade.*` + `agendamento.slot_ativo` + `solicitacao_espera.oferta_aberta` |
| RF-025 | `agendamento.*` (INSERT com `situacao = 'CONFIRMADO'`) |
| RF-026 | `agendamento.situacao` (DEFAULT `'CONFIRMADO'`) |
| RF-027 | `agendamento.situacao`, `data_cancelamento`, `id_usuario_cancelamento` |
| RF-028 | `agendamento.id_paciente`, `agendamento.situacao` |
| RF-029 | `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` |
| RF-030 | `atendimento.*`, `agendamento.situacao` |
| RF-031 | `atendimento.id_psicologo`, `atendimento.id_paciente`, `atendimento.data_hora_registro`, `atendimento.contexto_sessao` |
| RF-032 | `registro_auditoria.*` |
| RF-033 | `psicologo.email_contato`, `paciente.email_contato`, `registro_auditoria.operacao = 'FALHA_ENVIO_EMAIL'` |
| RF-034 | `solicitacao_espera.id_paciente`, `solicitacao_espera.id_psicologo`, `solicitacao_espera.situacao`, `solicitacao_espera.data_hora_entrada` |
| RF-035 | `solicitacao_espera.situacao`, `solicitacao_espera.id_disponibilidade`, `solicitacao_espera.prazo_aceite` |
| RF-036 | `solicitacao_espera.situacao`, `solicitacao_espera.id_agendamento`, `solicitacao_espera.data_hora_encerramento` |
| RF-037 | `agendamento.situacao`, `agendamento.data_nao_comparecimento` |

**Nenhum RF fica sem coluna**, exceto RF-002 (sessão volátil, DEC-020) e RF-009 (consulta agregada, sem dado próprio).

---

## 7. Campos provisórios (P-21)

| Coluna | Situação | O que falta |
|---|---|---|
| `psicologo.nome` | provisório | o CLS-001 não fixa atributos escalares de `Psicologo` (PC-04) |
| `psicologo.registro_profissional` | provisório | formato do registro (CRP e variantes) não decidido |
| `psicologo.email_contato` | provisório | e-mail não está no modelo de classes (INC-16) |
| `paciente.nome` | provisório | idem PC-05 |
| `paciente.email_contato` | provisório | idem INC-16 |
| `usuario.identificacao` | provisório | não está decidido se a identificação é e-mail, CPF ou login livre |

Todos são **necessários para o cadastro funcionar** e nenhum deles é dado clínico. Se o Integrante 3 fixar outros nomes ou tipos, a alteração é localizada: coluna renomeada no dicionário, no DDL e no mapeamento ORM.

---

## 8. Referências

- [`der/der-001-logico.md`](der/der-001-logico.md) — DER-001
- [`modelo-relacional.md`](modelo-relacional.md) — restrições
- [`mapeamento-objeto-relacional.md`](mapeamento-objeto-relacional.md) — classe ↔ tabela
- [`normalizacao.md`](normalizacao.md) — formas normais e desnormalizações
- [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql) — implementação
- [`../02-requisitos/requisitos-funcionais.md`](../02-requisitos/requisitos-funcionais.md)
- [`../01-planejamento/decisoes.md`](../01-planejamento/decisoes.md)
