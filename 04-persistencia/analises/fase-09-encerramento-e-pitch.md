# Fase 9 — Encerramento da persistência e da arquitetura e apoio ao pitch (Integrante 4)

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Data:** 31/10/2026 (atualizado em 10/11/2026) · **Versão:** v1.1
**Tarefas do plano atendidas** (Fase 9, bloco "2 a 4" — `01-planejamento/etapas-e-responsabilidades.md` §3):

1. corrigir os últimos achados dos meus artefatos;
2. participar do pitch com a parte técnica de arquitetura e persistência;
3. (herdado da Fase 8, bloco do I4) entregar a **versão final das seções 25 e 26** do dossiê, conferir **dicionário, mapeamento e DDL** e fechar as **versões finais** de pacotes, componentes, implantação, DER e modelo relacional.

**Natureza:** consolidação. Não há modelagem nova nesta fase: o esquema está congelado desde a Fase 7 e foi apenas verificado na Fase 8 (`fase-08-verificacao-qualidade-persistencia.md`). O que este documento entrega é (a) o quadro de versões finais, (b) a conferência final dos três artefatos que descrevem o banco, (c) o texto-base das seções 25 e 26 e (d) os pontos técnicos do pitch, com o que pode e o que **não** pode ser dito.

---

## 0. Escopo e método

| Item | Conteúdo |
|---|---|
| **Artefatos encerrados (meus)** | `der/der-001-logico.md` + `der-001.mmd`/`.drawio.xml` · `modelo-relacional.md` · `dicionario-de-dados.md` · `mapeamento-objeto-relacional.md` · `normalizacao.md` · `ddl/schema-mysql.sql` · PAC-001, CMP-001 e IMP-001 (`03-uml/`) · `impacto-requisitos.md` |
| **Insumos de encerramento** | `fase-08-verificacao-qualidade-persistencia.md` (censo, TDB, R8-01…R8-04); `07-dossie/secoes/fases7-9-secao-25-36.md` §25/§26 (estrutura prometida); `08-pitch/banco-de-pontos-pitch.md` §3 ("Arquitetura e persistência (Fase 7)"); `05-qualidade/plano-qualidade-iso25010.md`; `01-planejamento/decisoes.md` |
| **Método** | conferência de versão/arquivo; recontagem do censo do DDL contra dicionário e mapeamento; redação das seções 25 e 26 na estrutura prometida; conversão das evidências da Fase 8 em falas de pitch |
| **Regra respeitada** | artefato de outro integrante não é alterado. As pendências que dependem deles continuam registradas (§6) |

---

## 1. Versões finais dos artefatos

| Artefato | Arquivo | Versão final | O que mudou na Fase 8 | Situação |
|---|---|---|---|---|
| DER-001 (lógico) | [`der/der-001-logico.md`](../der/der-001-logico.md) + [`der-001.mmd`](../der/der-001.mmd) + [`der-001.drawio.xml`](../der/der-001.drawio.xml) | **v1.1** (30/10/2026) | normalização → §6; triggers → §17 do DDL; guarda RN-017 corrigida; alternativa da oferta → §5.3 | **Congelado** |
| Modelo relacional | [`modelo-relacional.md`](../modelo-relacional.md) | **v1.1** (30/10/2026) | 2 referências ao §17 do DDL; `ck_psicologo_nome`/`ck_paciente_nome` declarados; §8 com os 6 índices que faltavam | **Congelado** |
| Dicionário de dados | [`dicionario-de-dados.md`](../dicionario-de-dados.md) | **v1.1** (30/10/2026) | referência à normalização em §6; catálogo com `LOGIN_CONCEDIDO`, `LOGIN_NEGADO`, `PSICOLOGO_CRIADO` | **Congelado** |
| Mapeamento objeto-relacional | [`mapeamento-objeto-relacional.md`](../mapeamento-objeto-relacional.md) | **v1.1** (30/10/2026) | `bloquearSlot` → `(TRS-01 e TRS-04)` | **Congelado** |
| Normalização | [`normalizacao.md`](../normalizacao.md) | **v1.0** (29/10/2026) | — (nenhuma alteração estrutural na Fase 8) | **Congelado** |
| DDL MySQL 8.0 | [`ddl/schema-mysql.sql`](../ddl/schema-mysql.sql) | **1.0** (29/10/2026) | — (o censo da Fase 8 confirma o arquivo; nenhuma linha alterada) | **Congelado e testado** no MySQL 8.0.44 (10/11/2026, [`teste-ddl.md`](teste-ddl.md)) |
| Impacto nos requisitos | [`impacto-requisitos.md`](../impacto-requisitos.md) | **v2.1** (30/10/2026) | TRS-01 em RF-025/RN-005/RN-010; e-mail em `email_contato` (INC-16); resumo 22/13/2; §4.13/§4.11; RN-019 com FK composta | **Congelado** |
| PAC-001 (pacotes) | [`../../03-uml/Pacotes/diagrama-pacotes.mmd`](../../03-uml/Pacotes/diagrama-pacotes.mmd) + `.drawio.xml` | **v1.2** (10/11/2026) | par `AGENDA ↔ FILA` (UC-035/UC-036) dentro do pacote `aplicacao` + nota de exceção ao CQ-FLE-03 (Q8-07) | **Congelado** |
| CMP-001 (componentes) | [`../../03-uml/Componentes/diagrama-componentes.mmd`](../../03-uml/Componentes/diagrama-componentes.mmd) + `.drawio.xml` | **v1.1** (31/10/2026) | componente `ServicoHash` + realização de `ServicoHashSenha`; par `AGENDA ↔ FILA` | **Congelado** |
| IMP-001 (implantação) | [`../../03-uml/Implantacao/diagrama-implantacao.mmd`](../../03-uml/Implantacao/diagrama-implantacao.mmd) + `.drawio.xml` | **1.0** (29/10/2026) | — (nenhuma alteração na Fase 8) | **Congelado** |

