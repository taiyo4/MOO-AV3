# Fase 8 — Modelos dos testes conceituais que faltam (CT-003 a CT-031)

**Natureza:** esqueletos para preencher, gerados a partir da matriz final v0.7 e dos critérios de aceite. O cenário **C1** de cada teste já vem escrito a partir do critério de aceite (CA-RF); os cenários **C2 em diante** devem ser escritos por quem for dono do artefato (Integrante 3 para o modelo de domínio, Integrante 4 para a persistência). Cenários não preenchidos ficam marcados `[PREENCHER]`; nenhum resultado foi inventado.
**Convenção:** DEC-026, `CT-0RF`, no formato de `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md`. Cada cenário é um par Dado/Quando/Então verificável por inspeção do artefato.
**Cobertura:** 22 testes (CT-003 a CT-020, CT-022, CT-023, CT-029, CT-031). Os 15 restantes já foram escritos pelo Integrante 2.
**Como usar:** o dono copia o bloco do seu RF para o arquivo da sua pasta, completa os cenários, e o Integrante 5 marca "(escrito)" na matriz.


### CT-003 — RF-003 Cadastrar usuário · UC-003

**Critério de aceite:** CA-RF-003 · **Regras:** RN-002, RNF-001 · **Classe:** Usuario, Perfil · **Operação:** OP-03 `cadastrar` · **Persistência:** `usuario.*` (INSERT) · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autenticado e autorizado, **quando** cadastrar um usuário e associar perfil permitido, **então** o usuário deverá ser registrado com identificação própria sem exposição de senha em texto puro. | [PREENCHER: resultado observável no modelo] | Usuario, Perfil; `usuario.*` (INSERT) |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-004 — RF-004 Alterar dados de usuário · UC-003

**Critério de aceite:** CA-RF-004 · **Regras:** RN-002, RNF-002 · **Classe:** Usuario · **Operação:** `atualizarDadosPermitidos` · **Persistência:** `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um solicitante autenticado e autorizado para determinado conjunto de dados, **quando** alterar esses dados, **então** somente os campos permitidos deverão ser atualizados. | [PREENCHER: resultado observável no modelo] | Usuario; `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-005 — RF-005 Ativar usuário · UC-003

**Critério de aceite:** CA-RF-005 · **Regras:** RNF-003, RNF-002 · **Classe:** Usuario · **Operação:** `ativar` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Disponibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador ativar a conta, **então** a conta deverá ficar habilitada para autenticação, sujeita às permissões atribuídas. | [PREENCHER: resultado observável no modelo] | Usuario; `usuario.situacao_conta` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-006 — RF-006 Bloquear usuário · UC-003

**Critério de aceite:** CA-RF-006 · **Regras:** RN-001, RNF-003 · **Classe:** Usuario · **Operação:** `bloquear` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador bloquear a conta, **então** o usuário não deverá conseguir iniciar autenticação. | [PREENCHER: resultado observável no modelo] | Usuario; `usuario.situacao_conta` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-007 — RF-007 Gerenciar perfis · UC-003

**Critério de aceite:** CA-RF-007 · **Regras:** RNF-002 · **Classe:** Perfil · **Operação:** `adicionarPermissao`, `removerPermissao` · **Persistência:** `perfil.nome`, `perfil_permissao.*` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar ou manter um perfil de acesso, **então** a operação deverá respeitar as permissões administrativas e disponibilizar o perfil para associação autorizada. | [PREENCHER: resultado observável no modelo] | Perfil; `perfil.nome`, `perfil_permissao.*` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-008 — RF-008 Gerenciar permissões · UC-003

**Critério de aceite:** CA-RF-008 · **Regras:** RNF-002 · **Classe:** Permissao · **Operação:** — · **Persistência:** `permissao.codigo`, `perfil_permissao.*` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um perfil existente e um Administrador autorizado, **quando** atualizar as permissões do perfil, **então** autorizações subsequentes deverão considerar as permissões atualizadas sem ampliar os limites dos atores. | [PREENCHER: resultado observável no modelo] | Permissao; `permissao.codigo`, `perfil_permissao.*` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-009 — RF-009 Consultar painel administrativo · UC-003

**Critério de aceite:** CA-RF-009 · **Regras:** RNF-004, RNF-002 · **Classe:** (leitura agregada) · **Operação:** AP-05 · **Persistência:** *(consulta agregada)* · **Qualidade:** Usabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autenticado, **quando** acessar o painel administrativo, **então** deverá visualizar somente funções administrativas compatíveis com suas permissões. | [PREENCHER: resultado observável no modelo] | (leitura agregada); *(consulta agregada)* |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-010 — RF-010 Consultar usuários cadastrados · UC-003

