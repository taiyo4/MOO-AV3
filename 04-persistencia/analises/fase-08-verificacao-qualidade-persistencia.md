# Fase 8 — Verificação de qualidade da persistência e da arquitetura (Integrante 4)

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Data:** 30/10/2026 · **Atualizado em:** 31/10/2026 · **Versão:** v1.1
**Tarefas do plano atendidas** (Fase 8, bloco do Integrante 4 — `01-planejamento/etapas-e-responsabilidades.md` §3):

1. revisar **PK, FK, UNIQUE, NOT NULL, N:N, normalização, integridade referencial e exclusão/inativação**;
2. verificar **pacotes, componentes, interfaces e implantação** após as correções comportamentais;
3. confirmar que o **dicionário de dados** e o **mapeamento objeto-relacional** estão completos;
4. fornecer **evidências técnicas** para os critérios de **segurança, compatibilidade, confiabilidade e manutenibilidade**;
5. (etapa do I1 · §3) produzir os **testes conceituais de persistência e arquitetura**.

**Natureza:** verificação por **inspeção e censo**, não por execução. Não há MySQL no ambiente; o DDL continua validado textualmente (`README` da pasta e `ddl/schema-mysql.sql` cabeçalho). Os testes TDB-01 a TDB-14 definem **o que executar** quando houver SGBD: cada um é verificado por `CREATE`/`INSERT`/`UPDATE` recusado ou por `EXPLAIN`.

---

## 0. Escopo, método e insumos

| Item | Conteúdo |
|---|---|
| **Artefatos verificados (meus)** | `der/der-001-logico.md` + `der-001.mmd` · `modelo-relacional.md` · `dicionario-de-dados.md` · `mapeamento-objeto-relacional.md` · `normalizacao.md` · `ddl/schema-mysql.sql` · PAC-001/CMP-001/IMP-001 (`03-uml/`) |
| **Correlatos lidos (não alterados)** | `01-planejamento/revisoes/FASE7-REV-I2-*.md` e `FASE8-REV-I2-testes-conceituais.md`; `06-rastreabilidade/matriz-rastreabilidade-fase5.md` e `-fase6.md`; `05-qualidade/plano-qualidade-iso25010.md`; `02-requisitos/requisitos-{funcionais,nao-funcionais}.md`, `regras-negocio.md`, `criterios-aceite.md`; `01-planejamento/decisoes.md`; `07-dossie/secoes/fases7-9-secao-25-36.md` |
| **Método** | Censo declarado no DDL × declaração no modelo relacional × dicionário × mapeamento; confronto das restrições com RF/RN/RNF/CA/DEC; confronto das mensagens/comportamento (SEQ/AP/IR) com PAC/CMP/IMP após R7-01 a R7-12; checklist dos 4 critérios de qualidade da Fase 7 |
| **Resultado global** | **Aprovada com correções aplicadas** (§1 e §7): o esquema que estava nos três documentos coincide, e não há restrição ausente ou órfã. Nenhum achado exige mudança estrutural; todos são de texto/referência ou de divergência em artefato de outro integrante (§7.3) |

**Regra respeitada:** artefato de outro integrante **não é alterado**. As divergências encontradas neles estão em §7.3 como achados endereçados ao dono.

---

## 1. Censo das restrições (DDL × modelo relacional × dicionário)

Contagem direta no `ddl/schema-mysql.sql` (versão 1.0, congelada), confrontada com `modelo-relacional.md` §4 (declaração) e `dicionario-de-dados.md` (colunas).

| Contagem | DDL | Modelo relacional | Dicionário | Veredito |
|---|---|---|---|---|
| Tabelas | **15** | 15 (`§4.1`–`§4.15`) | 15 (`§3.1`–`§3.15`) | ✔ |
| Colunas | **97** | *— (não lista colunas por escolha da v1.0)* | **97** (uma linha por coluna) | ✔ |
| PK | **15** (13 `BIGINT AUTO_INCREMENT` + 2 PK compostas) | 15 | 15 | ✔ |
| UNIQUE | **17** (inclui as 4 chaves candidatas de FK composta e 4 índices únicos de coluna gerada) | 17 | *—* | ✔ |
| FK (REFERENCES) | **24** | 24 | *—* | ✔ |
| — das quais FK composta | **4** (`disponibilidade→agenda`, `agendamento→disponibilidade`, `atendimento→agendamento`, `solicitacao_espera→disponibilidade`) | 4 (§4.4 do DER) | *—* | ✔ |
| CHECK nomeados | **26** | 26 | 26 na coluna "Regra / domínio" | ✔ |
| Índices secundários (`ix_`) | **17** | 17 (§8, atualizado na Fase 8) | *—* | ✔ |
| Colunas geradas (`STORED`) | **4** (`vigente`, `slot_ativo`, `fila_ativa`, `oferta_aberta`) | 4 | 4 (§4.3) | ✔ |
| Triggers | **3** (DDL §17) | 3 (ref. §17 — corrigida na Fase 8) | *—* | ✔ |
| Domínios fechados | **6** enumerações + `uk_permissao_codigo` | 6 | 6 (§4.1) | ✔ |
| Carga inicial | **3** perfis + **29** permissões (`perfil_permissao` não é carregada — RF-007/RF-008) | — | catálogo §4.2 coerente | ✔ |

