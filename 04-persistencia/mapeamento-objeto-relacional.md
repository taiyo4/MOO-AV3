# Mapeamento objeto-relacional

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Fase do plano:** Fase 7 — Persistência
**Versão:** v1.0 · **Data:** 29/10/2026
**Deriva de:** CLS-001 ([`03-uml/Classes/`](../03-uml/Classes/)) e DER-001 ([`der/der-001-logico.md`](der/der-001-logico.md))

---

## 1. Objetivo

Explicar **como cada elemento do modelo de classes vira (ou não vira) estrutura no banco**: classe → tabela, atributo → coluna, associação → chave estrangeira, associação N:N → tabela associativa, atributo derivado → projeção calculada.

É o documento que fecha a distância entre o modelo OO do Integrante 3 e o modelo relacional desta pasta. Onde a tradução **não** é direta, há uma decisão numerada (`MD-nn`) com justificativa e consequência.

---

## 2. Estratégia geral

| Elemento de origem | Estratégia | Fundamento |
|---|---|---|
| Classe concreta | uma tabela com o mesmo nome em `snake_case` | não há herança no CLS-001 |
| Herança / classe abstrata | **não se aplica** | o CLS-001 declara "não há herança, agregação ou composição" |
| Objeto de valor | colunas achatadas na tabela da entidade que o contém | `Periodo` de `Disponibilidade` |
| Associação 1:N | FK no lado "muitos" | A06, A07, A09, A11, A12, A13, A14 |
| Associação 1:1 | FK com `UNIQUE` no lado dependente | A08 |
| Associação 0..1:0..1 | FK `NULL` + `UNIQUE` no lado opcional | A03, A04, A15, A17, A21 |
| Associação N:N | tabela associativa com PK composta | A02, A05 |
| Atributo derivado | **não** vira coluna: é calculado na leitura | `horario`, `estaAutorizado`, `posicao` |
| Enumeração | `VARCHAR` + `CHECK`, exposta como `enum` na linguagem | `SituacaoAgendamento`, etc. |
| Coleção de objetos | carregada por consulta explícita do repositório | evita *lazy loading* fora do agregado |

**Sem ORM obrigatório.** O mapeamento está descrito de forma independente de ferramenta. As decisões valem para JDBC, JPA/Hibernate, Entity Framework, SQLAlchemy ou acesso manual — o que muda é a anotação, não a estrutura.

---

## 3. Classe → tabela

| Classe (CLS-001) | Tabela | Estratégia | Observação |
|---|---|---|---|
| `Usuario` | `usuario` | tabela direta | `credencialProtegida` → `hash_senha` (MD-14) |
| `Perfil` | `perfil` | tabela direta | — |
| `Permissao` | `permissao` | tabela direta | — |
| `Psicologo` | `psicologo` | tabela direta | `id_usuario` nulo (DEC-021) |
| `AreaAtuacao` | `area_atuacao` | tabela direta | — |
| `Paciente` | `paciente` | tabela direta | `id_usuario` nulo (DEC-021) |
| `Vinculo` | `vinculo` | tabela direta | `estaAutorizado` é derivado (MD-07) |
| `Agenda` | `agenda` | tabela direta | 1:1 com `psicologo` |
| `Disponibilidade` | `disponibilidade` | tabela direta + objeto de valor achatado | `periodo` → 3 colunas (MD-10) |
| `Agendamento` | `agendamento` | tabela direta | `horario` derivado do slot (MD-07) |
| `Atendimento` | `atendimento` | tabela direta | — |
| `RegistroAuditoria` | `registro_auditoria` | tabela direta | `data` + `hora` → `data_hora` (MD-09) |
| *(nova)* `SolicitacaoEspera` | `solicitacao_espera` | tabela direta | classe ainda não oficial (P8) |
| *(associação A02)* | `perfil_permissao` | associativa | — |
| *(associação A05)* | `psicologo_area_atuacao` | associativa | — |

**15 tabelas para 12 classes oficiais + 1 classe proposta + 2 associativas.** Nenhuma tabela sobra e nenhuma classe oficial fica sem tabela.

---

## 4. Atributo → coluna

### 4.1 `Usuario`