**Por que não há v2.0:** nenhuma decisão de modelagem mudou desde a Fase 7. As versões 1.1 (e a 1.2 do PAC-001, que apenas declara a exceção do ciclo `AGENDA ↔ FILA`) são **correções de coerência** (referência cruzada, declaração de restrição que já existia no DDL, par de chamada e componente que faltavam no desenho), não redesenho. O esquema de 15 tabelas é o mesmo da entrega da Fase 7 — o censo da Fase 8 não encontrou restrição ausente, órfã ou divergente.

**Numeração das versões dos diagramas:** PAC-001 e CMP-001 trazem a versão no cabeçalho do `.mmd` (fonte da verdade). O `.drawio.xml` correspondente é o mesmo desenho e não repete a versão; o inventário de `03-uml/README.md` continua sendo o índice oficial.

---

## 2. Conferência final: dicionário × mapeamento × DDL

Recontagem feita diretamente no `ddl/schema-mysql.sql` e conferida contra os dois documentos que descrevem o banco. É a mesma do censo da Fase 8 (§1), agora fechada como **estado final**.

| Grandeza | DDL | Dicionário | Mapeamento | Veredito |
|---|---|---|---|---|
| Tabelas | **15** | 15 (`§3.1`–`§3.15`) | 15 (12 classes oficiais + `solicitacao_espera` proposta + 2 associativas) | ✔ |
| Colunas | **97** | **97** (uma linha por coluna) | cobre os 5 casos não triviais e remete o resto ao dicionário | ✔ |
| PK | **15** | 15 | 12 entidades + 2 associativas + 1 proposta | ✔ |
| UNIQUE | **17** | — | 4 chaves candidatas de FK composta + 4 únicas de coluna gerada + demais | ✔ |
| FK (`REFERENCES`) | **24** | — | 4 compostas (`disponibilidade`, `agendamento`, `atendimento`, `solicitacao_espera`) | ✔ |
| CHECK nomeados | **26** | 26 na coluna "Regra / domínio" | — | ✔ |
| Índices `ix_` | **17** | — | 12 de consulta + 5 de FK/painel (modelo §8) | ✔ |
| Colunas geradas | **4** | 4 | 4 (`vigente`, `slot_ativo`, `fila_ativa`, `oferta_aberta`) | ✔ |
| Triggers | **3** | — | 3 (DDL §17) | ✔ |
| Carga inicial | 3 perfis + 29 permissões | catálogo §4.2 coerente | — | ✔ |

**Conferência de nomes.** A coluna de situação é `situacao` (nunca `status`); a tabela de auditoria é `registro_auditoria` (nunca `auditoria`); a fila é `solicitacao_espera` (nunca `fila`); **não existe** tabela de notificação, sessão ou *outbox* (DEC-020/DEC-022). Essas quatro expressões aparecem erradas em matrizes de outro integrante e estão registradas como R8-01/R8-02 — não foram corrigidas por mim.