**NOT NULL:** em todas as tabelas, `NULL` só existe em coluna optada por decisão registrada (`id_usuario` de `psicologo`/`paciente` — DEC-021; `email_contato`; `data_fim` de `vinculo`; `data_cancelamento`/`id_usuario_cancelamento`; `data_nao_comparecimento`; `prazo_aceite`/`data_hora_encerramento`/`id_agendamento` de `solicitacao_espera`; `contexto_sessao`; `id_usuario`/`id_entidade`/`detalhe`/`situacao_anterior`/`situacao_nova` de `registro_auditoria`; `descricao`). Nenhuma coluna de negócio ficou nulável por omissão — conferido coluna a coluna contra o dicionário.

**As contagens em relação à Fase 7:** nenhuma contagem mudou de valor — o que a Fase 8 corrigiu está em §7.1 (referências cruzadas e cadastro de `ck_*_nome`/índices que já existiam no DDL e não estavam declarados no modelo/tabelas de referência).

---

## 2. N:N, normalização e integridade referencial

### 2.1 N:N

| Verificação | Resultado |
|---|---|
| Existe N:N sem tabela associativa? | Não: as duas N:N oficializadas (A02 `Perfil`×`Permissao`, A05 `Psicologo`×`AreaAtuacao`) viram `perfil_permissao` e `psicologo_area_atuacao`, ambas **associativas puras** (PK composta, sem `id` próprio, sem `atualizado_em`) |
| N:N com atributo? | Nenhuma no CLS-001 aprovado; a candidata (`OfertaVaga`, INC-17) foi resolvida como situação `OFERTADA` de `solicitacao_espera`, com a alternativa de tabela associativa com atributos documentada em `modelo-relacional.md` §5.3 e `mapeamento...` MD-18 |
| Revogação nas associativas | `DELETE` permitido **só** nelas (remover a associação não é apagar histórico — DDL §19); nas demais tabelas `ON DELETE RESTRICT` |

### 2.2 Normalização (`normalizacao.md`, re-checado na Fase 8)

| Redundância que existe | Controlada por | Veredito |
|---|---|---|
| `disponibilidade.id_psicologo` (derivável de `agenda`) | FK composta `(id_agenda, id_psicologo) → agenda (id, id_psicologo)` — impossível divergir | ✔ justificada (RN-011 no banco) |
| `agendamento.id_psicologo` + `id_paciente` (deriváveis do slot e do vínculo) | FK composta `(id_disponibilidade, id_psicologo)` + chave única `(id, id_psicologo, id_paciente)` | ✔ justificada (RN-018 no banco) |
| `atendimento.(id_psicologo, id_paciente)` (deriváveis do `agendamento`) | FK composta `(id_agendamento, id_psicologo, id_paciente) → agendamento (id, id_psicologo, id_paciente)` | ✔ justificada (RN-017/019 no banco) |
| `uk_agenda_id_psicologo` parece redundante | índice único exigido pelo MySQL para a FK composta — **não** é redundância de dados | ✔ documentado (§4.10) |

3FN demonstrada em `normalizacao.md` §5; 4FN/5FN triviais (sem dependência multivalorada indevida — §7). O domínio **não** carrega coluna derivada de tempo: `agendamento.horario` **não** é coluna (INC-15/MD-07), o que evita dependência transitiva.

### 2.3 Integridade referencial e exclusão/inativação

| Verificação | Evidência |
|---|---|
| Nenhuma FK `CASCADE` | 24 `REFERENCES` conferidas: todas `ON DELETE RESTRICT ON UPDATE RESTRICT` (RNF-009, RNF-013); a **evolução modular** fica então presa a exclusões explícitas de associação, não a efeito em cascata |
| "Sem exclusão de dado de negócio" | a exclusão física existe só na `perfil_permissao` e `psicologo_area_atuacao`; em todas as demais entidades, a saída do escopo é **inativação**: `usuario.situacao_conta`, `paciente.situacao_cadastral`, `vinculo.situacao`, `agendamento.situacao` — §6 do modelo relacional |
| Integridade do polimórfico `registro_auditoria.id_entidade` | **sem** FK, por decisão consciente (a trilha sobrevive à retirada de catálogo). Registrado em `modelo-relacional.md` §4.15 e MD-16 — coerente com RN-014/RNF-017 |
| Imutabilidade das trilhas | DDL §17 (3 triggers recusam `UPDATE`/`DELETE`); §19 reduz privilégios da conta de aplicação (sem `DELETE`, sem `UPDATE` na auditoria); `trg_se_entrada_imutavel` protege a ordem da fila (RN-023) |
| Carimbo único | 4 tabelas com carimbo de negócio substituem `criado_em` (`dicionário` §2.1); nenhuma delas tem carimbo técnico duplicado — verificado no DDL |

