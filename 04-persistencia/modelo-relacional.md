# Modelo relacional

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Fase do plano:** Fase 7 — Persistência
**Versão:** v1.1 · **Data:** 30/10/2026 (conferência da Fase 8)
**Deriva de:** [`der/der-001-logico.md`](der/der-001-logico.md) (DER-001) e [`impacto-requisitos.md`](impacto-requisitos.md)
**SGBD de referência:** MySQL 8.0 (DEC-003)
**Implementação:** [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql) · **Colunas e domínios:** [`dicionario-de-dados.md`](dicionario-de-dados.md)

---

## 1. Objetivo

Traduzir as 15 entidades do DER-001 em relações com **chave primária, chave estrangeira, unicidade, verificação de domínio e nulidade** declaradas, resolver as associações N:N e de cardinalidade condicional, e fixar a estratégia de exclusão/inativação e as fronteiras transacionais.

Este documento **não repete** a lista de colunas com tipo e domínio — isso está no dicionário de dados. Aqui o foco é **restrição**: o que o banco recusa.

---

## 2. Notação

| Símbolo | Significado |
|---|---|
| **negrito** | coluna de chave primária |
| *itálico* | coluna de chave estrangeira |
| `uk_` | restrição de unicidade (`UNIQUE`) |
| `ck_` | restrição de verificação (`CHECK`) |
| `fk_` | chave estrangeira (`FOREIGN KEY`) |
| `ix_` | índice não único |
| `NN` | `NOT NULL` |
| `gen` | coluna gerada (`GENERATED ALWAYS AS … STORED`) |

**Política de nulidade.** Uma coluna só aceita `NULL` quando o conceito é opcional **por decisão registrada**: conta de acesso opcional (DEC-021), cancelamento que pode não ter ocorrido, responsável de auditoria inexistente (falha de autenticação), prazo de oferta já consumido. Nulidade "por conveniência" não é usada.

**Política de `ON DELETE` / `ON UPDATE`.** Todas as FKs usam `ON DELETE RESTRICT ON UPDATE RESTRICT`, com **duas exceções** declaradas na §5: as associativas puras `perfil_permissao` e `psicologo_area_atuacao`, que também são `RESTRICT` na FK, mas cujas **linhas** podem ser removidas (revogar uma permissão é remover a associação, não o histórico).

---

## 3. Esquema relacional

```
perfil                (**id**, nome, descricao, criado_em, atualizado_em)
permissao             (**id**, codigo, descricao, criado_em)
perfil_permissao      (**id_perfil**, **id_permissao**)
usuario               (**id**, identificacao, hash_senha, situacao_conta, *id_perfil*, criado_em, atualizado_em)
area_atuacao          (**id**, nome, descricao, criado_em)
psicologo             (**id**, *id_usuario*, nome, registro_profissional, email_contato, criado_em, atualizado_em)
psicologo_area_atuacao(**id_psicologo**, **id_area_atuacao**)
paciente              (**id**, *id_usuario*, nome, email_contato, situacao_cadastral, criado_em, atualizado_em)
vinculo               (**id**, *id_psicologo*, *id_paciente*, situacao, data_inicio, data_fim, vigente, criado_em, atualizado_em)
agenda                (**id**, *id_psicologo*, criado_em, atualizado_em)
disponibilidade       (**id**, *id_agenda*, *id_psicologo*, data, hora_inicio, duracao_minutos, criado_em)
agendamento           (**id**, *id_disponibilidade*, *id_psicologo*, *id_paciente*, situacao,
                       data_cancelamento, *id_usuario_cancelamento*, data_nao_comparecimento,
                       slot_ativo, criado_em, atualizado_em)
atendimento           (**id**, *id_agendamento*, *id_psicologo*, *id_paciente*, data_hora_registro,
                       contexto_sessao)
solicitacao_espera    (**id**, *id_psicologo*, *id_paciente*, *id_disponibilidade*, situacao,
                       data_hora_entrada, prazo_aceite, data_hora_encerramento, *id_agendamento*,
                       fila_ativa, oferta_aberta, atualizado_em)
registro_auditoria    (**id**, *id_usuario*, data_hora, operacao, entidade, id_entidade,
                       situacao_anterior, situacao_nova, resultado, detalhe)
```

---

## 4. Restrições por tabela

### 4.1 `perfil`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_perfil` | `(id)` |
| UK | `uk_perfil_nome` | `(nome)` |
| CK | `ck_perfil_nome` | `CHAR_LENGTH(TRIM(nome)) > 0` |
| NN | — | `nome`, `criado_em`, `atualizado_em` |