**Conferência de integridade.** 24 FKs, todas `ON DELETE RESTRICT ON UPDATE RESTRICT`; exclusão física só nas duas associativas puras (`perfil_permissao`, `psicologo_area_atuacao`); nas demais, inativação por `situacao` (RNF-009/RNF-013). A trilha é *append-only* por trigger e por privilégio (RN-014/RNF-017).

**Enumerações (Q7-05).** Os cinco conjuntos de valores oficiais do CLS-001 foram conferidos em 10/11/2026 nos quatro arquivos (`dicionario-de-dados.md`, `modelo-relacional.md`, `ddl/schema-mysql.sql` e `der-001-logico.md`): `SituacaoConta` (ATIVO, BLOQUEADO, INATIVO), `Paciente.situacaoCadastral` (ATIVO, SUSPENSO, INATIVO), `Vinculo.situacao` (ATIVO, ENCERRADO), `SolicitacaoEspera.situacao` (AGUARDANDO, OFERTADA, ACEITA, RECUSADA, EXPIRADA, DESISTIU) e `Agendamento.situacao` (CONFIRMADO, CANCELADO, REALIZADO, NAO_COMPARECEU). **Não houve divergência**; nenhuma correção foi necessária.

**Execução do DDL (Q7-02).** Em 10/11/2026 o `schema-mysql.sql` foi executado em um **MySQL 8.0.44** limpo (ZIP portátil, porta 3307, sem instalação) e terminou com **código 0 e nenhum erro**. O censo do esquema criado bate com esta tabela: 15 tabelas, 97 colunas, 15 PK, 17 UNIQUE, 24 FK, 26 CHECK, 4 colunas geradas `STORED`, 3 triggers, 17 índices `ix_` e carga de 3 perfis + 29 permissões. A amostra dos TDB-01, TDB-07 e TDB-08 confirmou as recusas esperadas. Comando, saída real e ambiente estão em [`teste-ddl.md`](teste-ddl.md); nenhuma correção no `.sql` foi necessária.

---

## 3. Texto-base das seções 25 e 26 do dossiê

Estrutura prometida em `07-dossie/secoes/fases7-9-secao-25-36.md`: identificação e objetivo, elementos principais, como interpretar, decisões, relação com requisitos/classes/banco e arquivos. O texto abaixo pode ser usado quase literalmente pelo Integrante 6.

### 25. Arquitetura: pacotes, componentes e implantação

**Identificação e objetivo.** A arquitetura da Plataforma para Psicólogos é descrita por três diagramas UML complementares: **PAC-001** (pacotes e dependências), **CMP-001** (componentes, interfaces e realizações) e **IMP-001** (implantação física). O objetivo é mostrar como o sistema atende RF-001 a RF-037 mantendo três propriedades: separação de responsabilidades, inversão de dependência na fronteira com a infraestrutura e um caminho único de saída de e-mail. A descrição segue a ISO/IEC/IEEE 42010:2022 (decisões, preocupações e visões), com as decisões registradas em DEC-020, DEC-022, DEC-027 e DEC-029.

**Elementos principais.**

- **PAC-001 — cinco pacotes.** `apresentacao` (`web`, `view`), `aplicacao` (sete serviços + `UnidadeTrabalho`), `dominio` (`entidades`, `objetos de valor`, `repositorios` como interfaces e `fronteira` com `ServicoEnvioMensagem`/`ServicoHashSenha`), `infraestrutura` (`persistencia`, `mensageria`, `seguranca`) e `configuracao` (*composition root*). A regra de dependência é `apresentacao → aplicacao → dominio ← infraestrutura`: a aplicação **não** conhece a infraestrutura; quem liga as duas pontas é `configuracao`, em tempo de execução.
- **CMP-001 — onze componentes e três interfaces.** `InterfaceUsuario`; `ServicoAutenticacao`, `ServicoCadastro`, `ServicoAgenda`, `ServicoListaEspera`, `ServicoAuditoria`, `ServicoAutorizacao`, `ServicoTempo`; `Persistencia`, `AdaptadorEmail` e `ServicoHash`; interfaces `ServicoEnvioMensagem`, `ServicoHashSenha` e `IRepositorio*` (dez). `BancoDados` (MySQL 8.0) e `ServicoExternoEmail` (SMTP) são sistemas externos.
- **IMP-001 — quatro nós.** Dispositivo do usuário (navegador) → ServidorAplicacao (aplicação Java + `configuracao` + `AdaptadorEmail`) → ServidorBanco (MySQL 8.0/InnoDB/`utf8mb4`, com `schema-mysql.sql` instalado); o ServidorAplicacao fala com o ServicoExternoEmail por SMTP. Protocolos: HTTPS/443, JDBC/3306 e SMTP/587 com STARTTLS.