---

## 3. Verificação da arquitetura após as correções comportamentais (R7)

Os 12 achados do Integrante 2 (`FASE7-REV-I2` §3) que eram de dono I4 foram re-testados contra os artefatos atuais:

| Achado (I2) | Verificação na Fase 8 | Estado |
|---|---|---|
| **R7-01** inventário de mensagens antigo | a análise da Fase 6 v2.0 reescreveu o inventário (SEQ-002/003/004 atuais — `solicitar`, `notificar` sempre, `FALHA_ENVIO_EMAIL`, `abrirOferta`, `encerrar(DESISTIU)`) | **Fechado** (Fase 7) |
| **R7-02** CHECK de situações | `ck_agendamento_situacao` com os **4** valores da DEC-016; `ck_se_situacao` com os **6** da DEC-027; `SOLICITADO` não existe em nenhum domínio | **Fechado** |
| **R7-03** fronteira de e-mail | `ServicoEnvioMensagem` é interface; `AdaptadorEmail` a realiza; **nenhuma** tabela `notificacao`; falha = `FALHA_ENVIO_EMAIL` em transação própria (TRS-07) | **Fechado** |
| **R7-04** fila fora do DER | `solicitacao_espera` persistida com 12 colunas, 3 UK e 4 CHECKs; ordem por `data_hora_entrada` | **Fechado** |
| **R7-05** transições erradas | o erro está na análise da Fase 6 v1.0; desde a v2.0 as transições do modelo são T0–T3 + fila, sem `data_confirmacao` (o carimbo é `criado_em`; a confirmação é a criação — DEC-016/017) | **Fechado** |
| **R7-07** reserva em dois caminhos | caminho único: `IRepositorioAgenda.bloquearSlot` (`SELECT … FOR UPDATE`) + `uk_agendamento_slot_ativo`; a oferta aberta reserva via `uk_se_oferta` + horário já bloqueado às tentativas diretas | **Fechado** |
| **R7-08** notificação × commit | DEC-022 não cria tabela → não há *outbox* persistida **de propósito**; a "gravação do evento" desta solução é a linha de auditoria `FALHA_ENVIO_EMAIL` (transação própria, TRS-07) e a repetição é operacional. Justificativa no diagrama e no §7 (TRS-07) | **Fechado** (decisão declarada) |
| **R7-10** auditoria com identificadores | `registro_auditoria` grava `id_usuario` (não objeto), `entidade` + `id_entidade` e o par `situacao_anterior`/`situacao_nova` no mesmo instante (DEC-024) | **Fechado** |
| **R7-11** hub onipotente | `ServicoAgenda` delega: autorização (`ServicoAutorizacao`), auditoria, tempo, e-mail (`IMSG`) e fila (`Fila` chama `ServicoListaEspera`); nenhuma mensagem volta para a `InterfaceUsuario` | **Fechado** |
| **R7-12** fonte do tempo | `ServicoTempo` está em PAC e CMP (AGD/FIL dependem dele); a decisão de fuso único/server-side está no texto de TRS e no IMP-001 (sem carimbo do cliente) | **Fechado** |
| **R7-06** especificações de UC | dono I2 — resolvido por ele (v1.1 das especificações) | N/A |
| **R7-09** consulta por vínculo | minha parte: `DEP-04`/`IMP-CMP-07` → `pacientesVinculados` e `agendaDoPsicologo` são consultas nomeadas com `LEFT JOIN vinculo` (`mapeamento` §8); UC-029 sem diagrama é pendência de I2 (registrado) | **Fechado** (minha parte) + pendência I2 |

### 3.1 PAC × CMP × IMP

