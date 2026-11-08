# Fase 8 — Modelos dos testes conceituais que faltam (CT-003 a CT-031)

**Natureza:** esqueletos para preencher, gerados a partir da matriz final v0.7 e dos critérios de aceite. O cenário **C1** de cada teste já vem escrito a partir do critério de aceite (CA-RF); os cenários **C2 em diante** devem ser escritos por quem for dono do artefato (Integrante 3 para o modelo de domínio, Integrante 4 para a persistência). Cenários não preenchidos ficam marcados `[PREENCHER]`; nenhum resultado foi inventado.
**Convenção:** DEC-026, `CT-0RF`, no formato de `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md`. Cada cenário é um par Dado/Quando/Então verificável por inspeção do artefato.
**Estado (08/11/2026):** os 22 testes do domínio estão com C1 a C3 preenchidos pelo Integrante 3; a verificação de persistência (Integrante 4) segue pendente.  
**Cobertura:** 22 testes (CT-003 a CT-020, CT-022, CT-023, CT-029, CT-031). Os 15 restantes já foram escritos pelo Integrante 2.
**Como usar:** o dono copia o bloco do seu RF para o arquivo da sua pasta, completa os cenários, e o Integrante 5 marca "(escrito)" na matriz.


### CT-003 — RF-003 Cadastrar usuário · UC-003

**Critério de aceite:** CA-RF-003 · **Regras:** RN-002, RNF-001 · **Classe:** Usuario, Perfil · **Operação:** OP-03 `cadastrar` · **Persistência:** `usuario.*` (INSERT) · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autenticado e autorizado, **quando** cadastrar um usuário e associar perfil permitido, **então** o usuário deverá ser registrado com identificação própria sem exposição de senha em texto puro. | `Usuario.cadastrar` cria a conta com `identificacao` e `credencialProtegida` (representação segura, nunca texto puro) e associa exatamente um Perfil (DEC-019). | Usuario, Perfil; `usuario.*` (INSERT); RN-002 |
| C2 | **Dado** um solicitante sem autorização administrativa, **quando** tentar cadastrar um usuário, **então** a operação deve ser recusada. | Nenhum Usuario é criado e nenhum Perfil é associado. A conta de quem tentou permanece inalterada. | Usuario; RNF-002; RN-002 |
| C3 | **Dado** um cadastro de usuário concluído, **quando** o evento for auditado, **então** o responsável, a data, a hora e a operação devem constar em RegistroAuditoria. | RegistroAuditoria registra o evento com responsável imutável; nenhum campo do registro contém senha ou credencial em texto puro. | Usuario; RegistroAuditoria; RF-032; RN-014 |

### CT-004 — RF-004 Alterar dados de usuário · UC-003