**Como interpretar.**

- seta cheia `-->` = dependência de compilação/uso; seta tracejada `..>` = realização de interface (o componente implementa o contrato); seta tracejada com ponta aberta `-.->` = dependência de injeção montada em tempo de execução;
- o *lollipop* `([...])` é uma interface fornecida: quem aponta para ela depende do contrato, não da implementação — é o que permite trocar `AdaptadorEmail` ou o SGBD sem tocar em `ServicoAgenda`;
- o par `ServicoAgenda ↔ ServicoListaEspera` é **bidirecional de propósito**: o cancelamento dispara a oferta ao próximo da fila (UC-035) e o aceite da oferta reaproveita `agendar` (UC-036). As duas chamadas ficam **dentro** do pacote `aplicacao`; o par é um ciclo **intencional**, declarado como exceção ao CQ-FLE-03 na nota do PAC-001 (Q8-07), e **não existe ciclo entre pacotes**;
- no CMP-001, `Persistencia` realiza os dez `IRepositorio*`, `AdaptadorEmail` realiza `ServicoEnvioMensagem` e `ServicoHash` realiza `ServicoHashSenha`; nenhum componente de infraestrutura é chamado diretamente pela apresentação.

**Decisões que o desenho materializa.**

| Decisão | Efeito no desenho |
|---|---|
| DEC-022 — e-mail é fronteira de aplicação | uma interface (`ServicoEnvioMensagem`) e um adaptador; nenhuma tabela `notificacao` |
| DEC-029 — falha de envio não desfaz a operação | o adaptador devolve `SUCESSO`/`FALHA`; a falha vira `FALHA_ENVIO_EMAIL` em transação própria (TRS-07), depois do `COMMIT` |
| DEC-020 — sessão volátil | nenhum servidor de estado; qualquer instância atende qualquer requisição |
| DEC-003 — MySQL 8.0 | um único SGBD no ServidorBanco, sem cache ou fila externa (RNF-016) |
| DEC-027 — parâmetros da fila | `configuracao` lê os parâmetros; `ServicoListaEspera` não tem prazo fixo no código |
| AP-05 / RF-009 — painel | **não** vira componente: é leitura agregada pelos repositórios dos agregados, sem hub de consulta |

**Relação com requisitos, classes e banco.** Cada componente cobre um bloco de RF: `ServicoAutenticacao` (RF-001/RF-002), `ServicoCadastro` (RF-003 a RF-022), `ServicoAgenda` (RF-023 a RF-029 e RF-037), `ServicoListaEspera` (RF-034 a RF-036), `ServicoAuditoria` (RF-013/RF-032) e `ServicoAutorizacao` (RNF-002/RNF-006). As 12 classes oficiais do CLS-001 vivem em `dominio.entidades`; as dez interfaces de repositório correspondem aos dez agregados persistidos. As fronteiras transacionais TRS-01 a TRS-07 (`modelo-relacional.md` §7) são coordenadas por `UnidadeTrabalho` na aplicação; `Persistencia` apenas executa. O único sistema externo além do banco é o provedor SMTP.

**Arquivos.** `03-uml/Pacotes/diagrama-pacotes.mmd` (fonte) e `.drawio.xml` (editável); `03-uml/Componentes/diagrama-componentes.mmd` e `.drawio.xml`; `03-uml/Implantacao/diagrama-implantacao.mmd` e `.drawio.xml`.

### 26. Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional

**Identificação e objetivo.** A persistência é descrita por cinco artefatos que se conferem entre si: **DER-001** (modelo lógico), **modelo relacional** (esquema e restrições por tabela), **dicionário de dados** (uma linha por coluna), **mapeamento objeto-relacional** (classe → tabela, atributo → coluna, decisões MD-01 a MD-18) e **DDL MySQL 8.0** (o esquema executável). O objetivo é mostrar como o domínio aprovado vira um banco com integridade **declarativa** — PK, FK, UNIQUE, CHECK e colunas geradas — sem depender de código de aplicação para garantir RN-005, RN-011, RN-016, RN-017, RN-018 e RN-019.

**Elementos principais.**