`Perfil` é catálogo. Pode ser excluído fisicamente **somente** quando nenhuma conta o referencia (a FK `fk_usuario_perfil` é `RESTRICT`). Não há coluna de situação porque a decisão de inativar perfil não existe na baseline.

### 4.2 `permissao`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_permissao` | `(id)` |
| UK | `uk_permissao_codigo` | `(codigo)` |
| CK | `ck_permissao_codigo` | `codigo REGEXP '^[A-Z][A-Z0-9_]*$'` |
| NN | — | `codigo`, `criado_em` |

O `codigo` é o identificador estável usado na autorização (`USUARIO_BLOQUEAR`, `AGENDA_CONSULTAR`, …). A aplicação **nunca** decide por `id`, que é surrogate.

### 4.3 `perfil_permissao`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_perfil_permissao` | `(id_perfil, id_permissao)` |
| FK | `fk_pp_perfil` | `id_perfil → perfil(id)` |
| FK | `fk_pp_permissao` | `id_permissao → permissao(id)` |
| NN | — | ambas |

Associativa pura do N:N A02. Revogar uma permissão é `DELETE` da linha — e **só** da linha: a permissão e o perfil permanecem.

### 4.4 `usuario`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_usuario` | `(id)` |
| UK | `uk_usuario_identificacao` | `(identificacao)` |
| FK | `fk_usuario_perfil` | `id_perfil → perfil(id)` |
| CK | `ck_usuario_situacao` | `situacao_conta IN ('ATIVO','BLOQUEADO','INATIVO')` |
| CK | `ck_usuario_identificacao` | `CHAR_LENGTH(TRIM(identificacao)) > 0` |
| CK | `ck_usuario_hash` | `CHAR_LENGTH(hash_senha) >= 20` |
| NN | — | `identificacao`, `hash_senha`, `situacao_conta`, `id_perfil`, `criado_em`, `atualizado_em` |

**RN-002.** Não existe coluna de senha em texto puro, de senha recuperável nem de "senha temporária". O `ck_usuario_hash` existe apenas para recusar valor vazio ou truncado; o formato do hash é responsabilidade da aplicação.

**INC-14.** `id_perfil` é `NOT NULL` e **sem** `UNIQUE`, materializando a leitura semântica da DEC-019 (1 perfil por conta, N contas por perfil). Ver [`der/der-001-logico.md`](der/der-001-logico.md) §8.

### 4.5 `area_atuacao`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_area_atuacao` | `(id)` |
| UK | `uk_area_atuacao_nome` | `(nome)` |
| NN | — | `nome`, `criado_em` |

INC-09 permanece aberta quanto a **quem** mantém o catálogo; a estrutura não muda com a resposta.

### 4.6 `psicologo`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_psicologo` | `(id)` |
| UK | `uk_psicologo_usuario` | `(id_usuario)` |
| FK | `fk_psicologo_usuario` | `id_usuario → usuario(id)` |
| CK | `ck_psicologo_nome` | `CHAR_LENGTH(TRIM(nome)) > 0` |
| CK | `ck_psicologo_email` | `email_contato IS NULL OR email_contato LIKE '%_@_%._%'` |
| NN | — | `nome`, `criado_em`, `atualizado_em` |

`id_usuario` aceita `NULL` e é `UNIQUE` quando presente: DEC-021 permite cadastro sem conta, e uma conta atende no máximo um cadastro de cada tipo.

### 4.7 `psicologo_area_atuacao`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_psicologo_area` | `(id_psicologo, id_area_atuacao)` |
| FK | `fk_pa_psicologo` | `id_psicologo → psicologo(id)` |
| FK | `fk_pa_area` | `id_area_atuacao → area_atuacao(id)` |
| NN | — | ambas |

Associativa pura do N:N A05. Não há mínimo obrigatório de áreas (a especificação de classes registra que A05 "admite múltiplas áreas, mas não fixa mínimo").

### 4.8 `paciente`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_paciente` | `(id)` |
| UK | `uk_paciente_usuario` | `(id_usuario)` |
| FK | `fk_paciente_usuario` | `id_usuario → usuario(id)` |
| CK | `ck_paciente_situacao` | `situacao_cadastral IN ('ATIVO','SUSPENSO','INATIVO')` |
| CK | `ck_paciente_nome` | `CHAR_LENGTH(TRIM(nome)) > 0` |
| CK | `ck_paciente_email` | `email_contato IS NULL OR email_contato LIKE '%_@_%._%'` |
| NN | — | `nome`, `situacao_cadastral`, `criado_em`, `atualizado_em` |