**Critério de aceite:** CA-RF-004 · **Regras:** RN-002, RNF-002 · **Classe:** Usuario · **Operação:** `atualizarDadosPermitidos` · **Persistência:** `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um solicitante autenticado e autorizado para determinado conjunto de dados, **quando** alterar esses dados, **então** somente os campos permitidos deverão ser atualizados. | `atualizarDadosPermitidos` grava somente os campos que o solicitante pode alterar; campos fora desse conjunto mantêm o valor anterior. A lista exata de campos permitidos segue PC-01. | Usuario; `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em`; PC-01 |
| C2 | **Dado** um solicitante sem permissão sobre um campo, **quando** tentar alterar esse campo na mesma operação em que altera campos permitidos, **então** o campo não permitido deve ser recusado e os demais campos permitidos devem ser gravados de forma coerente. | O campo restrito permanece com o valor atual; a operação não amplia o conjunto de campos alteráveis. | Usuario; `atualizarDadosPermitidos`; RNF-002; RN-002 |
| C3 | **Dado** uma alteração permitida concluída, **quando** o evento for auditado, **então** o responsável, a data e a operação devem constar no registro sem incluir a credencial. | RegistroAuditoria recebe a operação com responsável; a credencial protegida nunca entra no registro. | Usuario; RegistroAuditoria; RF-032; RN-014 |

### CT-005 — RF-005 Ativar usuário · UC-003

**Critério de aceite:** CA-RF-005 · **Regras:** RNF-003, RNF-002 · **Classe:** Usuario · **Operação:** `ativar` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Disponibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador ativar a conta, **então** a conta deverá ficar habilitada para autenticação, sujeita às permissões atribuídas. | `Usuario.ativar` deve levar a conta para `ATIVO`, mantendo a identidade do usuário e permitindo autenticação compatível com o perfil associado. | Usuario; `ativar`; RF-005; CA-RF-005; RNF-003 |
| C2 | **Dado** um solicitante sem autorização administrativa ou uma conta inexistente, **quando** tentar ativar a conta, **então** a operação deve ser recusada e o estado deve permanecer inalterado. | Nenhuma transição para `ATIVO` deve ocorrer. A operação é negada sem ampliar permissões ou criar efeito colateral. | Usuario; `ativar`; RNF-002; RF-005 |
| C3 | **Dado** uma ativação realizada com sucesso, **quando** o evento for considerado auditável, **então** o responsável, a data e a operação devem figurar no registro de auditoria. | O evento de ativação deve ser rastreado por `RegistroAuditoria`, sem expor senha ou credencial em texto puro. | Usuario; `RegistroAuditoria`; RF-032; RN-009 |

### CT-006 — RF-006 Bloquear usuário · UC-003

**Critério de aceite:** CA-RF-006 · **Regras:** RN-001, RNF-003 · **Classe:** Usuario · **Operação:** `bloquear` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador bloquear a conta, **então** o usuário não deverá conseguir iniciar autenticação. | `Usuario.bloquear` deve alterar a conta para `BLOQUEADO`, impedindo nova autenticação e preservando as permissões já atribuídas sem expansões indevidas. | Usuario; `bloquear`; RF-006; CA-RF-006; RN-001 |
| C2 | **Dado** um usuário sem permissão administrativa, uma conta já bloqueada ou uma conta inexistente, **quando** tentar bloquear, **então** a operação deve ser recusada e não deve haver alteração do estado. | A conta permanece na situação atual; nenhuma mudança em `situacaoConta` é aplicada sem autorização. | Usuario; `bloquear`; RNF-003; RF-006 |
| C3 | **Dado** um bloqueio validado, **quando** o efeito for considerado auditável, **então** a operação deve ser registrada com responsável, data e ação. | O evento de bloqueio deve constar em `RegistroAuditoria`, mantendo a exigência de rastreabilidade e segurança. | Usuario; `RegistroAuditoria`; RN-009; RF-032 |

### CT-007 — RF-007 Gerenciar perfis · UC-003

**Critério de aceite:** CA-RF-007 · **Regras:** RNF-002 · **Classe:** Perfil · **Operação:** `adicionarPermissao`, `removerPermissao` · **Persistência:** `perfil.nome`, `perfil_permissao.*` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar ou manter um perfil de acesso, **então** a operação deverá respeitar as permissões administrativas e disponibilizar o perfil para associação autorizada. | `adicionarPermissao` e `removerPermissao` alteram somente a associação Perfil–Permissao: o perfil e as permissões continuam existindo. | Perfil; `perfil.nome`, `perfil_permissao.*`; A02 |
| C2 | **Dado** um solicitante sem permissão administrativa, **quando** tentar adicionar ou remover uma permissão de um perfil, **então** a operação deve ser recusada. | A associação Perfil–Permissao permanece como estava; nenhuma Permissao é criada ou excluída. | Perfil; `adicionarPermissao`, `removerPermissao`; RNF-002; RF-007 |
| C3 | **Dado** uma alteração de permissões de perfil concluída, **quando** o evento for auditado, **então** o responsável e a operação devem constar em RegistroAuditoria. | RegistroAuditoria registra a operação; o histórico não oferece edição nem exclusão. | Perfil; RegistroAuditoria; RF-032; RN-014 |

### CT-008 — RF-008 Gerenciar permissões · UC-003

**Critério de aceite:** CA-RF-008 · **Regras:** RNF-002 · **Classe:** Permissao · **Operação:** — · **Persistência:** `permissao.codigo`, `perfil_permissao.*` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um perfil existente e um Administrador autorizado, **quando** atualizar as permissões do perfil, **então** autorizações subsequentes deverão considerar as permissões atualizadas sem ampliar os limites dos atores. | Após a atualização das permissões de um perfil, as autorizações posteriores consideram o conjunto atualizado, sem ampliar o alcance de nenhum ator. | Permissao; Perfil; A02; `permissao.*`, `perfil_permissao.*` |
| C2 | **Dado** uma permissão associada a outros perfis, **quando** um dos perfis for alterado, **então** os demais perfis não devem ser afetados. | Associações dos outros perfis permanecem inalteradas; a Permissao não é excluída. | Permissao; Perfil; A02; RF-008 |
| C3 | **Dado** uma permissão removida de um perfil, **quando** uma autorização posterior for avaliada, **então** a permissão removida não deve ser considerada. | A autorização posterior não usa a permissão removida; a alteração fica registrada conforme RF-032. | Permissao; Perfil; RNF-002; RF-032 |

### CT-009 — RF-009 Consultar painel administrativo · UC-003

**Critério de aceite:** CA-RF-009 · **Regras:** RNF-004, RNF-002 · **Classe:** (leitura agregada) · **Operação:** AP-05 · **Persistência:** *(consulta agregada)* · **Qualidade:** Usabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autenticado, **quando** acessar o painel administrativo, **então** deverá visualizar somente funções administrativas compatíveis com suas permissões. | O painel exibe somente as funções administrativas liberadas pelas permissões do Administrador autenticado. | Usuario; Perfil; AP-05; RNF-002 |
| C2 | **Dado** um usuário sem papel administrativo, **quando** tentar acessar o painel administrativo, **então** o acesso deve ser negado. | Nenhum dado administrativo é apresentado; a conta permanece sem alteração. | Usuario; Perfil; RNF-002; RN-002 |
| C3 | **Dado** o painel exibido, **quando** seus indicadores forem consultados, **então** a leitura não deve alterar nenhum registro. | Consulta somente leitura; nenhum agregado ou registro é modificado. | AP-05; RNF-004; RN-014 |

### CT-010 — RF-010 Consultar usuários cadastrados · UC-003

**Critério de aceite:** CA-RF-010 · **Regras:** RNF-002, RN-002 · **Classe:** Usuario · **Operação:** OP-04 `consultarPermitidos` · **Persistência:** `usuario.identificacao`, `usuario.situacao_conta`, `usuario.id_perfil` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar usuários cadastrados, **então** os dados cadastrais permitidos deverão ser apresentados sem revelar senhas em texto puro. | `consultarPermitidos` retorna os dados cadastrais permitidos de cada Usuario, sem `credencialProtegida`. | Usuario; OP-04; RN-002; RNF-002 |
| C2 | **Dado** um solicitante sem papel administrativo, **quando** consultar usuários, **então** a consulta deve ser recusada. | Nenhum usuário é retornado. | Usuario; OP-04; RNF-002 |
| C3 | **Dado** uma consulta autorizada, **quando** o resultado for entregue, **então** nenhum campo de credencial ou senha em texto puro deve estar presente. | Resultado restrito aos campos permitidos; `credencialProtegida` ausente. | Usuario; RN-002; RNF-001 |

### CT-011 — RF-011 Consultar psicólogos cadastrados · UC-003

**Critério de aceite:** CA-RF-011 · **Regras:** RNF-002 · **Classe:** Psicologo · **Operação:** OP-06 `consultarCadastros` · **Persistência:** `psicologo.nome`, `psicologo_area_atuacao.*` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar psicólogos cadastrados, **então** o sistema deverá apresentar os dados profissionais permitidos. | `consultarCadastros` apresenta somente os dados profissionais permitidos de cada Psicologo. | Psicologo; OP-06; RF-011; RNF-002 |
| C2 | **Dado** um solicitante sem papel administrativo, **quando** consultar psicólogos, **então** a consulta deve ser recusada. | Nenhum cadastro profissional é retornado. | Psicologo; OP-06; RNF-002 |
| C3 | **Dado** um Psicologo sem conta de acesso vinculada, **quando** for consultado, **então** o cadastro profissional deve aparecer sem Usuario associado. | O cadastro aparece sem conta; a ausência de conta não impede a consulta (A03 é 0..1). | Psicologo; Usuario; A03; DEC-021 |

### CT-012 — RF-012 Consultar clientes/pacientes cadastrados · UC-003

**Critério de aceite:** CA-RF-012 · **Regras:** RNF-005, RNF-002 · **Classe:** Paciente · **Operação:** OP-08 `consultarCadastros` · **Persistência:** `paciente.nome`, `paciente.situacao_cadastral` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar clientes/pacientes cadastrados, **então** o sistema deverá apresentar dados cadastrais conforme suas permissões, sem conceder acesso a prontuário completo. | A consulta apresenta os dados cadastrais de cada Paciente conforme as permissões, sem nenhum conteúdo de prontuário. | Paciente; OP-08; RF-012; RNF-005 |
| C2 | **Dado** um solicitante sem papel administrativo, **quando** consultar pacientes, **então** a consulta deve ser recusada. | Nenhum paciente é retornado. | Paciente; OP-08; RNF-002 |
| C3 | **Dado** um paciente com situação SUSPENSO ou INATIVO, **quando** a consulta administrativa o apresentar, **então** a situação exibida deve ser um dos valores de DEC-014. | A situação exibida é ATIVO, SUSPENSO ou INATIVO; nenhum outro valor aparece. | Paciente; DEC-014; RF-012 |

### CT-013 — RF-013 Consultar registros de auditoria · UC-013

**Critério de aceite:** CA-RF-013 · **Regras:** RN-008, RN-014 · **Classe:** RegistroAuditoria · **Operação:** OP-09 `consultar` · **Persistência:** `registro_auditoria.*` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador com permissão de auditoria, **quando** consultar registros, **então** os registros autorizados deverão ser apresentados sem alteração pela operação de consulta. | A consulta retorna os registros autorizados ao Administrador com permissão de auditoria, sem alterar nenhum deles. | RegistroAuditoria; OP-09; RF-013; RN-008 |
| C2 | **Dado** um Administrador sem permissão de auditoria, **quando** consultar registros, **então** a consulta deve ser recusada. | Nenhum registro é apresentado. | RegistroAuditoria; RN-008; RNF-002 |
| C3 | **Dado** um registro de auditoria existente, **quando** alguém tentar alterá-lo ou excluí-lo, **então** a classe não deve oferecer essa operação. | RegistroAuditoria não expõe edição nem exclusão; responsável e data são imutáveis (OO-14). | RegistroAuditoria; RN-014; OO-14 |

### CT-014 — RF-014 Cadastrar psicólogo · UC-003

**Critério de aceite:** CA-RF-014 · **Regras:** RN-002, RNF-002 · **Classe:** Psicologo (+ Usuario, AreaAtuacao) · **Operação:** OP-05 `cadastrar` · **Persistência:** `psicologo.id_usuario`, `psicologo.nome`, `psicologo.registro_profissional` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** cadastrar um Psicólogo, **então** deverá ser criado o registro profissional correspondente sem duplicar desnecessariamente a identidade de usuário. | `cadastrar` cria o Psicologo, associado a uma conta existente ou sem conta (A03 é opcional), sem duplicar a identidade do Usuario. | Psicologo, Usuario, AreaAtuacao; OP-05; DEC-021 |
| C2 | **Dado** um solicitante sem papel administrativo, **quando** tentar cadastrar um psicólogo, **então** a operação deve ser recusada. | Nenhum Psicologo é criado; nenhuma conta é alterada. | Psicologo; RNF-002; RN-002 |
| C3 | **Dado** um Psicologo cadastrado com conta vinculada, **quando** a conta for consultada, **então** o mesmo Usuario deve ser referenciado, sem cópia de identidade. | Uma conta por cadastro profissional; identidade não duplicada. | Usuario; Psicologo; A03; DEC-021; RF-014 |

### CT-015 — RF-015 Atualizar perfil profissional · UC-015

**Critério de aceite:** CA-RF-015 · **Regras:** RN-002, RNF-002, RNF-002 · **Classe:** Psicologo · **Operação:** `atualizarDadosProfissionais` · **Persistência:** `psicologo.*` (UPDATE) · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com perfil profissional, **quando** atualizar dados profissionais liberados, **então** somente os dados de seu próprio perfil autorizados deverão ser alterados. | `atualizarDadosProfissionais` altera somente os campos profissionais liberados do próprio Psicologo; os campos liberados seguem PC-04. | Psicologo; RF-015; PC-04 |
| C2 | **Dado** um psicólogo tentando alterar o perfil profissional de outro psicólogo, **quando** executar a atualização, **então** a operação deve ser recusada. | O perfil do outro psicólogo permanece inalterado. | Psicologo; RN-003; RNF-002 |
| C3 | **Dado** uma atualização profissional concluída, **quando** o evento for auditado, **então** o responsável e a operação devem constar no registro. | RegistroAuditoria recebe o evento com responsável e operação. | Psicologo; RegistroAuditoria; RF-032 |

### CT-016 — RF-016 Associar área de atuação ao psicólogo · UC-015

**Critério de aceite:** CA-RF-016 · **Regras:** RN-002, RNF-002, RNF-002 · **Classe:** Psicologo, AreaAtuacao · **Operação:** `associarAreaAtuacao` · **Persistência:** `psicologo_area_atuacao.*`, `area_atuacao.nome` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo e uma área de atuação válidos, **quando** o Psicólogo ou Administrador autorizado efetuar a associação, **então** a área deverá constar no perfil profissional correspondente. | `associarAreaAtuacao` cria a ligação Psicologo–AreaAtuacao no perfil profissional, desde que a área exista no catálogo. | Psicologo, AreaAtuacao; A05; RF-016 |
| C2 | **Dado** uma área inexistente no catálogo, **quando** o psicólogo tentar associá-la, **então** a associação deve ser recusada. | Nenhuma ligação é criada. | AreaAtuacao; A05; RF-016 |
| C3 | **Dado** um psicólogo que já possui uma área, **quando** a mesma área for associada novamente, **então** não deve haver duplicidade. | A associação é única por par psicólogo–área (chave composta da associativa); o mínimo de áreas segue PC-09. | Psicologo; AreaAtuacao; A05; PC-09 |

### CT-017 — RF-017 Consultar clientes/pacientes vinculados · UC-016

**Critério de aceite:** CA-RF-017 · **Regras:** RN-003, RNF-006 · **Classe:** Psicologo, Vinculo · **Operação:** `consultarPacientesVinculados` · **Persistência:** `vinculo.id_psicologo`, `vinculo.id_paciente`, `vinculo.situacao` · **Qualidade:** Confiabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com vínculos autorizados, **quando** consultar clientes/pacientes, **então** o resultado deverá conter somente pacientes vinculados a esse Psicólogo. | `consultarPacientesVinculados` retorna somente os Pacientes com Vinculo ATIVO com o psicólogo solicitante. | Psicologo, Vinculo; RN-003; DEC-015 |
| C2 | **Dado** um paciente com vínculo ENCERRADO, **quando** o psicólogo consultar seus pacientes, **então** esse paciente não deve aparecer. | Vínculo encerrado não gera acesso; o paciente não é listado. | Vinculo; DEC-015; RN-003 |
| C3 | **Dado** um psicólogo sem nenhum vínculo autorizado, **quando** consultar, **então** o resultado deve ser vazio, sem revelar pacientes de terceiros. | Lista vazia; nenhum dado de outro profissional. | Psicologo; Vinculo; RN-003; RNF-006 |

### CT-018 — RF-018 Cadastrar cliente/paciente · UC-003

**Critério de aceite:** CA-RF-018 · **Regras:** RN-005 · **Classe:** Paciente (+ Usuario) · **Operação:** OP-07 `cadastrar` · **Persistência:** `paciente.id_usuario`, `paciente.nome`, `paciente.situacao_cadastral` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** cadastrar um cliente/paciente, **então** o cadastro deverá ser registrado sem uso de dados reais nos artefatos do projeto. | `cadastrar` cria o Paciente com um valor válido de SituacaoCadastral e conta opcional (A04). | Paciente, Usuario; OP-07; DEC-014; DEC-021 |
| C2 | **Dado** um solicitante sem papel administrativo, **quando** tentar cadastrar um paciente, **então** a operação deve ser recusada. | Nenhum Paciente é criado. | Paciente; RNF-002; RN-002 |
| C3 | **Dado** um cadastro de paciente usado como exemplo, **quando** o modelo for inspecionado, **então** nenhum dado real pode constar. | Somente dados fictícios nos artefatos. | Paciente; DEC-005; RF-018 |

### CT-019 — RF-019 Atualizar cadastro administrativo de cliente/paciente · UC-003

**Critério de aceite:** CA-RF-019 · **Regras:** RN-009, RNF-002 · **Classe:** Paciente · **Operação:** `atualizarCadastro` · **Persistência:** `paciente.nome`, `paciente.email_contato` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um cadastro de paciente existente e um Administrador autorizado, **quando** atualizar dados cadastrais administrativos, **então** somente dados administrativos permitidos deverão ser alterados. | `atualizarCadastro` altera somente os dados administrativos permitidos; a situação cadastral muda apenas por `alterarSituacao` (CT-020). | Paciente; RF-019; RN-009 |
| C2 | **Dado** um campo clínico ou não permitido, **quando** o administrador tentar alterá-lo, **então** a operação deve ser recusada. | O campo permanece inalterado; prontuário está fora do escopo. | Paciente; RN-009; DEC-008 |
| C3 | **Dado** uma atualização administrativa concluída, **quando** o evento for auditado, **então** o responsável, a data e a operação devem constar no registro. | RegistroAuditoria recebe o evento. | Paciente; RegistroAuditoria; RN-014 |

### CT-020 — RF-020 Alterar situação do cliente/paciente · UC-003

**Critério de aceite:** CA-RF-020 · **Regras:** RN-009 · **Classe:** Paciente · **Operação:** `alterarSituacao` · **Persistência:** `paciente.situacao_cadastral` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um cliente/paciente cadastrado e um Administrador autorizado, **quando** alterar sua situação, **então** a nova situação deverá ser registrada e a operação relevante deverá ser rastreável. | `Paciente.alterarSituacao` deve aceitar apenas valores de `SituacaoCadastral` válidos (`ATIVO`, `SUSPENSO`, `INATIVO`) e registrar a mudança de estado de forma rastreável. | Paciente; `alterarSituacao`; RF-020; RN-009; DEC-014 |
| C2 | **Dado** um solicitante sem autorização administrativa ou uma transição inválida, **quando** tentar alterar a situação, **então** a operação deve ser recusada e o estado cadastral não pode mudar. | O estado atual do paciente continua estável; não há substituição arbitrária de situação ou alteração sem autorização. | Paciente; `alterarSituacao`; RF-020; RN-009 |
| C3 | **Dado** uma alteração de situação validada, **quando** o evento for gerado, **então** o responsável, o momento e a operação devem ficar registrados na trilha de auditoria. | `RegistroAuditoria` recebe a operação com responsável, data e hora, sem permitir edição do histórico. | Paciente; `RegistroAuditoria`; RF-032; RN-014 |

### CT-022 — RF-022 Consultar informações do próprio cadastro · UC-022

**Critério de aceite:** CA-RF-022 · **Regras:** RN-004, RNF-005 · **Classe:** Paciente · **Operação:** `consultarCadastroPermitido` · **Persistência:** `paciente.id_usuario` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Cliente/Paciente autenticado, **quando** consultar seu cadastro, **então** deverá receber somente informações próprias liberadas para visualização. | A consulta retorna somente os dados do próprio Paciente que são liberados ao titular. | Paciente; `consultarCadastroPermitido`; RF-022; RN-004 |
| C2 | **Dado** um paciente autenticado, **quando** tentar consultar o cadastro de outro paciente, **então** a consulta deve ser recusada. | Nenhum dado de terceiro é retornado. | Paciente; RN-004; RNF-005 |
| C3 | **Dado** um paciente consultando o próprio cadastro, **quando** o retorno for montado, **então** ele não deve incluir a conta de outro usuário nem campos administrativos não liberados. | Retorno restrito ao titular; campos administrativos somente se liberados (PC-05). | Paciente; Usuario; RN-004; PC-05 |

### CT-023 — RF-023 Cadastrar disponibilidade do psicólogo · UC-015

**Critério de aceite:** CA-RF-023 · **Regras:** RN-005, RN-011 · **Classe:** Agenda, Disponibilidade · **Operação:** OP-10 `adicionarDisponibilidade` · **Persistência:** `disponibilidade.data`, `disponibilidade.hora_inicio`, `disponibilidade.duracao_minutos` · **Qualidade:** Confiabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado, **quando** cadastrar disponibilidade, **então** o período deverá ser associado à própria agenda e considerado junto a conflitos existentes. | `adicionarDisponibilidade` associa a Disponibilidade à própria Agenda do psicólogo autenticado e a considera junto aos Agendamentos existentes (A09 e A17). | Agenda, Disponibilidade; `disponibilidade.*`; A08, A09, A17; RF-023 |
| C2 | **Dado** um psicólogo tentando cadastrar disponibilidade na agenda de outro psicólogo, **quando** executar a operação, **então** a operação deve ser recusada. | A agenda alheia permanece inalterada; horários de outro profissional não são administrados como próprios. | Agenda; Psicologo; A08; RN-011 |
| C3 | **Dado** um período já ocupado por Agendamento confirmado, **quando** o psicólogo tentar cadastrar disponibilidade sobreposta, **então** o conflito deve ser tratado conforme a regra de sobreposição. | Resultado pendente: a regra de sobreposição e a precisão temporal seguem PC-07. O teste só é aprovado quando essa regra for fechada. | Agenda, Disponibilidade, Agendamento; PC-07; RN-005 |

### CT-029 — RF-029 Consultar agenda do psicólogo · UC-029

**Critério de aceite:** CA-RF-029 · **Regras:** RN-011, RN-003 · **Classe:** Agenda, Agendamento · **Operação:** OP-12 `consultarCompromissos` · **Persistência:** `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` · **Qualidade:** Usabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado e com vínculo ativo com o paciente, **quando** consultar a agenda, **então** deverá receber somente os compromissos ligados ao seu cadastro e ao vínculo autorizado. | `Agenda`/`Agendamento` devem apresentar somente registros do profissional e do vínculo ativo; informações de terceiros permanecem fora do resultado. | Agenda; Agendamento; Vinculo; RF-029; RN-011; RN-003 |
| C2 | **Dado** um psicólogo sem vínculo ativo, sem autorização ou sem compromisso associado, **quando** consultar a agenda, **então** a operação deve ser recusada e não devem aparecer registros indevidos. | A consulta deve retornar vazio ou negar acesso, sem revelar compromissos que não pertençam ao psicólogo ou ao vínculo válido. | Agenda; Agendamento; Vinculo; RN-003; RF-029 |
| C3 | **Dado** uma consulta de agenda validada, **quando** o resultado for exibido, **então** o sistema deve preservar a regra de acesso por vínculo ativo e a exclusão de dados sem autorização. | O conjunto exibido é um subconjunto autorizado, não uma visão global; entidades sem vínculo ativo não aparecem. | Agenda; Vinculo; `consultarCompromissos`; RN-003; RN-011 |

### CT-031 — RF-031 Consultar histórico permitido de atendimentos · UC-016

**Critério de aceite:** CA-RF-031 · **Regras:** RN-003, RN-007, RNF-006 · **Classe:** Psicologo, Atendimento · **Operação:** `consultarHistoricoPermitido` · **Persistência:** `atendimento.id_psicologo`, `atendimento.id_paciente`, `atendimento.data_hora_registro`, `atendimento.contexto_sessao` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com vínculo autorizado, **quando** consultar histórico de atendimentos, **então** deverá visualizar apenas registros permitidos relacionados ao vínculo. | `consultarHistoricoPermitido` retorna somente Atendimentos ligados a Vinculo ATIVO do psicólogo solicitante. | Psicologo, Atendimento, Vinculo; RF-031; RN-003; RN-007 |
| C2 | **Dado** um psicólogo sem vínculo ativo com o paciente, **quando** consultar o histórico, **então** a consulta deve ser negada. | Nenhum Atendimento é retornado. | Psicologo; Atendimento; Vinculo; RN-003; DEC-015 |
| C3 | **Dado** um atendimento de outro psicólogo, **quando** o histórico for montado, **então** esse registro não deve aparecer. | Somente registros do próprio profissional dentro do vínculo autorizado. | Atendimento; A13; RN-007 |
