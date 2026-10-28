# Regras de Negócio

As regras formalizam restrições operacionais identificadas no escopo e nas decisões. Regras sem parâmetros definidos estão marcadas como pendentes e não devem ser tratadas como decisão já aprovada.

**Atualização de 25/10/2026:** RN-012 e RN-013 foram revisadas conforme DEC-011 e DEC-017, e foram acrescentadas RN-020 a RN-022 (DEC-009, DEC-010 e DEC-016). Os identificadores **RN-015 a RN-019 não foram usados** aqui porque já identificam propostas técnicas do Integrante 4 em `04-persistencia/analises/`, ainda não incorporadas; reutilizá-los geraria referências ambíguas.

### RN-001 — Bloqueio de autenticação

**Regra:** Usuários bloqueados não podem autenticar-se.

**Atores/entidades envolvidos:** Usuário.

**Requisitos relacionados:** RF-001, RF-006.

**Justificativa:** Impedir acesso de contas bloqueadas.

### RN-002 — Proteção de senhas

**Regra:** O Administrador não pode visualizar senhas em texto puro; senhas não podem ser armazenadas ou disponibilizadas dessa forma.

**Atores/entidades envolvidos:** Administrador, usuário, credenciais.

**Requisitos relacionados:** RF-003, RF-010, RNF-001.

**Justificativa:** Preservar a confidencialidade das credenciais.

### RN-003 — Acesso profissional condicionado a vínculo

**Regra:** O Psicólogo somente pode acessar clientes/pacientes vinculados a ele por relação autorizada.

**Atores/entidades envolvidos:** Psicólogo, Cliente/Paciente, vínculo.

**Requisitos relacionados:** RF-017, RF-021, RF-031.

**Justificativa:** Restringir o acesso aos dados necessários à atuação autorizada.

### RN-004 — Acesso do paciente ao próprio cadastro

**Regra:** O Cliente/Paciente somente pode consultar informações relacionadas ao próprio cadastro e liberadas para seu acesso.

**Atores/entidades envolvidos:** Cliente/Paciente.

**Requisitos relacionados:** RF-022, RF-028.

**Justificativa:** Preservar a privacidade entre pacientes e limitar o autoatendimento.

### RN-005 — Exclusividade de horário ativo

**Regra:** Um mesmo horário de um Psicólogo não pode possuir dois agendamentos ativos incompatíveis.

**Atores/entidades envolvidos:** Psicólogo, disponibilidade, agendamento.

**Requisitos relacionados:** RF-023, RF-025, RF-026, RF-036.

**Justificativa:** Evitar conflitos na agenda.

### RN-006 — Agendamento cancelado

**Regra:** Um agendamento cancelado não pode posteriormente ser registrado como atendimento realizado.

**Atores/entidades envolvidos:** Agendamento, atendimento.

**Requisitos relacionados:** RF-027, RF-030.

**Justificativa:** Preservar consistência entre situação do agendamento e registro de atendimento.

### RN-007 — Vínculos obrigatórios do atendimento

**Regra:** Um atendimento registrado deve estar associado a um Psicólogo e a um Cliente/Paciente válidos, com vínculo autorizado.

**Atores/entidades envolvidos:** Psicólogo, Cliente/Paciente, atendimento, vínculo.

**Requisitos relacionados:** RF-021, RF-030, RF-031.

**Justificativa:** Manter contexto e autorização do registro conceitual de sessão.

### RN-008 — Consulta restrita à auditoria

**Regra:** Apenas usuários autorizados podem consultar registros de auditoria; no escopo atual, essa consulta cabe ao Administrador autorizado.

**Atores/entidades envolvidos:** Administrador, usuário, auditoria.

**Requisitos relacionados:** RF-013, RF-032.

**Justificativa:** Preservar a confidencialidade dos registros operacionais.

### RN-009 — Rastreabilidade de alterações relevantes

**Regra:** Alterações relevantes de situação devem preservar rastreabilidade por registro de auditoria.

**Atores/entidades envolvidos:** Usuário, situação cadastral, agendamento, auditoria.

**Requisitos relacionados:** RF-020, RF-026, RF-027, RF-032, RF-037.

**Justificativa:** Permitir identificar operações relevantes e seus responsáveis.

### RN-010 — Solicitação em horário disponível

**Regra:** Um Cliente/Paciente somente pode solicitar agendamento em horário que esteja disponível no momento da solicitação.

**Atores/entidades envolvidos:** Cliente/Paciente, Psicólogo, disponibilidade, agendamento.

**Requisitos relacionados:** RF-024, RF-025.

**Justificativa:** Evitar solicitações sobre horários indisponíveis.

