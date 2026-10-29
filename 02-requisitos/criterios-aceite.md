# Critérios de Aceite

Os critérios usam condições observáveis nos fluxos e artefatos de modelagem. Os comportamentos dependentes de decisão do grupo permanecem condicionados à resolução das pendências descritas nos próprios requisitos e em `PG-02` e `PG-04` a `PG-12` (`01-planejamento/decisoes.md`).

**Atualização de 25/10/2026:** revisados CA-RF-025, CA-RF-026, CA-RF-027 e CA-RF-030; acrescentados CA-RF-033 a CA-RF-037.

### CA-RF-001 — Autenticação válida

**Dado** um usuário cadastrado, ativo e com credenciais válidas,  
**quando** solicitar autenticação,  
**então** o sistema deverá permitir acesso somente às funções compatíveis com seu perfil e permissões.

### CA-RF-002 — Encerramento de sessão

**Dado** um usuário com sessão autenticada,  
**quando** solicitar encerramento,  
**então** a sessão deverá deixar de autorizar acesso às funções restritas.

### CA-RF-003 — Cadastro de usuário

**Dado** um Administrador autenticado e autorizado,  
**quando** cadastrar um usuário e associar perfil permitido,  
**então** o usuário deverá ser registrado com identificação própria sem exposição de senha em texto puro.

### CA-RF-004 — Alteração de dados de usuário

**Dado** um solicitante autenticado e autorizado para determinado conjunto de dados,  
**quando** alterar esses dados,  
**então** somente os campos permitidos deverão ser atualizados.

### CA-RF-005 — Ativação de usuário

**Dado** um usuário cadastrado e um Administrador autorizado,  
**quando** o Administrador ativar a conta,  
**então** a conta deverá ficar habilitada para autenticação, sujeita às permissões atribuídas.

### CA-RF-006 — Bloqueio de usuário

**Dado** um usuário cadastrado e um Administrador autorizado,  
**quando** o Administrador bloquear a conta,  
**então** o usuário não deverá conseguir iniciar autenticação.

### CA-RF-007 — Gerenciamento de perfis

**Dado** um Administrador autorizado,  
**quando** consultar ou manter um perfil de acesso,  
**então** a operação deverá respeitar as permissões administrativas e disponibilizar o perfil para associação autorizada.

### CA-RF-008 — Gerenciamento de permissões

**Dado** um perfil existente e um Administrador autorizado,  
**quando** atualizar as permissões do perfil,  
**então** autorizações subsequentes deverão considerar as permissões atualizadas sem ampliar os limites dos atores.

### CA-RF-009 — Painel administrativo

**Dado** um Administrador autenticado,  
**quando** acessar o painel administrativo,  
**então** deverá visualizar somente funções administrativas compatíveis com suas permissões.

### CA-RF-010 — Consulta de usuários

**Dado** um Administrador autorizado,  
**quando** consultar usuários cadastrados,  
**então** os dados cadastrais permitidos deverão ser apresentados sem revelar senhas em texto puro.

### CA-RF-011 — Consulta de psicólogos

**Dado** um Administrador autorizado,  
**quando** consultar psicólogos cadastrados,  
**então** o sistema deverá apresentar os dados profissionais permitidos.

### CA-RF-012 — Consulta de pacientes

**Dado** um Administrador autorizado,  
**quando** consultar clientes/pacientes cadastrados,  
**então** o sistema deverá apresentar dados cadastrais conforme suas permissões, sem conceder acesso a prontuário completo.

### CA-RF-013 — Consulta de auditoria

**Dado** um Administrador com permissão de auditoria,  
**quando** consultar registros,  
**então** os registros autorizados deverão ser apresentados sem alteração pela operação de consulta.

### CA-RF-014 — Cadastro de psicólogo

**Dado** um Administrador autorizado,  
**quando** cadastrar um Psicólogo,  
**então** deverá ser criado o registro profissional correspondente sem duplicar desnecessariamente a identidade de usuário.

### CA-RF-015 — Atualização de perfil profissional

**Dado** um Psicólogo autenticado com perfil profissional,  
**quando** atualizar dados profissionais liberados,  
**então** somente os dados de seu próprio perfil autorizados deverão ser alterados.

### CA-RF-016 — Associação de área de atuação

**Dado** um Psicólogo e uma área de atuação válidos,  
**quando** o Psicólogo ou Administrador autorizado efetuar a associação,  
**então** a área deverá constar no perfil profissional correspondente.

### CA-RF-017 — Consulta de pacientes vinculados