- **15 tabelas**: `perfil`, `permissao`, `perfil_permissao`, `usuario`, `area_atuacao`, `psicologo`, `psicologo_area_atuacao`, `paciente`, `vinculo`, `agenda`, `disponibilidade`, `agendamento`, `atendimento`, `solicitacao_espera`, `registro_auditoria`;
- **97 colunas**, **15 PK**, **17 UNIQUE**, **24 FK** (4 delas compostas), **26 CHECK** nomeados, **17 índices `ix_`**, **4 colunas geradas `STORED`** e **3 triggers**;
- **22 relações** no DER: A01–A17 oficiais e A18–A21 propostas (todas da `solicitacao_espera`, cuja classe ainda não foi oficializada — P8);
- carga inicial de **3 perfis** e **29 permissões** (`perfil_permissao` não é carregada — RF-007/RF-008);
- duas associativas puras (`perfil_permissao`, `psicologo_area_atuacao`), com PK composta e sem `id` próprio.

**Como interpretar.**

- toda tabela tem `id BIGINT AUTO_INCREMENT` como PK, exceto as duas associativas puras (PK composta) — e `agenda` é 1:1 com `psicologo`;
- a unicidade condicional do MySQL 8.0 é feita por **coluna gerada `TINYINT` (`1`/`NULL`) + `UNIQUE`**: `vigente`, `slot_ativo`, `fila_ativa` e `oferta_aberta` só assumem `1` quando a condição vale. É assim que o banco garante "um vínculo ativo por par", "um agendamento ativo por slot", "uma entrada ativa por par+slot" e "uma oferta aberta por slot";
- as **FK compostas** impedem divergência entre tabelas que repetem a mesma chave: `disponibilidade → agenda (id, id_psicologo)`, `agendamento → disponibilidade (id, id_psicologo)`, `atendimento → agendamento (id, id_psicologo, id_paciente)` e `solicitacao_espera → disponibilidade`;
- **nenhuma FK é `CASCADE`**: todas são `RESTRICT`; a saída de escopo é inativação (`usuario.situacao_conta`, `paciente.situacao_cadastral`, `vinculo.situacao`, `agendamento.situacao`), e a exclusão física só existe nas duas associativas puras;
- `registro_auditoria` é *append-only*: 2 triggers recusam `UPDATE`/`DELETE` e o §19 do DDL retira esses privilégios da conta de aplicação; o terceiro trigger (`trg_se_entrada_imutavel`) protege a ordem da fila;
- **não existem** tabelas de sessão, notificação, *outbox* ou histórico de situação: a sessão é volátil (DEC-020), o e-mail é fronteira de aplicação (DEC-022) e o histórico é o par `situacao_anterior`/`situacao_nova` (DEC-024).

**Decisões que o esquema materializa.**

| Decisão | Efeito no esquema |
|---|---|
| DEC-016/DEC-017 | `agendamento.situacao` só aceita `CONFIRMADO`, `CANCELADO`, `REALIZADO`, `NAO_COMPARECEU`; nasce `CONFIRMADO` (sem `SOLICITADO`, sem `data_confirmacao`) |
| DEC-018 | o slot é discreto em `disponibilidade`; `agendamento.horario` é projeção derivada, não coluna (INC-15/MD-07) |
| DEC-019/DEC-021 | `usuario.id_perfil` obrigatório; `psicologo.id_usuario`/`paciente.id_usuario` anuláveis e únicos; e-mail de contato na própria pessoa |
| DEC-024 | histórico por colunas em `registro_auditoria`, sem tabela de histórico |
| DEC-027 | `solicitacao_espera` com seis situações (`AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU`) e `prazo_aceite` |
| DEC-029 | falha de e-mail não desfaz a operação; vira linha de auditoria `FALHA_ENVIO_EMAIL` em transação própria |
| DEC-022 | nenhuma tabela de notificação |
| Carimbo único | `atendimento.data_hora_registro`, `solicitacao_espera.data_hora_entrada` e `registro_auditoria.data_hora` substituem `criado_em` |

**Relação com requisitos, classes e banco.** O dicionário §6 tem o mapa **RF → coluna** completo (RF-001 a RF-037); o mapeamento cobre **12/12 classes oficiais** do CLS-001, mais a proposta `SolicitacaoEspera` (P8), com **10 interfaces de repositório** e **7 consultas nomeadas** (`slotsLivres`, `proximoDaFila`, `posicaoNaFila`, `pacientesVinculados`, `historicoPermitido`, `agendaDoPsicologo`, `trilhaAuditoria`). As fronteiras transacionais TRS-01 a TRS-07 estão no modelo §7; TRS-07 fica **fora** da transação de negócio, de propósito. Os critérios de qualidade cobertos por este conjunto são CQ-SEG-01/02/03, CQ-CON-04/05, CQ-COM-01/02, CQ-FLE-03 e CQ-MAN-01 (evidências na análise da Fase 8 §7.4).