`situacao_cadastral` nasce `'ATIVO'` por `DEFAULT`. A transição entre os três valores é livre (DEC-014), sempre com auditoria.

### 4.9 `vinculo`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_vinculo` | `(id)` |
| UK | `uk_vinculo_vigente` | `(id_psicologo, id_paciente, vigente)` |
| FK | `fk_vinculo_psicologo` | `id_psicologo → psicologo(id)` |
| FK | `fk_vinculo_paciente` | `id_paciente → paciente(id)` |
| CK | `ck_vinculo_situacao` | `situacao IN ('ATIVO','ENCERRADO')` |
| CK | `ck_vinculo_temporal` | `(situacao = 'ATIVO' AND data_fim IS NULL) OR (situacao = 'ENCERRADO' AND data_fim IS NOT NULL AND data_fim >= data_inicio)` |
| gen | `vigente` | `CASE WHEN situacao = 'ATIVO' THEN 1 ELSE NULL END` |
| NN | — | `id_psicologo`, `id_paciente`, `situacao`, `data_inicio` |

**RN-016 implementada por índice parcial.** `vigente` vale `1` quando o vínculo está ativo e `NULL` quando está encerrado. Como o MySQL admite vários `NULL` em índice único, `uk_vinculo_vigente` impede **dois vínculos ativos para o mesmo par** e permite **quantos vínculos encerrados** forem necessários. É o mesmo efeito de `CREATE UNIQUE INDEX … WHERE situacao = 'ATIVO'` no PostgreSQL.

**RN-020 proposta** (integridade temporal) é o `ck_vinculo_temporal`: vínculo ativo não tem `data_fim`; vínculo encerrado tem, e ela não antecede `data_inicio`.

### 4.10 `agenda`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_agenda` | `(id)` |
| UK | `uk_agenda_psicologo` | `(id_psicologo)` |
| UK | `uk_agenda_id_psicologo` | `(id, id_psicologo)` — **chave candidata para FK composta** |
| FK | `fk_agenda_psicologo` | `id_psicologo → psicologo(id)` |
| NN | — | `id_psicologo`, `criado_em`, `atualizado_em` |

`uk_agenda_psicologo` garante A08 como 1:1. `uk_agenda_id_psicologo` parece redundante com a PK, mas **não é**: o MySQL exige um índice que cubra exatamente as colunas referenciadas por uma FK, e é ele que permite a FK composta de `disponibilidade` (§4.11).

### 4.11 `disponibilidade`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_disponibilidade` | `(id)` |
| UK | `uk_disp_id_psicologo` | `(id, id_psicologo)` — chave candidata para FK composta |
| UK | `uk_disp_slot` | `(id_agenda, data, hora_inicio)` |
| FK | `fk_disp_agenda` | `id_agenda → agenda(id)` |
| FK | `fk_disp_agenda_psicologo` | `(id_agenda, id_psicologo) → agenda(id, id_psicologo)` |
| CK | `ck_disp_duracao` | `duracao_minutos BETWEEN 5 AND 480` |
| NN | — | `id_agenda`, `id_psicologo`, `data`, `hora_inicio`, `duracao_minutos`, `criado_em` |

`uk_disp_slot` impede dois slots no mesmo instante na mesma agenda — é a chave natural do slot (DEC-018).

**RN-011 garantida no banco.** `id_psicologo` é repetido de `agenda` de forma controlada: `fk_disp_agenda_psicologo` amarra o par `(id_agenda, id_psicologo)` ao par existente em `agenda`. Um slot não pode pertencer à agenda de um profissional e declarar outro.

