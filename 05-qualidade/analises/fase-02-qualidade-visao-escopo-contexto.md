# Fase 2 — Qualidade da Visão, do Escopo e do Contexto (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 2 — Visão, escopo, stakeholders, glossário e contexto
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `02-requisitos/visao.md`, `escopo.md`, `stakeholders-atores.md`, `glossario.md`; `03-uml/Contexto/` (CTX-001 e `Interações_Processos.md`); `01-planejamento/Atores-Processos-Críticos.md`; `01-planejamento/decisoes.md` (DEC-001 a DEC-010).

---

## 1. Objetivo

Verificar se os artefatos de concepção da Fase 2 são completos, consistentes entre si e utilizáveis como base dos requisitos, e fazer a **seleção preliminar das características de qualidade** (ISO/IEC 25010:2023) e do **contexto de uso** (ISO/IEC 25019:2023) que o plano de qualidade vai detalhar.

## 2. Método

1. Conferir os elementos que o enunciado pede no documento de visão (barema §7): contexto, problema, objetivos, fronteiras, premissas e restrições.
2. Conferir a coerência entre visão, escopo, stakeholders, glossário e diagrama de contexto (mesmos atores, mesmas fronteiras, mesmos termos).
3. Usar a ISO/IEC/IEEE 29148:2018 como guia para a qualidade das informações de concepção (necessidades de stakeholders identificadas, fronteira do sistema, restrições e premissas explícitas).
4. Registrar achados `Q2-nn` sem alterar os documentos de outros integrantes.

## 3. Verificação dos elementos exigidos

| Elemento (barema §7) | Onde está | Resultado |
|---|---|---|
| Contexto | `visao.md` §1 | **OK** |
| Situação-problema | `visao.md` §2 | **OK** — cinco problemas nomeados |
| Objetivos (geral e específicos) | `visao.md` §3–§4 | **OK** |
| Fronteiras | `escopo.md` §5 | **OK** — interno × externo |
| Premissas | `escopo.md` §6 (PRE-001 a PRE-006) | **OK** — identificadas |
| Restrições | `escopo.md` §7 (RES-001 a RES-006) | **OK** — identificadas |
| Escopo negativo | `escopo.md` §4, DEC-008 | **OK** |
| Glossário | `glossario.md` | **OK** — 17 termos, inclui os termos da inovação |
| Stakeholders e atores | `stakeholders-atores.md` | **OK** — 6 stakeholders, 3 atores humanos, 1 ator externo |
| Diagrama de contexto | `03-uml/Contexto/diagrama-contexto.*` (CTX-001) | **Parcial** — ver Q2-01 |

## 4. Coerência entre os artefatos da Fase 2

| Verificação | Resultado |
|---|---|
| Os três atores humanos são os mesmos em visão, escopo, stakeholders e contexto | **OK** — Administrador, Psicólogo, Cliente/Paciente |
| Atendente fora do escopo em todos os documentos | **OK** — DEC-007 refletida em `stakeholders-atores.md` §5.1 e `Interações_Processos.md` |
| Serviço Externo de E-mail com a mesma situação em todos os documentos | **Divergente** — aprovado em DEC-009 (25/10/2026) e em `stakeholders-atores.md`; ainda "Pendente" no CTX-001 e em `Interações_Processos.md` (Q2-01, Q2-02) |
| Acesso do paciente (DEC-006) | **Divergente** — `Atores-Processos-Críticos.md` ainda pergunta se o paciente terá login (Q2-03) |
| Módulos do escopo × escopo mínimo do enunciado (barema §5) | **OK** — os 7 módulos do enunciado aparecem, mais o módulo de inovação (DEC-010) |
| Termos do glossário usados com o mesmo sentido nos requisitos | **OK** na amostra (Vínculo, Disponibilidade, Agendamento, Situação do agendamento) |

## 5. Seleção preliminar de características de qualidade (ISO/IEC 25010:2023)