| Atributo | Coluna | Situação |
|---|---|---|
| `identificacao` | `identificacao` | direto |
| `credencialProtegida` | `hash_senha` | direto, com nome que declara a proteção |
| `situacaoConta` | `situacao_conta` | direto (DEC-013) |
| *(associação A01)* | `id_perfil` | FK |

### 4.2 `Agendamento` — o caso de `horario`

| Atributo | Coluna | Situação |
|---|---|---|
| `horario` | — | **derivado** de `disponibilidade (data, hora_inicio)` |
| `situacao` | `situacao` | direto |

**Por que `horario` não é coluna.** Com DEC-018, o horário é o **slot**: `disponibilidade.data` + `disponibilidade.hora_inicio`. Manter `agendamento.horario` criaria uma dependência transitiva (`id_disponibilidade → (data, hora_inicio)` e `agendamento.horario` copiando o mesmo valor) que poderia divergir após uma alteração de slot — e não há regra que autorize alterar slot já ocupado. A coluna seria uma **segunda fonte de verdade para o tempo**.

**Consequência no código.** `Agendamento.getHorario()` é um método que delega ao slot associado, e não um campo. Em JPA: `@Transient` + getter derivado; em acesso manual: a consulta projeta `CONCAT(d.data, ' ', d.hora_inicio)`.

### 4.3 `Disponibilidade` — o caso de `periodo`

| Atributo | Coluna | Situação |
|---|---|---|
| `periodo` | `data`, `hora_inicio`, `duracao_minutos` | objeto de valor achatado |

**Por que não há coluna `periodo`.** Um intervalo contínuo (`inicio`–`fim`) não é o que DEC-018 decidiu: o slot é discreto e tem duração fixa. Guardar `periodo` como texto obrigaria a aplicação a interpretar texto em toda consulta de RF-024 — e impediria o índice `(id_agenda, data, hora_inicio)`.

O objeto de valor `Periodo` continua existindo **em memória** (MD-11): a classe relacional é reconstruída a partir das três colunas.

### 4.4 `Vinculo` — o caso de `estaAutorizado`

| Atributo / operação | Coluna | Situação |
|---|---|---|
| `situacao` | `situacao` | direto (DEC-015) |
| `dataInicio` | `data_inicio` | direto |
| `dataFim` | `data_fim` | direto |
| `estaAutorizado()` | — | **derivado**: `situacao = 'ATIVO' AND data_inicio <= hoje AND (data_fim IS NULL OR data_fim >= hoje)` |

`estaAutorizado` é regra, não estado: materializá-la como coluna criaria um valor que envelhece sozinho (um vínculo "autorizado" ontem continua `1` hoje).

### 4.5 `RegistroAuditoria` — o caso de `Data` + `Hora`

| Atributo | Coluna | Situação |
|---|---|---|
| `Data data` | `data_hora` | **concatenado** |
| `Hora hora` | `data_hora` | **concatenado** |
| `operacao` | `operacao` | direto |
| *(DEC-024)* | `situacao_anterior`, `situacao_nova` | acrescentados |
| *(DEC-024)* | `entidade`, `id_entidade` | acrescentados |

**Por que concatenar.** RN-014 exige ordem cronológica e RNF-004 exige trilha rastreável. Com `DATE` e `TIME` separados, ordenar exige `ORDER BY data, hora` e comparar instantes exige montar o `DATETIME` na consulta. Um único `DATETIME` ordena, compara e indexa direto.

**Consequência no código.** A classe mantém `getData()` e `getHora()` como acessores derivados do `DATETIME`; a assinatura pública do CLS-001 é preservada.

### 4.6 Demais atributos

| Classe | Atributo | Coluna |
|---|---|---|
| `Perfil` | `nome` | `nome` |
| `Permissao` | *(sem atributo fixado)* | `codigo`, `descricao` |
| `Psicologo` | *(sem atributo fixado — P-21)* | `nome`, `registro_profissional`, `email_contato` |
| `AreaAtuacao` | *(sem atributo fixado)* | `nome`, `descricao` |
| `Paciente` | *(sem atributo fixado — P-21)* | `nome`, `email_contato`, `situacao_cadastral` |
| `Agenda` | *(sem atributo fixado)* | `id_psicologo` |
| `Atendimento` | `contextoSessao` | `contexto_sessao` |

---

## 5. Decisões de mapeamento (`MD-nn`)