**Dado** um Psicólogo autenticado com vínculos autorizados,  
**quando** consultar clientes/pacientes,  
**então** o resultado deverá conter somente pacientes vinculados a esse Psicólogo.

### CA-RF-018 — Cadastro de cliente/paciente

**Dado** um Administrador autorizado,  
**quando** cadastrar um cliente/paciente,  
**então** o cadastro deverá ser registrado sem uso de dados reais nos artefatos do projeto.

### CA-RF-019 — Atualização administrativa de paciente

**Dado** um cadastro de paciente existente e um Administrador autorizado,  
**quando** atualizar dados cadastrais administrativos,  
**então** somente dados administrativos permitidos deverão ser alterados.

### CA-RF-020 — Alteração de situação cadastral

**Dado** um cliente/paciente cadastrado e um Administrador autorizado,  
**quando** alterar sua situação,  
**então** a nova situação deverá ser registrada e a operação relevante deverá ser rastreável.

### CA-RF-021 — Vínculo entre paciente e psicólogo

**Dado** um Psicólogo e um Cliente/Paciente cadastrados,  
**quando** um Administrador autorizado formalizar o vínculo,  
**então** o vínculo deverá ser registrado e considerado nas autorizações profissionais.

### CA-RF-022 — Consulta do próprio cadastro

**Dado** um Cliente/Paciente autenticado,  
**quando** consultar seu cadastro,  
**então** deverá receber somente informações próprias liberadas para visualização.

### CA-RF-023 — Cadastro de disponibilidade

**Dado** um Psicólogo autenticado,  
**quando** cadastrar disponibilidade,  
**então** o período deverá ser associado à própria agenda e considerado junto a conflitos existentes.

### CA-RF-024 — Consulta de horários disponíveis

**Dado** um Cliente/Paciente autenticado e vinculado ao Psicólogo,  
**quando** consultar horários,  
**então** serão exibidos horários disponíveis para solicitação e a consulta não deverá reservar nenhum deles.

### CA-RF-025 — Solicitação de agendamento

**Dado** um Cliente/Paciente autenticado, um Psicólogo vinculado e um horário disponível e sem conflito,  
**quando** solicitar o agendamento,  
**então** o agendamento deverá associar paciente, Psicólogo e horário e ficar na situação `Confirmado`, ocupando o horário.

**Dado** um horário indisponível ou em conflito,  
**quando** o Cliente/Paciente solicitar o agendamento,  
**então** nenhum agendamento confirmado deverá ser criado e o horário não deverá ser ocupado.

### CA-RF-026 — Confirmação automática de agendamento

**Dado** uma solicitação de agendamento ou um aceite de vaga para horário disponível e sem conflito,  
**quando** o sistema processar a solicitação,  
**então** o agendamento deverá passar a `Confirmado` sem ação manual de outro ator, sem criar conflito de horário, e o envio do e-mail de confirmação deverá ser solicitado.

**Dado** uma solicitação aceita,  
**quando** o agendamento for criado,  
**então** nenhuma situação `SOLICITADO` deverá ser registrada antes de `Confirmado`.

### CA-RF-027 — Cancelamento de agendamento

**Dado** um agendamento `Confirmado` cujo horário ainda não começou,  
**quando** o Cliente/Paciente titular ou o Psicólogo responsável solicitar o cancelamento,  
**então** a situação deverá passar a `Cancelado`, o horário deverá ser liberado, a operação deverá ser auditada, o envio do e-mail de cancelamento deverá ser solicitado e o agendamento não poderá ser registrado como atendimento realizado.

**Dado** um agendamento cujo horário marcado já começou,  
**quando** qualquer ator solicitar o cancelamento,  
**então** o cancelamento deverá ser recusado.

**Dado** um usuário que não é o paciente titular nem o Psicólogo do agendamento,  
**quando** solicitar o cancelamento,  
**então** o cancelamento deverá ser recusado.

**Dado** o Administrador,  
**quando** solicitar o cancelamento de um agendamento,  
**então** o cancelamento deverá ser recusado. Não há antecedência mínima além de "antes do horário marcado" (DEC-028).

### CA-RF-028 — Consulta dos próprios agendamentos

**Dado** um Cliente/Paciente autenticado,  
**quando** consultar seus agendamentos,  
**então** deverá visualizar somente os agendamentos associados ao próprio cadastro e suas situações.

### CA-RF-029 — Consulta da agenda do psicólogo

**Dado** um Psicólogo autenticado,  
**quando** consultar sua agenda,  
**então** deverá visualizar somente compromissos da própria agenda e informações compatíveis com seus vínculos autorizados.

