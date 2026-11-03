# DER-001 — Modelo Entidade-Relacionamento lógico

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Fase do plano:** Fase 7 — Persistência
**Versão:** v1.1 · **Data:** 30/10/2026 (conferência da Fase 8)
**SGBD de referência:** MySQL 8.0 (DEC-003)
**Artefatos deste diagrama:**

| Formato | Arquivo | Papel |
|---|---|---|
| Mermaid | [`der-001.mmd`](der-001.mmd) | fonte da verdade do conteúdo |
| draw.io | [`der-001.drawio.xml`](der-001.drawio.xml) | fonte editável gráfica |
| PDF | *(pendente de exportação)* | ver §9 |

> **Por que não há PDF nesta entrega.** A exportação para PDF exige diagrams.net (web ou desktop) ou um renderizador Mermaid. Nenhum dos dois está disponível no ambiente em que este documento foi produzido, e a preferência registrada do grupo é **não instalar ferramentas novas** para gerar diagramas. O `.mmd` é a fonte da verdade e abre direto no GitHub; o `.drawio.xml` abre no diagrams.net, de onde o PDF é exportado com *Arquivo → Exportar como → PDF*. O mesmo vale para PAC-001, CMP-001 e IMP-001.

---

## 1. Objetivo e fontes

Fixar a estrutura persistente que atende aos 37 requisitos funcionais da baseline, às 22 regras de negócio oficiais (mais as propostas RN-023 e RN-024) e às decisões DEC-001 a DEC-030.

**Insumos:**

- [`04-persistencia/impacto-requisitos.md`](../impacto-requisitos.md) — impacto de cada RF/RN/RNF na persistência;
- [`03-uml/Classes/diagrama-classes.mmd`](../../03-uml/Classes/diagrama-classes.mmd) e [`especificacao-classes.md`](../../03-uml/Classes/especificacao-classes.md) — CLS-001, associações A01–A16;
- [`03-uml/Dominio/modelo-dominio.md`](../../03-uml/Dominio/modelo-dominio.md) — modelo conceitual;
- [`03-uml/Sequências/proposta-I2-especificacao-sequencias.md`](../../03-uml/Sequências/proposta-I2-especificacao-sequencias.md) — SEQ-004 e os estados da fila;
- [`03-uml/Estados/proposta-I2-especificacao-estados.md`](../../03-uml/Estados/proposta-I2-especificacao-estados.md) — EST-001;
- [`01-planejamento/decisoes.md`](../../01-planejamento/decisoes.md) — DEC-013 a DEC-030.

**Relação com o CLS-001.** O DER **não substitui** o modelo de classes do Integrante 3: ele é a projeção relacional do CLS-001 acrescida das classes que ainda estão pendentes de oficialização (lista de espera). Toda divergência está declarada na §8 e registrada como `INC-14` a `INC-17` em [`impacto-requisitos.md`](../impacto-requisitos.md) §9.

---

## 2. Convenções

| Convenção | Regra adotada |
|---|---|
| Nome de tabela | singular, minúsculas, `snake_case`, derivado do nome da classe (`Paciente` → `paciente`) |
| Nome de coluna | `snake_case`; `id_<tabela>` para FK; `data_*`, `hora_*`, `*_em` para tempo |
| Chave primária | surrogate `BIGINT AUTO_INCREMENT` em todas as tabelas, exceto as associativas puras |
| Chave natural | declarada como `UNIQUE` quando existe e é estável (`usuario.identificacao`, `perfil.nome`, `permissao.codigo`) |
| Domínio fechado | `VARCHAR` + `CHECK` em vez de `ENUM`, para permitir evolução sem `ALTER TABLE` destrutivo e manter o valor legível no banco |
| Tempo | `DATETIME` para instantes, `DATE` para datas civis, `TIME` para hora do slot; **sempre** carimbado pelo servidor |
| Exclusão | **nunca** física: inativação por coluna de situação; `ON DELETE RESTRICT` em todas as FKs |
| Nulidade | declarada coluna a coluna; `NULL` só quando o conceito é opcional por decisão (DEC-021, DEC-024) |
| Unicidade condicional | coluna gerada `TINYINT` que vale `1` quando a condição ocorre e `NULL` caso contrário, dentro de `UNIQUE` — o MySQL permite vários `NULL` no índice |
| Cardinalidade | notação `1:1`, `1:N`, `0..1:0..1` na forma "instâncias da esquerda por instância da direita" |

