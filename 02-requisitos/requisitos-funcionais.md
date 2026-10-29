# Requisitos Funcionais

Os requisitos abaixo derivam do escopo e das decisões registradas na Fase 2. Prioridades indicam importância para o escopo mínimo da plataforma, não ordem de implementação. Ações administrativas devem respeitar permissões autorizadas. A integração externa e a inovação permanecem pendentes e não possuem RF definido.

## 1. Identidade e Acesso

### RF-001 — Autenticar usuário

**Descrição:** O sistema deverá permitir que usuários cadastrados e ativos realizem autenticação utilizando suas credenciais.

**Ator(es):** Administrador, Psicólogo e Cliente/Paciente.

**Prioridade:** Alta.

**Pré-condições:** O usuário deve estar cadastrado e ativo.

**Pós-condições:** O usuário autenticado poderá acessar somente funções compatíveis com seu perfil e suas permissões.

**Dependências:** Cadastro de usuário, perfil e permissões.

**Observações:** Usuários bloqueados não obtêm acesso.

### RF-002 — Encerrar sessão

**Descrição:** O sistema deverá permitir que um usuário autenticado encerre sua sessão.

**Ator(es):** Administrador, Psicólogo e Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** Deve existir uma sessão autenticada.

**Pós-condições:** A sessão encerrada não poderá continuar autorizando acesso às funções restritas.

**Dependências:** RF-001.

**Observações:** O comportamento técnico de expiração de sessão será detalhado em etapa posterior.

### RF-003 — Cadastrar usuário

**Descrição:** O sistema deverá permitir que o Administrador cadastre usuários para acesso à plataforma e associe os perfis autorizados.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** O usuário deverá estar registrado com identificação própria e perfil associado conforme autorização.

**Dependências:** RF-007.

**Observações:** O cadastro não poderá expor nem armazenar senha em texto puro.

### RF-004 — Alterar dados de usuário

**Descrição:** O sistema deverá permitir a alteração de dados cadastrais de usuários por Administrador autorizado e a alteração dos dados próprios que forem disponibilizados ao usuário autenticado.

**Ator(es):** Administrador, Psicólogo e Cliente/Paciente, dentro das respectivas permissões.

**Prioridade:** Média.

**Pré-condições:** O usuário alvo deve existir; o solicitante deve estar autenticado e autorizado para os dados pretendidos.

**Pós-condições:** Os dados permitidos deverão refletir as alterações autorizadas.

**Dependências:** RF-001, RF-008.

**Observações:** A alteração de perfil profissional é especificada em RF-015; o cadastro administrativo de paciente, em RF-019.

### RF-005 — Ativar usuário

**Descrição:** O sistema deverá permitir que um Administrador autorizado ative uma conta de usuário.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O usuário deve estar cadastrado e o Administrador autorizado.

**Pós-condições:** A conta ficará habilitada para autenticação, sujeita às demais regras de acesso.

**Dependências:** RF-003, RF-008.

**Observações:** Ativação não concede permissões além das atribuídas ao perfil.

### RF-006 — Bloquear usuário

**Descrição:** O sistema deverá permitir que um Administrador autorizado bloqueie uma conta de usuário.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O usuário deve estar cadastrado e o Administrador autorizado.

**Pós-condições:** A conta bloqueada não poderá iniciar autenticação.

**Dependências:** RF-003, RF-008.

**Observações:** O efeito sobre sessões já abertas deverá ser especificado na etapa de qualidade/segurança.

### RF-007 — Gerenciar perfis

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem, cadastrem, alterem e mantenham os perfis de acesso da plataforma.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** Os perfis mantidos ficarão disponíveis para associação autorizada a usuários.

**Dependências:** RF-001, RF-008.

**Observações:** Um perfil agrupa responsabilidades e permissões; esta operação não concede acesso administrativo automaticamente a outros atores.

### RF-008 — Gerenciar permissões

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem e mantenham as permissões associadas aos perfis.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado; o perfil alvo deve existir.

