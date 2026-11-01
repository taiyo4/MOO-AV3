# Plano de Qualidade — ISO/IEC 25010:2023 (versão preliminar)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Versão:** v0.7 — preliminar, atualizada até a Fase 7 (30/10/2026)
**Fecha em:** Fase 8 — Qualidade e rastreabilidade (14/11 a 18/11), como seção 28 do dossiê
**Base:** barema §13; seleção preliminar em `analises/fase-02-qualidade-visao-escopo-contexto.md` §5; classificação dos RNF em `analises/fase-03-verificacao-requisitos.md` §6.

> **Natureza deste documento:** o plano avalia a **qualidade do modelo** (dossiê), não de um software executável. Cada critério é verificável por **inspeção de artefato** ou por **contagem** no repositório. Valores-alvo marcados como "proposta" dependem de aprovação do grupo.

---

## 1. Características selecionadas

O enunciado pede no mínimo cinco características. O plano seleciona **sete**:

| Código | Característica (ISO/IEC 25010:2023) | Por que foi selecionada | RNF relacionados |
|---|---|---|---|
| CQ-SEG | Segurança | Dados sensíveis de pacientes, credenciais e permissões (visão §2) | RNF-001 a RNF-006 |
| CQ-ADE | Adequação funcional | O modelo precisa cobrir o escopo mínimo e a inovação | RNF-011 |
| CQ-CON | Confiabilidade | Agenda sem conflito; ciclo do agendamento com estados e exceções | RNF-007 |
| CQ-MAN | Manutenibilidade | O dossiê orienta implementação e evolução por outra equipe | RNF-008, RNF-011, RNF-012 |
| CQ-FLE | Flexibilidade | Plataforma para psicólogos de várias áreas (barema §2) | RNF-009 |
| CQ-COM | Compatibilidade | Integração com o Serviço Externo de E-mail (DEC-009) | proposta Q3-07 |
| CQ-INT | Capacidade de interação | Autoatendimento do paciente com prevenção de erro (DEC-006) | proposta Q3-08 |

Tratadas como critério secundário: **eficiência de desempenho** (RNF-010, ver CQ-SEC-01) e **proteção/segurança operacional** (riscos de uso indevido cobertos por CQ-SEG; escopo exclui funções clínicas de risco, DEC-008).

## 2. Critérios, métricas e evidências

Formato: cada critério diz **o que se mede**, **como**, **qual o alvo** e **onde está a evidência**. A coluna "Situação na Fase 6" é a medição em 28/10/2026.

### 2.1 CQ-SEG — Segurança

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-SEG-01 | Confidencialidade | Nenhum atributo, coluna, mensagem ou exemplo contém senha em texto puro | 0 ocorrências | CLS-001 (`credencialProtegida`); dicionário de dados (Fase 7) | **Atende** — `hash_senha` com CHECK de tamanho no DDL e dicionário (Fase 7) sem coluna de senha em texto puro |
| CQ-SEG-02 | Confidencialidade | Toda consulta de paciente por psicólogo passa pelo vínculo (RN-003) | 100% dos fluxos de consulta profissional | UC "Atender pacientes vinculados" E1; DEP-04 do Integrante 4 | **Atende** nos UC; validar no DER |
| CQ-SEG-03 | Confidencialidade | Paciente só acessa dados próprios (RN-004, RNF-005) | 100% dos UC do paciente com restrição explícita | UC-025, UC-027, "Consultar meu cadastro" | **Atende**; faltam cenários negativos nos CA (Q3-06) |
| CQ-SEG-04 | Autenticidade | Conta bloqueada não autentica (RN-001) | Fluxo de recusa presente | SEQ-001 E2 | **Atende** |
| CQ-SEG-05 | Responsabilização | Toda mudança de situação gera auditoria com responsável, data, hora e operação | 100% das transições do EST-001 com auditoria | EST-001; matriz da Fase 6 | **Atende**; lista de operações auditáveis pendente (Q3-03) |
| CQ-SEG-06 | Integridade | Auditoria sem operação de edição/exclusão (RN-014) | 0 operações de alteração em `RegistroAuditoria` | OO-14 | **Atende** |
| CQ-SEG-07 | Confidencialidade | Nenhum dado real de paciente (DEC-005) | 0 ocorrências | Inspeção dos `.mmd`, `.pdf` e textos | **Atende** |