### 4.12 `agendamento`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_agendamento` | `(id)` |
| UK | `uk_agendamento_slot_ativo` | `(slot_ativo)` |
| UK | `uk_agendamento_tripla` | `(id, id_psicologo, id_paciente)` — chave candidata para FK composta |
| FK | `fk_agendamento_slot` | `(id_disponibilidade, id_psicologo) → disponibilidade(id, id_psicologo)` |
| FK | `fk_agendamento_psicologo` | `id_psicologo → psicologo(id)` |
| FK | `fk_agendamento_paciente` | `id_paciente → paciente(id)` |
| FK | `fk_agendamento_cancelamento` | `id_usuario_cancelamento → usuario(id)` |
| CK | `ck_agendamento_situacao` | `situacao IN ('CONFIRMADO','CANCELADO','REALIZADO','NAO_COMPARECEU')` |
| CK | `ck_agendamento_cancelamento` | `(situacao = 'CANCELADO') = (data_cancelamento IS NOT NULL AND id_usuario_cancelamento IS NOT NULL)` |
| CK | `ck_agendamento_nao_comparecimento` | `(situacao = 'NAO_COMPARECEU') = (data_nao_comparecimento IS NOT NULL)` |
| gen | `slot_ativo` | `CASE WHEN situacao = 'CONFIRMADO' THEN id_disponibilidade ELSE NULL END` |
| NN | — | `id_disponibilidade`, `id_psicologo`, `id_paciente`, `situacao`, `criado_em`, `atualizado_em` |

**RN-005 implementada por índice parcial.** `slot_ativo` só tem valor enquanto o agendamento está `CONFIRMADO`; `uk_agendamento_slot_ativo` recusa um segundo `CONFIRMADO` no mesmo slot. Quando o agendamento passa a `CANCELADO`, `slot_ativo` vira `NULL` e o slot fica livre para outro agendamento — sem `DELETE` e sem `UPDATE` de coluna de negócio.

**RN-013.** Não existe valor `'SOLICITADO'` no `ck_agendamento_situacao` (DEC-016). O agendamento nasce `'CONFIRMADO'`.

**RN-018 garantida no banco.** `fk_agendamento_slot` referencia `(id_disponibilidade, id_psicologo)`, e não apenas `id_disponibilidade`: o slot ocupado tem de pertencer ao psicólogo do agendamento.

**A17 como 1:0..1.** O `UNIQUE` de `slot_ativo` também garante que um slot tem no máximo um agendamento confirmado, o que é a leitura de A17.

### 4.13 `atendimento`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_atendimento` | `(id)` |
| UK | `uk_atendimento_agendamento` | `(id_agendamento)` |
| FK | `fk_atendimento_agendamento` | `(id_agendamento, id_psicologo, id_paciente) → agendamento(id, id_psicologo, id_paciente)` |
| FK | `fk_atendimento_psicologo` | `id_psicologo → psicologo(id)` |
| FK | `fk_atendimento_paciente` | `id_paciente → paciente(id)` |
| CK | `ck_atendimento_contexto` | `contexto_sessao IS NULL OR CHAR_LENGTH(contexto_sessao) <= 500` |
| NN | — | `id_agendamento`, `id_psicologo`, `id_paciente`, `data_hora_registro` |

**RN-017.** `id_agendamento` é `NOT NULL` e `UNIQUE`: todo atendimento decorre de exatamente um agendamento, e um agendamento gera no máximo um atendimento (A15 como 1:0..1).

**RN-019 garantida no banco.** A FK composta `(id_agendamento, id_psicologo, id_paciente)` obriga o trio a coincidir com o do agendamento. Não é possível registrar atendimento em que o psicólogo ou o paciente divergem do compromisso.

**RN-006.** "Agendamento cancelado não pode ser realizado" **não** é expressável como `CHECK` (depende da transição, não do estado final). Fica na guarda de transição (§6, TRS-05) e no teste conceitual.

### 4.14 `solicitacao_espera`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_solicitacao_espera` | `(id)` |
| UK | `uk_se_agendamento` | `(id_agendamento)` |
| UK | `uk_se_fila` | `(id_disponibilidade, id_paciente, fila_ativa)` |
| UK | `uk_se_oferta` | `(id_disponibilidade, oferta_aberta)` |
| FK | `fk_se_psicologo` | `id_psicologo → psicologo(id)` |
| FK | `fk_se_paciente` | `id_paciente → paciente(id)` |
| FK | `fk_se_slot` | `(id_disponibilidade, id_psicologo) → disponibilidade(id, id_psicologo)` |
| FK | `fk_se_agendamento` | `id_agendamento → agendamento(id)` |
| CK | `ck_se_situacao` | `situacao IN ('AGUARDANDO','OFERTADA','ACEITA','RECUSADA','EXPIRADA','DESISTIU')` |
| CK | `ck_se_prazo` | `situacao <> 'OFERTADA' OR prazo_aceite IS NOT NULL` |
| CK | `ck_se_encerramento` | `situacao IN ('AGUARDANDO','OFERTADA') OR data_hora_encerramento IS NOT NULL` |
| CK | `ck_se_aceite` | `situacao <> 'ACEITA' OR id_agendamento IS NOT NULL` |
| gen | `fila_ativa` | `CASE WHEN situacao IN ('AGUARDANDO','OFERTADA') THEN 1 ELSE NULL END` |
| gen | `oferta_aberta` | `CASE WHEN situacao = 'OFERTADA' THEN 1 ELSE NULL END` |
| NN | — | `id_psicologo`, `id_paciente`, `id_disponibilidade`, `situacao`, `data_hora_entrada`, `atualizado_em` |