| ID | Decisão | Justificativa | Consequência |
|---|---|---|---|
| **MD-01** | uma tabela por classe concreta | não há herança no CLS-001 | nenhuma tabela de tipo, nenhum discriminador |
| **MD-02** | PK surrogate `BIGINT` + chave natural `UNIQUE` quando existe | identificadores de negócio mudam; o surrogate não | `identificacao`, `nome` de perfil e `codigo` de permissão continuam únicos |
| **MD-03** | associação 1:N vira FK no lado N | modelo relacional padrão | A06, A07, A09, A11, A12, A13, A14 |
| **MD-04** | associação 0..1:0..1 vira FK `NULL` + `UNIQUE` no lado opcional | DEC-021 permite cadastro sem conta | `psicologo.id_usuario`, `paciente.id_usuario` |
| **MD-05** | associação 1:1 vira FK `UNIQUE` | A08 é titularidade única | `agenda.id_psicologo` |
| **MD-06** | N:N vira tabela associativa com PK composta | A02 e A05 são associativas puras | duas tabelas, sem coluna `id` própria |
| **MD-07** | atributo derivado **não** vira coluna | evitar segunda fonte de verdade | `horario`, `estaAutorizado`, `posicao` são calculados |
| **MD-08** | enumeração vira `VARCHAR` + `CHECK` e é exposta como `enum` | valor legível no banco; evolução sem `ALTER` destrutivo | mapeamento `enum` ↔ `String` na camada de persistência |
| **MD-09** | `Data` + `Hora` viram `data_hora DATETIME` | ordenação e comparação de instantes (RN-014) | acessores `getData()`/`getHora()` derivados |
| **MD-10** | `periodo` vira `data` + `hora_inicio` + `duracao_minutos` | DEC-018: slot discreto | objeto de valor reconstruído (MD-11) |
| **MD-11** | objeto de valor é reconstruído na leitura, não persistido como tipo próprio | não há tipo composto no MySQL | `Periodo` é `@Embeddable`/classe imutável de aplicação |
| **MD-12** | coleções são carregadas por consulta explícita do repositório | evita *lazy loading* fora do agregado e `N+1` | `consultarDisponibilidades(agenda)`, `consultarVinculos(psicologo)` |
| **MD-13** | identidade de entidade é o `id`; igualdade por `id` | duas instâncias com o mesmo `id` são a mesma linha | `equals`/`hashCode` sobre `id`, não sobre atributos |
| **MD-14** | `credencialProtegida` vira `hash_senha`, nunca texto | RN-002, RNF-001 | o objeto de domínio nunca expõe a senha; só o serviço de autenticação compara hash |
| **MD-15** | auditoria **não** é coleção de entidade | DEC-024: serviço de aplicação grava | nenhuma entidade tem `List<RegistroAuditoria>` |
| **MD-16** | `id_entidade` é polimórfico e sem FK | a trilha cobre entidades de catálogo que podem ser excluídas | integridade semântica, não declarada — decisão consciente |
| **MD-17** | campos descritivos provisórios ficam isolados em um objeto de cadastro | P-21: o CLS-001 não fixa os atributos de `Psicologo`/`Paciente` | troca localizada quando o Integrante 3 fechar o modelo |
| **MD-18** | a oferta de vaga é a situação `OFERTADA` de `SolicitacaoEspera`, não uma entidade | INC-17: SEQ-004 modela `abrirOferta` na própria solicitação | sem tabela `oferta_vaga`; alternativa em `modelo-relacional.md` §5.3 |

---

## 6. Persistência das associações

### 6.1 Como cada associação A01–A16 é materializada