**Por que coluna gerada em vez de índice parcial.** O MySQL 8.0 não implementa `CREATE UNIQUE INDEX … WHERE`. A coluna gerada reproduz o índice parcial do PostgreSQL: `NULL` quando a linha não participa da regra, `1` quando participa. O índice único passa a valer só para as linhas participantes.

---

## 3. Entidades

| # | Tabela | Classe de origem | RF | RN | Papel |
|---|---|---|---|---|---|
| 1 | `perfil` | `Perfil` | RF-007 | — | agrupamento nomeado de permissões |
| 2 | `permissao` | `Permissao` | RF-008 | — | operação autorizável |
| 3 | `perfil_permissao` | associação A02 | RF-007, RF-008 | — | resolução do N:N `Perfil` × `Permissao` |
| 4 | `usuario` | `Usuario` | RF-001 a RF-006 | RN-001, RN-002 | conta de acesso |
| 5 | `area_atuacao` | `AreaAtuacao` | RF-016 | — | catálogo de especialidades |
| 6 | `psicologo` | `Psicologo` | RF-014, RF-015 | — | cadastro profissional |
| 7 | `psicologo_area_atuacao` | associação A05 | RF-016 | — | resolução do N:N `Psicologo` × `AreaAtuacao` |
| 8 | `paciente` | `Paciente` | RF-018 a RF-020 | RN-004 | cadastro do cliente/paciente |
| 9 | `vinculo` | `Vinculo` | RF-017, RF-021 | RN-003, RN-016 | autorização profissional por relação |
| 10 | `agenda` | `Agenda` | RF-023, RF-029 | RN-011 | titularidade da agenda do profissional |
| 11 | `disponibilidade` | `Disponibilidade` | RF-023, RF-024 | RN-005, RN-010, RN-011 | slot discreto ofertado (DEC-018) |
| 12 | `agendamento` | `Agendamento` | RF-025 a RF-029, RF-037 | RN-005, RN-012, RN-013, RN-020 | compromisso |
| 13 | `atendimento` | `Atendimento` | RF-030, RF-031 | RN-006, RN-007 | sessão efetivamente realizada |
| 14 | `solicitacao_espera` | `EntradaListaEspera` / `SolicitacaoEspera` (P8) | RF-034 a RF-036 | RN-021, RN-023, RN-024 | entrada na fila e oferta de vaga (DEC-027) |
| 15 | `registro_auditoria` | `RegistroAuditoria` | RF-013, RF-032 | RN-008, RN-009, RN-014 | trilha append-only (DEC-024) |

**Total: 15 tabelas.** Nenhuma entidade do CLS-001 ficou de fora e nenhuma tabela nasceu sem requisito de origem.

---

## 4. Relacionamentos

### 4.1 Tabela de relacionamentos e chaves estrangeiras