| Verificação | Resultado |
|---|---|
| PAC-001 sem ciclo (CQ-FLE-03) | `apresentacao → aplicacao → dominio ← infraestrutura`; `configuracao` (composition root) monta as duas pontas em tempo de execução — inspeção direta do `.mmd`. O par `ServicoAgenda` ↔ `ServicoListaEspera` (UC-035/UC-036) é interno ao pacote `aplicacao`, portanto **não** cria ciclo entre pacotes |
| CMP-001 sem componente de infraestrutura no domínio | `IRepositorio*`, `ServicoEnvioMensagem` e `ServicoHashSenha` são **interfaces do domínio**; `Persistencia`, `AdaptadorEmail` e `ServicoHash` as realizam (DIP) |
| Todas as AP-01…AP-06 têm componente? | AP-01 `ServicoAutenticacao`; AP-02 `ServicoAuditoria`; AP-03 `ServicoAgenda`; AP-04 interface + `AdaptadorEmail`; AP-06 `ServicoListaEspera`; **AP-05 não vira componente, por decisão** — ver §3.2 |
| IR-01/IR-02 | materializadas como `IRepositorioUsuario` e `IRepositorioPerfil` (`mapeamento` §7) |
| IMP-001 × DEC | DEC-003 (MySQL 8.0), DEC-020 (sem servidor de estado), DEC-022 (e-mail sai do servidor de aplicação), DEC-029 (indisponibilidade do provedor não derruba a operação) — coerentes com as 3 conexões desenhadas |
| IMP-001 × dicionário | artefato `schema-mysql.sql` com "15 tabelas, 3 triggers" — bate com o censo (§1) |
| Divergência consciente declarada | "UnidadeTrabalho" existe em PAC-001 e **não** em CMP-001: no nível de componentes, a fronteira transacional está encapsulada em `Persistencia` + pool; TRS-01–07 continuam anotadas no PAC. Registrado como simplificação, não como lacuna |

### 3.2 AP-05 / RF-009 — por que o painel não tem componente

O painel administrativo (RF-009) é **leitura agregada** sem regra própria (impacto "Baixo" em `impacto-requisitos.md` §2; dicionário §6 marca "*(consulta agregada)*"). Ele é atendido por duas projeções (`usuario`/`psicologo`/`paciente` filtradas por perfil — RF-010 a RF-012) e pela trilha de auditoria (RF-013). A decisão, agora registrada como verificação e não como omissão:

- **não há componente `ServicoConsulta`**: cada consulta de projeção é atendida pelo repositório do agregado que a lê (`pacientesVinculados` em `IRepositorioVinculo`, `agendaDoPsicologo` em `IRepositorioAgendamento` etc.) — um componente de "consultas" seria um *hub* nomeado de leitura, exatamente o anti-padrão que o R7-11 combatia;
- a `InterfaceUsuario` chama os repositórios de leitura **só via componentes de aplicação** (nenhum SQL na apresentação).

Se o Integrante 2 quiser um componente de projeção na Fase 9, a troca é localizada — `CMP-001` não colide com nada que exista.

### 3.3 Sequência × componente

| Mensagem/comportamento (matriz Fase 6) | Componente do CMP-001 | Estado |
|---|---|---|
| AP-01 (SEQ-001) | `ServicoAutenticacao` (+ `ServicoAutorizacao`, `ServicoAuditoria`, hash) | ✔ |
| AP-03 (SEQ-002/003) | `ServicoAgenda` (+ `ServicoTempo`, `IMSG`) | ✔ |
| AP-06 (SEQ-004) | `ServicoListaEspera` (+ `ServicoTempo`, `IMSG`) | ✔ |
| AP-04 (UC-033) | interface `ServicoEnvioMensagem` + `AdaptadorEmail` → `ServicoExternoEmail` | ✔ |
| AP-02 (RN-009) | `ServicoAuditoria` → `IRepositorioAuditoria` → `registro_auditoria` | ✔ |
| IR-01/IR-02 (todas as seq.) | `IRepositorio*` realizadas por `Persistencia` → `BancoDados` MySQL 8.0 | ✔ |
| UC-035 (oferta após cancelamento) / UC-036 (aceite da oferta) | `ServicoAgenda` ↔ `ServicoListaEspera` — chamada bidirecional **dentro** do pacote `aplicacao`, sem ciclo entre pacotes | ✔ (Fase 8) |

---

## 4. Completude do dicionário e do mapeamento

### 4.1 Dicionário

| Verificação | Resultado |
|---|---|
| Uma linha por coluna de cada tabela? | Sim — 97/97 contra o censo do DDL (§1); nenhuma coluna órfã |
| Tipo, Null, Default, domínio e origem preenchidos? | Sim; origem cita RF/RN/DEC/Axx destino para toda coluna de negócio (§6 tem o mapa RF → coluna completo, RF-001 a RF-037) |
| Catálogo de `operacao` completo? | **Não estava** — corrigido na Fase 8: entradas `LOGIN_CONCEDIDO`, `LOGIN_NEGADO` (auditadas na SEQ-001 e citadas por CT-001/CT-032 do I2) e `PSICOLOGO_CRIADO` (par de `PACIENTE_CRIADO`) |
| Carimbo único | §2.1 formalizado; DDL obedece (nenhuma tabela tem `criado_em` + carimbo de negócio) |
| Campos provisórios (P-21) | §7 explicita `psicologo.nome/registro_profissional/email_contato` como provisórios enquanto o I3 não fecha PC-03/04/05 — **não é incoerência**: é rastreio da decisão consciente |

### 4.2 Mapeamento