**Arquivos.** `04-persistencia/der/der-001-logico.md` + `der-001.mmd`/`.drawio.xml`; `04-persistencia/modelo-relacional.md`; `04-persistencia/dicionario-de-dados.md`; `04-persistencia/mapeamento-objeto-relacional.md`; `04-persistencia/normalizacao.md`; `04-persistencia/ddl/schema-mysql.sql`.

---

## 4. Pontos técnicos para o pitch

Resposta ao item pendente **"Arquitetura e persistência (Fase 7)"** de `08-pitch/banco-de-pontos-pitch.md` §3. A parte "Modelagem" do roteiro (§2, item 4) mostra UC-001 → CLS-001 → SEQ-002 → EST-001 → **PAC/CMP/DER**. Sugestão de 2 minutos, com quatro falas e uma tela cada.

### 4.1 Falas prontas (ordem sugerida)

| # | Fala | Tela | Prova no artefato |
|---|---|---|---|
| 1 | "A arquitetura é em camadas com **inversão de dependência**: a aplicação depende de interfaces do domínio, não do banco. Quem liga as pontas é o pacote `configuracao`." | PAC-001 | `apresentacao → aplicacao → dominio ← infraestrutura`; `BOOT -.->` nas três camadas |
| 2 | "E-mail é **uma interface, um adaptador e nenhuma tabela**. Se o provedor cair, o agendamento continua: a falha vira uma linha de auditoria depois do `COMMIT`." | CMP-001 | `ServicoEnvioMensagem` + `AdaptadorEmail`; `AGD -.-> AUD` com `FALHA_ENVIO_EMAIL`; TRS-07 |
| 3 | "A **lista de espera** conversa com a agenda nos dois sentidos — cancelou, oferta ao próximo; aceitou, reagenda. O par é um ciclo **intencional dentro do pacote `aplicacao`**, declarado como exceção ao CQ-FLE-03 no PAC-001; não há ciclo entre pacotes." | PAC-001 + CMP-001 | par `ServicoAgenda ↔ ServicoListaEspera` (UC-035/UC-036); nota `NOTA_CICLO` no PAC-001 (Q8-07) |
| 4 | "O banco **não confia no código**: 24 FKs, 4 compostas, 26 CHECK e colunas geradas garantem slot único, vínculo único e fila única; a auditoria é imutável por trigger." | DER-001 + trecho do DDL | `uk_agendamento_slot_ativo`, `uk_vinculo_vigente`, `uk_se_fila`, `uk_se_oferta`; DDL §17 |

Fechamento (15 s): "São 15 tabelas, 97 colunas, 10 repositórios e 7 transações — o suficiente para implementar sem reabrir a modelagem."

### 4.2 O que **não** dizer (regra de coerência do pitch)

| Não dizer | Por quê | O que dizer no lugar |
|---|---|---|
| "o PDF é a fonte da verdade do diagrama" | o PDF é cópia de leitura; a fonte é o `.mmd` e o editável é o `.drawio.xml` | "PAC-001, CMP-001, IMP-001 e DER-001 têm `.mmd`, `.drawio.xml` e PDF; o `.mmd` é a fonte da verdade" |
| "todos os TDB-01…TDB-14 foram executados no MySQL" | o DDL foi executado em MySQL 8.0.44 limpo em 10/11/2026, mas só a amostra TDB-01/07/08 foi rodada | "o DDL executa sem erro no MySQL 8.0.44; o censo bate e a amostra de restrições foi testada (ver `teste-ddl.md`)" |
| "as multiplicidades do diagrama de classes estão fechadas" | o CLS-001 (I3) ainda tem `PENDENTE` | "o DER usa a leitura aprovada em DEC-019/021; o fechamento formal é do I3" |
| "CQ-COM-02 está 100%" | a recontagem é do I5 e o CTX-001 ainda é pendência de I1/I2 | "CMP, IMP e UC-033 já cobrem o serviço externo; a recontagem é da qualidade" |
| "a tabela `auditoria`" / "o campo `status`" / "a tabela `fila`" | nomes errados | `registro_auditoria`, `situacao`, `solicitacao_espera` |
| "o painel tem um serviço de consulta" | AP-05 não virou componente, por decisão | "o painel lê pelos repositórios dos agregados; não há hub de consulta" |

### 4.3 Perguntas prováveis da banca (com resposta curta)