| # | Origem → destino | Cardinalidade | Coluna(s) | Regra de integridade |
|---|---|---|---|---|
| R01 | `usuario` → `perfil` | N:1 | `id_perfil` NOT NULL | DEC-019 — toda conta tem exatamente um perfil |
| R02 | `perfil_permissao` → `perfil` | N:1 | `id_perfil` | parte da PK composta |
| R03 | `perfil_permissao` → `permissao` | N:1 | `id_permissao` | parte da PK composta |
| R04 | `psicologo` → `usuario` | 0..1:0..1 | `id_usuario` NULL + UNIQUE | DEC-021 — cadastro pode existir sem conta |
| R05 | `paciente` → `usuario` | 0..1:0..1 | `id_usuario` NULL + UNIQUE | DEC-021 |
| R06 | `psicologo_area_atuacao` → `psicologo` | N:1 | `id_psicologo` | PK composta |
| R07 | `psicologo_area_atuacao` → `area_atuacao` | N:1 | `id_area_atuacao` | PK composta |
| R08 | `vinculo` → `psicologo` | N:1 | `id_psicologo` | parte do índice único de vigência |
| R09 | `vinculo` → `paciente` | N:1 | `id_paciente` | parte do índice único de vigência |
| R10 | `agenda` → `psicologo` | 1:1 | `id_psicologo` NOT NULL + UNIQUE | A08 — um titular por agenda, uma agenda por titular |
| R11 | `disponibilidade` → `agenda` | N:1 | `id_agenda` NOT NULL | A09 — o slot pertence a uma agenda |
| R12 | `disponibilidade` → `agenda` (coerência de titular) | N:1 | `(id_agenda, id_psicologo)` | FK composta — o psicólogo do slot é o titular da agenda |
| R13 | `agendamento` → `disponibilidade` | 0..1:1 | `(id_disponibilidade, id_psicologo)` | A17 + RN-018 — o slot ocupado é do mesmo psicólogo |
| R14 | `agendamento` → `psicologo` | N:1 | `id_psicologo` | A11 |
| R15 | `agendamento` → `paciente` | N:1 | `id_paciente` | A12 |
| R16 | `agendamento` → `usuario` | N:1 | `id_usuario_cancelamento` NULL | RN-012/DEC-028 — autor do cancelamento |
| R17 | `atendimento` → `agendamento` | 0..1:1 | `(id_agendamento, id_psicologo, id_paciente)` | A15 + RN-017 + RN-019 — coerência do trio |
| R18 | `atendimento` → `psicologo` | N:1 | `id_psicologo` | A13 |
| R19 | `atendimento` → `paciente` | N:1 | `id_paciente` | A14 |
| R20 | `solicitacao_espera` → `psicologo` | N:1 | `id_psicologo` | A18 (proposta) |
| R21 | `solicitacao_espera` → `paciente` | N:1 | `id_paciente` | A19 (proposta) |
| R22 | `solicitacao_espera` → `disponibilidade` | N:1 | `(id_disponibilidade, id_psicologo)` | A20 + RN-018 — a vaga ofertada é do mesmo psicólogo |
| R23 | `solicitacao_espera` → `agendamento` | 0..1:0..1 | `id_agendamento` NULL + UNIQUE | A21 (proposta) — o aceite gera um único agendamento |
| R24 | `registro_auditoria` → `usuario` | N:0..1 | `id_usuario` NULL | A16 + DEC-024 — responsável pode não existir (falha de autenticação) |

### 4.2 Associações que **não** viraram FK

| Associação | Motivo | Como o vínculo é obtido |
|---|---|---|
| **A10** `Agenda` — `Agendamento` | Com DEC-018 o agendamento referencia o **slot**, e o slot referencia a agenda. Criar `agendamento.id_agenda` seria dependência transitiva (3FN) e abriria a possibilidade de agenda divergente | junção `agendamento → disponibilidade → agenda` |
| **A01** `Usuario` — `Perfil` como N:N | DEC-019 fixou 1 perfil por conta | FK simples `usuario.id_perfil` |
| `Vinculo` como atributo de `Atendimento` | O vínculo é a **autorização** vigente no momento do acesso, não uma propriedade imutável da sessão | consulta `EXISTS` sobre `vinculo` com `situacao = 'ATIVO'` (RN-003) |

### 4.3 Resolução das associações N:N

| Associação | Tabela associativa | PK | Observação |
|---|---|---|---|
| A02 `Perfil` × `Permissao` | `perfil_permissao` | `(id_perfil, id_permissao)` | associativa pura, sem atributos próprios |
| A05 `Psicologo` × `AreaAtuacao` | `psicologo_area_atuacao` | `(id_psicologo, id_area_atuacao)` | associativa pura; a especificação não fixa mínimo de áreas (A05) |

