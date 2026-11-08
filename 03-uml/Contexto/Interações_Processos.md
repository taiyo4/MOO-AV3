1. Interações detalhadas por ator — decisão oficial do grupo
Administrador (confirmado)
-----------------------------------------------------------------------------------------------------------------
Gerencia usuários, perfis, permissões, psicólogos e clientes/pacientes. Consulta auditoria. Restrição: não pode visualizar senhas em texto puro. Como não há Atendente (DEC-007), também acumula o cadastro administrativo de paciente no dia a dia.

Psicólogo (confirmado)

Gerencia o próprio perfil profissional. Consulta pacientes vinculados. Gerencia disponibilidade e agenda. Registra atendimentos conceituais. Restrição: não tem acesso irrestrito a todos os pacientes — só aos vinculados a ele.

Paciente (confirmado — acesso autenticado limitado)

Responsabilidades permitidas: realizar login; consultar horários disponíveis; solicitar agendamento; consultar os próprios agendamentos; cancelar agendamento quando permitido; consultar somente informações disponibilizadas ao próprio usuário.

Restrições: não tem acesso a funções administrativas, informações de outros usuários, auditoria ou informações profissionais restritas.

Justificativa do grupo: permitir autoatendimento básico relacionado à agenda, sem conceder privilégios administrativos ou profissionais.

Serviço Externo de E-mail (DEC-009, DEC-022, DEC-029)

O sistema dispara notificação real por e-mail por meio de um ator secundário, o Serviço Externo de E-mail (DEC-009). A falha de envio não desfaz a operação (DEC-029).

Atendente — EXCLUÍDO (DEC-007)

Não será incluído no escopo desta fase do projeto. É um papel opcional; excluí-lo evita acréscimo desnecessário de requisitos, regras, casos de uso e permissões, mantendo o foco nos objetivos pedagógicos da AV3. Se o grupo decidir incluí-lo depois, isso vira uma nova decisão formal.

2. Processos de negócio candidatos
-----------------------------------------------------------------------------------------------------------------
Continuam válidos, independente da inovação (são baseados nos módulos obrigatórios do escopo mínimo, não na inovação):

Criar e editar perfil de psicólogo (CRP, área de atuação)
Definir e editar disponibilidade de horários
Cadastrar e editar paciente
Bloquear e desbloquear usuário
Gerenciar perfis e permissões
Consultar trilha de auditoria
Consultar histórico de atendimento

3. Validação dos módulos mínimos no diagrama de contexto
-----------------------------------------------------------------------------------------------------------------
Identidade e acesso — coberto via Administrador (login, perfis, permissões)
Administração — coberto via Administrador (painel, gestão de usuários/pacientes, auditoria)
Psicólogos — coberto via ator Psicólogo
Clientes/Pacientes — coberto diretamente via ator Paciente (login próprio)
Agenda — coberto via Psicólogo e via Paciente
Atendimento — coberto via Psicólogo