| Pergunta | Resposta |
|---|---|
| "Por que não há tabela de notificação?" | DEC-022: o e-mail é efeito externo, não estado do domínio. Persistir a notificação criaria um *outbox* que ninguém consome; a evidência de tentativa é a linha `FALHA_ENVIO_EMAIL` (DEC-029). |
| "Como vocês garantem que dois pacientes não pegam o mesmo horário?" | `SELECT … FOR UPDATE` na linha do slot (TRS-01/TRS-04) **e** `uk_agendamento_slot_ativo` como rede de segurança. O lock serializa; a restrição impede o furo. |
| "Por que a FK de `atendimento` tem três colunas?" | Para impedir que o atendimento registre um par psicólogo-paciente diferente do agendamento (RN-017/RN-019). A FK composta referencia a chave candidata `(id, id_psicologo, id_paciente)`. |
| "O que acontece ao cancelar?" | `agendamento.situacao = 'CANCELADO'`; a coluna gerada `slot_ativo` vira `NULL` e libera o slot; a transação abre a oferta ao próximo da fila (UC-035). O histórico não é apagado. |
| "Por que `UnidadeTrabalho` não aparece nos componentes?" | Simplificação declarada: no nível de componentes a fronteira transacional está em `Persistencia` + pool; TRS-01…07 continuam no PAC e no modelo §7. |
| "Isso escala?" | A aplicação não tem estado de sessão (DEC-020), então escala horizontalmente atrás de um balanceador; o banco é o ponto único, com índices que cobrem as 7 consultas nomeadas (RNF-018). |

---

## 5. Editáveis, exportações e integridade dos arquivos

| Artefato | `.mmd` (fonte) | `.drawio.xml` (editável) | PDF | Observação |
|---|---|---|---|---|
| PAC-001 | ✔ | ✔ | ✔ | exportado em 10/11/2026 do `.drawio.xml` (draw.io Desktop portátil); nota de exceção do ciclo |
| CMP-001 | ✔ | ✔ | ✔ | exportado em 10/11/2026 do `.drawio.xml` |
| IMP-001 | ✔ | ✔ | ✔ | exportado em 10/11/2026 do `.drawio.xml` |
| DER-001 | ✔ | ✔ | ✔ | exportado em 10/11/2026 do `.drawio.xml`; o `.mmd` é a fonte da verdade do conteúdo |

- Os dois `.drawio.xml` alterados na Fase 8 (PAC e CMP) foram validados como **XML bem formado** após a edição; as arestas novas usam o mesmo formato das existentes (`mxCell edge="1"` + `mxGeometry relative="1"` com pontos de roteamento).
- O `.mmd` continua sendo a fonte da verdade: as arestas `AGENDA ↔ FILA`, o componente `ServicoHash` e a realização `SEG ..> IHASH` existem **nos dois formatos**.
- Em 10/11/2026 os quatro PDFs foram exportados com o **draw.io Desktop 32.6.10** em modo portátil (ZIP, sem instalação), pela CLI `--export --format pdf`; nenhum arquivo foi instalado no ambiente. A exportação preserva o desenho e a página definidos no `.drawio.xml`. Ver `03-uml/README.md` e `der/der-001-logico.md` §9.
- O DDL é texto puro e abre em qualquer editor; não há binário nem arquivo proprietário na persistência.

---

## 6. Últimos achados, pendências e o que ficou para outros integrantes

### 6.1 Achados que eu corrigi nesta entrega (Fase 8)

