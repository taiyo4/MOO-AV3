# ISO/IEC/IEEE 42010 - stakeholders, interesses e correspondência entre as visões

**Responsável:** Integrante 4 - Caio Cunha (persistência e arquitetura)
**Fase do plano:** Fase 7 - fechamento do achado Q7-03 (revisão do Integrante 5)
**Data:** 10/11/2026 - **Versão:** v1.0
**Norma:** ISO/IEC/IEEE 42010:2022 - descrição de arquitetura: *stakeholders*, *concerns*, *viewpoints*, *views* e *correspondence rules*.
**Insumos:** `02-requisitos/stakeholders-atores.md` §1; `04-persistencia/analises/fase-09-encerramento-e-pitch.md` §3; `03-uml/Pacotes/diagrama-pacotes.mmd`; `03-uml/Componentes/diagrama-componentes.mmd`; `03-uml/Implantacao/diagrama-implantacao.mmd`; `04-persistencia/der/der-001-logico.md`; DEC-003, DEC-020, DEC-022, DEC-027 e DEC-029.

---

## 1. Objetivo

O achado **Q7-03** pediu duas tabelas que a ISO/IEC/IEEE 42010 exige de uma descrição de arquitetura:

1. **stakeholder → interesse (*concern*) → visão (*view*)** - quem se importa com o quê e onde a resposta está;
2. **correspondência entre as quatro visões** - como PAC-001, CMP-001, IMP-001 e DER-001 se referem aos mesmos elementos.

A descrição não substitui os diagramas: ela explica **por que** cada visão existe e **como** as quatro se conferem. As quatro visões são as da Fase 7:

| Sigla | Visão | *Viewpoint* (pergunta que responde) | Artefatos |
|---|---|---|---|
| **PAC** | Pacotes | Como o sistema é dividido e quais dependências são permitidas? | `03-uml/Pacotes/diagrama-pacotes.mmd` + `.drawio.xml` + `.pdf` |
| **CMP** | Componentes | Quais componentes, interfaces e realizações existem? | `03-uml/Componentes/diagrama-componentes.mmd` + `.drawio.xml` + `.pdf` |
| **IMP** | Implantação | Em quais nós e por quais protocolos o sistema roda? | `03-uml/Implantacao/diagrama-implantacao.mmd` + `.drawio.xml` + `.pdf` |
| **DER** | Dados | Como o domínio vira esquema persistente com integridade declarativa? | `04-persistencia/der/der-001-logico.md`, `der-001.mmd`/`.drawio.xml`/`.pdf`, `modelo-relacional.md`, `dicionario-de-dados.md`, `ddl/schema-mysql.sql` |

---

## 2. Tabela A - stakeholder, interesse e visão

Os stakeholders são os de `02-requisitos/stakeholders-atores.md` §1, mais o ator externo de e-mail (DEC-009/DEC-022) e os avaliadores da AV3. Cada linha tem **pelo menos uma visão** que responde ao interesse.

| # | Stakeholder | Interesse (*concern*) | Visão(ões) | Onde a resposta aparece |
|---|---|---|---|---|
| S1 | Organização responsável pela plataforma | Operação simples e de custo controlado: um único SGBD, sem cache ou fila externa (RNF-016) | **IMP**, **PAC** | IMP: quatro nós e três protocolos (HTTPS/443, JDBC/3306, SMTP/587); PAC: cinco pacotes, sem serviço de fila/cache |
| S2 | Administradores | Governança de acesso, cadastros e trilha de auditoria imutável (RF-013, RF-032, RN-014) | **CMP**, **DER**, **PAC** | CMP: `ServicoAutenticacao`, `ServicoAutorizacao`, `ServicoAuditoria`; DER: `usuario`, `perfil`, `permissao`, `perfil_permissao`, `registro_auditoria`; PAC: pacotes `aplicacao` e `dominio` |
| S3 | Psicólogos | Agenda sem conflito, disponibilidade e histórico permitido (RN-005, RN-011, RN-018) | **DER**, **CMP**, **PAC** | DER: `agenda`, `disponibilidade`, `agendamento`, `atendimento` e as restrições de slot único; CMP: `ServicoAgenda`; PAC: `AGENDA` |
| S4 | Clientes/Pacientes | Autoatendimento, privacidade e lista de espera (RF-034 a RF-036, DEC-027) | **CMP**, **DER**, **IMP** | CMP: `InterfaceUsuario` e `ServicoListaEspera`; DER: `paciente` e `solicitacao_espera` (situação `OFERTADA`); IMP: navegador → HTTPS/443 |
| S5 | Equipe de Engenharia / futura implementação | Baixo acoplamento, inversão de dependência, contratos claros e esquema executável | **PAC**, **CMP**, **DER**, **IMP** | PAC: regra `apresentacao → aplicacao → dominio ← infraestrutura`; CMP: dez `IRepositorio*` e três interfaces; DER: DDL MySQL 8.0; IMP: instalação do `schema-mysql.sql` |
| S6 | Equipe de Suporte e Manutenção | Continuidade operacional, monitoramento e mudança localizada | **IMP**, **PAC**, **CMP**, **DER** | IMP: topologia e protocolos; PAC: `configuracao` (*composition root*); CMP: adaptadores (`Persistencia`, `AdaptadorEmail`, `ServicoHash`); DER: `registro_auditoria` e inativação por `situacao` |
| S7 | Serviço Externo de E-mail (ator externo) | Contrato de envio e isolamento de falha (DEC-022, DEC-029) | **CMP**, **IMP**, **PAC** | CMP: interface `ServicoEnvioMensagem` e componente `AdaptadorEmail`; IMP: SMTP/587 com STARTTLS; PAC: `dominio.fronteira` e `infraestrutura.mensageria`; DER: **nenhuma tabela** (DEC-022) |
| S8 | Avaliadores da AV3 (banca) | Rastreabilidade das decisões, coerência entre artefatos e aderência à norma | **PAC**, **CMP**, **IMP**, **DER** | as quatro visões, a tabela B e as decisões DEC-003/020/022/027/029 citadas em cada uma |

