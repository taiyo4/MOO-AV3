# Análises de Persistência e Arquitetura — Integrante 4

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**Escopo:** revisões e registros atribuídos ao Integrante 4 no Plano de Execução da AV3 (Fases 4 a 9).
**SGBD de referência:** relacional (DEC-003).

## Objetivo

Esta pasta reúne as análises produzidas pelo Integrante 4 **antes** da elaboração do DER, do modelo relacional, do dicionário de dados e do mapeamento objeto-relacional, que correspondem à Fase 7 do plano.

Cada documento responde às tarefas atribuídas ao Integrante 4 em uma fase específica e funciona como insumo direto para a Fase 7. Nenhum deles é o DER: são revisões, classificações e registros de decisão que antecedem a modelação.

## Documentos

| Documento | Fase do plano | Tarefas do plano cobertas | Situação |
|---|---|---|---|
| [Revisão de dados por caso de uso](fase-04-revisao-dados-por-caso-de-uso.md) | Fase 4 — Casos de uso e especificações | Identificar em cada caso de uso quais informações precisam ser consultadas, criadas ou alteradas; marcar integrações externas a considerar em componentes e implantação; registrar regras de persistência implícitas a formalizar como RN ou RNF; revisar os casos que envolvem auditoria, autenticação, autorização e dados sensíveis. | **Revisada em v2.0 (29/10/2026)** — §9 fecha os itens de §7 contra os 37 UC oficiais |
| [Viabilidade de persistência do modelo de domínio](fase-05-viabilidade-persistencia-dominio.md) | Fase 5 — Modelo de domínio, classes e objetos | Revisar multiplicidades e associações pensando na viabilidade de persistência; identificar quais classes serão persistentes e quais são apenas serviços/estruturas de apoio; marcar N:N, composição e herança que exigirão estratégia de mapeamento; apontar inconsistências entre multiplicidade de domínio e regras de negócio antes do DER. | **Revisada em v2.0 (29/10/2026)** — §9 fecha P-01 a P-12 e levanta a suspensão do DER |
| [Impacto comportamental sobre a persistência](fase-06-impacto-comportamental-persistencia.md) | Fase 6 — Diagramas comportamentais | Revisar chamadas a repositórios, serviços externos e persistência para evitar dependências incoerentes; identificar quais mensagens exigirão suporte arquitetural ou transacional posteriormente; verificar se alterações de estado precisam de campos, histórico ou auditoria na persistência; registrar impactos do comportamento no DER e nos componentes planejados. | **Revisada em v2.0 (29/10/2026)** — §10 fecha P-13 a P-19, INC-13 e mapeia a entrega da Fase 7 |

### Situação das fases do Integrante 4

| Fase | Tarefas do Integrante 4 | Artefato | Situação |
|---|---|---|---|
| Fase 4 — Casos de uso e especificações | Revisão de dados por caso de uso; integrações externas; regras de persistência implícitas; auditoria, autenticação, autorização e dados sensíveis | `analises/fase-04-revisao-dados-por-caso-de-uso.md` | **Concluída e revisada em v2.0** (29/10/2026) |
| Fase 5 — Modelo de domínio | Multiplicidades, classes persistentes × estruturas de apoio, N:N, composição, herança, inconsistências antes do DER | `analises/fase-05-viabilidade-persistencia-dominio.md` | **Concluída e revisada em v2.0** (29/10/2026) |
| Fase 6 — Diagramas comportamentais | Chamadas a repositórios e serviços, fronteiras transacionais, histórico e auditoria, impacto no DER e nos componentes | `analises/fase-06-impacto-comportamental-persistencia.md` | **Concluída e revisada em v2.0** (29/10/2026) |
| Fase 7 — Arquitetura e persistência | Diagrama de pacotes (PAC-001), de componentes (CMP-001) e de implantação (IMP-001); DER lógico (DER-001); modelo relacional com PK/FK/UNIQUE/NOT NULL/domínios; resolução de N:N; integridade referencial e exclusão/inativação; dicionário de dados; mapeamento objeto-relacional; justificativa da normalização; DDL MySQL | `der/`, `modelo-relacional.md`, `dicionario-de-dados.md`, `mapeamento-objeto-relacional.md`, `normalizacao.md`, `ddl/schema-mysql.sql`, `03-uml/{Pacotes,Componentes,Implantacao}/` | **Concluída** (29/10/2026) |
| Fase 8 — Qualidade e rastreabilidade | Revisar PK, FK, UNIQUE, NOT NULL, N:N, normalização, integridade referencial e exclusão/inativação; verificar pacotes, componentes, interfaces e implantação; confirmar dicionário e mapeamento; evidências para segurança, compatibilidade, confiabilidade e manutenibilidade | `fase-08-verificacao-qualidade-persistencia.md` | **Não iniciada** |
| Fase 9 — Consolidação e pitch | Versões finais de DER e modelo relacional; conferência de dicionário, mapeamento e DDL; pontos técnicos de arquitetura e persistência para o pitch | `fase-09-encerramento-e-pitch.md` | **Não iniciada** |

### Artefatos da Fase 7 (fora desta pasta)