| Associação | Materialização | Navegabilidade no código |
|---|---|---|
| A01 `Usuario` — `Perfil` | `usuario.id_perfil` | `usuario.getPerfil()` (carregado por `IRepositorioPerfil`) |
| A02 `Perfil` — `Permissao` | `perfil_permissao` | `perfil.getPermissoes()` via consulta |
| A03 `Usuario` — `Psicologo` | `psicologo.id_usuario` | `psicologo.getUsuario()` pode ser nulo |
| A04 `Usuario` — `Paciente` | `paciente.id_usuario` | idem |
| A05 `Psicologo` — `AreaAtuacao` | `psicologo_area_atuacao` | `psicologo.getAreas()` via consulta |
| A06 `Psicologo` — `Vinculo` | `vinculo.id_psicologo` | `psicologo.getVinculos()` via consulta |
| A07 `Paciente` — `Vinculo` | `vinculo.id_paciente` | `paciente.getVinculos()` via consulta |
| A08 `Psicologo` — `Agenda` | `agenda.id_psicologo` | `psicologo.getAgenda()` |
| A09 `Agenda` — `Disponibilidade` | `disponibilidade.id_agenda` | `agenda.getDisponibilidades()` via consulta por período |
| A10 `Agenda` — `Agendamento` | **derivada** (A09 + A17) | `agenda.getAgendamentos()` = junção por slot |
| A11 `Psicologo` — `Agendamento` | `agendamento.id_psicologo` | `agendamento.getPsicologo()` |
| A12 `Paciente` — `Agendamento` | `agendamento.id_paciente` | `agendamento.getPaciente()` |
| A13 `Psicologo` — `Atendimento` | `atendimento.id_psicologo` | `atendimento.getPsicologo()` |
| A14 `Paciente` — `Atendimento` | `atendimento.id_paciente` | `atendimento.getPaciente()` |
| A15 `Agendamento` — `Atendimento` | `atendimento.id_agendamento` | `agendamento.getAtendimento()` pode ser nulo |
| A16 `Usuario` — `RegistroAuditoria` | `registro_auditoria.id_usuario` | **não navegável** a partir do usuário (MD-15) |

### 6.2 Associações propostas para a lista de espera

| Associação | Materialização |
|---|---|
| A18 `Psicologo` — `SolicitacaoEspera` | `solicitacao_espera.id_psicologo` |
| A19 `Paciente` — `SolicitacaoEspera` | `solicitacao_espera.id_paciente` |
| A20 `Disponibilidade` — `SolicitacaoEspera` | `solicitacao_espera.id_disponibilidade` |
| A21 `SolicitacaoEspera` — `Agendamento` | `solicitacao_espera.id_agendamento` (nulo até o aceite) |

### 6.3 Fronteiras de agregado

O mapeamento define o que é carregado junto e o que exige consulta própria:

| Agregado (raiz) | Contém | Fora do agregado |
|---|---|---|
| `Usuario` | `Perfil` (referência) | `Psicologo`, `Paciente`, auditoria |
| `Psicologo` | `Agenda` | `Disponibilidade`, `Vinculo`, `Agendamento` |
| `Agenda` | `Disponibilidade` (do período consultado) | `Agendamento` |
| `Agendamento` | `Disponibilidade` (referência) | `Atendimento` |
| `Paciente` | — | `Vinculo`, `Agendamento`, `Atendimento` |
| `SolicitacaoEspera` | `Disponibilidade` (referência) | `Agendamento` |

**Regra:** uma transação toca **um** agregado por vez, exceto nas operações TRS-01 a TRS-06, que precisam de duas tabelas e são coordenadas pela unidade de trabalho da aplicação ([`modelo-relacional.md`](modelo-relacional.md) §7).

---

## 7. Interfaces de repositório

Cada agregado tem um repositório com interface no domínio e implementação na infraestrutura (RNF-008, DIP). A interface aparece no diagrama de componentes (`03-uml/Componentes/diagrama-componentes.mmd`).

| Interface | Operações principais | Atende |
|---|---|---|
| `IRepositorioUsuario` | `porIdentificacao`, `porId`, `salvar`, `alterarSituacao` | RF-001 a RF-006 |
| `IRepositorioPerfil` | `porId`, `listar`, `salvar`, `adicionarPermissao`, `removerPermissao` | RF-007, RF-008 |
| `IRepositorioPsicologo` | `porId`, `porUsuario`, `listar`, `salvar`, `associarArea` | RF-011, RF-014, RF-016 |
| `IRepositorioPaciente` | `porId`, `porUsuario`, `listar`, `salvar`, `alterarSituacao` | RF-012, RF-018 a RF-020, RF-022 |
| `IRepositorioVinculo` | `vigenteEntre`, `porPsicologo`, `porPaciente`, `salvar`, `encerrar` | RF-017, RF-021 |
| `IRepositorioAgenda` | `porPsicologo`, `salvarDisponibilidade`, `slotsLivres`, `bloquearSlot` | RF-023, RF-024, RF-029 |
| `IRepositorioAgendamento` | `porId`, `porPaciente`, `porPsicologo`, `salvar`, `alterarSituacao` | RF-025 a RF-029, RF-037 |
| `IRepositorioAtendimento` | `porAgendamento`, `porPar`, `salvar` | RF-030, RF-031 |
| `IRepositorioSolicitacaoEspera` | `proximoDaFila`, `porPaciente`, `salvar`, `alterarSituacao` | RF-034 a RF-036 |
| `IRepositorioAuditoria` | `registrar`, `consultar` | RF-013, RF-032 |

