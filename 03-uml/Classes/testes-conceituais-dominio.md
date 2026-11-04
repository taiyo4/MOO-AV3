# Testes conceituais do domínio (Integrante 3)

**Fonte:** `06-rastreabilidade/modelos-testes-conceituais-fase8.md`  
**Escopo:** preenchimento inicial dos cenários desviados de regra/negativos e do resultado esperado do cenário C1 para os testes de domínio que foram priorizados nesta etapa.

---

### CT-005 — RF-005 Ativar usuário · UC-003

**Critério de aceite:** CA-RF-005 · **Regras:** RNF-003, RNF-002 · **Classe:** Usuario · **Operação:** `ativar` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Disponibilidade

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador ativar a conta, **então** a conta deverá ficar habilitada para autenticação, sujeita às permissões atribuídas. | `Usuario.ativar` deve levar a conta para `ATIVO`, mantendo a identidade do usuário e permitindo autenticação compatível com o perfil associado. | Usuario; `ativar`; RF-005; CA-RF-005; RNF-003 |
| C2 | **Dado** um solicitante sem autorização administrativa ou uma conta inexistente, **quando** tentar ativar a conta, **então** a operação deve ser recusada e o estado deve permanecer inalterado. | Nenhuma transição para `ATIVO` deve ocorrer. A operação é negada sem ampliar permissões ou criar efeito colateral. | Usuario; `ativar`; RNF-002; RF-005 |
| C3 | **Dado** uma ativação realizada com sucesso, **quando** o evento for considerado auditável, **então** o responsável, a data e a operação devem figurar no registro de auditoria. | O evento de ativação deve ser rastreado por `RegistroAuditoria`, sem expor senha ou credencial em texto puro. | Usuario; `RegistroAuditoria`; RF-032; RN-009 |

### CT-006 — RF-006 Bloquear usuário · UC-003

**Critério de aceite:** CA-RF-006 · **Regras:** RN-001, RNF-003 · **Classe:** Usuario · **Operação:** `bloquear` · **Persistência:** `usuario.situacao_conta` · **Qualidade:** Segurança

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um usuário cadastrado e um Administrador autorizado, **quando** o Administrador bloquear a conta, **então** o usuário não deverá conseguir iniciar autenticação. | `Usuario.bloquear` deve alterar a conta para `BLOQUEADO`, impedindo nova autenticação e preservando as permissões já atribuídas sem expansões indevidas. | Usuario; `bloquear`; RF-006; CA-RF-006; RN-001 |
| C2 | **Dado** um usuário sem permissão administrativa, uma conta já bloqueada ou uma conta inexistente, **quando** tentar bloquear, **então** a operação deve ser recusada e não deve haver alteração do estado. | A conta permanece na situação atual; nenhuma mudança em `situacaoConta` é aplicada sem autorização. | Usuario; `bloquear`; RNF-003; RF-006 |
| C3 | **Dado** um bloqueio validado, **quando** o efeito for considerado auditável, **então** a operação deve ser registrada com responsável, data e ação. | O evento de bloqueio deve constar em `RegistroAuditoria`, mantendo a exigência de rastreabilidade e segurança. | Usuario; `RegistroAuditoria`; RN-009; RF-032 |

### CT-020 — RF-020 Alterar situação do cliente/paciente · UC-003

**Critério de aceite:** CA-RF-020 · **Regras:** RN-009 · **Classe:** Paciente · **Operação:** `alterarSituacao` · **Persistência:** `paciente.situacao_cadastral` · **Qualidade:** Rastreabilidade

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um cliente/paciente cadastrado e um Administrador autorizado, **quando** alterar sua situação, **então** a nova situação deverá ser registrada e a operação relevante deverá ser rastreável. | `Paciente.alterarSituacao` deve aceitar apenas valores de `SituacaoCadastral` válidos (`ATIVO`, `SUSPENSO`, `INATIVO`) e registrar a mudança de estado de forma rastreável. | Paciente; `alterarSituacao`; RF-020; RN-009; DEC-014 |
| C2 | **Dado** um solicitante sem autorização administrativa ou uma transição inválida, **quando** tentar alterar a situação, **então** a operação deve ser recusada e o estado cadastral não pode mudar. | O estado atual do paciente continua estável; não há substituição arbitrária de situação ou alteração sem autorização. | Paciente; `alterarSituacao`; RF-020; RN-009 |
| C3 | **Dado** uma alteração de situação validada, **quando** o evento for gerado, **então** o responsável, o momento e a operação devem ficar registrados na trilha de auditoria. | `RegistroAuditoria` recebe a operação com responsável, data e hora, sem permitir edição do histórico. | Paciente; `RegistroAuditoria`; RF-032; RN-014 |

### CT-029 — RF-029 Consultar agenda do psicólogo · UC-029

**Critério de aceite:** CA-RF-029 · **Regras:** RN-011, RN-003 · **Classe:** Agenda, Agendamento · **Operação:** OP-12 `consultarCompromissos` · **Persistência:** `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` · **Qualidade:** Usabilidade

| # | Cenário | Resultado esperado | Evidência |
|---|---|---|---|
| C1 | **Dado** um Psicólogo autenticado e com vínculo ativo com o paciente, **quando** consultar a agenda, **então** deverá receber somente os compromissos ligados ao seu cadastro e ao vínculo autorizado. | `Agenda`/`Agendamento` devem apresentar somente registros do profissional e do vínculo ativo; informações de terceiros permanecem fora do resultado. | Agenda; Agendamento; Vinculo; RF-029; RN-011; RN-003 |
| C2 | **Dado** um psicólogo sem vínculo ativo, sem autorização ou sem compromisso associado, **quando** consultar a agenda, **então** a operação deve ser recusada e não devem aparecer registros indevidos. | A consulta deve retornar vazio ou negar acesso, sem revelar compromissos que não pertençam ao psicólogo ou ao vínculo válido. | Agenda; Agendamento; Vinculo; RN-003; RF-029 |
| C3 | **Dado** uma consulta de agenda validada, **quando** o resultado for exibido, **então** o sistema deve preservar a regra de acesso por vínculo ativo e a exclusão de dados sem autorização. | O conjunto exibido é um subconjunto autorizado, não uma visão global; entidades sem vínculo ativo não aparecem. | Agenda; Vinculo; `consultarCompromissos`; RN-003; RN-011 |

---

> Os cenários acima foram preenchidos conforme as regras do domínio e as decisões de modelagem, sem inventar requisitos não documentados.