**RN-023 (ordem da fila).** A posição é determinada por `ORDER BY data_hora_entrada, id` sobre as linhas com `fila_ativa = 1`. Não existe coluna `posicao`: uma posição materializada exigiria reescrever toda a fila a cada entrada, saída ou expiração — e ficaria inconsistente sob concorrência. `data_hora_entrada` é imutável (§17 do DDL).

**RN-024 (uma oferta aberta por slot).** `oferta_aberta` vale `1` só em `OFERTADA`; `uk_se_oferta` impede duas ofertas simultâneas para o mesmo slot. `uk_se_fila` impede que o mesmo paciente tenha duas entradas ativas para o mesmo slot (dupla entrada por duplo clique).

**DEC-027.** O prazo é `prazo_aceite`, um instante calculado na abertura da oferta a partir de parâmetro configurável — o valor numérico **não** é fixado no modelo, como decidiu o grupo.

**A21.** `id_agendamento` é `NULL` até o aceite e `UNIQUE` quando presente: um agendamento nasce de no máximo uma solicitação de espera.

### 4.15 `registro_auditoria`

| Tipo | Nome | Definição |
|---|---|---|
| PK | `pk_registro_auditoria` | `(id)` |
| FK | `fk_auditoria_usuario` | `id_usuario → usuario(id)` |
| CK | `ck_auditoria_resultado` | `resultado IN ('SUCESSO','FALHA')` |
| CK | `ck_auditoria_operacao` | `CHAR_LENGTH(TRIM(operacao)) > 0` |
| CK | `ck_auditoria_entidade` | `CHAR_LENGTH(TRIM(entidade)) > 0` |
| CK | `ck_auditoria_situacao_par` | `(situacao_anterior IS NULL) = (situacao_nova IS NULL)` |
| NN | — | `data_hora`, `operacao`, `entidade`, `resultado` |

**DEC-024.** `situacao_anterior` e `situacao_nova` são preenchidas **em par** quando a operação altera situação; o `ck_auditoria_situacao_par` impede meia informação. Em operações sem transição (consulta, falha de e-mail) as duas ficam `NULL`.

**DEC-029.** A falha de envio é uma linha com `operacao = 'FALHA_ENVIO_EMAIL'` e `resultado = 'FALHA'`. A operação de origem **já foi confirmada** e não é revertida.

**RN-014.** A tabela é *append-only*: nenhuma FK aponta para ela e o `DELETE` é recusado (§17 do DDL). `id_entidade` é polimórfico **de propósito** — a trilha precisa registrar operações sobre entidades que podem ser excluídas do catálogo, e uma FK por tabela auditada exigiria uma coluna por entidade. O preço é que a integridade referencial de `id_entidade` é semântica, não declarada; está registrado como decisão consciente.

---

## 5. Resolução de associações

### 5.1 N:N

| Associação | Solução | Justificativa |
|---|---|---|
| A02 `Perfil` × `Permissao` | tabela `perfil_permissao` (PK composta) | associativa pura, sem atributo próprio |
| A05 `Psicologo` × `AreaAtuacao` | tabela `psicologo_area_atuacao` (PK composta) | associativa pura |

### 5.2 Cardinalidades condicionais (0..1)

| Associação | Solução | Efeito |
|---|---|---|
| A03 `Usuario` × `Psicologo` | FK `psicologo.id_usuario` `NULL` + `UNIQUE` | cadastro sem conta (DEC-021) e conta com no máximo um cadastro profissional |
| A04 `Usuario` × `Paciente` | FK `paciente.id_usuario` `NULL` + `UNIQUE` | idem |
| A15 `Agendamento` × `Atendimento` | FK `atendimento.id_agendamento` `NOT NULL` + `UNIQUE` | 1 agendamento → 0..1 atendimento |
| A17 `Disponibilidade` × `Agendamento` | FK `agendamento.id_disponibilidade` `NOT NULL` + `UNIQUE (slot_ativo)` | 1 slot → 0..1 agendamento confirmado |
| A21 `SolicitacaoEspera` × `Agendamento` | FK `solicitacao_espera.id_agendamento` `NULL` + `UNIQUE` | aceite gera no máximo um agendamento |