### RN-011 — Disponibilidade na própria agenda

**Regra:** Um Psicólogo somente pode disponibilizar horários vinculados à própria agenda.

**Atores/entidades envolvidos:** Psicólogo, disponibilidade, agenda.

**Requisitos relacionados:** RF-023, RF-029.

**Justificativa:** Evitar alteração de disponibilidade pertencente a outro profissional.

### RN-012 — Permissão para cancelamento

**Regra:** Um agendamento na situação `Confirmado` somente pode ser cancelado pelo Cliente/Paciente titular ou pelo Psicólogo responsável pelo agendamento, e somente antes do horário marcado. O cancelamento libera o horário.

**Atores/entidades envolvidos:** Cliente/Paciente, Psicólogo, agendamento, disponibilidade.

**Requisitos relacionados:** RF-027, RF-035.

**Justificativa:** Garantir que apenas atores autorizados alterem a situação do agendamento (DEC-011).

**Decisão complementar (DEC-028):** não há antecedência mínima além de "antes do horário marcado" e o Administrador não cancela agendamentos.

### RN-013 — Confirmação automática de agendamento

**Regra:** O agendamento é confirmado automaticamente pelo sistema quando o horário estiver disponível e não houver conflito de agenda; não há aprovação manual por outro ator. Sem disponibilidade ou com conflito, o agendamento não é confirmado.

**Atores/entidades envolvidos:** Sistema, Cliente/Paciente, agendamento, disponibilidade.

**Requisitos relacionados:** RF-025, RF-026, RF-036.

**Justificativa:** Decisão DEC-017.

**Observação:** Não existe situação persistente `SOLICITADO` anterior à confirmação (DEC-016).

### RN-014 — Imutabilidade lógica de auditoria

**Regra:** Registros de auditoria devem ser cronológicos, rastreáveis e não devem ser alterados por operações comuns de consulta ou gestão.

**Atores/entidades envolvidos:** Auditoria, usuários autorizados.

**Requisitos relacionados:** RF-013, RF-032.

**Justificativa:** Preservar confiabilidade da trilha operacional, conforme escopo.

### RN-020 — Situações do agendamento

**Regra:** O agendamento assume as situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu`. `SOLICITADO` não é situação persistente: o agendamento já nasce `Confirmado`. `Cancelado`, `Realizado` e `Não compareceu` somente são atribuídos a agendamento `Confirmado`. `Não compareceu` é registrado pelo Psicólogo após o horário marcado, se o agendamento não tiver sido cancelado nem concluído.

**Atores/entidades envolvidos:** Agendamento.

**Requisitos relacionados:** RF-026, RF-027, RF-030, RF-037.

**Justificativa:** Decisões DEC-016 e DEC-025, que alinham requisitos, máquina de estados e persistência.

**Decisão complementar (DEC-030):** o registro só é permitido para agendamento `Confirmado` e leva o agendamento a `Realizado`.

### RN-021 — Oferta de horário da lista de espera

**Regra:** Um horário liberado por cancelamento pode ser oferecido a paciente da lista de espera do mesmo Psicólogo, desde que o paciente possua vínculo autorizado com ele. A oferta só se converte em agendamento se o paciente aceitar e o horário continuar disponível e sem conflito no momento do aceite (RN-005, RN-013).

**Atores/entidades envolvidos:** Cliente/Paciente, Psicólogo, lista de espera, disponibilidade, agendamento.

**Requisitos relacionados:** RF-027, RF-034, RF-035, RF-036.

**Justificativa:** Decisão DEC-010.

**Parâmetros (DEC-027):** fila por ordem de entrada; uma oferta por vez; prazo de aceite curto e configurável, com o horário reservado ao paciente; recusa ou ausência de resposta passa a oferta ao próximo; se ninguém aceitar, o horário volta a ficar livre; entrada por Psicólogo e horário específico; o cancelamento do Psicólogo também gera oferta.

### RN-022 — Eventos notificados por e-mail

**Regra:** A confirmação de agendamento, o cancelamento de agendamento e a oferta de vaga da lista de espera devem gerar solicitação de envio de e-mail ao Serviço Externo de E-mail. A mensagem não deve conter senhas nem informações clínicas.

**Atores/entidades envolvidos:** Sistema, Serviço Externo de E-mail, Cliente/Paciente, Psicólogo.

**Requisitos relacionados:** RF-026, RF-027, RF-033, RF-035.

**Justificativa:** Decisão DEC-009.

**Falha no envio (DEC-029):** não desfaz a operação de origem; é registrada na auditoria e o envio pode ser repetido.
