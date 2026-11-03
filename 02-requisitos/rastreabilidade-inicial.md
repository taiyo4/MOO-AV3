# Matriz de Rastreabilidade Inicial

Esta matriz conecta cada requisito funcional às regras de negócio aplicáveis, ator, caso de uso futuro e critério de aceite. Os nomes `UC-FUT-*` são identificadores de trabalho para o Integrante 2 confirmar ou substituir; não representam casos de uso ou diagramas já elaborados. Onde não há regra específica, usa-se RNF aplicável ou indica-se “—”.

**Atualização de 25/10/2026:** linhas RF-025 a RF-027 e RF-030 revisadas; linhas RF-033 a RF-037 acrescentadas; colunas de história de usuário e decisão incluídas. Linhas RF-025, RF-026 e RF-037 atualizadas após a resolução de PG-01 e PG-03. Pendências do grupo usam os identificadores `PG-xx` de `01-planejamento/decisoes.md`.

| Requisito | Regra relacionada | Ator | Caso de uso futuro | Critério de aceite | História | Decisão | Status |
|---|---|---|---|---|---|---|---|
| RF-001 | RN-001, RNF-002 | Administrador, Psicólogo, Cliente/Paciente | UC-FUT-001 — Autenticar usuário | CA-RF-001 | HU-001 | — | Para revisão |
| RF-002 | RNF-002 | Administrador, Psicólogo, Cliente/Paciente | UC-FUT-002 — Encerrar sessão | CA-RF-002 | HU-001 | — | Para revisão |
| RF-003 | RN-002 | Administrador | UC-FUT-003 — Cadastrar usuário | CA-RF-003 | HU-002 | — | Para revisão |
| RF-004 | RNF-002 | Administrador, Psicólogo, Cliente/Paciente conforme permissão | UC-FUT-004 — Alterar dados permitidos | CA-RF-004 | HU-002 | — | Para revisão |
| RF-005 | RNF-002 | Administrador | UC-FUT-005 — Ativar usuário | CA-RF-005 | HU-002 | — | Para revisão |
| RF-006 | RN-001 | Administrador | UC-FUT-006 — Bloquear usuário | CA-RF-006 | HU-001, HU-002 | — | Para revisão |
| RF-007 | RNF-002 | Administrador | UC-FUT-007 — Gerenciar perfis | CA-RF-007 | HU-003 | — | Para revisão |
| RF-008 | RNF-002 | Administrador | UC-FUT-008 — Gerenciar permissões | CA-RF-008 | HU-003 | — | Para revisão |
| RF-009 | RNF-002 | Administrador | UC-FUT-009 — Consultar painel administrativo | CA-RF-009 | HU-003 | — | Para revisão |
| RF-010 | RN-002 | Administrador | UC-FUT-010 — Consultar usuários | CA-RF-010 | HU-002 | — | Para revisão |
| RF-011 | — | Administrador | UC-FUT-011 — Consultar psicólogos | CA-RF-011 | HU-004 | — | Para revisão |
| RF-012 | RNF-002 | Administrador | UC-FUT-012 — Consultar pacientes | CA-RF-012 | HU-005 | — | Para revisão |
| RF-013 | RN-008, RN-014 | Administrador autorizado | UC-FUT-013 — Consultar auditoria | CA-RF-013 | HU-014 | — | Para revisão |
| RF-014 | — | Administrador | UC-FUT-014 — Cadastrar psicólogo | CA-RF-014 | HU-004 | — | Para revisão |
| RF-015 | RNF-002 | Psicólogo | UC-FUT-015 — Atualizar perfil profissional | CA-RF-015 | HU-006 | — | Para revisão |
| RF-016 | RNF-002 | Psicólogo, Administrador autorizado | UC-FUT-016 — Associar área de atuação | CA-RF-016 | HU-006 | — | Para revisão |
| RF-017 | RN-003, RNF-006 | Psicólogo | UC-FUT-017 — Consultar pacientes vinculados | CA-RF-017 | HU-007 | — | Para revisão |
| RF-018 | — | Administrador | UC-FUT-018 — Cadastrar cliente/paciente | CA-RF-018 | HU-005 | — | Para revisão |
| RF-019 | RNF-002 | Administrador | UC-FUT-019 — Atualizar cadastro de paciente | CA-RF-019 | HU-005 | — | Para revisão |
| RF-020 | RN-009 | Administrador | UC-FUT-020 — Alterar situação cadastral | CA-RF-020 | HU-005 | — | Para revisão |
| RF-021 | RN-003, RN-007 | Administrador | UC-FUT-021 — Formalizar vínculo | CA-RF-021 | — | — | Para revisão |
| RF-022 | RN-004, RNF-005 | Cliente/Paciente | UC-FUT-022 — Consultar próprio cadastro | CA-RF-022 | HU-008 | DEC-006 | Para revisão |
| RF-023 | RN-011 | Psicólogo | UC-FUT-023 — Cadastrar disponibilidade | CA-RF-023 | HU-009 | — | Para revisão |
| RF-024 | RN-010, RN-004 | Cliente/Paciente | UC-FUT-024 — Consultar horários disponíveis | CA-RF-024 | HU-010 | DEC-006 | Para revisão |
| RF-025 | RN-005, RN-010, RN-013 | Cliente/Paciente | UC-FUT-025 — Solicitar agendamento | CA-RF-025 | HU-010 | DEC-016, DEC-017 | Para revisão |
| RF-026 | RN-005, RN-013, RN-020, RN-022 | Sistema (automático) | UC-FUT-026 — Confirmar agendamento automaticamente | CA-RF-026 | HU-010, HU-012 | DEC-017, DEC-016 | Para revisão |
| RF-027 | RN-006, RN-009, RN-012, RN-020, RN-022 | Cliente/Paciente, Psicólogo | UC-FUT-027 — Cancelar agendamento | CA-RF-027 | HU-011, HU-012 | DEC-011, DEC-016, DEC-028 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-028 | RN-004, RNF-005 | Cliente/Paciente | UC-FUT-028 — Consultar próprios agendamentos | CA-RF-028 | HU-011 | DEC-006 | Para revisão |
| RF-029 | RN-003, RN-011 | Psicólogo | UC-FUT-029 — Consultar agenda própria | CA-RF-029 | HU-012 | — | Para revisão |
| RF-030 | RN-006, RN-007, RN-020 | Psicólogo | UC-FUT-030 — Registrar atendimento realizado | CA-RF-030 | HU-013 | DEC-016, DEC-030 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-031 | RN-003, RN-007 | Psicólogo | UC-FUT-031 — Consultar histórico permitido | CA-RF-031 | HU-013 | — | Para revisão |
| RF-032 | RN-009, RN-014, RNF-004 | Sistema, decorrente de ação dos atores | UC-FUT-032 — Registrar evento de auditoria | CA-RF-032 | HU-014 | — | Para revisão |
| RF-033 | RN-022 | Sistema; Serviço Externo de E-mail | UC-FUT-033 — Enviar notificação por e-mail | CA-RF-033 | HU-016 | DEC-009, DEC-029 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-034 | RN-003, RN-021 | Cliente/Paciente | UC-FUT-034 — Entrar na lista de espera | CA-RF-034 | HU-015 | DEC-010, DEC-027 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-035 | RN-012, RN-021, RN-022 | Sistema; Serviço Externo de E-mail | UC-FUT-035 — Ofertar horário liberado | CA-RF-035 | HU-015 | DEC-010, DEC-027 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-036 | RN-005, RN-013, RN-021 | Cliente/Paciente | UC-FUT-036 — Responder à oferta de vaga | CA-RF-036 | HU-015 | DEC-010, DEC-017, DEC-027 | Para revisão; pendências resolvidas em 28/10/2026 |
| RF-037 | RN-009, RN-020 | Psicólogo | UC-FUT-037 — Registrar não comparecimento | CA-RF-037 | HU-012 | DEC-016, DEC-025 | Para revisão |

## Pendências para fechar a rastreabilidade

- Integrante 2 deve confirmar nomes, fronteiras e atores dos casos de uso futuros. A matriz da Fase 5 já propõe `UC-033` (notificar por e-mail) e um único `UC-034` (encaixe em lista de espera); este último cobriria RF-034 a RF-036 e precisa ser conciliado com a convenção `UC-0RF` proposta em DEC-026.
- RF-021 não possui história de usuário própria (lacuna anterior a esta revisão).
- Todas as pendências do grupo foram resolvidas em 28/10/2026: DEC-027 (lista de espera, `PG-04` a `PG-09`), DEC-028 (cancelamento, `PG-02` e `PG-10`), DEC-029 (falha de e-mail, `PG-11`) e DEC-030 (atendimento e `Realizado`, `PG-12`). Falta propagar aos diagramas (ver `01-planejamento/`).
- Grupo deve selecionar quais eventos não administrativos também serão auditáveis (RF-032/RN-009).