**Direção da FK em 0..1:0..1.** Em A03/A04/A21 a FK fica no lado que **pode não existir** (`psicologo`, `paciente`, `solicitacao_espera`), nunca em `usuario` ou `agendamento`. Isso evita três colunas nulas em `usuario` e mantém a tabela central enxuta.

### 5.3 `OfertaVaga` como tabela própria (alternativa, INC-17)

Se o Integrante 3 oficializar `OfertaVaga` (P8) como classe com identidade própria, a alternativa é:

```
oferta_vaga (**id**, *id_solicitacao_espera*, *id_disponibilidade*, prazo_aceite,
             situacao, data_hora_resposta, *id_agendamento*)
  uk_oferta_vaga_aberta (id_disponibilidade, aberta)   -- aberta é gerada
  fk_oferta_solicitacao → solicitacao_espera(id)
```

Custo: uma tabela a mais, um `JOIN` a mais na consulta de posição e duas fontes de verdade para "existe oferta aberta neste slot". Ganho: histórico de ofertas com identidade própria e possibilidade de ofertar o mesmo slot a mais de um paciente em sequência sem criar novas linhas em `solicitacao_espera`.

**Decisão do DER:** adotar a **situação** (`OFERTADA`) em `solicitacao_espera`, porque (a) a SEQ-004 já modela `abrirOferta` como operação da própria `SolicitacaoEspera`, (b) DEC-027 fixa uma oferta por vez, e (c) a recusa seguida de nova oferta ao próximo paciente gera uma **nova linha** para o próximo, preservando o histórico sem tabela extra.

---

## 6. Estratégia de exclusão e inativação

### 6.1 Princípio

**Não há exclusão física de dado de negócio.** Excluir destruiria histórico de atendimento, trilha de auditoria e a própria possibilidade de provar conformidade (RNF-004, RNF-009, RN-014). A saída de cena de uma entidade é sempre uma **mudança de situação**, auditada.

### 6.2 Por entidade

| Entidade | Mecanismo | Efeito |
|---|---|---|
| `usuario` | `situacao_conta = 'INATIVO'` | não autentica; permanece referenciado por auditoria e agendamentos |
| `paciente` | `situacao_cadastral = 'INATIVO'` | sai das listas operacionais; histórico permanece |
| `vinculo` | `situacao = 'ENCERRADO'` + `data_fim` | deixa de autorizar o profissional (RN-003); agendamentos futuros **não** são cancelados (DEC-015) |
| `agendamento` | situação terminal (`CANCELADO`, `REALIZADO`, `NAO_COMPARECEU`) | nunca é removido |
| `atendimento` | sem exclusão | registro histórico |
| `registro_auditoria` | sem exclusão, sem `UPDATE` | trilha imutável |
| `disponibilidade` | sem exclusão depois de usada | slot referenciado por agendamento histórico |
| `perfil`, `permissao`, `area_atuacao` | exclusão física permitida **só** se não referenciados | a FK `RESTRICT` é a guarda |
| `perfil_permissao`, `psicologo_area_atuacao` | `DELETE` da linha | revogar associação não apaga catálogo nem histórico |

### 6.3 Efeito nas consultas

Toda consulta operacional filtra a situação. Exemplos:

| Consulta | Filtro |
|---|---|
| autenticação (RF-001) | `usuario.situacao_conta = 'ATIVO'` |
| pacientes vinculados (RF-017) | `vinculo.situacao = 'ATIVO' AND v.data_inicio <= CURDATE() AND (v.data_fim IS NULL OR v.data_fim >= CURDATE())` |
| horários disponíveis (RF-024) | `NOT EXISTS` agendamento `CONFIRMADO` **e** `NOT EXISTS` oferta aberta |
| fila (RF-034/035) | `solicitacao_espera.situacao IN ('AGUARDANDO','OFERTADA')` |

---

## 7. Fronteiras transacionais

As fronteiras abaixo são o que a persistência precisa garantir para que RN-005, RN-009, RN-015, RN-017 e RN-021 sejam verdadeiras. Elas são implementadas na **unidade de trabalho** do componente de aplicação, não dentro do repositório (ver `03-uml/Componentes/diagrama-componentes.mmd`).