**Pós-condições:** As permissões atualizadas deverão ser consideradas nas autorizações subsequentes.

**Dependências:** RF-007.

**Observações:** O sistema deverá preservar as restrições de acesso definidas para cada ator.

## 2. Administração

### RF-009 — Consultar painel administrativo

**Descrição:** O sistema deverá disponibilizar ao Administrador autorizado um painel central com acesso às funções administrativas contempladas no escopo.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** As opções exibidas deverão respeitar as permissões do Administrador.

**Dependências:** RF-001, RF-008.

**Observações:** Indicadores ou relatórios não especificados no escopo não são presumidos.

### RF-010 — Consultar usuários cadastrados

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem os usuários cadastrados.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** Serão exibidos somente dados cadastrais permitidos; credenciais não serão exibidas em texto puro.

**Dependências:** RF-003, RF-008.

**Observações:** Consulta não implica permissão para alterar dados.

### RF-011 — Consultar psicólogos cadastrados

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem os psicólogos cadastrados.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** Os dados profissionais permitidos serão apresentados ao Administrador.

**Dependências:** RF-014, RF-008.

**Observações:** Não amplia o acesso do Psicólogo aos cadastros globais.

### RF-012 — Consultar clientes/pacientes cadastrados

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem os cadastros de clientes/pacientes.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** Os dados cadastrais serão apresentados conforme as permissões aplicáveis.

**Dependências:** RF-018, RF-008.

**Observações:** Consulta administrativa não concede acesso profissional ao histórico de atendimento.

### RF-013 — Consultar registros de auditoria

**Descrição:** O sistema deverá permitir que Administradores autorizados consultem os registros de auditoria.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e possuir permissão para auditoria.

**Pós-condições:** Os registros autorizados serão apresentados sem permitir alteração por meio desta consulta.

**Dependências:** RF-032, RF-008.

**Observações:** Cliente/Paciente e Psicólogo não possuem acesso à auditoria administrativa.

## 3. Psicólogos

### RF-014 — Cadastrar psicólogo

**Descrição:** O sistema deverá permitir que um Administrador autorizado cadastre um psicólogo na plataforma.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** O psicólogo deverá constar no cadastro profissional da plataforma.

**Dependências:** RF-003.

**Observações:** O cadastro profissional e a conta de acesso são conceitos relacionados, mas suas informações não devem ser duplicadas sem necessidade.

### RF-015 — Atualizar perfil profissional

**Descrição:** O sistema deverá permitir que um Psicólogo atualize os dados de seu próprio perfil profissional que estejam liberados para manutenção.

**Ator(es):** Psicólogo.

**Prioridade:** Média.

**Pré-condições:** O Psicólogo deve estar autenticado e possuir perfil profissional cadastrado.

**Pós-condições:** Os dados profissionais permitidos deverão refletir as alterações.

**Dependências:** RF-014, RF-008.

**Observações:** A definição dos campos editáveis deverá ser detalhada na modelagem, sem incluir dados reais nos exemplos.

### RF-016 — Associar área de atuação ao psicólogo

**Descrição:** O sistema deverá permitir a associação de uma ou mais áreas de atuação ao perfil do Psicólogo, pelo próprio profissional ou por Administrador autorizado.

**Ator(es):** Psicólogo, Administrador.

**Prioridade:** Média.

**Pré-condições:** O perfil do Psicólogo e a área de atuação devem existir; o solicitante deve estar autorizado.

**Pós-condições:** A associação autorizada deverá constar no perfil profissional.

**Dependências:** RF-014, RF-015, RF-008.

**Observações:** A manutenção de um catálogo de áreas não está detalhada nas decisões atuais e requer definição se for necessária.

### RF-017 — Consultar clientes/pacientes vinculados

**Descrição:** O sistema deverá permitir que o Psicólogo consulte clientes/pacientes com vínculo autorizado com seu perfil.

**Ator(es):** Psicólogo.

