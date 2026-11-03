# Especificações dos casos de uso críticos

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Versão:** v1.1 (29/10/2026) — acrescentados **Objetivo** e **RFs cobertos** (P5 / DEC-026) e atualizadas as pendências das DEC-016, DEC-025, DEC-028 e DEC-029. Os fluxos, atores e regras originais foram preservados; só foram corrigidos os pontos que contrariavam decisão aprovada.
**Numeração (DEC-026):** `UC-0RF` — o número do caso é o número do requisito.
**Natureza:** artefato oficial do grupo (Fase 4), revisado pelo dono na Fase 9.

---

UC-001 — Autenticar usuário
--------------------------------------------------------------------------------------------------------
Atores: Administrador, Psicólogo, Paciente

**Objetivo:** permitir que Administrador, Psicólogo e Paciente entrem no sistema com credenciais próprias e recebam apenas as permissões do seu perfil.

**RFs cobertos:** RF-001, RF-002.

Pré-condição: Usuário possui conta cadastrada e ativa.

Pós-condição (sucesso): Sessão autenticada é criada, com acesso restrito às funções compatíveis com o perfil do usuário.

Fluxo principal:

Usuário informa credenciais (e-mail e senha).
Sistema valida se a conta existe e está ativa.
Sistema valida se a senha confere.
Sistema cria a sessão autenticada, vinculada ao perfil e permissões do usuário.

Fluxos alternativos:

A1 (RF-002): usuário solicita encerramento de sessão a qualquer momento — sistema invalida a sessão ativa.

Exceções:

E1: credenciais inválidas — sistema recusa o acesso e não cria sessão (RF-001).
E2: conta bloqueada — sistema recusa o acesso mesmo com credenciais corretas (RN-001).

Regras de negócio aplicadas: RN-001 (bloqueio de autenticação), RN-002 (proteção de senhas — nunca exibidas em texto puro).

UC-021 — Vincular psicólogo a paciente
--------------------------------------------------------------------------------------------------------
Ator: Administrador

**Objetivo:** formalizar o vínculo autorizado entre Psicólogo e Paciente, que é a condição de acesso profissional aos dados do paciente (RN-003).

**RFs cobertos:** RF-021.

Pré-condição: Psicólogo e Paciente já cadastrados no sistema.

Pós-condição (sucesso): Vínculo registrado; Psicólogo passa a ter acesso autorizado aos dados do Paciente.

Fluxo principal:

Administrador seleciona um Psicólogo cadastrado.
Administrador seleciona um Paciente cadastrado.
Sistema formaliza o vínculo entre os dois.
Sistema inclui o evento na trilha de auditoria (<<include>> UC "Registrar evento de auditoria").

Fluxos alternativos: nenhum identificado até o momento.

Exceções:

E1: psicólogo ou paciente não encontrado/inválido — sistema recusa a operação.

Regras de negócio aplicadas: RN-003 (acesso profissional condicionado a vínculo), RN-007 (vínculos obrigatórios do atendimento).

Pendência aberta: DUV-003 — o que acontece com agendamentos futuros se esse vínculo for desfeito depois. Ainda sem regra definida.

UC-025 — Solicitar agendamento (com confirmação automática)
--------------------------------------------------------------------------------------------------------
Ator: Paciente

**Objetivo:** permitir que o Paciente vinculado reserve um horário disponível, com confirmação automática e aviso por e-mail.

**RFs cobertos:** RF-024, RF-025, RF-026, RF-032, RF-033, RF-034.

Pré-condição: Paciente autenticado e vinculado a um Psicólogo; Psicólogo já cadastrou disponibilidade de horários (UC-023).

Pós-condição (sucesso): Agendamento criado e automaticamente confirmado (`CONFIRMADO`); envio do e-mail de confirmação **solicitado** — a falha de envio não desfaz o agendamento e é auditada (DEC-029).

Fluxo principal:

Paciente consulta horários disponíveis do Psicólogo vinculado (UC-024).
Paciente seleciona um horário disponível e solicita o agendamento.
Sistema valida que o horário ainda está disponível (RN-005, RN-010).
Sistema cria o agendamento com situação confirmada automaticamente — não há etapa de aprovação manual por outro ator, já que o horário só está visível por já ter sido liberado pelo Psicólogo.
Sistema inclui o envio do e-mail de confirmação ao Paciente (`<<include>>` **UC-033** — RF-033; fronteira `ServicoEnvioMensagem`, DEC-009/DEC-022).

Fluxos alternativos:

A1 (RF-034): nenhum horário disponível para o Psicólogo vinculado — sistema informa e oferece a **lista de espera** (UC-034, DEC-027).

Exceções:

E1 — conflito de horário: paciente tenta solicitar um horário que deixou de estar disponível entre a consulta (passo 1) e a solicitação (passo 2). **Resolvido:** o sistema recusa a reserva, informa "horário indisponível" com mensagem de negócio (não erro técnico) e sugere outro horário (CA-RF-025; SEQ-002, ramo E1).

Regras de negócio aplicadas: RN-005 (exclusividade de horário ativo), RN-010 (solicitação em horário disponível).

UC-027 — Cancelar agendamento
--------------------------------------------------------------------------------------------------------
Atores: Paciente, Psicólogo (DEC-011)

**Objetivo:** permitir que o Paciente titular ou o Psicólogo responsável cancele um agendamento **antes do horário marcado**, liberando o horário e avisando por e-mail.

**RFs cobertos:** RF-027, RF-032, RF-033, RF-035, RF-037.

Pré-condição: Agendamento existente, em situação cancelável (`CONFIRMADO` e horário ainda não iniciado).

Pós-condição (sucesso): Situação do agendamento alterada para `CANCELADO`, horário liberado, operação auditada e envio do e-mail de cancelamento solicitado; agendamento cancelado não pode depois ser registrado como atendimento realizado (RN-006).

Fluxo principal:

Ator (Paciente ou Psicólogo) seleciona um agendamento próprio/vinculado.
Ator solicita o cancelamento.
Sistema valida se o agendamento está em situação cancelável.
Sistema altera a situação para cancelado.
Sistema registra a operação na auditoria (RN-009).

Justificativa do Psicólogo como ator (registrada pelo grupo): o psicólogo precisa poder cancelar para os casos em que algo impeça o atendimento da parte dele.

Fluxos alternativos:

A1 (RF-035): se houver fila de espera para o horário liberado, o sistema oferta a vaga ao primeiro da fila (UC-035, `<<extend>>`, DEC-027).

Exceções:

E1: agendamento já realizado ou já cancelado — sistema recusa novo cancelamento.

Regras de negócio aplicadas: RN-006 (agendamento cancelado), RN-012 (permissão para cancelamento).

Pendências **resolvidas** em 29/10/2026:

DEC-012 (prazo mínimo de 2 horas para cancelar) — **não adotada**: a guarda é apenas `[antes do horário marcado]`, sem antecedência mínima (DEC-011 + DEC-028). O Administrador **não** cancela (CA-RF-027).
DEC-5 ("não compareceu" manual ou automático) — **manual**: o Psicólogo registra depois do horário marcado, e só a partir de `CONFIRMADO` (DEC-025; UC-037; EST-001, T3).
