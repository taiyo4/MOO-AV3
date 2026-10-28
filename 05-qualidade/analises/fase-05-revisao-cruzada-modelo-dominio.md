# Fase 5 — Revisão Cruzada de Qualidade do Modelo de Domínio, Classes e Objetos (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 5 — Modelo de domínio, classes e objetos
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `03-uml/Dominio/`, `03-uml/Classes/` (CLS-001 oficial do Integrante 3 e CLS-001 v2 proposta do Integrante 2), `03-uml/Objetos/` (OBJ-001 e OBJ-002), `03-uml/Classes/decisoes-modelagem.md` (OO-01 a OO-16), `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` (R5-01 a R5-17), `04-persistencia/analises/fase-05-viabilidade-persistencia-dominio.md` (INC-01 a INC-13), `06-rastreabilidade/matriz-rastreabilidade-fase5.md`, `07-dossie/secoes/fase5-secao-18-20-27.md`, `decisoes.md` (estado de 25/10/2026).
**Referências:** barema §8, §9 (regras 3, 4, 7, 8), §11 (princípios OO) e §19; ISO/IEC 25010:2023 (Manutenibilidade, Segurança, Confiabilidade); ISO/IEC 19505-2 / UML 2.

---

## 1. Objetivo

Fazer a **revisão cruzada por integrante diferente do autor** que a revisão da Fase 5 do Integrante 2 registra como pendente (Definition of Done) e responder ao achado **R5-15**, endereçado aos Integrantes 3 e 5 (composição entre `Agendamento` e `Atendimento`). A revisão olha o modelo pelo critério de qualidade: ele é **analisável, modificável, testável, íntegro e seguro**?

## 2. Resultado 1 — Requisitos do barema para o diagrama de classes

| Exigência (barema §8 / §19) | CLS-001 oficial (I3) | CLS-001 v2 (proposta I2) |
|---|---|---|
| Classes com responsabilidade | **OK** — 12 classes, sem classe onipotente | **OK** |
| Atributos | **Não conforme** — 10 atributos em 12 classes; `Perfil`, `Psicologo`, `Vinculo`, `Agenda` e `Atendimento` sem atributo; `Permissao` e `AreaAtuacao` vazias | **Não conforme** — 13 atributos; as mesmas classes sem atributo, exceto `Vinculo` |
| Atributos com tipo | **Não conforme** — 2 de 10 tipados (só em `RegistroAuditoria`); tipos omitidos por falta de fonte (OO-06) | **Não conforme** — 2 de 13 tipados |
| Operações com assinatura | **Parcial** — 22 operações, assinaturas incompletas (PC-07, PC-12) | **OK** — 41 operações, incluindo OP-01…OP-22 propostas, com parâmetros e retornos |
| Visibilidade | **OK** | **OK** |
| Multiplicidades | **Não conforme** — 23 extremidades de associação com `PENDENTE` | **OK** — A01–A17 fechadas |
| Composição/agregação | Nenhuma (OO-03, "conservador") | Nenhuma no diagrama |
| Generalização | Nenhuma, justificada (OO-01, OO-02) | Nenhuma, justificada |
| Coerência com DEC-016 (sem `SOLICITADO`) | Não se aplica (enum não fechado, OO-05) | **Não conforme** — enum `SituacaoAgendamento` ainda contém `SOLICITADO` |
| Lista de espera (DEC-010) representada | **Ausente** | **Ausente** |

A contagem acima foi feita por leitura automática dos arquivos `.mmd` em 28/10/2026 (atributos são as linhas iniciadas por `-`/`+` sem parênteses; operações, as linhas com parênteses).

O barema diz que "ausência de multiplicidades, responsabilidades ou fluxos essenciais caracteriza modelagem incompleta" (§19). Hoje o artefato **oficial** está nessa situação e o artefato com multiplicidades fechadas é uma **proposta**. A qualidade do bloco "Classes, objetos e persistência" (1,40 ponto, o maior do barema) depende de o grupo escolher **um** diagrama oficial.

## 3. Resultado 2 — Manutenibilidade (ISO/IEC 25010:2023)

Indicadores calculados sobre a proposta v2 (a única com multiplicidades completas):

| Indicador | Valor | Leitura |
|---|---|---|
| Classes de domínio | 12 (+4 enumerações) | Tamanho adequado ao escopo |
| Associações | 17 (A01–A17) | — |
| Grau máximo de acoplamento | `Psicologo`: 6 associações; `Agendamento`: 5 | Concentração esperada (são os conceitos centrais); nenhuma classe acima de 6 |
| Classes sem operação | 3 (`Permissao`, `AreaAtuacao`, `Disponibilidade`) | `Permissao` e `AreaAtuacao` são catálogos e podem ficar sem operação, mas precisam de atributos (ex.: `codigo`, `descricao`); `Disponibilidade` precisa ao menos dos atributos de horário (DEC-018 em proposta) |
| Atributos tipados | 2 de 13 | Principal lacuna de completude do modelo |
| N:N que exigem tabela associativa | 2 (A02 `Perfil`–`Permissao`, A05 `Psicologo`–`AreaAtuacao`) | Coerente com o previsto pelo Integrante 4 |
| Getters/setters genéricos | 0 (OO-04) | Encapsulamento preservado |

**Redundância de caminhos (integridade):** há dois caminhos para o mesmo fato em dois pontos do modelo:

- `Agendamento → Agenda → Psicologo` (A10 + A08) e `Agendamento → Psicologo` (A11);
- `Atendimento → Agendamento → Psicologo/Paciente` (A15 + A11/A12) e `Atendimento → Psicologo/Paciente` (A13/A14).