**Cobertura.** As quatro visões aparecem na tabela A: PAC em S1-S3, S5, S6 e S8; CMP em S2-S8; IMP em S1, S4-S8; DER em S2-S6 e S8. Todo interesse listado tem ao menos uma visão responsável.

---

## 3. Tabela B - correspondência entre as quatro visões

### 3.1 Matriz elemento × visão

A matriz mostra o **mesmo elemento** nas quatro visões. "—" significa ausência **deliberada**, com a decisão que a justifica - não é elemento órfão.

| Elemento arquitetural | PAC-001 | CMP-001 | IMP-001 | DER-001 |
|---|---|---|---|---|
| Interface com o usuário | pacotes `apresentacao.web` e `apresentacao.view` | componente `InterfaceUsuario` | nó `Dispositivo do usuário` (navegador) | — (estado volátil, DEC-020) |
| Autenticação e autorização | `AUTENTICACAO`, `AUTORIZACAO` | `ServicoAutenticacao`, `ServicoAutorizacao` | dentro do `ServidorAplicacao` | `usuario`, `perfil`, `permissao`, `perfil_permissao` |
| Cadastros | `CADASTRO` | `ServicoCadastro` | dentro do `ServidorAplicacao` | `psicologo`, `paciente`, `vinculo`, `area_atuacao`, `psicologo_area_atuacao` |
| Agenda e agendamento | `AGENDA` | `ServicoAgenda` | dentro do `ServidorAplicacao` | `agenda`, `disponibilidade`, `agendamento`, `atendimento` |
| Lista de espera | `FILA` | `ServicoListaEspera` | dentro do `ServidorAplicacao` | `solicitacao_espera` |
| Auditoria | `AUDITORIA` | `ServicoAuditoria` | dentro do `ServidorAplicacao` | `registro_auditoria` (2 triggers *append-only*) |
| Tempo | `TEMPO` | `ServicoTempo` | dentro do `ServidorAplicacao` | `criado_em`, `atualizado_em`, `data_hora_*` |
| Unidade de trabalho | `UOW` (`UnidadeTrabalho`) | — (não é componente; é coordenação da aplicação) | dentro do `ServidorAplicacao` | fronteiras TRS-01 a TRS-07 (`modelo-relacional.md` §7) |
| Envio de e-mail | `dominio.fronteira` + `infraestrutura.mensageria` | interface `ServicoEnvioMensagem` + `AdaptadorEmail` | `AdaptadorEmail` no `ServidorAplicacao` → `ServicoExternoEmail` (SMTP/587) | — (DEC-022: nenhuma tabela `notificacao`) |
| Hash de senha | `dominio.fronteira` + `infraestrutura.seguranca` | interface `ServicoHashSenha` + `ServicoHash` | dentro do `ServidorAplicacao` | `usuario.hash_senha` (`CHECK` de comprimento mínimo) |
| Repositórios | `dominio.repositorios` (interfaces) | dez `IRepositorio*` | dentro do `ServidorAplicacao` | dez agregados que cobrem as 15 tabelas |
| Persistência | `infraestrutura.persistencia` | componente `Persistencia` | `ServidorAplicacao` → JDBC/3306 | `ddl/schema-mysql.sql`, `modelo-relacional.md`, `dicionario-de-dados.md` |
| SGBD | `BANCO` (externo) | `BancoDados` (externo) | nó `ServidorBanco` (MySQL 8.0/InnoDB/`utf8mb4`) | 15 tabelas, 97 colunas, 24 FKs, 26 CHECK, 4 colunas geradas, 3 triggers |
| Configuração | `configuracao` (*composition root*) | — (não é componente) | artefato `configuracao` no `ServidorAplicacao` | — (parâmetros fora do esquema; DEC-027) |