**Prioridade:** Alta.

**Pré-condições:** O Psicólogo deve estar autenticado.

**Pós-condições:** Serão apresentados apenas os clientes/pacientes vinculados ao Psicólogo.

**Dependências:** RF-021.

**Observações:** É vedado o acesso ao cadastro global de pacientes sem vínculo autorizado.

## 4. Clientes/Pacientes

### RF-018 — Cadastrar cliente/paciente

**Descrição:** O sistema deverá permitir que um Administrador autorizado cadastre um cliente/paciente.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O Administrador deve estar autenticado e autorizado.

**Pós-condições:** O cadastro do cliente/paciente deverá estar registrado.

**Dependências:** RF-003.

**Observações:** Não utilizar dados reais de pacientes em artefatos ou exemplos.

### RF-019 — Atualizar cadastro administrativo de cliente/paciente

**Descrição:** O sistema deverá permitir que um Administrador autorizado atualize os dados cadastrais administrativos de um cliente/paciente.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O cadastro deve existir e o Administrador deve estar autorizado.

**Pós-condições:** Os dados administrativos autorizados deverão refletir as alterações.

**Dependências:** RF-018, RF-008.

**Observações:** Não inclui prontuário clínico completo nem notas profissionais restritas.

### RF-020 — Alterar situação do cliente/paciente

**Descrição:** O sistema deverá permitir que um Administrador autorizado altere a situação cadastral de um cliente/paciente.

**Ator(es):** Administrador.

**Prioridade:** Média.

**Pré-condições:** O cadastro deve existir e o Administrador deve estar autorizado.

**Pós-condições:** A situação cadastral deverá refletir a alteração autorizada.

**Dependências:** RF-018, RF-032.

**Observações:** Os estados cadastrais válidos ainda devem ser definidos pelo grupo.

### RF-021 — Vincular cliente/paciente a psicólogo

**Descrição:** O sistema deverá permitir que um Administrador autorizado formalize o vínculo entre um cliente/paciente e um Psicólogo.

**Ator(es):** Administrador.

**Prioridade:** Alta.

**Pré-condições:** O cliente/paciente e o Psicólogo devem estar cadastrados; o Administrador deve estar autorizado.

**Pós-condições:** O vínculo deverá ser considerado nas consultas e autorizações profissionais.

**Dependências:** RF-014, RF-018, RF-008.

**Observações:** As condições de encerramento do vínculo precisam ser definidas pelo grupo antes de detalhar transições.

### RF-022 — Consultar informações do próprio cadastro

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado consulte as informações liberadas de seu próprio cadastro.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** O Cliente/Paciente deve estar autenticado.

**Pós-condições:** Serão apresentadas somente informações disponibilizadas ao próprio usuário.

**Dependências:** RF-001, RF-018, RF-008.

**Observações:** É vedado consultar dados de outros pacientes ou informações profissionais restritas.

## 5. Agenda

### RF-023 — Cadastrar disponibilidade do psicólogo

**Descrição:** O sistema deverá permitir que um Psicólogo cadastre períodos de disponibilidade em sua própria agenda.

**Ator(es):** Psicólogo.

**Prioridade:** Alta.

**Pré-condições:** O Psicólogo deve estar autenticado e possuir perfil profissional.

**Pós-condições:** Os períodos cadastrados poderão ser considerados na consulta de horários, respeitando conflitos e agendamentos existentes.

**Dependências:** RF-014, RF-008.

**Observações:** Regras detalhadas de recorrência e fuso horário não foram definidas na Fase 2.

### RF-024 — Consultar horários disponíveis

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado consulte horários disponíveis do Psicólogo vinculado.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Alta.

**Pré-condições:** O Cliente/Paciente deve estar autenticado e possuir vínculo autorizado com o Psicólogo consultado.

**Pós-condições:** Serão apresentados horários que constem como disponíveis para solicitação.

**Dependências:** RF-021, RF-023.