Caminhos redundantes são aceitáveis (facilitam consulta), mas sem restrição explícita permitem estado inconsistente — por exemplo, um agendamento na agenda do psicólogo X com `psicologo = Y`. Recomendação (Q5-04): declarar restrições OCL simples no diagrama ou na especificação, como `{self.agenda.psicologo = self.psicologo}` em `Agendamento`, ou marcar A11 como associação derivada (`/`). Essas restrições viram `CHECK`/regra de integridade na Fase 7 (RNF-007).

## 4. Resultado 3 — Resposta ao achado R5-15 (composição)

**Pergunta:** a relação `Agendamento`–`Atendimento` (A15) deve ser composição?

**Análise de qualidade:**

| Critério de composição (UML 2) | `Agendamento` ◆— `Atendimento` | `Agenda` ◆— `Disponibilidade` |
|---|---|---|
| A parte pertence a um único todo | Sim (1 agendamento) | Sim (1 agenda) |
| A parte não existe sem o todo | Sim, se DEC-023 for aprovada | Sim — a disponibilidade só existe na agenda do titular (RN-011) |
| Destruir o todo destrói a parte | **Problema:** o atendimento é registro histórico; o agendamento não é excluído, é encerrado em situação final; e a auditoria exige trilha preservada (RN-014) | Aceitável: remover a agenda remove os períodos ofertados; agendamentos já confirmados não são partes da agenda |

**Recomendação do Integrante 5 (proposta, não decisão):**

1. Manter A15 como **associação** `1` — `0..1`, sem composição, com a restrição de RN-006 (agendamento cancelado não gera atendimento). A justificativa entra na seção 27 do dossiê.
2. Se o grupo quiser evidenciar composição no modelo (o barema §11 cita "Composição — ciclo de vida dependente representado corretamente"), o candidato mais seguro é **A09 `Agenda` ◆— `Disponibilidade`**.

**Atenção à coerência do dossiê:** o texto preparado para a seção 27 (`fase5-secao-18-20-27.md` §27.2 e §27.4) afirma que `Agendamento`–`Atendimento` "foi modelada como composição", mas nem o diagrama oficial (OO-03) nem a proposta v2 desenham composição. O dossiê não pode afirmar o que o diagrama não mostra (Q5-03).

## 5. Resultado 4 — Segurança e confiabilidade no modelo estrutural

| Verificação | Resultado |
|---|---|
| Nenhum atributo de senha em texto puro (RNF-001, RN-002) | **OK** — `credencialProtegida` |
| Autorização por perfil e permissão representável (RNF-002) | **OK** — `Usuario`–`Perfil`–`Permissao` |
| Acesso profissional condicionado a vínculo (RN-003, RNF-006) | **OK** — `Vinculo` é classe de primeira ordem |
| Auditoria imutável (RN-014) | **OK** — sem operações de edição/exclusão (OO-14) |
| Situação do agendamento com valores fechados e iguais às decisões | **Não conforme** — oficial sem valores; v2 com `SOLICITADO` (DEC-016 diz que não é persistente) |
| Diagrama de objetos com dados fictícios (DEC-005) | **OK** — `CONTA-FICTICIA-*`, `FAIXA-FICTICIA-*` |
| OBJ-002 coerente com DEC-016 | **OK** nos objetos mostrados (`REALIZADO`, `CANCELADO`); o objeto de notificação ainda é descrito "enquanto DEC-009 não for decidida" (texto desatualizado) |

## 6. Achados

| ID | Achado | Responsável sugerido |
|---|---|---|
| Q5-01 | Dois diagramas de classes concorrentes (oficial com `PENDENTE`; proposta com multiplicidades). O grupo precisa escolher a base oficial antes da Fase 7 | Grupo + Integrante 3 |
| Q5-02 | `SituacaoAgendamento` da v2 contém `SOLICITADO`, contrariando DEC-016 | Integrante 2 / Integrante 3 |
| Q5-03 | Texto da seção 27 afirma composição `Agendamento`–`Atendimento` que não existe no diagrama; ver recomendação da §4 | Integrante 2 (texto) + Integrante 3 (modelo) |
| Q5-04 | Caminhos redundantes (A10/A11 e A13/A14/A15) sem restrição de consistência | Integrante 3 |
| Q5-05 | Lista de espera (DEC-010, RF-034 a RF-036) sem classe no domínio — ex.: `EntradaListaEspera` e `OfertaVaga`, com atributos dependentes de PG-04 a PG-08 marcados como pendentes | Integrante 3 (com Integrante 4 para persistência) |
| Q5-06 | Texto das seções 18 a 20 e do OBJ-002 cita DEC-009 como pendente | Integrante 2 |
| Q5-07 | Seção 27 (SRP) descreve o ciclo "solicitado → confirmado → realizado/cancelado"; deve ser "confirmado → realizado / cancelado / não compareceu" | Integrante 2 |
| Q5-08 | Atributos ausentes e sem tipo nas duas versões do diagrama (2 de 13 tipados); o barema §8 exige "atributos, … tipos". Sugestão: tipos conceituais (`Texto`, `Data`, `Hora`, `DataHora`, `Booleano` e as enumerações) sem tipos técnicos, coerentes com OO-06 e com o dicionário de dados da Fase 7 | Integrante 3 (com Integrante 4) |

## 7. Situação ao final da Fase 5

O modelo tem **boa coesão e encapsulamento** e nenhuma classe onipotente. As não conformidades de qualidade são de **completude** (multiplicidades no oficial, atributos e tipos nas duas versões, lista de espera ausente) e de **coerência** (enumeração com `SOLICITADO`, composição citada e não desenhada). Revisão cruzada da Fase 5 **registrada**; aprovação do grupo continua pendente.