| Artefato | Caminho | Conteúdo |
|---|---|---|
| DER-001 | [`../der/der-001.mmd`](../der/der-001.mmd), [`../der/der-001.drawio.xml`](../der/der-001.drawio.xml), [`../der/der-001-logico.md`](../der/der-001-logico.md) | 15 entidades, 22 relações, convenções e decisões de modelação |
| Modelo relacional | [`../modelo-relacional.md`](../modelo-relacional.md) | esquema, restrições por tabela, resolução de N:N, TRS-01..TRS-07, índices |
| Dicionário de dados | [`../dicionario-de-dados.md`](../dicionario-de-dados.md) | colunas, tipos, nulidade, default, domínio, origem e rastreabilidade RF → coluna |
| Mapeamento objeto-relacional | [`../mapeamento-objeto-relacional.md`](../mapeamento-objeto-relacional.md) | MD-01..MD-18, classe → tabela, atributo → coluna, interfaces de repositório |
| Normalização | [`../normalizacao.md`](../normalizacao.md) | DFs, 1FN–5FN e as três desnormalizações controladas |
| DDL | [`../ddl/schema-mysql.sql`](../ddl/schema-mysql.sql) | 15 `CREATE TABLE`, `CHECK`s nomeados, colunas geradas, 3 triggers, carga inicial |
| PAC-001 | [`../../03-uml/Pacotes/diagrama-pacotes.mmd`](../../03-uml/Pacotes/diagrama-pacotes.mmd) | camadas com inversão de dependência |
| CMP-001 | [`../../03-uml/Componentes/diagrama-componentes.mmd`](../../03-uml/Componentes/diagrama-componentes.mmd) | componentes e a interface `ServicoEnvioMensagem` |
| IMP-001 | [`../../03-uml/Implantacao/diagrama-implantacao.mmd`](../../03-uml/Implantacao/diagrama-implantacao.mmd) | navegador, servidor de aplicação, MySQL 8.0 e SMTP |

## Convenções

- Identificadores de RF, RNF, RN, CA, UC, SEQ, EST, PAC, CMP, IMP, DER, CT e DEC seguem o padrão definido no Plano de Execução. A numeração oficial vigente é **RF-001 a RF-037**, **RN-001 a RN-022**, **RNF-001 a RNF-012**, **UC-001 a UC-037** e **DEC-013 a DEC-030**.
- `UC-0RF` e `CT-0RF` são as convenções de nomenclatura derivada fixadas em **DEC-026**: o caso de uso e o caso de teste herdam o número do requisito funcional que verificam.
- `RNF-013` a `RNF-022` e `RN-023`/`RN-024` são **propostas técnicas deste Integrante 4**. A incorporação ao conjunto oficial de requisitos cabe ao Integrante 1 (coordenação e requisitos); até lá, valem como proposta rastreável.
- `INC-01` a `INC-17` são inconsistências detectadas entre multiplicidade de domínio, regras de negócio e comportamento; `P-01` a `P-21` são pendências que exigem decisão do grupo. As que continuam abertas estão em [`../impacto-requisitos.md`](../impacto-requisitos.md) §9.
- `DEP-01` a `DEP-06` são dependências incoerentes entre comportamento e persistência; `TRS-01` a `TRS-07` são exigências transacionais (as sete formalizadas em [`../modelo-relacional.md`](../modelo-relacional.md) §7); `ARQ-01` a `ARQ-08` são exigências arquiteturais; `IMP-DER-01` a `IMP-DER-10` e `IMP-CMP-01` a `IMP-CMP-09` são os impactos registrados sobre o DER e sobre os componentes planejados.
- Os documentos das Fases 4, 5 e 6 foram escritos sobre a baseline anterior. O corpo original foi **preservado** como registro histórico e cada um recebeu uma seção final **"Revisão v2.0 — 29/10/2026"** que o reinterpreta contra a baseline oficial.
- Documentos de outras áreas **não são alterados** por este Integrante. Qualquer alteração proposta é registrada como proposta explícita e endereçada ao responsável.
- Nenhum exemplo deste conjunto utiliza dados reais de pacientes (DEC-005).

## Situação dos insumos

| Insumo | Responsável | Situação |
|---|---|---|
| RF-001..RF-037, RNF-001..RNF-012, RN-001..RN-022 | Integrante 1 | **Concluído** (Fase 3) |
| Glossário, visão, escopo, critérios de aceite | Integrante 1 | **Concluído** (Fases 2 e 3) |
| Diagrama de contexto e interações por ator | Integrante 2 | **Concluído** (Fase 2) |
| Casos de uso e especificações textuais (UC-001..UC-037) | Integrante 2 | **Concluído** — a análise da Fase 4 foi revisada em v2.0 (§9) |
| Modelo de classes e de objetos | Integrante 3 | **Concluído** — a análise da Fase 5 foi revisada em v2.0 (§9) |
| Diagramas comportamentais (SEQ-001..SEQ-004, EST-001, ATV-001, COM-001) | Integrante 2 | **Concluído** — a análise da Fase 6 foi revisada em v2.0 (§10) |
| Decisões DEC-013..DEC-030 | Integrante 1 (coordenação) | **Concluído** — registradas em `01-planejamento/decisoes.md` |

As três análises foram fechadas contra a baseline oficial em 29/10/2026 e **não há pendência de insumo** que impeça a Fase 7, já entregue. O que resta para as Fases 8 e 9 é verificação (revisão de PK/FK/UNIQUE/NOT NULL, normalização, integridade e exclusão) e consolidação — não nova modelação. O walkthrough da Fase 6 ("comparar sequência × operações de classes e estados × atributo/status persistível") continua valendo como roteiro para essa verificação.