**Critério de aceite:** CA-RF-010 · **Regras:** RNF-002, RN-002 · **Classe:** Usuario · **Operação:** OP-04 `consultarPermitidos` · **Persistência:** `usuario.identificacao`, `usuario.situacao_conta`, `usuario.id_perfil` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar usuários cadastrados, **então** os dados cadastrais permitidos deverão ser apresentados sem revelar senhas em texto puro. | [PREENCHER: resultado observável no modelo] | Usuario; `usuario.identificacao`, `usuario.situacao_conta`, `usuario.id_perfil` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-011 — RF-011 Consultar psicólogos cadastrados · UC-003

**Critério de aceite:** CA-RF-011 · **Regras:** RNF-002 · **Classe:** Psicologo · **Operação:** OP-06 `consultarCadastros` · **Persistência:** `psicologo.nome`, `psicologo_area_atuacao.*` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar psicólogos cadastrados, **então** o sistema deverá apresentar os dados profissionais permitidos. | [PREENCHER: resultado observável no modelo] | Psicologo; `psicologo.nome`, `psicologo_area_atuacao.*` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-012 — RF-012 Consultar clientes/pacientes cadastrados · UC-003

**Critério de aceite:** CA-RF-012 · **Regras:** RNF-005, RNF-002 · **Classe:** Paciente · **Operação:** OP-08 `consultarCadastros` · **Persistência:** `paciente.nome`, `paciente.situacao_cadastral` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** consultar clientes/pacientes cadastrados, **então** o sistema deverá apresentar dados cadastrais conforme suas permissões, sem conceder acesso a prontuário completo. | [PREENCHER: resultado observável no modelo] | Paciente; `paciente.nome`, `paciente.situacao_cadastral` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-013 — RF-013 Consultar registros de auditoria · UC-013

**Critério de aceite:** CA-RF-013 · **Regras:** RN-008, RN-014 · **Classe:** RegistroAuditoria · **Operação:** OP-09 `consultar` · **Persistência:** `registro_auditoria.*` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador com permissão de auditoria, **quando** consultar registros, **então** os registros autorizados deverão ser apresentados sem alteração pela operação de consulta. | [PREENCHER: resultado observável no modelo] | RegistroAuditoria; `registro_auditoria.*` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-014 — RF-014 Cadastrar psicólogo · UC-003

**Critério de aceite:** CA-RF-014 · **Regras:** RN-002, RNF-002 · **Classe:** Psicologo (+ Usuario, AreaAtuacao) · **Operação:** OP-05 `cadastrar` · **Persistência:** `psicologo.id_usuario`, `psicologo.nome`, `psicologo.registro_profissional` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** cadastrar um Psicólogo, **então** deverá ser criado o registro profissional correspondente sem duplicar desnecessariamente a identidade de usuário. | [PREENCHER: resultado observável no modelo] | Psicologo (+ Usuario, AreaAtuacao); `psicologo.id_usuario`, `psicologo.nome`, `psicologo.registro_profissional` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-015 — RF-015 Atualizar perfil profissional · UC-015

**Critério de aceite:** CA-RF-015 · **Regras:** RN-002, RNF-002, RNF-002 · **Classe:** Psicologo · **Operação:** `atualizarDadosProfissionais` · **Persistência:** `psicologo.*` (UPDATE) · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com perfil profissional, **quando** atualizar dados profissionais liberados, **então** somente os dados de seu próprio perfil autorizados deverão ser alterados. | [PREENCHER: resultado observável no modelo] | Psicologo; `psicologo.*` (UPDATE) |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-016 — RF-016 Associar área de atuação ao psicólogo · UC-015

**Critério de aceite:** CA-RF-016 · **Regras:** RN-002, RNF-002, RNF-002 · **Classe:** Psicologo, AreaAtuacao · **Operação:** `associarAreaAtuacao` · **Persistência:** `psicologo_area_atuacao.*`, `area_atuacao.nome` · **Qualidade:** Manutenibilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo e uma área de atuação válidos, **quando** o Psicólogo ou Administrador autorizado efetuar a associação, **então** a área deverá constar no perfil profissional correspondente. | [PREENCHER: resultado observável no modelo] | Psicologo, AreaAtuacao; `psicologo_area_atuacao.*`, `area_atuacao.nome` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-017 — RF-017 Consultar clientes/pacientes vinculados · UC-016

**Critério de aceite:** CA-RF-017 · **Regras:** RN-003, RNF-006 · **Classe:** Psicologo, Vinculo · **Operação:** `consultarPacientesVinculados` · **Persistência:** `vinculo.id_psicologo`, `vinculo.id_paciente`, `vinculo.situacao` · **Qualidade:** Confiabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com vínculos autorizados, **quando** consultar clientes/pacientes, **então** o resultado deverá conter somente pacientes vinculados a esse Psicólogo. | [PREENCHER: resultado observável no modelo] | Psicologo, Vinculo; `vinculo.id_psicologo`, `vinculo.id_paciente`, `vinculo.situacao` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-018 — RF-018 Cadastrar cliente/paciente · UC-003