| Verificação | Resultado |
|---|---|
| Classe → tabela | **12/12** classes oficiais do CLS-001; `SolicitacaoEspera` (proposta, P8) mapeada por SEQ-004/DEC-027 e aguardando oficialização do I3 (P8/LAC-10) — registrado, não omítido |
| Atributo → coluna | §4 do mapeamento cobre os 5 casos não triviais (`hash_senha`, `horario`, `periodo`, `estaAutorizado`, `Data`+`Hora`) e o resto em §4.6; zero atributo sem destino ou coluna sem origem |
| 18 decisões MD-01…MD-18 | todas com justificativa e consequência; MD-18 é a única que muda modelagem (INC-17) e cita a alternativa |
| Repositórios | 10 interfaces ↔ 10 dominadas pelo DDL (1 por agregado; associativas puras operadas pelas donas da FK) |
| Consultas nomeadas | 7 (`slotsLivres`, `proximoDaFila`, `posicaoNaFila`, `pacientesVinculados`, `historicoPermitido`, `agendaDoPsicologo`, `trilhaAuditoria`) cobrem todas as consultas indexadas (RNF-018) |
| O que não é mapeado | §10 é explícito: sessão, e-mail, outbox, entrada-livro; coincide com as 4 ausências do DDL (= DEC-020/022) |

---

## 5. Confronto com o que os outros integrantes declaram (atividade conjunta)

| Comparação | Meu artefato | Artefato do outro integrante | Situação |
|---|---|---|---|
| Classe × tabela | 12 entidades oficiais + `SolicitacaoEspera` (proposta); sem tabela de sessão, e-mail ou notificação (DEC-020/022) | CLS-001 (I3) | **Parcial**: CLS-001 sem atributos escalares de `Psicologo`/`Paciente` (PC-03/04/05, P-21), com `confirmar()` e multiplicidades `PENDENTE` (R6-09/Q5-01). O DER materializa a leitura aprovada (DEC-019/021); o fechamento depende do I3 (R8-03) |
| Classe × tabela | `SolicitacaoEspera` ↔ `solicitacao_espera` | SEQ-004 + UC-034/036/037 (I2, oficializado) | ✔ consistente; aguardo apenas I3 para feedback do mapeamento MD-* |
| Multiplicidade × cardinalidade | 22 relações do DER (A01–A17 + A18–A21), todas com NO/NN/UK/CHECK correspondente | matriz Fase 5/6 (I2) | Matrizes usam tabelas de "fase anterior" (`auditoria` em vez de `registro_auditoria`, `agendamento.status` em vez de `situacao`) — **R8-01/R8-02** registram e propõem a correção às donas |
| Sequência × componente | 136 mensagens ancoradas em AP/OP/IR | matriz Fase 6 v2.1 + SEQ/ATV/COM/EST de I2 | ✔ — cada AP e cada IR tem componente/interface no CMP-001 (§3.3) |
| Testes conceituais | TDB-01…TDB-14 (persistência, §6) | CT-001…CT-037 (convenção CT-0RF, DEC-026) do I2 | Complementares, sem sobreposição: os CT verificam **comportamento**; os TDB verificam **restrição de banco e transação** |

---

## 6. Testes conceituais de persistência e arquitetura (TDB)

Complementares aos CT-0RF do Integrante 2 (DEC-026): enquanto os CT verificam comportamento, os TDB verificam **restrição declarada, transação e índice**. Para cada TDB: Dado/Quando/Então + origem. Nenhum depende de execução; todos são executáveis nos `CREATE`/`INSERT` do DDL ou por `EXPLAIN` quando houver MySQL.

