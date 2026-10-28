# Fase 3 — Verificação da Qualidade dos Requisitos (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 3 — Levantamento e especificação de requisitos
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Base verificada:** `02-requisitos/` na versão de 25/10/2026 (commit `0fb9fb6`) — RF-001 a RF-037, RNF-001 a RNF-012, RN-001 a RN-014 e RN-020 a RN-022, CA-RF-001 a CA-RF-037, HU-001 a HU-016 e `rastreabilidade-inicial.md`.
**Norma de referência:** ISO/IEC/IEEE 29148:2018 (características de requisito individual e de conjunto de requisitos).

---

## 1. Objetivo

Cumprir a parte do Integrante 5 na revisão cruzada da Fase 3, que o `02-requisitos/README.md` registra como pendente ("revisão cruzada pelos Integrantes 2 a 6 … continua pendente"): verificar se os requisitos são **necessários, não ambíguos, verificáveis, singulares, consistentes e rastreáveis**, e se o conjunto é **completo** em relação ao escopo e às decisões aprovadas.

Esta verificação não aprova requisitos (isso cabe ao grupo) e não altera a baseline (isso cabe ao Integrante 1). Os achados são `Q3-nn`.

## 2. Método

1. Contagem automática de cobertura: para cada RF, presença de critério de aceite, história de usuário, regra de negócio e linha na matriz inicial.
2. Varredura de termos vagos ("relevante", "adequado", "normal", "a definir", "etapa posterior", "poderá").
3. Leitura dos critérios de aceite procurando cenário negativo (o que **não** deve acontecer).
4. Classificação dos RNF pelas características da ISO/IEC 25010:2023 e verificação de critério mensurável.
5. Conferência com `decisoes.md`: nenhum requisito pode tratar como aprovado o que é proposta ou pendência (`PG-02`, `PG-04` a `PG-12`).

## 3. Resultado 1 — Cobertura e rastreabilidade (contagem automática)

| Verificação | Resultado | Situação |
|---|---|---|
| RF com critério de aceite `CA-RF-xxx` | 37 de 37 | **OK** |
| RF com linha na matriz inicial | 37 de 37 | **OK** |
| RF citado em pelo menos uma história de usuário | 36 de 37 — falta RF-021 | **Parcial** (Q3-01; já registrado pelo Integrante 1) |
| RF citado em pelo menos uma RN | 24 de 37 | **Aceitável** — os 13 restantes (RF-002, 004, 005, 007, 008, 009, 011, 012, 014, 015, 016, 018, 019) são cadastros e consultas cobertos por RNF-002 na matriz |
| Identificadores duplicados ou renumerados | nenhum | **OK** — RF-001 a RF-032 preservados; RF-033 a RF-037 acrescentados; RN-015 a RN-019 reservados ao Integrante 4 |
| Requisito que trata pendência como decisão | nenhum | **OK** — PG-02 e PG-04 a PG-12 citados como pendentes; 2 horas registradas como não aprovadas |
| Requisito com conteúdo fora do escopo (DEC-008) | nenhum | **OK** |
| Dados reais ou senha em texto puro | nenhum | **OK** (DEC-005, RES-001, RES-002) |

## 4. Resultado 2 — Qualidade individual (ISO/IEC/IEEE 29148)

| Característica | Resultado | Evidência |
|---|---|---|
| Necessário | **OK** | Todo RF deriva de módulo do escopo ou de decisão (DEC-006, DEC-009, DEC-010, DEC-011, DEC-016, DEC-017, DEC-025) |
| Não ambíguo | **Parcial** | Termos vagos em RNF-010 ("compatível com uso interativo normal"), RF-032/RNF-004/RN-009 ("operações relevantes"), RF-002 ("etapa posterior") — Q3-02, Q3-03 |
| Verificável | **Parcial** | RNF-010 sem métrica ("VALOR A DEFINIR"); CA-RF-035 usa "poderá registrar a oferta", que não é verificável como obrigação — Q3-02, Q3-04 |
| Singular | **Aceitável** | RF-004 junta alteração administrativa e alteração dos próprios dados; RF-007 agrupa consultar/cadastrar/alterar perfis. Não bloqueia; registrado em Q3-05 |
| Completo (atributos) | **OK** | Todos os RF têm descrição, ator, prioridade, pré e pós-condições, dependências e observações |
| Consistente | **OK** | RF-025/026/027/037, RN-012/013/020 e CA correspondentes usam as quatro situações de DEC-016 e não usam `SOLICITADO` como situação |
| Viável | **OK** | Nenhum requisito exige tecnologia fora do escopo de modelagem |

## 5. Resultado 3 — Critérios de aceite

| Verificação | Resultado |
|---|---|
| Formato Dado/Quando/Então em todos os 37 CA | **OK** |
| CA com cenário negativo explícito | 7 de 37 (CA-RF-025, 026, 027, 034, 036, 037 e, indiretamente, 006) |
| CA de requisitos de segurança sem cenário de recusa | CA-RF-001 (credencial inválida), CA-RF-013 (usuário sem permissão de auditoria), CA-RF-017 (paciente não vinculado), CA-RF-022 e CA-RF-028 (dados de outro paciente) — Q3-06 |

Os cenários negativos que faltam estão descritos nas exceções dos casos de uso (UC-001 E1/E2) e em RN-003/RN-004/RN-008; o achado pede que sejam **também** verificáveis no critério de aceite, porque é ele que alimenta o teste conceitual (CT) da matriz.

## 6. Resultado 4 — Requisitos não funcionais × ISO/IEC 25010:2023