**Critério de aceite:** CA-RF-018 · **Regras:** RN-005 · **Classe:** Paciente (+ Usuario) · **Operação:** OP-07 `cadastrar` · **Persistência:** `paciente.id_usuario`, `paciente.nome`, `paciente.situacao_cadastral` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Administrador autorizado, **quando** cadastrar um cliente/paciente, **então** o cadastro deverá ser registrado sem uso de dados reais nos artefatos do projeto. | [PREENCHER: resultado observável no modelo] | Paciente (+ Usuario); `paciente.id_usuario`, `paciente.nome`, `paciente.situacao_cadastral` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-019 — RF-019 Atualizar cadastro administrativo de cliente/paciente · UC-003

**Critério de aceite:** CA-RF-019 · **Regras:** RN-009, RNF-002 · **Classe:** Paciente · **Operação:** `atualizarCadastro` · **Persistência:** `paciente.nome`, `paciente.email_contato` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um cadastro de paciente existente e um Administrador autorizado, **quando** atualizar dados cadastrais administrativos, **então** somente dados administrativos permitidos deverão ser alterados. | [PREENCHER: resultado observável no modelo] | Paciente; `paciente.nome`, `paciente.email_contato` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-020 — RF-020 Alterar situação do cliente/paciente · UC-003

**Critério de aceite:** CA-RF-020 · **Regras:** RN-009 · **Classe:** Paciente · **Operação:** `alterarSituacao` · **Persistência:** `paciente.situacao_cadastral` · **Qualidade:** Rastreabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um cliente/paciente cadastrado e um Administrador autorizado, **quando** alterar sua situação, **então** a nova situação deverá ser registrada e a operação relevante deverá ser rastreável. | [PREENCHER: resultado observável no modelo] | Paciente; `paciente.situacao_cadastral` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-022 — RF-022 Consultar informações do próprio cadastro · UC-022

**Critério de aceite:** CA-RF-022 · **Regras:** RN-004, RNF-005 · **Classe:** Paciente · **Operação:** `consultarCadastroPermitido` · **Persistência:** `paciente.id_usuario` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Cliente/Paciente autenticado, **quando** consultar seu cadastro, **então** deverá receber somente informações próprias liberadas para visualização. | [PREENCHER: resultado observável no modelo] | Paciente; `paciente.id_usuario` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-023 — RF-023 Cadastrar disponibilidade do psicólogo · UC-015

**Critério de aceite:** CA-RF-023 · **Regras:** RN-005, RN-011 · **Classe:** Agenda, Disponibilidade · **Operação:** OP-10 `cadastrarDisponibilidade` · **Persistência:** `disponibilidade.data`, `disponibilidade.hora_inicio`, `disponibilidade.duracao_minutos` · **Qualidade:** Confiabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado, **quando** cadastrar disponibilidade, **então** o período deverá ser associado à própria agenda e considerado junto a conflitos existentes. | [PREENCHER: resultado observável no modelo] | Agenda, Disponibilidade; `disponibilidade.data`, `disponibilidade.hora_inicio`, `disponibilidade.duracao_minutos` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-029 — RF-029 Consultar agenda do psicólogo · UC-029

**Critério de aceite:** CA-RF-029 · **Regras:** RN-011, RN-003 · **Classe:** Agenda, Agendamento · **Operação:** OP-12 `consultarCompromissos` · **Persistência:** `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` · **Qualidade:** Usabilidade
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado, **quando** consultar sua agenda, **então** deverá visualizar somente compromissos da própria agenda e informações compatíveis com seus vínculos autorizados. | [PREENCHER: resultado observável no modelo] | Agenda, Agendamento; `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |

### CT-031 — RF-031 Consultar histórico permitido de atendimentos · UC-016

**Critério de aceite:** CA-RF-031 · **Regras:** RN-003, RN-007, RNF-006 · **Classe:** Psicologo, Atendimento · **Operação:** `consultarHistoricoPermitido` · **Persistência:** `atendimento.id_psicologo`, `atendimento.id_paciente`, `atendimento.data_hora_registro`, `atendimento.contexto_sessao` · **Qualidade:** Segurança
**Dono sugerido:** Integrante 3 (domínio) com Integrante 4 (persistência)

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado com vínculo autorizado, **quando** consultar histórico de atendimentos, **então** deverá visualizar apenas registros permitidos relacionados ao vínculo. | [PREENCHER: resultado observável no modelo] | Psicologo, Atendimento; `atendimento.id_psicologo`, `atendimento.id_paciente`, `atendimento.data_hora_registro`, `atendimento.contexto_sessao` |
| C2 | [PREENCHER: caso de erro ou regra negativa, ex.: usuário sem permissão] | [PREENCHER] | [PREENCHER] |
| C3 | [PREENCHER: caso de auditoria ou persistência] | [PREENCHER] | [PREENCHER] |
