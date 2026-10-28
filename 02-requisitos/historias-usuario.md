# Histórias de Usuário

As histórias representam objetivos dos atores confirmados e estão ligadas a requisitos funcionais da Fase 3.

**Atualização de 25/10/2026:** revisadas HU-010, HU-011 e HU-012 conforme DEC-011 e DEC-017; acrescentadas HU-015 (lista de espera, DEC-010) e HU-016 (avisos por e-mail, DEC-009).

### HU-001 — Acesso à plataforma

Como Administrador, Psicólogo ou Cliente/Paciente,  
quero autenticar-me e encerrar minha sessão,  
para acessar a plataforma de forma controlada.

**Requisitos relacionados:** RF-001, RF-002, RF-006.

### HU-002 — Gerenciamento de usuários

Como Administrador,  
quero cadastrar, consultar, alterar, ativar e bloquear usuários,  
para controlar quem pode acessar a plataforma.

**Requisitos relacionados:** RF-003, RF-004, RF-005, RF-006, RF-010.

### HU-003 — Controle de perfis e permissões

Como Administrador,  
quero manter perfis e permissões,  
para limitar o acesso às funções conforme as responsabilidades autorizadas.

**Requisitos relacionados:** RF-007, RF-008, RF-009.

### HU-004 — Administração de psicólogos

Como Administrador,  
quero cadastrar e consultar psicólogos,  
para manter os cadastros profissionais da plataforma.

**Requisitos relacionados:** RF-011, RF-014.

### HU-005 — Administração de clientes/pacientes

Como Administrador,  
quero cadastrar, consultar, atualizar e alterar a situação de clientes/pacientes,  
para manter seus cadastros administrativos.

**Requisitos relacionados:** RF-012, RF-018, RF-019, RF-020.

### HU-006 — Manutenção profissional

Como Psicólogo,  
quero atualizar meu perfil e manter minhas áreas de atuação,  
para manter minhas informações profissionais disponíveis na plataforma.

**Requisitos relacionados:** RF-015, RF-016.

### HU-007 — Consulta de pacientes vinculados

Como Psicólogo,  
quero consultar os clientes/pacientes vinculados ao meu perfil,  
para acessar somente informações relacionadas à minha atuação autorizada.

**Requisitos relacionados:** RF-017, RN-003.

### HU-008 — Consulta do próprio cadastro

Como Cliente/Paciente,  
quero consultar informações liberadas do meu cadastro,  
para acompanhar meus próprios dados na plataforma.

**Requisitos relacionados:** RF-022.

### HU-009 — Disponibilidade profissional

Como Psicólogo,  
quero cadastrar períodos de disponibilidade na minha agenda,  
para informar horários que podem ser solicitados.

**Requisitos relacionados:** RF-023.

### HU-010 — Solicitação de agendamento

Como Cliente/Paciente,  
quero consultar horários disponíveis e solicitar um agendamento que seja confirmado automaticamente quando o horário estiver livre,  
para organizar meu atendimento de forma autônoma.

**Requisitos relacionados:** RF-024, RF-025, RF-026.

### HU-011 — Acompanhamento de agendamentos

Como Cliente/Paciente,  
quero consultar meus agendamentos e cancelá-los antes do horário marcado,  
para acompanhar e ajustar meus horários.

**Requisitos relacionados:** RF-027, RF-028.

**Decisão:** não há antecedência mínima além de "antes do horário" e o Administrador não cancela (DEC-028).

### HU-012 — Gestão da agenda profissional

Como Psicólogo,  
quero consultar minha agenda, acompanhar os agendamentos confirmados automaticamente, cancelar agendamentos antes do horário marcado e registrar quando o paciente não comparecer,  
para manter minha agenda atualizada.

**Requisitos relacionados:** RF-026, RF-027, RF-029, RF-037.

### HU-013 — Registro de sessão realizada

Como Psicólogo,  
quero registrar conceitualmente os atendimentos realizados e consultar o histórico permitido,  
para acompanhar sessões associadas aos pacientes vinculados.

**Requisitos relacionados:** RF-030, RF-031.

### HU-014 — Consulta de auditoria

Como Administrador autorizado,  
quero consultar registros de auditoria,  
para acompanhar operações relevantes da plataforma.

**Requisitos relacionados:** RF-013, RF-032.

### HU-015 — Lista de espera inteligente

Como Cliente/Paciente,  
quero entrar na lista de espera do meu Psicólogo e receber a oferta de um horário que for liberado por cancelamento,  
para conseguir atendimento mais cedo quando não houver horário disponível.

**Requisitos relacionados:** RF-034, RF-035, RF-036.

**Parâmetros da fila:** DEC-027.

### HU-016 — Avisos por e-mail

Como Cliente/Paciente ou Psicólogo,  
quero receber por e-mail a confirmação, o cancelamento e as ofertas de vaga,  
para saber das mudanças na agenda sem precisar acessar a plataforma.

**Requisitos relacionados:** RF-033.

**Falha no envio:** DEC-029.