**`bloquearSlot`** é a operação que executa `SELECT … FOR UPDATE` (TRS-01/TRS-03). Ela existe no repositório de agenda porque é ali que a serialização do slot acontece — não no serviço.

---

## 8. Consultas nomeadas

Consultas que precisam de SQL específico (não derivável do mapeamento):

| Nome | SQL essencial | RF |
|---|---|---|
| `slotsLivres` | `disponibilidade d` **onde não existe** `agendamento` `CONFIRMADO` no slot **e não existe** `solicitacao_espera` `OFERTADA` | RF-024 |
| `proximoDaFila` | `solicitacao_espera` com `fila_ativa = 1` **ordenado por** `data_hora_entrada, id` **limite 1** | RF-035 |
| `posicaoNaFila` | `COUNT(*)` de entradas ativas do mesmo slot com `data_hora_entrada` menor + 1 | RF-034 |
| `pacientesVinculados` | `vinculo` `ATIVO` do psicólogo, com `data_fim` nula ou futura | RF-017 |
| `historicoPermitido` | `atendimento` do par psicólogo–paciente, ordenado por `data_hora_registro` | RF-031 |
| `agendaDoPsicologo` | `agendamento` do psicólogo no período, com `LEFT JOIN vinculo` para marcar "sem vínculo ativo" | RF-029 |
| `trilhaAuditoria` | `registro_auditoria` filtrado por período, usuário e operação | RF-013 |

**`agendaDoPsicologo` e a marcação de DEC-015.** "Paciente sem vínculo ativo" **não** é coluna: é o resultado do `LEFT JOIN` com `vinculo` vigente. Materializar essa marca seria uma coluna que envelhece sozinha, exatamente como `estaAutorizado`.

---

## 9. Como as divergências do CLS-001 foram resolvidas

| ID | Divergência | Resolução no mapeamento |
|---|---|---|
| INC-14 | cardinalidade `Usuario`–`Perfil` na DEC-019 | MD-02 + `usuario.id_perfil NOT NULL` sem `UNIQUE` |
| INC-15 | `Agendamento.horario` × slot discreto | MD-07 (derivado) + MD-10 |
| INC-16 | ausência de e-mail de contato | coluna em `psicologo` e `paciente`; **não** em `usuario` |
| INC-17 | `OfertaVaga` × situação `OFERTADA` | MD-18 (situação) com alternativa documentada em `modelo-relacional.md` §5.3 |
| — | `RegistroAuditoria.Data` + `Hora` | MD-09 |
| — | `Disponibilidade.periodo` | MD-10 + MD-11 |

---

## 10. O que **não** é mapeado

| Elemento | Motivo |
|---|---|
| Sessão autenticada | DEC-020: estado volátil, não entidade |
| `ServicoEnvioMensagem` | DEC-022: interface de fronteira, sem estado |
| `ServicoAuditoria`, `ServicoAutorizacao`, `ServicoTempo`, `UnidadeTrabalho` | serviços de aplicação, sem estado próprio |
| `Notificacao` | DEC-022: não existe classe nem tabela |
| `HistoricoSituacao` | DEC-024: a trilha está em `registro_auditoria` |
| Prontuário / evolução clínica | DEC-008: fora do escopo |

---

## 11. Pendências

| ID | Pendência | Efeito no mapeamento |
|---|---|---|
| P-21 | atributos descritivos e e-mail de contato | MD-17: os campos provisórios ficam isolados em um objeto de cadastro, para troca localizada |
| P-20 | fila por horário sem slot | `SolicitacaoEspera` ganharia um objeto de valor de preferência temporal |
| INC-17 | `OfertaVaga` como classe | `SolicitacaoEspera` perderia `prazo_aceite`/`oferta_aberta` para uma nova entidade |
| — | ferramenta ORM | o mapeamento é independente; a escolha é da implementação |