### 2.2 CQ-ADE — Adequação funcional

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-ADE-01 | Completude funcional | Todo RF tem critério de aceite | 37/37 | `criterios-aceite.md` | **Atende** |
| CQ-ADE-02 | Completude funcional | Todo RF é coberto por caso de uso especificado | 100% | Especificações de UC | **Não atende** — 31/37; faltam RF-028, RF-033 a RF-037 (Q4-03) |
| CQ-ADE-03 | Completude funcional | A inovação (DEC-010) tem requisito, caso de uso, CA, comportamento e persistência (`PLANEJAMENTO_AV3` §6 regra 8) | 5 de 5 elementos | RF-034 a RF-036, CA; UC, diagrama e tabela ausentes | **Não atende** — 2 de 5 (Q4-03, Q5-05, Q6-05) |
| CQ-ADE-04 | Correção funcional | Diagramas usam as mesmas situações aprovadas (DEC-016) | 0 divergências | EST-001, SEQ-002, CLS-001 v2 | **Não atende** — `SOLICITADO` em 3 artefatos (Q5-02, Q6-01) |
| CQ-ADE-05 | Pertinência funcional | Nenhum elemento fora do escopo (DEC-008) | 0 ocorrências | Requisitos e modelos | **Atende** |

### 2.3 CQ-CON — Confiabilidade

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-CON-01 | Maturidade | Todo estado do ciclo do agendamento tem evento de entrada e toda transição tem evento | 100% | EST-001 | **Atende** na forma (rever após Q6-01) |
| CQ-CON-02 | Tolerância a falhas | Exceções dos casos críticos aparecem nos diagramas de sequência | 100% das exceções de UC-001, UC-025, UC-027 | SEQ-001/002/003 | **Atende** |
| CQ-CON-03 | Tolerância a falhas | Falha de envio de e-mail tem efeito definido | Decisão registrada | DEC-029 (28/10/2026) | **Atende** (decisão registrada; falta propagar aos diagramas) |
| CQ-CON-04 | Integridade dos dados | FKs e restrições respeitam as multiplicidades (RNF-007) | 100% das associações com FK/restrição correspondente | DER (Fase 7) | **Parcial** — DDL com 24 chaves estrangeiras para as associações do DER-001; as multiplicidades do diagrama de classes oficial seguem `PENDENTE` (Q5-01), então a conferência 1 a 1 depende do Integrante 3 |
| CQ-CON-05 | Integridade sob concorrência | Dois agendamentos ativos nunca ocupam o mesmo horário (RN-005) | Restrição de unicidade + revalidação na confirmação | SEQ-002 (revalidação); DER (Fase 7) | **Atende** — `UNIQUE (slot_ativo)` em `agendamento` + `SELECT … FOR UPDATE` no slot (TRS-01, TRS-04); falta teste real, pois o DDL não foi executado |

### 2.4 CQ-MAN — Manutenibilidade

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-MAN-01 | Modularidade | Nenhuma classe com mais de 6 associações; nenhuma classe onipotente | ≤ 6 (proposta) | Contagem na CLS-001 v2 | **Atende** — máximo 6 (`Psicologo`) |
| CQ-MAN-02 | Analisabilidade | Toda mensagem de diagrama comportamental remete a operação conhecida | 100% | Matriz da Fase 6 | **Atende** — 82/82 e 14/14 |
| CQ-MAN-03 | Analisabilidade | Matriz final sem elementos órfãos (RF, UC, classe, estado, tabela, diagrama) | 0 órfãos ou exceção justificada | Matriz final (Fase 8) | **Em andamento** |
| CQ-MAN-04 | Modificabilidade | Toda decisão aprovada propagada a todos os artefatos afetados em até uma fase | 0 artefatos desatualizados ao fim da fase seguinte | `decisoes.md` × artefatos | **Não atende** — decisões de 25/10 ainda não propagadas aos diagramas (Q6-01 a Q6-06) |
| CQ-MAN-05 | Testabilidade | Todo RF tem teste conceitual (CT) ligado a CA e a artefato que o materializa | 100% | Matrizes das Fases 5 e 6 | **Parcial** — CT definidos para RF-001 a RF-032 |
| CQ-MAN-06 | Reusabilidade / legibilidade | Todo diagrama tem `.mmd` ou fonte editável, `.drawio.xml` e `.pdf` legível | 100% | `03-uml/README.md` | **Atende** (CTX-001 e UC-001 sem `.mmd`, com `.drawio.xml`) |