| ID | Operação | Passos na mesma transação | Isolamento exigido |
|---|---|---|---|
| **TRS-01** | solicitar agendamento (RF-025) | `SELECT … FOR UPDATE` no slot → verificar livre → `INSERT agendamento` (`CONFIRMADO`) → `INSERT registro_auditoria` | `READ COMMITTED` + lock de linha no slot |
| **TRS-02** | cancelar agendamento (RF-027) | `UPDATE agendamento` → `UPDATE disponibilidade`? **não** (o slot é liberado pela coluna gerada) → abrir oferta ao próximo da fila → `INSERT registro_auditoria` | `READ COMMITTED` |
| **TRS-03** | abrir oferta (RF-035) | `SELECT … FOR UPDATE` no slot → verificar livre → `UPDATE solicitacao_espera` para `OFERTADA` + `prazo_aceite` → `INSERT registro_auditoria` | `READ COMMITTED` |
| **TRS-04** | aceitar oferta (RF-036) | `SELECT … FOR UPDATE` no slot → verificar livre → `INSERT agendamento` → `UPDATE solicitacao_espera` para `ACEITA` + `id_agendamento` → `INSERT registro_auditoria` | `READ COMMITTED` |
| **TRS-05** | registrar atendimento (RF-030) | verificar `agendamento.situacao = 'CONFIRMADO'` → `INSERT atendimento` → `UPDATE agendamento` para `REALIZADO` → `INSERT registro_auditoria` | `READ COMMITTED` |
| **TRS-06** | registrar não comparecimento (RF-037) | `UPDATE agendamento` para `NAO_COMPARECEU` → `INSERT registro_auditoria` | `READ COMMITTED` |
| **TRS-07** | envio de e-mail (RF-033) | **fora** da transação de negócio, após o `COMMIT`; falha gera `INSERT registro_auditoria` (`FALHA_ENVIO_EMAIL`) | — |

**Por que TRS-07 fica fora.** DEC-029 determina que a falha de e-mail **não desfaz** a operação. Se o envio estivesse dentro da transação, uma falha do provedor reverteria o agendamento — o oposto da decisão.

**Por que `FOR UPDATE` no slot, e não só no agendamento.** Antes de existir agendamento não há linha em `agendamento` para bloquear. A linha que precisa ser serializada é a do **slot**: é ela que duas transações concorrentes tentariam ocupar. O `uk_agendamento_slot_ativo` é a rede de segurança caso o lock falhe; a mensagem de erro precisa distinguir "slot já ocupado" (regra de negócio) de "violação de unicidade" (defeito).

---

## 8. Índices

Além das chaves, os índices abaixo cobrem as consultas de RF-024, RF-028, RF-029, RF-031, RF-034 e RF-013 (RNF-018).

| Índice | Tabela | Colunas | Consulta atendida |
|---|---|---|---|
| `ix_usuario_situacao` | `usuario` | `(situacao_conta)` | autenticação, painel administrativo |
| `ix_vinculo_psicologo` | `vinculo` | `(id_psicologo, situacao)` | RF-017 |
| `ix_vinculo_paciente` | `vinculo` | `(id_paciente, situacao)` | RF-022, RF-028 |
| `uk_disp_slot` | `disponibilidade` | `(id_agenda, data, hora_inicio)` | RF-024, RF-029 (índice único que também serve à consulta) |
| `ix_agendamento_psicologo` | `agendamento` | `(id_psicologo, situacao)` | RF-029 |
| `ix_agendamento_paciente` | `agendamento` | `(id_paciente, situacao)` | RF-028 |
| `ix_atendimento_par` | `atendimento` | `(id_psicologo, id_paciente, data_hora_registro)` | RF-031 |
| `ix_se_slot` | `solicitacao_espera` | `(id_disponibilidade, situacao, data_hora_entrada)` | RF-035 (próximo da fila) |
| `ix_se_psicologo` | `solicitacao_espera` | `(id_psicologo, situacao, data_hora_entrada)` | RF-034 (posição) |
| `ix_se_paciente` | `solicitacao_espera` | `(id_paciente, situacao, data_hora_entrada)` | consultas da fila por paciente (RF-034) |
| `ix_auditoria_data` | `registro_auditoria` | `(data_hora)` | RF-013 |
| `ix_auditoria_usuario` | `registro_auditoria` | `(id_usuario, data_hora)` | RF-013 |
| `ix_auditoria_operacao` | `registro_auditoria` | `(operacao, data_hora)` | RF-013 |

