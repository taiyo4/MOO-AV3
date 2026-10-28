# Fase 4 — Revisão de Qualidade dos Casos de Uso (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 4 — Casos de uso e especificações
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `03-uml/Casos de uso/` (diagrama UC-001 em `.drawio.xml` e `.pdf`, `especificacoes-casos-de-uso-criticos.md`, `especificacoes-casos-de-uso-demais.md`, `CasosDeUsoFuturo.md`); baseline `02-requisitos/` de 25/10/2026; `decisoes.md`.
**Referências:** barema §8 e §9 (regras 1 e 2); ISO/IEC/IEEE 29148:2018 (rastreabilidade requisito → caso de uso); ISO/IEC 19505-2 / UML 2 (`include`, `extend`, generalização).

---

## 1. Objetivo

Fazer a revisão cruzada de qualidade dos casos de uso: completude das especificações textuais, cobertura dos requisitos, uso correto dos relacionamentos UML e coerência com as decisões aprovadas depois da Fase 4 (DEC-009, DEC-010, DEC-011, DEC-016, DEC-017 e DEC-025).

## 2. Inventário verificado

| Caso de uso (nome no diagrama) | Especificação | Identificador |
|---|---|---|
| Autenticar-se | críticos | UC-001 |
| Vincular psicólogo a paciente | críticos | UC-021 |
| Agendar consulta | críticos | UC-025 |
| Gerenciar meus agendamentos (cancelamento) | críticos | UC-027 |
| Gerenciar usuários e permissões | demais | sem ID |
| Gerenciar psicólogos e pacientes | demais | sem ID |
| Consultar auditoria | demais | sem ID |
| Gerenciar perfil e agenda | demais | sem ID |
| Atender pacientes vinculados | demais | sem ID |
| Consultar meu cadastro | demais | sem ID |
| Registrar evento de auditoria («include») | demais | sem ID |
| Notificar por e-mail («include») | demais | sem ID |

Doze casos de uso no diagrama, doze especificações. A convenção de numeração `UC-0RF` está proposta em DEC-026 (aguardando o grupo); por isso os casos "demais" ainda não têm identificador.

## 3. Resultado 1 — Completude das especificações (barema §8)

| Elemento exigido | Críticos (4) | Demais (8) |
|---|---|---|
| Objetivo | **Ausente** como campo (inferível pelo nome) | **Ausente** como campo |
| Atores | 4/4 | 8/8 (os dois «include» declaram "sem ator próprio") |
| Pré-condição | 4/4 | 6/6 aplicáveis |
| Pós-condição | 4/4 | 6/6 aplicáveis |
| Fluxo principal | 4/4 | 8/8 |
| Fluxos alternativos | 2/4 com alternativo | 1/6 com alternativo |
| Exceções | 4/4 | 5/6 |
| Regras de negócio aplicadas | 4/4 | 8/8 |
| Linha "RFs cobertos" | **0/4** (achado R5-16 do Integrante 2) | 7/8 (Notificar por e-mail: "nenhum RF oficial ainda") |

## 4. Resultado 2 — Cobertura dos requisitos pelos casos de uso

| Situação | Requisitos |
|---|---|
| Cobertos por especificação | RF-001 a RF-027 (RF-002 como A1 de UC-001; RF-024 e RF-026 dentro de UC-025), RF-029 a RF-032 |
| **Sem caso de uso especificado** | **RF-028** (consultar os próprios agendamentos — aparece no diagrama como "Gerenciar meus agendamentos", sem passo próprio na especificação), **RF-033** (já existe o «include» "Notificar por e-mail", mas a especificação diz "nenhum RF oficial ainda"), **RF-034, RF-035, RF-036** (lista de espera, DEC-010) e **RF-037** (não comparecimento, DEC-025) |

Os seis requisitos sem caso de uso foram numerados em 25/10/2026, depois da Fase 4; a lacuna é de **propagação**, não de erro de origem. Mesmo assim, ela atinge a inovação (DEC-010), que o `PLANEJAMENTO_AV3` §6 regra 8 exige com "requisito, caso de uso, critérios de aceite, representação comportamental e modelo de persistência".