### 3.2 Regras de correspondência

| Regra | Enunciado | Verificação |
|---|---|---|
| **RC-01** | Todo componente do CMP pertence a exatamente um pacote do PAC. | `InterfaceUsuario` → `apresentacao`; os sete serviços → `aplicacao`; `Persistencia`, `AdaptadorEmail` e `ServicoHash` → `infraestrutura`. |
| **RC-02** | Toda interface do CMP é de propriedade de um pacote do PAC. | `ServicoEnvioMensagem` e `ServicoHashSenha` → `dominio.fronteira`; `IRepositorio*` → `dominio.repositorios`. |
| **RC-03** | Todo nó do IMP hospeda artefatos/componentes já declarados no PAC/CMP; o IMP não cria elemento lógico novo. | `ServidorAplicacao` hospeda `aplicacao` + `configuracao` + `AdaptadorEmail`; `ServidorBanco` hospeda o SGBD e o `schema-mysql.sql`; `ServicoExternoEmail` é externo. |
| **RC-04** | Toda entidade persistida do DER corresponde a uma classe/agregado do CMP, alcançada por um repositório, e ao pacote `dominio.entidades` do PAC. | 12 classes oficiais + `solicitacao_espera` (P8) + 2 associativas puras = 15 tabelas; dez `IRepositorio*`. |
| **RC-05** | O que não existe no DER por decisão não é lacuna: sessão (DEC-020), notificação (DEC-022), *outbox* (DEC-022) e histórico de situação (DEC-024) não têm tabela. | Conferido no DDL: 15 tabelas, nenhuma de sessão/notificação/outbox/histórico. |
| **RC-06** | O par `AGENDA ↔ FILA` é um ciclo **intencional dentro do pacote `aplicacao`**, declarado como exceção ao CQ-FLE-03 no PAC-001 (Q8-07). O DER não tem ciclo de pacotes: `solicitacao_espera → agendamento` é uma FK, não uma dependência de pacote. | Nota `NOTA_CICLO` no PAC-001; par `ServicoAgenda ↔ ServicoListaEspera` no CMP-001. |

### 3.3 Conferências de coerência

- **Nomes iguais nas quatro visões:** `ServicoAgenda`, `ServicoListaEspera`, `ServicoAutenticacao`, `ServicoAutorizacao`, `ServicoCadastro`, `ServicoAuditoria`, `ServicoTempo`, `Persistencia`, `AdaptadorEmail` e `ServicoHash` aparecem com o mesmo nome no PAC e no CMP; `solicitacao_espera`, `agendamento` e `registro_auditoria` aparecem com o mesmo nome no DER e no dicionário.
- **Sem elemento órfão:** todo elemento de PAC/CMP/IMP tem contraparte no DER **ou** ausência justificada (RC-05); toda tabela do DER tem classe/agregado de origem no CMP (RC-04).
- **Decisões rastreáveis:** DEC-003 (MySQL 8.0) aparece em IMP e DER; DEC-020 (sessão volátil) em PAC, IMP e DER; DEC-022/DEC-029 (e-mail como fronteira e falha isolada) em PAC, CMP, IMP e DER; DEC-027 (lista de espera) em PAC, CMP, DER e no texto de IMP.
- **Exceção declarada:** o ciclo `AGENDA ↔ FILA` está registrado no PAC-001 (nota visível) e explicado no CMP-001; a fala 3 do pitch foi ajustada para não afirmar "sem ciclo" (Q8-07).

---

## 4. Limites desta descrição

| Fora do escopo | Motivo |
|---|---|
| Código-fonte, ORM e *frameworks* | a AV3 entrega modelagem; a escolha de implementação é da futura equipe (MD-18/P-21) |
| Dimensionamento, *hardware* e automação de implantação | o IMP-001 fixa topologia e protocolos, não capacidade |
| Desenho de telas e usabilidade | pertence à visão de apresentação, não à descrição de arquitetura |
| `SolicitacaoEspera` como classe oficial | ainda é proposta P8 do Integrante 3; o DER já a mapeia e registra a alternativa `OfertaVaga` em `modelo-relacional.md` §5.3 |

**Relação com o dossiê.** As seções 25 e 26 do dossiê usam o texto-base de `fase-09-encerramento-e-pitch.md` §3; este documento fornece as duas tabelas que fecham o Q7-03 e pode ser citado como evidência da descrição conforme a ISO/IEC/IEEE 42010.