**Observações:** A consulta não reserva o horário.

### RF-025 — Solicitar agendamento

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado solicite um agendamento em horário disponível com Psicólogo vinculado.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Alta.

**Pré-condições:** O Cliente/Paciente deve estar autenticado, vinculado ao Psicólogo e selecionar horário disponível.

**Pós-condições:** A solicitação deverá ser registrada com Cliente/Paciente, Psicólogo, horário e situação `CONFIRMADO`, ocupando imediatamente o horário.

**Dependências:** RF-021, RF-024.

**Observações:** O agendamento **já nasce `CONFIRMADO`**: não existe situação `SOLICITADO` nem aprovação manual de outro ator (RN-013, DEC-017). A criação ocupa o horário (RN-005, RN-010).

### RF-026 — Confirmar agendamento

**Descrição:** O sistema deverá confirmar o agendamento no **mesmo ato** da solicitação, por mecanismo autorizado pela regra, sem etapa de aprovação manual.

**Ator(es):** Sistema (mecanismo autorizado, RN-013).

**Prioridade:** Alta.

**Pré-condições:** Deve existir solicitação de agendamento com horário ainda disponível.

**Pós-condições:** A situação do agendamento deverá ser `CONFIRMADO`, preservando a associação entre Cliente/Paciente, Psicólogo e horário.

**Dependências:** RF-025.

**Observações:** A confirmação não é um estado intermediário: ela é o estado inicial do agendamento. Por isso não há transição `SOLICITADO → CONFIRMADO` no EST-001 (revisão da Fase 6).

### RF-027 — Cancelar agendamento

**Descrição:** O sistema deverá permitir que o Cliente/Paciente cancele agendamento próprio quando permitido; outras possibilidades de cancelamento dependem das permissões e regras aprovadas.

**Ator(es):** Cliente/Paciente (titular) e Psicólogo vinculado (DEC-011); Administrador apenas em operação corretiva, com motivo registrado.

**Prioridade:** Alta.

**Pré-condições:** O agendamento deve pertencer ao solicitante ou o ator deve ter autorização; deve estar `CONFIRMADO` e o horário marcado ainda não pode ter começado.

**Pós-condições:** A situação do agendamento deverá ser alterada para `CANCELADO`, o horário deverá ser liberado, a operação auditada e o interessado notificado; não poderá ser registrada como atendimento realizado.

**Dependências:** RF-025, RF-026.

**Observações:** A guarda é **"antes do horário marcado"** — **não existe prazo de 2 horas** (revisão da Fase 6). Após o início, o compromisso só pode terminar como `REALIZADO` ou `NAO_COMPARECEU`. O cancelamento é o gatilho da oferta de vaga (RF-035, `<<extend>>`).

### RF-028 — Consultar os próprios agendamentos

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado consulte seus próprios agendamentos e suas situações.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Alta.

**Pré-condições:** O Cliente/Paciente deve estar autenticado.

**Pós-condições:** Serão apresentados somente agendamentos do próprio Cliente/Paciente.

**Dependências:** RF-025.

**Observações:** Não permite consultar agendamentos de outros pacientes.

### RF-029 — Consultar agenda do psicólogo

**Descrição:** O sistema deverá permitir que um Psicólogo autenticado consulte sua própria agenda de atendimentos e horários marcados.

**Ator(es):** Psicólogo.

**Prioridade:** Alta.

**Pré-condições:** O Psicólogo deve estar autenticado.

**Pós-condições:** Serão apresentados os compromissos associados à sua agenda, respeitando os vínculos autorizados.

**Dependências:** RF-023, RF-025.

**Observações:** Não concede acesso a agendas de outros Psicólogos.

## 6. Atendimento

### RF-030 — Registrar conceitualmente um atendimento

**Descrição:** O sistema deverá permitir que um Psicólogo registre conceitualmente a realização de um atendimento associado a si próprio e a um Cliente/Paciente vinculado.

**Ator(es):** Psicólogo.