### CA-RF-030 — Registro conceitual de atendimento

**Dado** um Psicólogo autenticado, vínculo autorizado e sessão válida,  
**quando** registrar a realização do atendimento,  
**então** o registro deverá associar Psicólogo e Cliente/Paciente válidos e não deverá representar prontuário completo.

**Dado** um agendamento `Confirmado`,  
**quando** o Psicólogo registrar o atendimento,  
**então** o agendamento deverá passar a `Realizado`; para agendamento em outra situação, o registro deverá ser recusado (DEC-030).

### CA-RF-031 — Consulta de histórico permitido

**Dado** um Psicólogo autenticado com vínculo autorizado,  
**quando** consultar histórico de atendimentos,  
**então** deverá visualizar apenas registros permitidos relacionados ao vínculo.

### CA-RF-032 — Registro de evento de auditoria

**Dado** uma operação classificada como relevante para auditoria,  
**quando** ela ocorrer,  
**então** deverá ser registrado usuário responsável, data, hora e operação em trilha cronológica e rastreável, sem incluir senhas em texto puro.

### CA-RF-033 — Notificação por e-mail

**Dado** a ocorrência de confirmação de agendamento, cancelamento de agendamento ou oferta de vaga da lista de espera,  
**quando** a operação for concluída,  
**então** o sistema deverá solicitar ao Serviço Externo de E-mail o envio da mensagem correspondente aos envolvidos, sem incluir senhas ou informações clínicas.

**Dado** uma falha no envio do e-mail,  
**quando** a operação de origem já tiver sido concluída,  
**então** a operação deverá ser mantida, a falha deverá ser registrada na auditoria e o envio poderá ser repetido (DEC-029).

### CA-RF-034 — Entrada na lista de espera

**Dado** um Cliente/Paciente autenticado e vinculado ao Psicólogo,  
**quando** solicitar entrada na lista de espera,  
**então** a entrada deverá ser registrada e associada ao paciente e ao Psicólogo.

**Dado** um Cliente/Paciente sem vínculo autorizado com o Psicólogo,  
**quando** solicitar entrada na lista de espera desse Psicólogo,  
**então** a entrada deverá ser recusada.

**Dado** um Cliente/Paciente na lista de espera,  
**quando** consultar a lista ou solicitar a saída,  
**então** o sistema deverá informar a sua posição e remover a entrada, respectivamente. A entrada é por Psicólogo e horário específico (DEC-027).

### CA-RF-035 — Oferta de horário liberado

**Dado** um cancelamento que libera horário ainda não iniciado e um paciente elegível na lista de espera do mesmo Psicólogo,  
**quando** o horário for liberado,  
**então** o sistema poderá registrar a oferta e solicitar o envio do e-mail de oferta, sem criar agendamento confirmado apenas pela oferta.

**Dado** vários pacientes na lista para o horário liberado,  
**quando** a oferta for feita,  
**então** ela deverá ir a um paciente por vez, na ordem de entrada, inclusive quando o cancelamento for do Psicólogo (DEC-027).

### CA-RF-036 — Resposta à oferta de vaga

**Dado** um paciente com oferta válida e o horário ainda disponível e sem conflito,  
**quando** aceitar a oferta,  
**então** o agendamento deverá ser confirmado automaticamente.

**Dado** um paciente com oferta válida e o horário já ocupado ou em conflito,  
**quando** aceitar a oferta,  
**então** nenhum agendamento deverá ser criado.

**Dado** um paciente com oferta válida,  
**quando** recusar a oferta,  
**então** a recusa deverá ser registrada.

**Dado** uma oferta sem resposta dentro do prazo, ou recusada,  
**quando** o prazo terminar ou a recusa for registrada,  
**então** o paciente deverá perder a vez e a oferta deverá passar ao próximo da fila; se ninguém aceitar, o horário voltará a ficar livre (DEC-027).

### CA-RF-037 — Registro de não comparecimento

**Dado** um agendamento `Confirmado` cujo horário marcado já passou,  
**quando** o Psicólogo responsável registrar o não comparecimento,  
**então** a situação deverá passar a `Não compareceu` e a operação deverá ser auditada.

**Dado** um agendamento `Cancelado` ou `Realizado`, ou um agendamento cujo horário ainda não passou,  
**quando** o Psicólogo tentar registrar o não comparecimento,  
**então** o registro deverá ser recusado.

**Dado** um usuário que não é o Psicólogo responsável pelo agendamento,  
**quando** tentar registrar o não comparecimento,  
**então** o registro deverá ser recusado.
