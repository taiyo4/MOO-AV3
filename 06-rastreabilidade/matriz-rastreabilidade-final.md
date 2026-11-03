# Matriz de Rastreabilidade Final — v0.7 (preenchida até a Fase 7)

**Responsável:** Integrante 5 (verificação, sem órfãos; gerada por `06-rastreabilidade/montar-matriz.py`) e Integrante 1 (requisitos); montada em 30/10/2026 a partir das matrizes das Fases 3, 5 e 6, do dicionário de dados da Fase 7 e dos testes conceituais do Integrante 2.
**Situação:** versão **v0.7**, não final. As colunas de classe e de persistência dependem do diagrama de classes oficial (Integrante 3), que ainda não incorporou DEC-013 a DEC-030. Esta matriz será **v1.0** quando os itens P7 a P10 de `01-planejamento/etapas-e-responsabilidades.md` estiverem fechados.
**Fontes:** `02-requisitos/rastreabilidade-inicial.md` (UC futuro, CA, HU, decisão); `06-rastreabilidade/matriz-rastreabilidade-fase5.md` (classe, teste, categoria de qualidade); `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (operação, SEQ, ATV, COM, EST); `04-persistencia/dicionario-de-dados.md` §6 (tabela e coluna); `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md` (testes escritos).

## 1. Matriz principal — requisito, regra, caso de uso, classe, comportamento, persistência, qualidade e teste

| RF | RN / RNF | UC | Classe | Operação / responsabilidade | Diagramas comportamentais | Persistência (tabela.coluna) | CA; HU | Decisão | Teste conceitual | Qualidade |
|---|---|---|---|---|---|---|---|---|---|---|
| RF-001 Autenticar usuário | RN-001, RN-002, RNF-001, RNF-002 | UC-001 | Usuario (+ aplicação `ServicoAutenticacao`) | OP-01 `podeAutenticar`; OP-02 `confereCredencial`; AP-01 | SEQ: SEQ-001 | `usuario.identificacao`, `usuario.hash_senha`, `usuario.situacao_conta`, `usuario.id_perfil` | CA-RF-001; HU-001 | — | CT-001 (escrito) | Segurança |
| RF-002 Encerrar sessão | RNF-002 | UC-001 (A1) | — (aplicação) | AP-01 `invalidarSessaoAtiva` | SEQ: SEQ-001 (`opt`) | *(nenhuma — DEC-020)* | CA-RF-002; HU-001 | — | CT-002 (escrito) | Usabilidade |
| RF-003 Cadastrar usuário | RN-002, RNF-001 | UC-003 | Usuario, Perfil | OP-03 `cadastrar` | — | `usuario.*` (INSERT) | CA-RF-003; HU-002 | — | CT-003 (a escrever) | Segurança |
| RF-004 Alterar dados de usuário | RN-002, RNF-002 | UC-003 | Usuario | `atualizarDadosPermitidos` | — | `usuario.identificacao`, `usuario.id_perfil`, `usuario.atualizado_em` | CA-RF-004; HU-002 | — | CT-004 (a escrever) | Segurança |
| RF-005 Ativar usuário | RNF-003, RNF-002 | UC-003 | Usuario | `ativar` | — | `usuario.situacao_conta` | CA-RF-005; HU-002 | — | CT-005 (a escrever) | Disponibilidade |
| RF-006 Bloquear usuário | RN-001, RNF-003 | UC-003 | Usuario | `bloquear` | — | `usuario.situacao_conta` | CA-RF-006; HU-001, HU-002 | — | CT-006 (a escrever) | Segurança |
| RF-007 Gerenciar perfis | RNF-002 | UC-003 | Perfil | `adicionarPermissao`, `removerPermissao` | — | `perfil.nome`, `perfil_permissao.*` | CA-RF-007; HU-003 | — | CT-007 (a escrever) | Manutenibilidade |
| RF-008 Gerenciar permissões | RNF-002 | UC-003 | Permissao | — | — | `permissao.codigo`, `perfil_permissao.*` | CA-RF-008; HU-003 | — | CT-008 (a escrever) | Manutenibilidade |
| RF-009 Consultar painel administrativo | RNF-004, RNF-002 | UC-003 | (leitura agregada) | AP-05 | — | *(consulta agregada)* | CA-RF-009; HU-003 | — | CT-009 (a escrever) | Usabilidade |
| RF-010 Consultar usuários cadastrados | RNF-002, RN-002 | UC-003 | Usuario | OP-04 `consultarPermitidos` | COM: 2 | `usuario.identificacao`, `usuario.situacao_conta`, `usuario.id_perfil` | CA-RF-010; HU-002 | — | CT-010 (a escrever) | Segurança |
| RF-011 Consultar psicólogos cadastrados | RNF-002 | UC-003 | Psicologo | OP-06 `consultarCadastros` | — | `psicologo.nome`, `psicologo_area_atuacao.*` | CA-RF-011; HU-004 | — | CT-011 (a escrever) | Segurança |
| RF-012 Consultar clientes/pacientes cadastrados | RNF-005, RNF-002 | UC-003 | Paciente | OP-08 `consultarCadastros` | — | `paciente.nome`, `paciente.situacao_cadastral` | CA-RF-012; HU-005 | — | CT-012 (a escrever) | Segurança |
| RF-013 Consultar registros de auditoria | RN-008, RN-014 | UC-013 | RegistroAuditoria | OP-09 `consultar` | — | `registro_auditoria.*` | CA-RF-013; HU-014 | — | CT-013 (a escrever) | Rastreabilidade |
| RF-014 Cadastrar psicólogo | RN-002, RNF-002 | UC-003 | Psicologo (+ Usuario, AreaAtuacao) | OP-05 `cadastrar` | — | `psicologo.id_usuario`, `psicologo.nome`, `psicologo.registro_profissional` | CA-RF-014; HU-004 | — | CT-014 (a escrever) | Manutenibilidade |
| RF-015 Atualizar perfil profissional | RN-002, RNF-002, RNF-002 | UC-015 | Psicologo | `atualizarDadosProfissionais` | — | `psicologo.*` (UPDATE) | CA-RF-015; HU-006 | — | CT-015 (a escrever) | Manutenibilidade |
| RF-016 Associar área de atuação ao psicólogo | RN-002, RNF-002, RNF-002 | UC-015 | Psicologo, AreaAtuacao | `associarAreaAtuacao` | — | `psicologo_area_atuacao.*`, `area_atuacao.nome` | CA-RF-016; HU-006 | — | CT-016 (a escrever) | Manutenibilidade |
| RF-017 Consultar clientes/pacientes vinculados | RN-003, RNF-006 | UC-016 | Psicologo, Vinculo | `consultarPacientesVinculados` | — | `vinculo.id_psicologo`, `vinculo.id_paciente`, `vinculo.situacao` | CA-RF-017; HU-007 | — | CT-017 (a escrever) | Confiabilidade |
| RF-018 Cadastrar cliente/paciente | RN-005 | UC-003 | Paciente (+ Usuario) | OP-07 `cadastrar` | — | `paciente.id_usuario`, `paciente.nome`, `paciente.situacao_cadastral` | CA-RF-018; HU-005 | — | CT-018 (a escrever) | Segurança |
| RF-019 Atualizar cadastro administrativo de cliente/paciente | RN-009, RNF-002 | UC-003 | Paciente | `atualizarCadastro` | — | `paciente.nome`, `paciente.email_contato` | CA-RF-019; HU-005 | — | CT-019 (a escrever) | Rastreabilidade |
| RF-020 Alterar situação do cliente/paciente | RN-009 | UC-003 | Paciente | `alterarSituacao` | — | `paciente.situacao_cadastral` | CA-RF-020; HU-005 | — | CT-020 (a escrever) | Rastreabilidade |
| RF-021 Vincular cliente/paciente a psicólogo | RN-003, RN-007 | UC-021 | Vinculo | `formalizar`; OP-21 `encerrar` | — | `vinculo.*` | CA-RF-021; — | — | CT-021 (escrito) | Confiabilidade |
| RF-022 Consultar informações do próprio cadastro | RN-004, RNF-005 | UC-022 | Paciente | `consultarCadastroPermitido` | — | `paciente.id_usuario` | CA-RF-022; HU-008 | DEC-006 | CT-022 (a escrever) | Segurança |
| RF-023 Cadastrar disponibilidade do psicólogo | RN-005, RN-011 | UC-015 | Agenda, Disponibilidade | OP-10 `cadastrarDisponibilidade` | — | `disponibilidade.data`, `disponibilidade.hora_inicio`, `disponibilidade.duracao_minutos` | CA-RF-023; HU-009 | — | CT-023 (a escrever) | Confiabilidade |
| RF-024 Consultar horários disponíveis | RN-010, RNF-010, RN-004 | UC-024 | Agenda, Disponibilidade, Agendamento | OP-11 `consultarHorariosDisponiveis` | SEQ: SEQ-002; ATV: ATV-001 (`Consultar horários`); COM: 4, 5 | `disponibilidade.*` + `agendamento.slot_ativo` + `solicitacao_espera.oferta_aberta` | CA-RF-024; HU-010 | DEC-006 | CT-024 (escrito) | Usabilidade |
| RF-025 Solicitar agendamento | RN-005, RN-010, RN-013 | UC-025 / UC-036 (aceite) | Agendamento | `Agendamento.solicitar` (cria `CONFIRMADO`) | SEQ: SEQ-002, SEQ-004; ATV: ATV-001 (`Criar agendamento (CONFIRMADO)`); COM: 1, 7; EST: T0 (`[*] → CONFIRMADO`) | `agendamento.*` (INSERT com `situacao = 'CONFIRMADO'`) | CA-RF-025; HU-010 | DEC-016, DEC-017 | CT-025 (escrito) | Confiabilidade |
| RF-026 Confirmar agendamento automaticamente | RN-013, RN-005, RN-020, RN-022 | UC-025 (efeito) / UC-036 | Agendamento | `Agendamento.solicitar` — a confirmação é automática e simultânea | SEQ: SEQ-002, SEQ-004; ATV: ATV-001 (`Criar agendamento (CONFIRMADO)`); COM: 7; EST: T0 | `agendamento.situacao` (DEFAULT `'CONFIRMADO'`) | CA-RF-026; HU-010, HU-012 | DEC-017, DEC-016 | CT-026 (escrito) | Confiabilidade |
| RF-027 Cancelar agendamento | RN-012, DEC-011 + DEC-028, RN-006, RN-006, RN-009, RN-020, RN-022 | UC-027 | Agendamento | OP-14 `cancelar`; OP-15 `podeSerCancelado` (guarda `[antes do horário marcado]`) | SEQ: SEQ-003, SEQ-004 (gatilho); ATV: ATV-001 (`Cancelar (OP-14)`); COM: 11; EST: T1 (`CONFIRMADO → CANCELADO`) | `agendamento.situacao`, `data_cancelamento`, `id_usuario_cancelamento` | CA-RF-027; HU-011, HU-012 | DEC-011, DEC-016, DEC-028 | CT-027 (escrito) | Confiabilidade |
| RF-028 Consultar os próprios agendamentos | RN-004, RNF-005 | UC-028 (novo) | Agendamento | OP-19 `consultarMeus` | SEQ: SEQ-003 | `agendamento.id_paciente`, `agendamento.situacao` | CA-RF-028; HU-011 | DEC-006 | CT-028 (escrito) | Usabilidade |
| RF-029 Consultar agenda do psicólogo | RN-011, RN-003 | UC-029 | Agenda, Agendamento | OP-12 `consultarCompromissos` | — | `agendamento.id_psicologo`, `agendamento.situacao`, `vinculo.situacao` | CA-RF-029; HU-012 | — | CT-029 (a escrever) | Usabilidade |
| RF-030 Registrar conceitualmente um atendimento | RN-020, DEC-030, RN-006, RN-007, RN-006, RN-007 | UC-016 / UC-027 | Atendimento, Agendamento | OP-20 `registrar`; OP-17 `concluir` | SEQ: SEQ-003 (`opt`); ATV: ATV-001 (`Registrar atendimento`, `Concluir`); COM: 16, 17; EST: T2 (`CONFIRMADO → REALIZADO`) | `atendimento.*`, `agendamento.situacao` | CA-RF-030; HU-013 | DEC-016, DEC-030 | CT-030 (escrito) | Confiabilidade |
| RF-031 Consultar histórico permitido de atendimentos | RN-003, RN-007, RNF-006 | UC-016 | Psicologo, Atendimento | `consultarHistoricoPermitido` | — | `atendimento.id_psicologo`, `atendimento.id_paciente`, `atendimento.data_hora_registro`, `atendimento.contexto_sessao` | CA-RF-031; HU-013 | — | CT-031 (a escrever) | Segurança |
| RF-032 Registrar evento de auditoria | RN-009, RN-014, RNF-004 | UC-032 (`<<include>>`) | RegistroAuditoria | `RegistroAuditoria.registrar` + AP-02 | SEQ: SEQ-001/002/003/004; ATV: ATV-001 (4 auditorias); COM: 8, 9; EST: efeito de T0–T3 | `registro_auditoria.*` | CA-RF-032; HU-014 | — | CT-032 (escrito) | Rastreabilidade |
| RF-033 Enviar notificação por e-mail | RN-022, RNF-004 | UC-033 (novo) | — | AP-04 `ServicoEnvioMensagem.notificar` (fronteira externa) | SEQ: SEQ-002/003/004; ATV: ATV-001 (2 nós: confirmação e cancelamento); COM: 10, 12, 15; EST: efeito de T1 | `psicologo.email_contato`, `paciente.email_contato`, `registro_auditoria.operacao = 'FALHA_ENVIO_EMAIL'` | CA-RF-033; HU-016 | DEC-009, DEC-029 | CT-033 (escrito) | — |
| RF-034 Entrar na lista de espera | RN-021, DEC-027, RN-003 | UC-034 (novo) | — | AP-06 `entrarNaFila`/`consultarPosicao`/`sairDaFila`; OP-23 `registrarEntrada`; OP-28 `posicaoNaFila`; OP-27 `encerrar(DESISTIU)` | SEQ: SEQ-002 (A1), SEQ-004; ATV: ATV-001 (`Sem horários: oferecer lista de espera`) | `solicitacao_espera.id_paciente`, `solicitacao_espera.id_psicologo`, `solicitacao_espera.situacao`, `solicitacao_espera.data_hora_entrada` | CA-RF-034; HU-015 | DEC-010, DEC-027 | CT-034 (escrito) | — |
| RF-035 Ofertar horário liberado à lista de espera | RN-021, DEC-027, RN-012, RN-022 | UC-035 (`<<extend>>` de UC-027) | — | AP-06 `ofertarVaga`; OP-24 `proximoDaFila`; OP-25 `abrirOferta` | SEQ: SEQ-003 (`opt <<extend>>`), SEQ-004; ATV: ATV-001 (`Ofertar vaga se houver fila`); COM: 13, 14, 15; EST: efeito de T1 | `solicitacao_espera.situacao`, `solicitacao_espera.id_disponibilidade`, `solicitacao_espera.prazo_aceite` | CA-RF-035; HU-015 | DEC-010, DEC-027 | CT-035 (escrito) | — |
| RF-036 Responder à oferta de vaga | RN-021, DEC-027, RN-005, RN-013 | UC-036 (novo) | — | OP-26 `validarPrazo`; OP-27 `encerrar` (ACEITA/RECUSADA/EXPIRADA) | SEQ: SEQ-004 | `solicitacao_espera.situacao`, `solicitacao_espera.id_agendamento`, `solicitacao_espera.data_hora_encerramento` | CA-RF-036; HU-015 | DEC-010, DEC-017, DEC-027 | CT-036 (escrito) | — |
| RF-037 Registrar não comparecimento | RN-020, DEC-025, RN-009 | UC-037 (novo) | — | OP-18 `registrarFalta` | SEQ: SEQ-003 (`opt`); ATV: ATV-001 (`Registrar falta`); EST: T3 (`CONFIRMADO → NAO_COMPARECEU`) | `agendamento.situacao`, `agendamento.data_nao_comparecimento` | CA-RF-037; HU-012 | DEC-016, DEC-025 | CT-037 (escrito) | — |

## 2. Verificação de órfãos

| Conjunto | Total | Rastreados na matriz | Órfãos |
|---|---|---|---|
| RF | 37 | 37 | nenhum (todos têm linha) |
| RN | 17 | 17 | nenhum |
| RNF | 12 | 7 | RNF-007, RNF-008, RNF-009, RNF-011, RNF-012 |

RNF órfãos na coluna "RN / RNF" são **requisitos transversais** (valem para o sistema inteiro, não para um RF específico); estão cobertos pelo plano de qualidade (`05-qualidade/plano-qualidade-iso25010.md`) e não são lacuna de modelagem.

## 3. Lacunas a fechar para a v1.0

| RF | Lacuna detectada pela matriz |
|---|---|
| RF-021 | sem diagrama comportamental |

Lacunas já conhecidas por outras fontes: (a) a lista de espera (RF-034 a RF-036) tem caso de uso, diagramas comportamentais e tabela (`solicitacao_espera`), mas **não tem classe no diagrama de classes oficial** (P8, Integrante 3); (b) a coluna **Classe** das linhas RF-001 a RF-033 reflete o diagrama oficial, ainda com multiplicidades `PENDENTE` (P7); (c) os testes conceituais marcados "a escrever" ficam para os Integrantes 3 e 4 (Fase 8).

## 4. Cobertura de testes conceituais

- Testes escritos (Integrante 2): 15 de 37 requisitos têm teste `CT-0RF` com cenário escrito.
- Testes previstos e ainda a escrever: 22.
- Convenção: `CT-0RF` (DEC-026).

## 5. Regra de manutenção

1. Esta matriz é **regerada** por script quando uma fonte muda; não é editada à mão.
2. Um RF novo exige linha em todas as fontes antes de entrar aqui.
3. Um achado de rastreabilidade vira achado `Q8-nn` no `05-qualidade/analises/`.