**Índices de suporte a FK e a consultas administrativas** (presentes no DDL e contados no censo da Fase 8; o MySQL exige um índice sobre as colunas de toda FK — quando nenhum dos índices acima cobre, o DDL declara um):

| Índice | Tabela | Colunas | Propósito |
|---|---|---|---|
| `ix_pp_permissao` | `perfil_permissao` | `(id_permissao)` | FK e revogação por permissão (RF-008) |
| `ix_pa_area` | `psicologo_area_atuacao` | `(id_area_atuacao)` | FK (a PK composta já cobre a FK do psicólogo) |
| `ix_usuario_perfil` | `usuario` | `(id_perfil)` | FK; painel por perfil |
| `ix_paciente_situacao` | `paciente` | `(situacao_cadastral)` | filtro administrativo por situação (RF-012) |
| `ix_agendamento_cancelamento` | `agendamento` | `(id_usuario_cancelamento)` | FK; auditoria de cancelamento |
| `uk_agenda_id_psicologo` | `agenda` | `(id, id_psicologo)` | índice único exclusivo para a FK composta de `disponibilidade` |

Os índices de FK composta de `disponibilidade`, `agendamento`, `atendimento` e `solicitacao_espera` são cobertos pelos `uk_`-chaves candidatas do início de cada tabela (§4.11, §4.12, §4.13, §4.14).

**Índices que não existem de propósito:** nenhum índice em `hash_senha` (nunca é buscado), nenhum índice em `contexto_sessao` (não é pesquisável), nenhum índice de texto livre.

---

## 9. Rastreabilidade das restrições

| Regra | Restrição que a implementa |
|---|---|
| RN-001 | `ck_usuario_situacao` + filtro `= 'ATIVO'` na autenticação |
| RN-002 | ausência de coluna de senha + `ck_usuario_hash` |
| RN-003 | `vinculo` + `ck_vinculo_temporal` + filtro por situação |
| RN-005 | `uk_agendamento_slot_ativo` + TRS-01 |
| RN-006 | TRS-05 (guarda de transição) |
| RN-007 | `fk_atendimento_*` + `fk_vinculo_*` |
| RN-009 | TRS-01 a TRS-06 (auditoria na mesma transação) |
| RN-011 | `fk_disp_agenda_psicologo` |
| RN-012 | `ck_agendamento_cancelamento` |
| RN-013 | `ck_agendamento_situacao` sem `'SOLICITADO'` |
| RN-014 | *append-only* + trigger opcional |
| RN-016 | `uk_vinculo_vigente` |
| RN-017 | `uk_atendimento_agendamento` + `fk_atendimento_agendamento` |
| RN-018 | `fk_agendamento_slot` |
| RN-019 | `fk_atendimento_agendamento` (trio) |
| RN-020 | `ck_agendamento_situacao` |
| RN-021 | `solicitacao_espera` + TRS-03/TRS-04 |
| RN-022 | ausência de tabela + TRS-07 |
| RN-023 | `ix_se_slot` + imutabilidade de `data_hora_entrada` |
| RN-024 | `uk_se_oferta` |
| DEC-013 | `ck_usuario_situacao` |
| DEC-014 | `ck_paciente_situacao` |
| DEC-015 | `ck_vinculo_situacao` + `ck_vinculo_temporal` |
| DEC-019 | `usuario.id_perfil NOT NULL` (sem `UNIQUE`) |
| DEC-021 | `id_usuario` nulo e único em `psicologo` e `paciente` |
| DEC-024 | `situacao_anterior` / `situacao_nova` + `ck_auditoria_situacao_par` |
| DEC-029 | `resultado = 'FALHA'` + `operacao = 'FALHA_ENVIO_EMAIL'` + TRS-07 |

---

## 10. Pendências

| ID | Pendência | Efeito no modelo relacional |
|---|---|---|
| P-20 | fila por horário sem slot cadastrado | `solicitacao_espera.id_disponibilidade` passaria a `NULL` e precisaria de colunas de preferência |
| P-21 | atributos descritivos mínimos | as colunas `nome`, `registro_profissional` e `email_contato` estão marcadas como provisórias no dicionário §7 |
| INC-17 | `OfertaVaga` como tabela | alternativa pronta em §5.3 |
| — | RN-023 e RN-024 ainda são propostas | se não forem aprovadas, os índices `uk_se_oferta` e a imutabilidade de `data_hora_entrada` continuam válidos como decisão técnica do DER, mas perdem a âncora em requisito |