A seleção parte das necessidades dos stakeholders declaradas na visão. São selecionadas **sete** características (o enunciado pede no mínimo cinco); o detalhamento em critérios mensuráveis está em [`../plano-qualidade-iso25010.md`](../plano-qualidade-iso25010.md).

| Característica | Necessidade da visão que a justifica |
|---|---|
| Segurança | "Insegurança da informação", "controle de permissões", isolamento de dados sensíveis (`visao.md` §2 e §6) |
| Adequação funcional | Cobrir os módulos do escopo mínimo e os objetivos específicos (`visao.md` §4) |
| Confiabilidade | Agenda sem conflitos e ciclo do agendamento consistente (`escopo.md` §3.5) |
| Manutenibilidade | Dossiê usado por "Equipe Técnica e de Desenvolvimento" para implementar e evoluir (`visao.md` §5) |
| Flexibilidade | "Plataforma flexível" para psicólogos de diferentes áreas (barema §2; `visao.md` §3) |
| Compatibilidade | Integração com o Serviço Externo de E-mail (DEC-009) |
| Capacidade de interação | Autoatendimento do paciente com prevenção de erro (DEC-006) |

Características avaliadas e **não** selecionadas como foco: eficiência de desempenho (há apenas RNF-010, sem métrica — tratada como critério secundário) e proteção/segurança operacional (*safety*), porque o escopo exclui teleconsulta, prescrição e prontuário clínico (DEC-008); os riscos de uso indevido são cobertos por Segurança.

## 6. Contexto de uso (ISO/IEC 25019:2023) — preliminar

| Stakeholder | Uso principal | Resultado em uso esperado |
|---|---|---|
| Administrador | Gestão de acessos, cadastros e auditoria | Controle de quem acessa o quê, com trilha verificável |
| Psicólogo | Agenda, vínculos e registro conceitual de sessões | Agenda sem conflito e acesso somente a pacientes vinculados |
| Cliente/Paciente | Autoatendimento de agenda e lista de espera | Marcar, consultar e cancelar sem intermediário; ocupar vaga liberada |
| Equipe de implementação | Leitura do dossiê | Implementar sem ambiguidade a partir dos modelos |

O contexto de uso é usado no plano de qualidade para justificar a escolha das características e, na Fase 9, para o argumento de valor do pitch.

## 7. Achados

| ID | Achado | Artefato | Responsável sugerido |
|---|---|---|---|
| Q2-01 | O CTX-001 marca o Serviço de e-mail como "Pendente", mas DEC-009 foi aprovada em 25/10/2026 | `03-uml/Contexto/diagrama-contexto.drawio.xml` e `.pdf` | Integrante 2 |
| Q2-02 | `Interações_Processos.md` ainda descreve o serviço de e-mail como "PENDENTE (DEC-009)" | `03-uml/Contexto/Interações_Processos.md` | Integrante 2 |
| Q2-03 | `Atores-Processos-Críticos.md` mantém como aberta a pergunta sobre login do paciente, já decidida em DEC-006; e numera decisões como `DEC-1` a `DEC-5`, que não correspondem aos IDs oficiais | `01-planejamento/Atores-Processos-Críticos.md` | Integrante 2 + Integrante 1 |
| Q2-04 | O glossário não define "Horário/slot", "Conflito de agenda" e "Sessão autenticada", usados nos requisitos e nos diagramas | `02-requisitos/glossario.md` | Integrante 1 |
| Q2-05 | Premissas e restrições não têm vínculo explícito com requisitos (ex.: RES-002 ↔ RNF-001/RN-002) | `02-requisitos/escopo.md` | Integrante 1 (opcional; pode ser resolvido na matriz final) |

## 8. Situação ao final da Fase 2

Artefatos de concepção **completos**; três divergências documentais (Q2-01 a Q2-03) decorrem de decisões tomadas depois da Fase 2 e precisam ser propagadas. Seleção preliminar de sete características da ISO/IEC 25010:2023 registrada.