Não há associação N:N que carregue atributos no CLS-001. Se o grupo adotar `OfertaVaga` como classe própria (INC-17), ela será uma tabela associativa **com atributos** (`prazo_aceite`, `resposta`), e não uma associativa pura.

### 4.4 FK compostas de coerência

Três regras de negócio exigem que duas colunas de tabelas diferentes "combinem". O DER resolve isso com **FK composta sobre chave candidata**, não com validação apenas na aplicação:

| Regra | Restrição |
|---|---|
| RN-018 — o slot ocupado é do psicólogo do agendamento | `disponibilidade` declara `UNIQUE (id, id_psicologo)`; `agendamento` declara `FOREIGN KEY (id_disponibilidade, id_psicologo) REFERENCES disponibilidade (id, id_psicologo)` |
| RN-011 — o slot pertence à agenda do próprio psicólogo | `agenda` declara `UNIQUE (id, id_psicologo)`; `disponibilidade` declara `FOREIGN KEY (id_agenda, id_psicologo) REFERENCES agenda (id, id_psicologo)` |
| RN-017/RN-019 — psicólogo e paciente do atendimento são os do agendamento | `agendamento` declara `UNIQUE (id, id_psicologo, id_paciente)`; `atendimento` declara `FOREIGN KEY (id_agendamento, id_psicologo, id_paciente) REFERENCES agendamento (id, id_psicologo, id_paciente)` |

**Custo declarado.** Para que a FK composta exista, `disponibilidade` repete `id_psicologo` (já derivável de `agenda`) e `atendimento` repete `id_psicologo` e `id_paciente` (já deriváveis de `agendamento`). É **desnormalização controlada**: a coluna repetida não pode divergir, porque a FK composta a amarra à origem. O ganho é que RN-011, RN-017, RN-018 e RN-019 deixam de depender de código de aplicação. A análise está em [`normalizacao.md`](../normalizacao.md) §6.

### 4.5 Diagrama

O arquivo [`der-001.mmd`](der-001.mmd) contém 15 entidades e 22 relações. As relações A18–A21 estão marcadas como proposta porque as classes correspondentes ainda não foram oficializadas pelo Integrante 3 (P8).

---

## 5. Domínios fechados

| Tabela.coluna | Valores | Origem |
|---|---|---|
| `usuario.situacao_conta` | `ATIVO`, `BLOQUEADO`, `INATIVO` | DEC-013 |
| `paciente.situacao_cadastral` | `ATIVO`, `SUSPENSO`, `INATIVO` | DEC-014 |
| `vinculo.situacao` | `ATIVO`, `ENCERRADO` | DEC-015 |
| `agendamento.situacao` | `CONFIRMADO`, `CANCELADO`, `REALIZADO`, `NAO_COMPARECEU` | DEC-016, RN-020 |
| `solicitacao_espera.situacao` | `AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU` | SEQ-004, DEC-027 |
| `registro_auditoria.resultado` | `SUCESSO`, `FALHA` | DEC-029 (falha de e-mail) |

`SOLICITADO` **não existe** em nenhum domínio (DEC-016). `ServicoNotificacao` não existe em nenhum nome (DEC-022).

---

## 6. Regras de integridade que o DER garante sozinho

| Regra | Garantia |
|---|---|
| RN-005 — um slot não tem dois agendamentos ativos | `UNIQUE (slot_ativo)` em `agendamento`, com `slot_ativo = id_disponibilidade` apenas quando `situacao = 'CONFIRMADO'` |
| RN-016 — um vínculo vigente por par | `UNIQUE (id_psicologo, id_paciente, vigente)` em `vinculo` |
| RN-024 — uma oferta aberta por slot | `UNIQUE (id_disponibilidade, oferta_aberta)` em `solicitacao_espera` |
| RN-023 — fila sem reordenação | `data_hora_entrada` imutável (trigger opcional, §17 do DDL) |
| RN-014 — auditoria imutável | `ON DELETE RESTRICT` + trigger que recusa `UPDATE`/`DELETE` (opcional) |
| RN-017 — atendimento não vem de cancelado | o `atendimento` só é criado quando `agendamento.situacao = 'CONFIRMADO'`, e a própria transição leva o agendamento para `REALIZADO`; a guarda de transição é da aplicação (TRS-05), e a FK impede atendimento órfão |
| RN-020 — situações válidas | `CHECK` de domínio |
| DEC-024 — situação anterior/nova | colunas `situacao_anterior` e `situacao_nova` em `registro_auditoria` |

