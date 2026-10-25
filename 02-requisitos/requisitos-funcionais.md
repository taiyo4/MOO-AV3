# Requisitos Funcionais

Os requisitos abaixo derivam do escopo e das decisões registradas em [`01-planejamento/decisoes.md`](../01-planejamento/decisoes.md). Prioridades indicam importância para o escopo mínimo da plataforma, não ordem de implementação. Ações administrativas devem respeitar permissões autorizadas.

**Atualização de 25/10/2026:** com a aprovação de DEC-009 (serviço externo de e-mail), DEC-010 (lista de espera inteligente), DEC-011 (cancelamento por paciente e psicólogo), DEC-016 (situações do agendamento, parcialmente) e DEC-017 (confirmação automática), foram revisados RF-025, RF-026, RF-027 e RF-030 e acrescentados RF-033 a RF-037. Os identificadores RF-001 a RF-032 foram preservados. Pendências do grupo são citadas pelo identificador `PG-xx` definido em `decisoes.md`.

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

**Pós-condições:** Se o horário estiver disponível e não houver conflito, o agendamento deverá ser registrado com Cliente/Paciente, Psicólogo e horário, e confirmado automaticamente (RF-026), ocupando o horário. Caso contrário, a solicitação não deverá gerar agendamento confirmado nem ocupar o horário.

**Dependências:** RF-021, RF-024, RF-026.

**Observações:** Confirmação automática aprovada em DEC-017. A solicitação não é registrada como situação própria: `SOLICITADO` não é persistente, e o agendamento já nasce `Confirmado` (DEC-016).

### RF-026 — Confirmar agendamento automaticamente

**Descrição:** O sistema deverá confirmar automaticamente o agendamento solicitado quando o horário estiver disponível e não houver conflito de agenda, sem aprovação manual de outro ator.

**Ator(es):** Sistema (confirmação automática decorrente da solicitação do Cliente/Paciente).

**Prioridade:** Alta.

**Pré-condições:** Deve existir solicitação de agendamento (RF-025) ou aceite de vaga da lista de espera (RF-036) para horário disponível e sem conflito.

**Pós-condições:** O agendamento deverá ficar na situação `Confirmado`, preservando a associação entre Cliente/Paciente, Psicólogo e horário, e o e-mail de confirmação deverá ser solicitado ao Serviço Externo de E-mail (RF-033).

**Dependências:** RF-025, RF-033.

**Observações:** Decisão DEC-017. Não há situação anterior a `Confirmado` (DEC-016). A assinatura da operação nos modelos é proposta técnica do Integrante 2 e não decisão do grupo.

### RF-027 — Cancelar agendamento

**Descrição:** O sistema deverá permitir que o Cliente/Paciente titular ou o Psicólogo responsável cancele um agendamento antes do horário marcado.

**Ator(es):** Cliente/Paciente (agendamento próprio) e Psicólogo (agendamento da própria agenda).

**Prioridade:** Alta.

**Pré-condições:** O solicitante deve estar autenticado e ser o Cliente/Paciente titular ou o Psicólogo do agendamento; o agendamento deve estar na situação `Confirmado`; o horário marcado ainda não deve ter começado.

**Pós-condições:** A situação do agendamento deverá ser alterada para `Cancelado`, o horário deverá ser liberado, a alteração deverá ser auditada (RF-032), o e-mail de cancelamento deverá ser solicitado (RF-033) e o horário liberado poderá ser oferecido à lista de espera (RF-035). O agendamento cancelado não poderá ser registrado como atendimento realizado.

**Dependências:** RF-025, RF-026, RF-032, RF-033.

**Observações:** Decisão DEC-011. A antecedência mínima de 2 horas **não foi aprovada**; a existência de outro prazo mínimo está pendente (`PG-02`). Também estão pendentes o cancelamento pelo Administrador (`PG-10`), e se o cancelamento pelo Psicólogo gera oferta à lista de espera (`PG-09`).

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

### RF-037 — Registrar não comparecimento

**Descrição:** O sistema deverá permitir que o Psicólogo registre que o Cliente/Paciente não compareceu a um agendamento confirmado, alterando sua situação para `Não compareceu`.

**Ator(es):** Psicólogo (agendamento da própria agenda).

**Prioridade:** Média.

**Pré-condições:** O Psicólogo deve estar autenticado e ser o responsável pelo agendamento; o horário marcado já deve ter passado; o agendamento deve continuar `Confirmado`, ou seja, não pode ter sido cancelado nem concluído.

**Pós-condições:** A situação do agendamento deverá ser `Não compareceu` e a alteração deverá ser auditada (RF-032).

**Dependências:** RF-026, RF-029, RF-032.

**Observações:** Situação aprovada em DEC-016 e responsável aprovado em DEC-025. Numerado em 25/10/2026, após RF-033 a RF-036, para preservar a numeração existente. O registro automático pelo sistema não foi aprovado.

