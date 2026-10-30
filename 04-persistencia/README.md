# Persistência e Arquitetura de Dados — Integrante 4

**Responsável:** Integrante 4 — Caio Cunha (Persistência e arquitetura)
**SGBD de referência:** MySQL 8.0 / InnoDB / `utf8mb4` (DEC-003)
**Baseline:** RF-001 a RF-037, RN-001 a RN-022, RNF-001 a RNF-012, UC-001 a UC-037, DEC-013 a DEC-030

Esta pasta reúne a modelagem de dados da Fase 7 do Plano de Execução e as análises
das Fases 4, 5 e 6 que a antecedem e justificam. Os diagramas de arquitetura
(pacotes, componentes e implantação) ficam em `03-uml/`, porque são diagramas UML
e seguem a convenção de entrega daquela pasta.

## Artefatos

| Artefato | Arquivo | Conteúdo |
|---|---|---|
| DER-001 | [`der/der-001.mmd`](der/der-001.mmd) · [`der/der-001.drawio.xml`](der/der-001.drawio.xml) · [`der/der-001-logico.md`](der/der-001-logico.md) | 15 entidades, 22 relações (A01–A17 oficiais, A18–A21 propostas), convenções, FK compostas e decisões de modelação |
| Modelo relacional | [`modelo-relacional.md`](modelo-relacional.md) | esquema, restrições por tabela (§4.1–§4.15), resolução de N:N e de 0..1, exclusão/inativação, **TRS-01 a TRS-07** e índices |
| Dicionário de dados | [`dicionario-de-dados.md`](dicionario-de-dados.md) | colunas, tipos, nulidade, default, domínio e origem das 15 tabelas; catálogo de `operacao` da auditoria; rastreabilidade RF → coluna |
| Mapeamento objeto-relacional | [`mapeamento-objeto-relacional.md`](mapeamento-objeto-relacional.md) | **MD-01 a MD-18**, classe → tabela, atributo → coluna, associações, agregados e as 10 interfaces de repositório |
| Normalização | [`normalizacao.md`](normalizacao.md) | dependências funcionais, 1FN–5FN e as **três desnormalizações controladas** |
| DDL | [`ddl/schema-mysql.sql`](ddl/schema-mysql.sql) | 15 `CREATE TABLE` MySQL 8.0, `CHECK`s nomeados, colunas geradas, 3 triggers, carga inicial de perfis e permissões |
| Análises das Fases 4–6 | [`analises/`](analises/) | revisões que antecedem a modelação, cada uma com a seção **"Revisão v2.0 — 29/10/2026"** |
| Impacto nos requisitos | [`impacto-requisitos.md`](impacto-requisitos.md) | RF/RN/RNF × persistência, mapa de renumeração v1.0 → oficial, pendências e inconsistências |

### Diagramas de arquitetura (em `03-uml/`)

| ID | Fonte da verdade | Editável | Conteúdo |
|---|---|---|---|
| PAC-001 | [`../03-uml/Pacotes/diagrama-pacotes.mmd`](../03-uml/Pacotes/diagrama-pacotes.mmd) | [`../03-uml/Pacotes/diagrama-pacotes.drawio.xml`](../03-uml/Pacotes/diagrama-pacotes.drawio.xml) | camadas com inversão de dependência (`apresentação → aplicação → domínio ← infraestrutura`) |
| CMP-001 | [`../03-uml/Componentes/diagrama-componentes.mmd`](../03-uml/Componentes/diagrama-componentes.mmd) | [`../03-uml/Componentes/diagrama-componentes.drawio.xml`](../03-uml/Componentes/diagrama-componentes.drawio.xml) | componentes e a interface **`ServicoEnvioMensagem`** (DEC-022) |
| IMP-001 | [`../03-uml/Implantacao/diagrama-implantacao.mmd`](../03-uml/Implantacao/diagrama-implantacao.mmd) | [`../03-uml/Implantacao/diagrama-implantacao.drawio.xml`](../03-uml/Implantacao/diagrama-implantacao.drawio.xml) | navegador —HTTPS/443→ servidor de aplicação —JDBC/3306→ MySQL 8.0; —SMTP/587→ serviço de e-mail |

## Decisões de modelação que estruturam o esquema

| Decisão | Efeito no esquema |
|---|---|
| **DEC-018** — slot discreto é a autoridade do tempo | `disponibilidade` define o slot; `agendamento.horario` é projeção derivada (INC-15) |
| **DEC-024** — histórico de situação por colunas | `registro_auditoria.situacao_anterior` e `situacao_nova`, sem tabela de histórico |
| **DEC-029** — falha de e-mail não desfaz a operação | `registro_auditoria.operacao = 'FALHA_ENVIO_EMAIL'` com `resultado = 'FALHA'`, em transação própria (TRS-07) |
| **DEC-022** — envio é fronteira de aplicação | interface `ServicoEnvioMensagem` no domínio; `AdaptadorEmail` na infraestrutura; nenhuma tabela de notificação |
| **DEC-020** — sessão volátil | nenhuma tabela `sessao` |
| **DEC-021** — conta opcional para profissional e paciente | `psicologo.id_usuario` e `paciente.id_usuario` anuláveis e únicos; e-mail de contato na própria pessoa |
| **DEC-027** — lista de espera com oferta de vaga | `solicitacao_espera` com `AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU` |
| Carimbo único | `atendimento.data_hora_registro`, `solicitacao_espera.data_hora_entrada` e `registro_auditoria.data_hora` substituem `criado_em` (dicionário §2.1) |

## Estado

- **Fase 7 concluída** em 29/10/2026: DER-001, modelo relacional, dicionário de dados, mapeamento objeto-relacional, normalização, DDL e os três diagramas de arquitetura.
- Os diagramas são entregues em `.mmd` (fonte da verdade) e `.drawio.xml` (editável). A **exportação em PDF está pendente**: depende do diagrams.net, que não estava disponível no ambiente e que o grupo decidiu não instalar. Ver a nota em [`../03-uml/README.md`](../03-uml/README.md).
- O DDL **não foi executado**: não há MySQL no ambiente. A validação foi por revisão textual e por verificação de que o arquivo é sintaticamente consistente com MySQL 8.0.
- **Fases 8 e 9** (verificação de qualidade e consolidação) ainda não foram executadas.

## Convenções

- Nenhum dado real de paciente é usado em exemplo algum (DEC-005).
- Documentos de outros integrantes não são alterados; alterações propostas são registradas como proposta explícita e endereçada ao responsável.
- Unicidade condicional em MySQL 8.0 é feita por **coluna gerada `TINYINT` (`1`/`NULL`) + `UNIQUE`**, porque o SGBD não tem índice único parcial.