| RNF | Categoria declarada | Característica 25010 | Subcaracterística | Critério mensurável? |
|---|---|---|---|---|
| RNF-001 | Segurança | Segurança | Confidencialidade | Sim (inspeção do modelo: nenhum atributo de senha em texto puro) |
| RNF-002 | Segurança | Segurança | Confidencialidade / Integridade | Sim (inspeção da matriz e dos UC) |
| RNF-003 | Segurança | Segurança | Autenticidade | Sim (fluxo de autenticação nega conta bloqueada) |
| RNF-004 | Segurança | Segurança | Responsabilização (*accountability*) | Parcial — depende da lista de operações auditáveis (Q3-03) |
| RNF-005 | Segurança | Segurança | Confidencialidade | Sim |
| RNF-006 | Segurança | Segurança | Confidencialidade | Sim |
| RNF-007 | Confiabilidade | Confiabilidade / Segurança | Integridade (FK e restrições) | Sim, na Fase 7 (DER) |
| RNF-008 | Manutenibilidade | Manutenibilidade | Modularidade | Parcial — critério por inspeção, sem indicador |
| RNF-009 | Flexibilidade | Flexibilidade | Adaptabilidade / Escalabilidade | Parcial — depende da arquitetura (Fase 7) |
| RNF-010 | Desempenho | Eficiência de desempenho | Comportamento no tempo | **Não** — sem valor (Q3-02) |
| RNF-011 | Rastreabilidade | Manutenibilidade | Analisabilidade | Sim |
| RNF-012 | Rastreabilidade | Manutenibilidade | Analisabilidade | Sim (revisão cruzada) |

**Lacunas de cobertura do conjunto** (características selecionadas na Fase 2 sem RNF correspondente):

| Característica | Lacuna | Proposta (sem número; numeração cabe ao Integrante 1) |
|---|---|---|
| Compatibilidade | Nenhum RNF trata a integração com o Serviço Externo de E-mail (DEC-009) | "A plataforma deve se comunicar com o Serviço Externo de E-mail por uma interface própria, de modo que a troca do provedor não altere o domínio." — Q3-07 |
| Capacidade de interação | Nenhum RNF trata prevenção de erro do usuário no autoatendimento | "Antes de cancelar ou aceitar uma oferta de vaga, a operação deve exigir confirmação explícita do usuário e informar o efeito (liberação do horário / confirmação do agendamento)." — Q3-08 |
| Confiabilidade | Nenhum RNF trata consistência sob concorrência (dois pacientes no mesmo horário) | "A confirmação automática deve revalidar a disponibilidade no momento da gravação, de modo que dois agendamentos ativos nunca ocupem o mesmo horário (RN-005)." — Q3-09 |

> **Numeração:** `RNF-013` a `RNF-020` já identificam propostas técnicas do Integrante 4 (`04-persistencia/analises/README.md`). Se o grupo aceitar as propostas Q3-07 a Q3-09, o Integrante 1 deve conferir o último ID livre antes de numerar, como manda o `PLANEJAMENTO_AV3` §6.

## 7. Achados

| ID | Achado | Artefato | Responsável sugerido |
|---|---|---|---|
| Q3-01 | RF-021 sem história de usuário | `historias-usuario.md` | Integrante 1 |
| Q3-02 | RNF-010 sem métrica. Proposta para o grupo: critério de **inspeção** no nível de modelagem ("toda consulta de agenda acessa no máximo a agenda de um psicólogo e é atendida por índice sobre `psicologo` + data na persistência"), em vez de número de milissegundos sem base | `requisitos-nao-funcionais.md` | Integrante 1 + Integrante 4 |
| Q3-03 | "Operações relevantes/auditáveis" sem lista fechada (RF-032, RNF-004, RN-009; DUV-006) | `requisitos-funcionais.md`, `regras-negocio.md` | Grupo (o Integrante 5 sugere: toda mudança de situação de conta, cadastro, vínculo e agendamento, e toda operação administrativa) |
| Q3-04 | CA-RF-035 usa "poderá"; o critério não diz o que é obrigatório quando houver paciente elegível. Depende de `PG-04`, `PG-05` e `PG-09` | `criterios-aceite.md` | Integrante 1 após decisão do grupo |
| Q3-05 | RF-004 e RF-007 agrupam mais de uma capacidade; aceitável, mas os casos de uso devem tratar cada capacidade como passo distinto | `requisitos-funcionais.md` | Integrante 2 (nos UC) |
| Q3-06 | CA de segurança sem cenário de recusa (CA-RF-001, 013, 017, 022, 028) | `criterios-aceite.md` | Integrante 1 |
| Q3-07 | Falta RNF de compatibilidade para a integração de e-mail | `requisitos-nao-funcionais.md` | Integrante 1 (proposta) |
| Q3-08 | Falta RNF de capacidade de interação (prevenção de erro) | `requisitos-nao-funcionais.md` | Integrante 1 (proposta) |
| Q3-09 | Falta RNF de confiabilidade sob concorrência | `requisitos-nao-funcionais.md` | Integrante 1 (proposta) |
| Q3-10 | `02-requisitos/README.md` diz que o projeto "está na Fase 3"; o repositório já está na Fase 6 | `02-requisitos/README.md` | Integrante 1 |
| Q3-11 | `04-persistencia/impacto-requisitos.md` usa numeração própria de RF (ex.: "RF-006 — Agendamentos sem conflito"), divergente da baseline | `04-persistencia/impacto-requisitos.md` | Integrante 4 (já registrado no guia de transferência) |

## 8. Situação ao final da Fase 3

A baseline está **rastreável e consistente com as decisões aprovadas**; a verificabilidade é a característica mais fraca (RNF-010, lista de operações auditáveis e cenários negativos dos CA). Nenhum achado exige renumerar requisitos.