**Prioridade:** Alta.

**Pré-condições:** O Psicólogo deve estar autenticado, o vínculo deve ser autorizado e o atendimento deve corresponder a uma sessão válida da agenda.

**Pós-condições:** O atendimento realizado deverá estar registrado com associação ao Psicólogo e ao Cliente/Paciente válidos.

**Dependências:** RF-017, RF-021, RF-029.

**Observações:** Registro conceitual não significa prontuário clínico completo; não incluir conteúdo clínico aprofundado.

### RF-031 — Consultar histórico permitido de atendimentos

**Descrição:** O sistema deverá permitir que o Psicólogo consulte o histórico permitido de atendimentos relacionados aos clientes/pacientes vinculados.

**Ator(es):** Psicólogo.

**Prioridade:** Média.

**Pré-condições:** O Psicólogo deve estar autenticado e possuir vínculo autorizado com o Cliente/Paciente.

**Pós-condições:** Serão apresentados somente registros permitidos associados ao Psicólogo e ao vínculo.

**Dependências:** RF-030, RF-021.

**Observações:** Cliente/Paciente não acessa notas técnicas ou registros profissionais restritos; o conteúdo e limites do histórico devem ser detalhados pelo grupo.

## 7. Auditoria

### RF-032 — Registrar evento de auditoria

**Descrição:** O sistema deverá registrar cronologicamente operações administrativas e outras operações relevantes definidas como auditáveis, identificando o usuário responsável, data, hora e operação.

**Ator(es):** Sistema (registro decorrente de ações de Administrador, Psicólogo ou Cliente/Paciente).

**Prioridade:** Alta.

**Pré-condições:** Deve ocorrer uma operação classificada como relevante para auditoria.

**Pós-condições:** Um registro de auditoria deverá ser acrescentado e permanecer rastreável.

**Dependências:** RF-001, operações auditáveis a definir.

**Observações:** O escopo define registro cronológico e imutável; eventos além das operações administrativas compulsórias devem ser selecionados pelo grupo. Nenhum segredo ou senha em texto puro deve constar no registro.

## 8. Notificações, lista de espera e não comparecimento

> **Origem deste bloco (Fase 6):** o grupo fechou as pendências DEC-009 (canal de notificação),
> DEC-022 (nome único da fronteira de envio) e DEC-027 (regras da lista de espera). Os requisitos
> abaixo formalizam o que os diagramas comportamentais já desenham. A numeração continua a série
> oficial (RF-033 a RF-037) e cada um recebe um caso de uso com o mesmo número (DEC-026).

### RF-033 — Notificar os interessados por e-mail

**Descrição:** O sistema deverá enviar mensagem por e-mail ao interessado sempre que ocorrer **confirmação de agendamento**, **cancelamento de agendamento** ou **oferta de vaga** proveniente da lista de espera.

**Ator(es):** Sistema (envio decorrente de ação de Paciente, Psicólogo ou do próprio sistema), por meio do Serviço Externo de E-mail.

**Prioridade:** Alta.

**Pré-condições:** A operação de agenda correspondente (RF-025, RF-027 ou RF-035) deve ter sido concluída com sucesso; o destinatário deve possuir endereço de e-mail cadastrado.

**Pós-condições:** A mensagem correspondente deverá ser entregue ao Serviço Externo de E-mail e o resultado do envio deverá ficar registrado. **A falha de envio não desfaz nem invalida a operação de agenda** que a originou.

**Dependências:** RF-025, RF-026, RF-027, RF-035.

**Observações:** O envio não é condicional: os três eventos (confirmação, cancelamento, oferta de vaga) **sempre** o solicitam (DEC-009 resolvida na Fase 6). A fronteira de aplicação tem nome único, `ServicoEnvioMensagem` (DEC-022); não há classe de domínio nem tabela própria. O envio é pós-commit e não participa da transação que grava o agendamento (TRS-02 do Integrante 4).