## 6. Atendimento

### RF-030 — Registrar conceitualmente um atendimento

**Descrição:** O sistema deverá permitir que um Psicólogo registre conceitualmente a realização de um atendimento associado a si próprio e a um Cliente/Paciente vinculado.

**Ator(es):** Psicólogo.

**Prioridade:** Alta.

**Pré-condições:** O Psicólogo deve estar autenticado, o vínculo deve ser autorizado e o atendimento deve corresponder a uma sessão válida da agenda.

**Pós-condições:** O atendimento realizado deverá estar registrado com associação ao Psicólogo e ao Cliente/Paciente válidos.

**Dependências:** RF-017, RF-021, RF-029.

**Observações:** Registro conceitual não significa prontuário clínico completo; não incluir conteúdo clínico aprofundado. A situação `Realizado` foi aprovada (DEC-016); a relação entre este registro e a mudança do agendamento para `Realizado` é a proposta DEC-023, ainda não aprovada (`PG-12`).

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

## 8. Notificações externas

### RF-033 — Enviar notificação por e-mail

**Descrição:** O sistema deverá solicitar ao Serviço Externo de E-mail o envio de mensagem aos envolvidos quando ocorrer confirmação de agendamento, cancelamento de agendamento ou oferta de vaga da lista de espera.

**Ator(es):** Sistema; Serviço Externo de E-mail (ator externo de suporte).

**Prioridade:** Média.

**Pré-condições:** Deve ocorrer um dos eventos previstos: confirmação (RF-026), cancelamento (RF-027) ou oferta de vaga (RF-035).

**Pós-condições:** A solicitação de envio deverá conter apenas os dados necessários ao aviso, sem senhas nem informações clínicas.

**Dependências:** RF-026, RF-027, RF-035.

**Observações:** Decisão DEC-009. Envio em outros eventos não foi decidido. O efeito de falha no envio sobre a operação de origem está pendente (`PG-11`).

## 9. Inovação — Lista de espera inteligente

**Status do módulo:** aprovado pelo grupo (DEC-010). Os parâmetros operacionais da fila continuam pendentes (`PG-04` a `PG-09`) e não devem ser presumidos nos modelos.

### RF-034 — Entrar na lista de espera

**Descrição:** O sistema deverá permitir que um Cliente/Paciente autenticado registre interesse em horário com Psicólogo vinculado, entrando na lista de espera.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** O Cliente/Paciente deve estar autenticado e possuir vínculo autorizado com o Psicólogo.

**Pós-condições:** A entrada na lista de espera deverá ser registrada, associada ao Cliente/Paciente e ao Psicólogo.

**Dependências:** RF-001, RF-021.

**Observações:** Pendentes: abrangência da entrada (por psicólogo, faixa de horário ou horário específico), consulta da posição e saída voluntária da lista (`PG-08`).

### RF-035 — Ofertar horário liberado à lista de espera

**Descrição:** Quando um agendamento for cancelado e o horário for liberado, o sistema poderá oferecer esse horário a paciente da lista de espera do mesmo Psicólogo.

**Ator(es):** Sistema; Serviço Externo de E-mail (aviso da oferta).

**Prioridade:** Média.

**Pré-condições:** Deve existir cancelamento (RF-027) que libere horário ainda não iniciado e paciente elegível na lista de espera.

**Pós-condições:** A oferta deverá ser registrada e comunicada por e-mail (RF-033). A oferta, por si só, não cria agendamento confirmado.

**Dependências:** RF-027, RF-033, RF-034.

**Observações:** Pendentes: ordem da fila (`PG-04`), oferta a um ou a vários pacientes ao mesmo tempo (`PG-05`), tratamento de recusa ou ausência de resposta (`PG-07`), se o horário fica reservado durante o prazo de aceite (`PG-06`) e se o cancelamento pelo Psicólogo também gera oferta (`PG-09`).

### RF-036 — Responder à oferta de vaga

**Descrição:** O sistema deverá permitir que o Cliente/Paciente que recebeu a oferta aceite ou recuse o horário oferecido.

**Ator(es):** Cliente/Paciente.

**Prioridade:** Média.

**Pré-condições:** Deve existir oferta válida destinada ao Cliente/Paciente.

**Pós-condições:** Em caso de aceite, o sistema deverá revalidar que o horário continua disponível e sem conflito; se sim, o agendamento deverá ser confirmado automaticamente (RF-026); se não, nenhum agendamento deverá ser criado. Em caso de recusa, a resposta deverá ser registrada.

**Dependências:** RF-026, RF-035.

**Observações:** Pendentes: prazo para aceitar (`PG-06`) e o que ocorre após recusa ou ausência de resposta (`PG-07`).