## 5. Resultado 3 — Relacionamentos UML

| Verificação | Resultado |
|---|---|
| `«include»` com semântica correta (comportamento obrigatório reutilizado) | **OK** — "Registrar evento de auditoria" e "Notificar por e-mail" são incluídos e não têm ator próprio |
| `«extend»` | **Ausente.** O barema §8 pede `include`/`extend` e generalizações **justificadas**; não é obrigatório usar `extend`, mas o dossiê precisa justificar a ausência ou modelar o caso natural: "Ofertar horário liberado à lista de espera" **estende** "Cancelar agendamento" (ocorre só sob condição — paciente elegível na lista) |
| Generalização de atores ou casos | **Ausente.** Justificável: os três atores não têm relação "é um" (DEC-006, OO-01/OO-02). O dossiê deve declarar essa justificativa |
| Atores do diagrama definidos na documentação (barema §9 regra 1) | **OK** — Administrador, Psicólogo, Paciente |
| Serviço Externo de E-mail no diagrama de casos de uso | **Ausente** como ator secundário, apesar de DEC-009 aprovada |

## 6. Resultado 4 — Coerência com as decisões aprovadas depois da Fase 4

| Texto da especificação | Decisão vigente | Situação |
|---|---|---|
| UC-025 E1: "Pendente (DEC-4): recusar em silêncio ou sugerir outro horário?" | DEC-017 / RN-013 / CA-RF-025: sem disponibilidade ou com conflito, nenhum agendamento é criado | **Desatualizado** — a recusa está decidida; "sugerir outro horário" não foi aprovado |
| UC-027: "DEC-5: não compareceu é manual ou automático" | DEC-025: o Psicólogo registra após o horário marcado | **Desatualizado** |
| UC-027: "DEC-012: prazo de antecedência mínimo" | DEC-011 aprovada ("antes do horário marcado"); 2 horas não aprovadas; prazo adicional em PG-02 | **Desatualizado** na redação, correto no efeito |
| UC-027 pré-condição "situação cancelável" | RN-012: somente `Confirmado` e antes do horário | **Impreciso** — deve citar `Confirmado` e o horário |
| "Notificar por e-mail" só para confirmação | DEC-009 / RN-022: confirmação, cancelamento e oferta de vaga | **Incompleto** — falta o «include» a partir do cancelamento e da oferta |

## 7. Achados

| ID | Achado | Responsável sugerido |
|---|---|---|
| Q4-01 | Especificações sem campo "Objetivo" (exigido pelo barema §8) | Integrante 2 |
| Q4-02 | Casos críticos sem "RFs cobertos" (confirma R5-16) | Integrante 2 |
| Q4-03 | RF-028, RF-033, RF-034, RF-035, RF-036 e RF-037 sem caso de uso especificado | Integrante 2 (com Integrante 1 para a numeração, DEC-026) |
| Q4-04 | Ausência de `«extend»` e de generalização sem justificativa escrita; candidato natural: oferta da lista de espera estende o cancelamento | Integrante 2 |
| Q4-05 | Serviço Externo de E-mail ausente do diagrama de casos de uso | Integrante 2 |
| Q4-06 | UC-025 e UC-027 citam pendências já resolvidas (DEC-4, DEC-5, DEC-012) | Integrante 2 |
| Q4-07 | Fluxos alternativos rasos nos casos "demais" (1 de 6 tem alternativo) — reduz a evidência de confiabilidade e capacidade de interação | Integrante 2 |
| Q4-08 | Casos "demais" sem identificador; a matriz depende de inferência (R5-17, DEC-026) | Grupo (DEC-026) |

## 8. Situação ao final da Fase 4

Especificações **estruturalmente adequadas** para os casos críticos, com campos obrigatórios presentes, exceto "Objetivo" e "RFs cobertos". A principal não conformidade de qualidade é a **ausência de caso de uso para a inovação e para RF-037**, que impede que esses requisitos cheguem aos diagramas comportamentais e à persistência.