### RF-034 — Entrar na lista de espera

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado, vinculado ao Psicólogo e **sem horário disponível** no período consultado, registre sua entrada na lista de espera daquele Psicólogo.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** O Cliente/Paciente deve estar autenticado e vinculado ao Psicólogo (RN-003); não deve existir entrada ativa do mesmo paciente para o mesmo Psicólogo.

**Pós-condições:** A solicitação de espera deverá ser registrada com Psicólogo, Paciente, período desejado, data/hora de entrada e situação `AGUARDANDO`.

**Dependências:** RF-021, RF-024.

**Observações:** A posição na fila é definida **exclusivamente pela ordem de entrada** (DEC-027); não há prioridade manual. O registro da espera é um incremento de domínio proposto na Fase 6 (`SolicitacaoEspera`), dependente de incorporação pelo Integrante 3.

### RF-035 — Ofertar vaga ao próximo da lista de espera

**Descrição:** O sistema deverá, ao liberar um horário por cancelamento (RF-027), ofertar a vaga ao **primeiro** Cliente/Paciente da lista de espera daquele Psicólogo, abrindo uma oferta com prazo de aceite.

**Ator(es):** Sistema (decorrente do cancelamento).

**Prioridade:** Média.

**Pré-condições:** Deve ter ocorrido cancelamento de agendamento que libere um horário; deve existir solicitação de espera em situação `AGUARDANDO` para o mesmo Psicólogo.

**Pós-condições:** A solicitação mais antiga deverá passar a `OFERTADA`, com prazo de aceite registrado; o paciente deverá ser notificado por e-mail (RF-033).

**Dependências:** RF-027, RF-033, RF-034.

**Observações:** A oferta de vaga é modelada como **`<<extend>>` do cancelamento** — não é caso de uso independente iniciado por ator. Existe **uma única oferta aberta por vez** por Psicólogo (DEC-027); enquanto ela estiver aberta, a fila não é percorrida.

### RF-036 — Responder à oferta de vaga

**Descrição:** O sistema deverá permitir que o Cliente/Paciente que recebeu uma oferta de vaga a **aceite** ou **recuse** dentro do prazo de aceite.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** Deve existir oferta aberta para o Cliente/Paciente, dentro do prazo de aceite.

**Pós-condições:** No aceite, o agendamento deverá ser criado já `CONFIRMADO` (RF-025/RF-026) e a solicitação de espera encerrada como `ACEITA`. Na recusa ou no vencimento do prazo, a solicitação deverá ser encerrada (`RECUSADA` / `EXPIRADA`) e a vaga deverá ser ofertada ao **próximo** da fila.

**Dependências:** RF-025, RF-035.

**Observações:** A recusa **não** remove o paciente de uma nova entrada futura na fila; apenas encerra aquela solicitação. O prazo de aceite é parâmetro único do sistema, definido em configuração — não há prazo por paciente.

### RF-037 — Registrar não comparecimento

**Descrição:** O sistema deverá permitir que o Psicólogo registre o não comparecimento do Cliente/Paciente a um agendamento `CONFIRMADO` cujo horário já tenha passado.

**Ator(es):** Psicólogo.

**Prioridade:** Média.

**Pré-condições:** O Psicólogo deve estar autenticado e vinculado ao Paciente; o agendamento deve estar `CONFIRMADO` e o horário marcado já deve ter passado.

**Pós-condições:** A situação do agendamento deverá passar a `NAO_COMPARECEU` (terminal) e a operação deverá ser auditada (RF-032).

**Dependências:** RF-026, RF-030, RF-032.

**Observações:** O registro é **manual** (DEC-025): não há expiração automática. Não comparecimento não é atendimento realizado (RN-006) e não gera registro em `Atendimento`.

## 9. Inovação

**Status do módulo:** `PENDENTE DE DECISÃO DO GRUPO`.

Nenhum requisito funcional de inovação foi criado. A lista será atualizada somente após decisão formal do grupo.