### 2.5 CQ-FLE — Flexibilidade

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-FLE-01 | Adaptabilidade | Nova área de atuação entra por dado (catálogo), sem mudar classes | Sim/Não | `AreaAtuacao` como catálogo (A05) | **Atende** |
| CQ-FLE-02 | Adaptabilidade | Novo papel de acesso entra por `Perfil`/`Permissao`, sem subclasse de `Usuario` | Sim/Não | OO-01, OO-02 | **Atende** |
| CQ-FLE-03 | Escalabilidade | Módulos com dependências declaradas (RNF-009) | Diagrama de pacotes sem ciclo | Fase 7 | **Pendente** — PAC-001 declara a regra de dependência, mas a ausência de ciclo ainda não foi conferida pelo Integrante 5 (fica para a Fase 8) |

### 2.6 CQ-COM — Compatibilidade

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-COM-01 | Interoperabilidade | O e-mail é acessado por interface de fronteira, sem classe de domínio ou tabela de notificação | Sim/Não | `ServicoNotificacao` (AP-04); DEC-022 (proposta) | **Atende** como proposta |
| CQ-COM-02 | Coexistência | O Serviço Externo de E-mail aparece no contexto, nos casos de uso, nos componentes e na implantação | 4 de 4 | CTX-001 ("Pendente"), UC-001 (ausente), Fase 7 | **Parcial** — 2 de 4: implantação (IMP-001) e componentes (CMP-001) trazem o serviço; CTX-001 e o diagrama de casos de uso oficial ainda não (Q2-01, Q4-05) |

### 2.7 CQ-INT — Capacidade de interação

| ID | Subcaracterística | Critério | Medida / alvo | Evidência | Situação na Fase 6 |
|---|---|---|---|---|---|
| CQ-INT-01 | Proteção contra erro do usuário | Cancelamento e aceite de vaga pedem confirmação explícita | Passo de confirmação nos UC/diagramas | — | **Não atende** (Q3-08) |
| CQ-INT-02 | Reconhecibilidade da adequação | O usuário recebe resposta explícita em toda recusa | 100% das exceções com mensagem ao ator | SEQ-001/002/003 | **Atende** |

### 2.8 Critério secundário

| ID | Característica | Critério | Situação na Fase 6 |
|---|---|---|---|
| CQ-SEC-01 | Eficiência de desempenho | RNF-010 com critério de inspeção: consulta de agenda restrita a uma agenda e apoiada por índice (proposta Q3-02) | **Pendente** (Integrante 1 + Integrante 4) |

## 3. Resumo da medição (atualizado em 30/10/2026, após a Fase 7)

| Situação | Quantidade de critérios |
|---|---|
| Atende (inclui "atende como proposta" e "atende na forma") | 20 |
| Parcial | 3 |
| Não atende | 5 |
| Pendente de decisão do grupo, em andamento ou não medível ainda | 3 |
| **Total** | **31** |

Os seis "Não atende" têm três causas: **decisões aprovadas ainda não propagadas aos diagramas** (CQ-ADE-04, CQ-MAN-04, CQ-COM-02), **casos de uso faltando para os requisitos novos, inclusive a inovação** (CQ-ADE-02, CQ-ADE-03) e **prevenção de erro sem requisito** (CQ-INT-01). As duas primeiras são o foco recomendado antes da Fase 7.

## 4. Como o plano será usado nas próximas fases

| Fase | Uso |
|---|---|
| 7 — Arquitetura e persistência | Integrante 4 usa CQ-SEG-01, CQ-CON-04, CQ-CON-05, CQ-COM-02 e CQ-FLE-03 como critérios de aceite do DER e dos diagramas de arquitetura |
| 8 — Qualidade e rastreabilidade | Medição final de todos os critérios; texto da seção 28 do dossiê; matriz final (CQ-MAN-03) |
| 9 — Consolidação e pitch | Três números para o pitch: cobertura (CQ-ADE-01/02), mensagens com origem (CQ-MAN-02) e órfãos na matriz final (CQ-MAN-03) |