---

## 7. O que **não** virou tabela

| Conceito | Decisão | Consequência para a persistência |
|---|---|---|
| Sessão autenticada | DEC-020 | nenhuma tabela `sessao`; o token/estado é volátil |
| Notificação / outbox | DEC-022 | nenhuma tabela `notificacao`; a fronteira é a interface `ServicoEnvioMensagem` |
| Histórico de situação por entidade | DEC-024 | a trilha fica em `registro_auditoria` (`situacao_anterior`, `situacao_nova`), sem tabela `historico_situacao` |
| `OfertaVaga` como entidade | INC-17 | a oferta é a situação `OFERTADA` de `solicitacao_espera`; alternativa descrita em [`modelo-relacional.md`](../modelo-relacional.md) §5.3 |
| Prontuário / conteúdo clínico | DEC-008 | `atendimento.contexto_sessao` é texto curto; não há tabela de evolução clínica |

---

## 8. Divergências declaradas em relação ao CLS-001

| ID | Divergência | Decisão do DER |
|---|---|---|
| INC-14 | DEC-019 escreve `Usuario "0..1" — Perfil "1"`, que pela convenção do repositório significaria "um perfil atende no máximo uma conta" | o DER adota a leitura semântica da própria DEC-019 ("um perfil pode ser compartilhado por várias contas"): `usuario.id_perfil NOT NULL`, sem `UNIQUE` em `id_perfil` |
| INC-15 | `Agendamento.horario` é atributo no CLS-001; com DEC-018 o tempo é do slot | `horario` é **projeção derivada** de `disponibilidade (data, hora_inicio)`; não há coluna de horário em `agendamento` |
| INC-16 | O CLS-001 não tem atributo de e-mail de contato, necessário a RF-033 | o DER cria `psicologo.email_contato` e `paciente.email_contato` (não em `usuario`: o destinatário é a pessoa do cadastro, que pode existir sem conta — DEC-021) |
| INC-17 | `OfertaVaga` como classe (P8) × `OFERTADA` como situação (SEQ-004) | o DER adota a situação, com a alternativa documentada |
| — | `RegistroAuditoria` tem `Data` e `Hora` separados | o DER usa `data_hora DATETIME` único, para ordenação cronológica e comparação de instantes (RN-014, RNF-004) |
| — | `Disponibilidade.periodo` (intervalo) | substituído por `data`, `hora_inicio` e `duracao_minutos` (DEC-018) |

---

## 9. Pendências e próximos passos

| ID | Pendência | Impacto no DER |
|---|---|---|
| P-20 | fila por horário sem slot cadastrado | se confirmada, `solicitacao_espera` precisa de colunas de preferência temporal e `id_disponibilidade` passa a aceitar `NULL` |
| P-21 | atributos descritivos mínimos e e-mail de contato | o DER usa o mínimo (`nome`, `registro_profissional`, `email_contato`) e registra a origem em [`dicionario-de-dados.md`](../dicionario-de-dados.md) §7 |
| INC-14 a INC-17 | ver §8 | resolvidas no DER, pendentes de validação pelos donos dos artefatos |
| PDF | exportação dos diagramas | depende de diagrams.net; não bloqueia o conteúdo |

**Próximo artefato:** [`modelo-relacional.md`](../modelo-relacional.md), que detalha PK, FK, UNIQUE, CHECK, NOT NULL e a estratégia de exclusão.