| ID | Teste | Resultado esperado | Origem |
|---|---|---|---|
| **TDB-01** | Dado `usuario` com `situacao_conta` fora de `{ATIVO,BLOQUEADO,INATIVO}` (ou `hash_senha` com < 20 caracteres), quando `INSERT`, então o SGBD recusa | `ck_usuario_situacao`/`ck_usuario_hash` recusam | DEC-013, RN-001, RN-002, RNF-014 |
| **TDB-02** | Dado slot já ocupado por `agendamento` `CONFIRMADO`, quando nova tentativa de `INSERT` no mesmo slot, então a geração de `slot_ativo` viola `uk_agendamento_slot_ativo` e o `INSERT` falha | só 1 agendamento ativo por slot; após `CANCELADO`, `slot_ativo` vira `NULL` e o slot volta a ficar livre | RN-005, RNF-016, CQ-CON-05 |
| **TDB-03** | Dado slot do psicólogo A, quando tentar `INSERT` `agendamento` com `id_psicologo` = B, então a FK composta `(id_disponibilidade, id_psicologo)` recusa | impossível reservar o slot de outro psicólogo | RN-011, RN-018 |
| **TDB-04** | Dado `agendamento` CONFIRMADO, quando `INSERT` em `atendimento` com par psicólogo-paciente divergente (ou id inexistente), então a FK composta recusa; nem duas visitas para o mesmo `agendamento` (`uk_atendimento_agendamento`) | atendimento coerente com o agendamento | RN-017, RN-019 |
| **TDB-05** | Dado par com vínculo `ATIVO`, quando criar **segundo** vínculo ativo, então `uk_vinculo_vigente` recusa; e `INSERT`/`UPDATE` com `situacao = 'ENCERRADO'` e `data_fim NULL` é recusado por `ck_vinculo_temporal` | no máximo um vínculo vigente por par; temporalidade coerente | RN-016, RNF-020 |
| **TDB-06** | Dado `paciente` com `situacao_cadastral = 'INATIVO'`, quando tentar `DELETE` (com histórico), então `RESTRICT` recusa | inativação no lugar de exclusão | RNF-009, RNF-013 |
| **TDB-07** | Dado `registro_auditoria` com linha, quando `UPDATE`/`DELETE` pela conta da aplicação, então trigger recusa (e privilégios do §19 revogam o direito) | trilha append-only | RN-014, RNF-017 |
| **TDB-08** | Dado `registro_auditoria` com `situacao_anterior` preenchida e `situacao_nova` nula, quando `INSERT`, então `ck_auditoria_situacao_par` recusa | situação anterior/nova sempre em par | DEC-024, RN-009 |
| **TDB-09** | Dado solicitação de fila duplicada (`solicitacao_espera` `AGUARDANDO` do mesmo par+slot), quando `INSERT`, então `uk_se_fila` recusa; e segunda oferta `OFERTADA` no mesmo slot é recusada por `uk_se_oferta` | dupla entrada ativa e dupla oferta proibidas | RN-024, DEC-027, RNF-021 |
| **TDB-10** | Dado valor fora dos 6 casos de `solicitacao_espera.situacao` ou dos 4 de `agendamento.situacao` (por exemplo `SOLICITADO`), quando `INSERT`, então `ck_se_situacao`/`ck_agendamento_situacao` recusam | SOLICITADO é inexistente no banco (DEC-016) | RNF-014, DEC-016 |
| **TDB-11** | Dado transação que muda `agendamento.situacao` (TRS-05), quando a gravação em `registro_auditoria` falhar, então **toda** a transação é revertida | situação e auditoria são atômicas | RN-015, RNF-015 |
| **TDB-12** | Dado falha do `AdaptadorEmail` após o `COMMIT` de TRS-01/02/03/04/05/06, quando registrar `FALHA_ENVIO_EMAIL` em transação própria, então a operação **não** é desfeita (DEC-029) | e-mail é pós-commit e repetível | DEC-029, TRS-07 |
| **TDB-13** | Dado `solicitacao_espera`, quando `UPDATE` de `data_hora_entrada`, então trigger recusa | ordem da fila imutável | RN-023, RNF-022 |
| **TDB-14** | Dado as consultas de RF-013, RF-017, RF-024, RF-028, RF-029 e RF-031, quando `EXPLAIN` | nenhum `type = ALL` nos filtros principais | RNF-010, RNF-018 |