As 14 correções estão tabeladas em `fase-08-verificacao-qualidade-persistencia.md` §7.1. As duas últimas (#13 e #14) são as únicas que tocam desenho:

- **#13** — par `ServicoAgenda ↔ ServicoListaEspera` explicitado em PAC-001 e CMP-001 (antes só existia no texto do R7-11);
- **#14** — componente `ServicoHash` e realização `ServicoHash ..> ServicoHashSenha` acrescentados ao CMP-001 (o PAC-001 já os mostrava).

### 6.2 Pendências que **não** são minhas (registradas, não corrigidas)

| ID | Dono | Pendência | Efeito se não fechar |
|---|---|---|---|
| **R8-01** | I2 | matriz da Fase 6 usa `agendamento.status` | matriz final com nome inexistente no banco |
| **R8-02** | I2 | matriz da Fase 5 usa `auditoria`/`fila`/`notificacao` | idem |
| **R8-03** | I3 | CLS-001 sem atributos de `Psicologo`/`Paciente`, com `confirmar()` | P-21 continua aberta; o DER já usa a leitura aprovada |
| **R8-04** | I5 | CQ-COM-02 medido antes da Fase 7 | critério pode ficar "não conforme" sem motivo |
| **CQ-CON-04** | I3/I5 | multiplicidades `PENDENTE` no CLS-001 | evidência fica "parcial" do lado do I3 |
| **P-20** | grupo | fila por horário sem slot cadastrado | decisão de produto, não de esquema |
| **P-21** | I3/I1 | atributos provisórios de `psicologo`/`paciente` | troca localizada no dicionário §7 |

**Nenhuma delas impede a entrega da persistência**: o esquema está completo e coerente com a baseline; o que falta é o fechamento formal em artefato de outro dono.

### 6.3 O que eu **não** fiz (e por quê)

- não alterei `05-qualidade/plano-qualidade-iso25010.md`, `06-rastreabilidade/*` nem o CLS-001 — são de I5, I1/I2 e I3; em `03-uml/README.md` atualizei apenas o inventário de PDFs (exceção autorizada pelo checklist);
- executei o DDL em **MySQL 8.0.44 portátil** (Q7-02) e rodei a amostra TDB-01/07/08; os demais TDB continuam como roteiro da Fase 8;
- exportei os PDFs de PAC-001, CMP-001, IMP-001 e DER-001 com o draw.io Desktop portátil;
- não reabri a modelagem: a Fase 9 é de consolidação.

---

## 7. Checklist de encerramento do Integrante 4

| Item | Estado | Evidência |
|---|---|---|
| Versões finais de DER, modelo relacional, dicionário e mapeamento | ✔ | §1 (v1.1, 30/10/2026) |
| Versões finais de PAC-001, CMP-001 e IMP-001 | ✔ | §1 (PAC v1.2, 10/11/2026; CMP v1.1, 31/10/2026; IMP 1.0, 29/10/2026) |
| Dicionário completo (97/97 colunas) | ✔ | §2; Fase 8 §4.1 |
| Mapeamento completo (12/12 classes + proposta) | ✔ | §2; Fase 8 §4.2 |
| DDL executado e conferido (15/97/15/17/24/26/17/4/3) | ✔ | §2; [`teste-ddl.md`](teste-ddl.md) |
| Integridade referencial e inativação | ✔ | §2; Fase 8 §2.3 |
| N:N, normalização e desnormalizações controladas | ✔ | Fase 8 §2.1/§2.2; `normalizacao.md` |
| Testes conceituais TDB-01…TDB-14 | ✔ | Fase 8 §6; amostra executada em `teste-ddl.md` §5 |
| Evidências CQ para o I5 | ✔ | Fase 8 §7.4 |
| Texto das seções 25 e 26 | ✔ | §3 |
| Pontos técnicos do pitch | ✔ | §4 |
| Editáveis e fontes dos diagramas | ✔ (PDF exportado em 10/11/2026) | §5 |
| Achados de outros integrantes registrados | ✔ | §6.2 (R8-01…R8-04) |

---

## 8. Referências

| Conteúdo | Origem |
|---|---|
| Censo, TDB e correções da Fase 8 | [`fase-08-verificacao-qualidade-persistencia.md`](fase-08-verificacao-qualidade-persistencia.md) |
| Estrutura das seções 25 e 26 | [`../../07-dossie/secoes/fases7-9-secao-25-36.md`](../../07-dossie/secoes/fases7-9-secao-25-36.md) |
| Pontos e roteiro do pitch | [`../../08-pitch/banco-de-pontos-pitch.md`](../../08-pitch/banco-de-pontos-pitch.md) §2–§3 |
| Critérios CQ e medição | [`../../05-qualidade/plano-qualidade-iso25010.md`](../../05-qualidade/plano-qualidade-iso25010.md) |
| Decisões DEC-016 a DEC-030 | [`../../01-planejamento/decisoes.md`](../../01-planejamento/decisoes.md) |
| Tarefas por fase | [`../../01-planejamento/etapas-e-responsabilidades.md`](../../01-planejamento/etapas-e-responsabilidades.md) §3 |

**Registro de participação:** Integrante 4 (Caio Cunha) — fechamento das versões v1.1/v2.1, conferência final do trio dicionário × mapeamento × DDL, texto-base das seções 25 e 26, roteiro técnico de arquitetura e persistência para o pitch (quatro falas + perguntas prováveis + lista do que não dizer) e inventário de editáveis/exportações com a pendência de PDF declarada.