**Testes de arquitetura inspetoriais** (sem SGBD): A-1 PAC-001 sem ciclo entre 4 camadas e `configuracao` ligando pontas (o par `ServicoAgenda` ↔ `ServicoListaEspera` é interno ao pacote `aplicacao`); A-2 nenhum componente acumula UI + regra + SQL (re-teste de R7-11 contra o CMP-001 atual); A-3 toda interface de domínio tem realização na infraestrutura (10 `IRepositorio*`, `ServicoEnvioMensagem` e `ServicoHashSenha`) — a realização do hash estava só no PAC-001 e foi acrescentada ao CMP-001 nesta fase (correção #14). Todos **aprovados**.

---

## 7. Registro de revisão e achados

### 7.1 Correções aplicadas aos meus artefatos nesta Fase 8 (v1.1/v2.1)

| # | Arquivo | Correção |
|---|---|---|
| 1 | `impacto-requisitos.md` | RF-025/RN-005/RN-010 citavam TRS-03 ou TRS-06 para a reserva de slot — o correto é **TRS-01** (nomenclatura vigente de `modelo-relacional.md` §7) |
| 2 | `impacto-requisitos.md` | RF-033 dizia "exige `usuario.email`" — corretamente é `psicologo.email_contato`/`paciente.email_contato` (INC-16). §9 INC-16 corrigido na mesma direção |
| 3 | `impacto-requisitos.md` | resumo de impacto: **22 Alto / 13 Médio / 2 sem estrutura** (RF-002 e RF-033), não 24/12/1 |
| 4 | `impacto-requisitos.md` | RN-007 citava §4.3 do modelo; a FK composta do atendimento está em §4.13. RN-011 citava §4.4; a FK composta da agenda/disponibilidade está em §4.11 |
| 5 | `impacto-requisitos.md` | RN-019: FK composta agora escrita como `(id_agendamento, id_psicologo, id_paciente)`, como no DDL — antes citava só o par |
| 6 | `der/der-001-logico.md` | referências: normalização **§6** (antes §4); triggers no DDL **§17** (antes §8); alternativa da oferta em `modelo-relacional.md` **§5.3** (antes §4.6) |
| 7 | `der/der-001-logico.md` | RN-017 reescrita: o atendimento nasce de `agendamento.situacao = 'CONFIRMADO'` — a frase anterior ("só existe se situacao = REALIZADO") invertia a guarda |
| 8 | `modelo-relacional.md` | 2 referências "§8 do DDL" → **§17 do DDL** (§17 é a de garantias procedurais — triggers) |
| 9 | `modelo-relacional.md` | §4.6 e §4.8 agora declaram `ck_psicologo_nome` e `ck_paciente_nome`, que existiam no DDL sem declaração no modelo |
| 10 | `modelo-relacional.md` | §8 (índices) passou a listar os 6 índices que faltavam (`ix_pp_permissao`, `ix_pa_area`, `ix_usuario_perfil`, `ix_paciente_situacao`, `ix_agendamento_cancelamento`, `ix_se_paciente`) e a explicar os índices de FK composta |
| 11 | `dicionario-de-dados.md` | referência à normalização em §6 (antes §4); catálogo §4.2 ganhou `LOGIN_CONCEDIDO`, `LOGIN_NEGADO`, `PSICOLOGO_CRIADO` |
| 12 | `mapeamento-objeto-relacional.md` | `bloquearSlot` citava `(TRS-01/TRS-03)` — correto é ``(TRS-01 e TRS-04)`` (reserva do slot acontece em solicitar e no aceite da oferta) |
| 13 | PAC-001 e CMP-001 (`.mmd` + `.drawio.xml`) | par `ServicoAgenda` ↔ `ServicoListaEspera` explicitado: `AGENDA → FILA` (vaga liberada dispara `ofertarVaga`, UC-035) e `FILA → AGENDA` (aceite reaproveita `agendar`, UC-036). Antes o acoplamento só aparecia no texto do R7-11; o par fica **dentro** do pacote `aplicacao`, sem ciclo entre pacotes (CQ-FLE-03) |
| 14 | CMP-001 (`.mmd` + `.drawio.xml`) | acrescentado o componente `ServicoHash` e a realização `ServicoHash ..> ServicoHashSenha`. O PAC-001 já mostrava o pacote `seguranca` realizando a interface, mas o CMP-001 não tinha o componente — o teste A-3 ficava sem evidência no nível de componentes |

### 7.2 Pendências que permanecem (sem mudança de estado)

| ID | Pendência | Só se resolve com |
|---|---|---|
| P-20 | fila por horário sem slot cadastrado | decisão do grupo (fila por faixa de horário mudaria `solicitacao_espera`) |
| P-21 | atributos provisórios de `psicologo`/`paciente` | correção atributos por I3 (PC-03/04/05) e, se aplicar, requisito novo do I1 |
| INC-14/15/16/17 | leituras já materializadas no DER com decisões ou leituras alternativas registradas | homologação pelo grupo/I3 (não é mais incoerência do meu lado) |
| CQ-CON-04 | multiplicidades estão `PENDENTE` no CLS-001 (dono I3); 100% das FKs do DER derivam das multiplicidades aprovadas (DEC-019/021, Q5-… e mapa A01-A17) | I3 fechando Q5-01 |

### 7.3 Achados em artefatos de outros integrantes (registrados e endereçados; não corrigidos)

| ID | Artefato / responsável | O que foi encontrado | Correção proposta |
|---|---|---|---|
| **R8-01** | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §3 e resumo (I2) | cita `agendamento.status` (e IMP-DER-02); a coluna do DER, do dicionário e a convenção do CLS-001 são `situacao` no singular (`status` é anglicismo reservado de I2) | atualizar a expressão para `agendamento.situacao` na matriz e na matriz final da Fase 8 (I1/I2) |
| **R8-02** | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` §1 e FASE7-REV §2 mapa (I2) | coluna "Tabela prevista" nomeia `auditoria`, `fila`, `notificacao` em várias linhas; nomes oficiais: `registro_auditoria`, `solicitacao_espera`, *(sem tabela de notificação — DEC-022)* | ao produzir a matriz final (Fase 8, I1), usar os nomes do dicionário |
| **R8-03** | CLS-001 (I3) | sem atributos escalares em `Psicologo`/`Paciente` (PC-03/04/05) e com `Agendamento.confirmar()`/`pendências` (R6-09) | fechamento da P-21 pelo I3 (o meu lado está rastreado como provisório no dicionário §7 e MD-17) |
| **R8-04** | `05-qualidade/plano-qualidade-iso25010.md` §4 (I5) | CQ-COM-02 contava 0/4 ("Serviço Externo de E-mail em 4 artefatos") na medição pré-Fase 7; com CMP-001 (`AdaptadorEmail`), IMP-001 e UC-033, a parte do CMP/IMP/UC está conforme — recontagem agora é do I5 | reavaliar CQ-COM-02 com a evidência do §4 desta análise; permanece não conforme no CTX-001 (dono I1/I2) até atualização |

### 7.4 Evidências entregues para o plano de qualidade (Integrante 5)

| Critério | Evidência concreta (inspeção) | Situação |
|---|---|---|
| **CQ-SEG-01** | 0 colunas de senha além de `hash_senha` (censo §1: 97 colunas varridas); `usuario.hash_senha` é a única credencial persistida e `ck_usuario_hash` exige ≥ 20 caracteres | **Atende** |
| **CQ-SEG-02** | `pacientesVinculados` e `agendaDoPsicologo` (`mapeamento` §8) são as únicas vias de consulta profissional e ambos filtram `vinculo` `ATIVO` (DEP-04) | **Atende** |
| **CQ-SEG-03** | `IRepositorioPaciente.porUsuario` e `RF-022` no dicionário §6 — consulta por `id_usuario` do solicitante | **Atende** |
| **CQ-CON-04** | censo §1: 100% das 22 relações do DER têm FK e UK composta coerente (24 FK, 4 delas compostas) — falta oficializar multiplicidades do CLS-001 (pendência I3, §7.2) | **Parcial (meu lado ok)** |
| **CQ-CON-05** | `uk_agendamento_slot_ativo` + `bloquearSlot` (usado nas 2 transações de reserva, TRS-01/TRS-04) + revalidação dentro da transação | **Atende**; TDB-02 é o teste de execução |
| **CQ-COM-01** | o único ponto de e-mail é a interface `ServicoEnvioMensagem` realizada por `AdaptadorEmail`; 0 tabela de notificação | **Atende** |
| **CQ-COM-02** | o Serviço Externo de E-mail aparece em CMP-001 e IMP-001 (na fase 7); UC-033 e CT-033 cobrem casos de uso/teste; CTX-001 segue sendo cobertura do I1/I2 | **Parcial** (meus artefatos ok) |
| **CQ-FLE-03** | PAC-001 sem ciclo entre as 4 camadas (composition root monta as pontas); o par `ServicoAgenda` ↔ `ServicoListaEspera` (UC-035/UC-036) é interno ao pacote `aplicacao` e não cria ciclo entre pacotes | **Atende** |
| **CQ-MAN-01** | `ServicoAgenda` delega para 5 serviços; `Persistencia` não tem regra (DIP); auditoria grava por serviço (MD-15) — conferido contra R7-11 | **Atende** (a contagem de associações por classe fica com I3) |

---

## 8. Referências e rastreabilidade

| Conteúdo | Origem |
|---|---|
| Censo (§1) | `ddl/schema-mysql.sql` (15 CREATE TABLE, 24 REFERENCES, 26 CHECK, 17 UNIQUE, 17 `ix_`, 4 colunas geradas, 3 triggers, 3+29 carga) |
| Restrições por tabela | `modelo-relacional.md` §4 (v1.1) |
| Domínios, catálogo, carimbo, provisórios | `dicionario-de-dados.md` §2–§4, §7 (v1.1) |
| N:N, 3FN, desnormalizações | `normalizacao.md` §5–§7 (sem alteração estrutural na Fase 8) |
| Mapeamento | `mapeamento-objeto-relacional.md` (v1.1: MD-01…MD-18, 10 interfaces, 7 consultas) |
| Arquitetura e correções R7 | `01-planejamento/revisoes/FASE7-REV-I2-coerencia-arquitetura-casos-de-uso.md` (I2); PAC/CMP/IMP mmd em `03-uml/` |
| Comportamento e testes CT | `06-rastreabilidade/matriz-rastreabilidade-fase5/6.md`; `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md` |
| Critérios CQ | `05-qualidade/plano-qualidade-iso25010.md` (v0.6: CQ-SEG-01/02/03, CQ-CON-04/05, CQ-COM-01/02, CQ-FLE-03, CQ-MAN-01) |

**Registro de participação:** Integrante 4 (Caio Cunha) — censo completo do DDL, verificação de 14 testes conceituais de persistência (TDB), conferência arquitetura × casos de uso (12 achados R7 re-verificados), correção de 14 pontos nos artefatos próprios (v1.1/v2.1, incluindo o par AGENDA↔FILA e o componente `ServicoHash`), 4 achados cruzados registrados (R8-01…R8-04) e evidências CQ consolidadas para o Integrante 5.
