# Especificação de classes — Plataforma para Psicólogos

**Responsável:** Integrante 3.  
**Status:** modelo OO alinhado às decisões aprovadas; tipos conceituais e contratos ainda não especificados permanecem pendentes. Não é implementação executável.

## 1. Escopo e fontes

Refinamento das 13 classes do [modelo de domínio](../Dominio/modelo-dominio.md), incluindo a lista de espera, preservando as associações da [fonte do domínio](../Dominio/diagrama-dominio.mmd).

Fontes: [RF](../../02-requisitos/requisitos-funcionais.md), [RN](../../02-requisitos/regras-negocio.md), [RNF](../../02-requisitos/requisitos-nao-funcionais.md), [critérios de aceite](../../02-requisitos/criterios-aceite.md), [glossário](../../02-requisitos/glossario.md), [decisões oficiais](../../01-planejamento/decisoes.md) e [escopo](../../02-requisitos/escopo.md). As [interações/processos](../Contexto/Interações_Processos.md) e a [revisão de casos futuros](../Casos%20de%20uso/CasosDeUsoFuturo.md) são fontes complementares; sugestões não equivalem a decisões aprovadas.

Consultar [diagrama-classes.mmd](diagrama-classes.mmd) e [decisoes-modelagem.md](decisoes-modelagem.md). Não são modeladas arquitetura, persistência, funcionalidades excluídas ou dados reais de pacientes.

## 2. Convenções

- Classes em PascalCase; atributos, parâmetros e operações em camelCase, em português.
- Atributos privados (`-`); operações públicas no nível OO (`+`). Público não significa endpoint exposto ou acesso sem autorização.
- Associações representam propriedades dos objetos, encapsuladas, sem duplicação em atributos de IDs, listas ou chaves estrangeiras.
- `Data`, `Hora`, `DataHora`, `Texto`, `Inteiro`, `Booleano`, `SituacaoConta`, `SituacaoAgendamento`, `SituacaoCadastral`, `SituacaoVinculo` e `SituacaoFila` são tipos conceituais independentes de tecnologia. Precisão, fuso e armazenamento permanecem pendentes.
- Atributo ou parâmetro sem tipo tem **tipo PENDENTE**: não equivale a Texto, objeto genérico ou campo livre. Retorno omitido está **PENDENTE**, não significa void.
- O marcador Mermaid `$` indica operação de classe. `formalizar`, `solicitar` e os dois `registrar` são criações que retornam a instância válida indicada, não reescritas de instâncias existentes. A criação de `Agendamento` já produz um agendamento `CONFIRMADO`, conforme DEC-016 e DEC-017.
- A fila aprovada em DEC-027 é representada somente por `SolicitacaoEspera`; a situação `OFERTADA` representa uma oferta em andamento. A conversão em `Agendamento` depende da aceitação e da disponibilidade, sem classe independente `OfertaVaga`.
- `PENDENTE` nos extremos é anotação editorial, não multiplicidade UML válida. O modelo ainda não é um diagrama UML finalizado.
- Situações aprovadas são registradas conforme DEC-013, DEC-014, DEC-015 e DEC-027; as enumerações não são intercambiáveis.
- A alocação de responsabilidades e os nomes de membros são decisões OO desta etapa, fundamentadas nos requisitos citados; não se afirma que as fontes já continham essas assinaturas.

### Classificação das operações

As tabelas de cada classe distinguem **natureza documental** e **condicionamento**:

- **Comportamento diretamente sustentado:** o objetivo está expresso em RF; nome, alocação na classe, visibilidade e assinatura continuam escolhas OO.
- **Refinamento OO derivado:** decomposição proposta de uma responsabilidade/regra. Não equivale a operação literal exigida e requer validação dos Integrantes 1 e 2.
- **Contrato condicionado a definição pendente:** comportamento com regras, dados ou colaboração ainda incompletos, identificado na coluna Condicionamento. Pode coexistir com qualquer natureza anterior.

Os objetivos e refinamentos são classificados individualmente nas tabelas por classe. Tipos/retornos omitidos permanecem provisórios, inclusive quando a regra principal já está descrita. Nenhuma classificação comprova execução das regras.

## 3. Contratos transversais

Toda operação restrita exige identidade autenticada e autorização efetiva para o alvo. `solicitante: Usuario` identifica o contexto a verificar; passar uma instância de Usuario não prova autenticação ou autorização. A origem confiável e a colaboração de verificação serão alinhadas com o Integrante 2 (PC-12).

Pré-condição não satisfeita impede alteração de domínio bem-sucedida. Tipos de erro e resultados não especificados permanecem pendentes. Operações com regras incompletas são **contratos condicionados**, não algoritmos aprovados.

Alterações administrativas e outras classificadas como auditáveis devem ser concluídas com rastreabilidade. Especialmente `Paciente.alterarSituacao` e `Agendamento.cancelar` não satisfazem RN-009 sem auditoria correspondente. A entidade não é presumida responsável por gravação em banco. A colaboração necessária para preservar alteração e registro permanece PC-12; não se escolhem arquitetura, transações ou eventos.

Consultas não devolvem automaticamente dados integrais ou referências mutáveis: aplicam RN-003, RN-004 e RN-008, conforme ator, alvo e vínculo. Projeções e tipos de retorno ficam pendentes quando não especificados.

## 4. Classes

### Usuario

**Finalidade e responsabilidade:** Representar a conta de acesso, mantendo identidade, credencial protegida e situação da conta separadas dos cadastros de domínio.

**Fundamentação:** RF-001–006, RF-010; RN-001–002; RNF-001–003; PRE-001.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `identificacao` | PENDENTE | Identificação própria da conta (RF-003; PRE-001). Formato, geração e relação com login: PC-01. |
| `credencialProtegida` | PENDENTE | Representação segura exigida por RF-003 e RNF-001. Não é senha em texto puro; estrutura e mecanismo: PC-01. |
| `situacaoConta` | `SituacaoConta` | `ATIVO`, `BLOQUEADO`, `INATIVO` (DEC-013); apenas `ATIVO` permite autenticação. |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `ativar(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-02/PC-12: desbloqueio e colaboração. | RF-005; CA-RF-005 | Exige Administrador autenticado e autorizado e conta cadastrada. Habilita autenticação sem ampliar permissões. Não decide se ativar também desbloqueia; PC-02. Operação administrativa auditável. |
| `bloquear(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-02/PC-12: sessões existentes e colaboração. | RF-006; RN-001 | Exige Administrador autenticado e autorizado. Impede novas autenticações e mantém permissões sem ampliação. Deve integrar auditoria. Efeito em sessões existentes: PC-02. |
| `associarPerfil(perfil: Perfil, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-09/PC-12: cardinalidade; manutenção posterior não definida. | RF-003, RF-007–008; RNF-002 | RF-003 sustenta associação de perfil durante o cadastro, por Administrador autenticado e autorizado. RF-007 sustenta perfis disponíveis para associação, não um fluxo completo de alteração posterior. Não amplia privilégios fora dos limites do ator. Manutenção posterior de perfis depende de definição/validação em PC-09/PC-12; não está aprovada por esta assinatura. |
| `atualizarDadosPermitidos(dadosPermitidos, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-01/PC-12: campos, tipos e retorno. | RF-004; CA-RF-004 | Permite exclusivamente campos autorizados ao solicitante, incluindo dados próprios liberados nos termos atuais do RF-004. Não altera situação ou permissões por contorno às operações específicas. Estrutura dos dados: PC-01. |

**Relacionamentos:** A01, A03, A04 e A16.

**Restrições/invariantes:** Somente contas `ATIVO` autenticam; `BLOQUEADO` e `INATIVO` não autenticam (DEC-013). Credencial não é exposta por consultas nem auditoria. Alteração de dados não concede perfil adicional. A identificação do solicitante deve provir de autenticação confiável, não de uma identidade arbitrária fornecida pelo cliente.

**Pendências:** PC-01, PC-02, PC-09, PC-12.

### Perfil

**Finalidade e responsabilidade:** Agrupar responsabilidades e permissões de acesso; não representa dados profissionais de Psicologo.

**Fundamentação:** RF-003, RF-007–008; RNF-002; glossário.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `adicionarPermissao(permissao: Permissao, solicitante: Usuario)` | Refinamento OO derivado | Contrato condicionado a definição pendente — PC-03/PC-09/PC-12: proposta e colaboração a validar. | RF-008; CA-RF-008 | Exige Administrador autenticado e autorizado e perfil existente. Autorizações subsequentes consideram a associação, preservando limites dos atores; integrar auditoria administrativa. |
| `removerPermissao(permissao: Permissao, solicitante: Usuario)` | Refinamento OO derivado | Contrato condicionado a definição pendente — PC-03/PC-09/PC-12: possível revogação a validar. | RF-008; CA-RF-008 | Proposta de refinamento OO a validar: possível revogação da associação Perfil–Permissao, sem excluir o objeto Permissao. RF-008/CA-RF-008 não detalham isoladamente essa operação; sua inclusão não aprova um fluxo de revogação. Preserva os limites dos atores e integra auditoria. Reação a associação inexistente: PC-12. |

**Relacionamentos:** A01 e A02.

**Restrições/invariantes:** Acesso depende de permissões e das restrições de propriedade e vínculo; não basta o nome do perfil. Administrador é papel/perfil, não subclasse.

**Pendências:** Campos de identificação/nome não estão especificados: PC-03. Cardinalidades: PC-09.

### Permissao

**Finalidade e responsabilidade:** Representar autorização para uma operação da plataforma.

**Fundamentação:** RF-008; RNF-002; glossário; RN-003–004, RN-008.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

Nenhuma operação própria acrescentada por conveniência. Não foram gerados getters, setters ou CRUD automaticamente.

**Relacionamentos:** A02.

**Restrições/invariantes:** Uma permissão não elimina restrições de vínculo, identidade e privacidade. Não há método que conceda acesso irrestrito.

**Pendências:** PC-03: código, nome e representação da operação autorizada não definidos; nenhum atributo artificial foi acrescentado. Sua associação é mantida por Perfil.

### Psicologo

**Finalidade e responsabilidade:** Representar o cadastro profissional e delimitar acesso profissional aos pacientes vinculados.

**Fundamentação:** RF-011, RF-014–017, RF-031; RN-003, RN-007; RNF-006.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `atualizarDadosProfissionais(dadosPermitidos, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-04/PC-12: campos, tipos e retorno. | RF-015; CA-RF-015 | Exige Psicólogo autenticado correspondente a este cadastro. Atualiza somente os campos profissionais liberados; não altera a conta, papéis ou outros cadastros. Campos e tipo de dadosPermitidos: PC-04. |
| `associarAreaAtuacao(area: AreaAtuacao, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-03/PC-09/PC-12: limites e colaboração. | RF-016; CA-RF-016 | Exige área existente e próprio Psicólogo ou Administrador autenticado e autorizado. Associa a área a este profissional; não cria catálogo ou área por efeito colateral. |
| `consultarPacientesVinculados(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-04/PC-06/PC-12: autorização e projeção. | RF-017; RN-003 | Exige conta autenticada correspondente ao próprio profissional. Resultado contém exclusivamente pacientes com vínculo autorizado; projeção de dados e tipo do retorno: PC-04/PC-12. |
| `consultarHistoricoPermitido(paciente: Paciente, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-06/PC-08/PC-12: autorização e conteúdo. | RF-031; RN-003, RN-007 | Exige próprio profissional autenticado e vínculo autorizado com o paciente. Retorna somente registros permitidos associados ao profissional e ao vínculo. Conteúdo e retorno: PC-08/PC-12. |

**Relacionamentos:** A03, A05, A06, A08, A11 e A13.

**Restrições/invariantes:** Nenhuma consulta concede acesso ao cadastro global de pacientes. Perfil profissional não se confunde com Perfil. Consultas não devolvem automaticamente objetos mutáveis ou dados integrais.

**Pendências:** PC-04: campos profissionais, inclusive detalhamento do CRP citado apenas como processo candidato; PC-08, PC-09, PC-12.

### AreaAtuacao

**Finalidade e responsabilidade:** Representar campo de especialidade ou linha de atuação associado ao profissional.

**Fundamentação:** RF-016; PRE-002; glossário.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

Nenhuma operação própria acrescentada por conveniência. Não foram gerados getters, setters ou CRUD automaticamente.

**Relacionamentos:** A05.

**Restrições/invariantes:** Associar área pressupõe sua existência. Não se acrescenta funcionalidade de manutenção de catálogo sem definição do grupo.

**Pendências:** PC-03 e PC-09: atributos, manutenção do catálogo, mínimo durante cadastro, compartilhamento e limites de áreas.

### Paciente

**Finalidade e responsabilidade:** Representar cadastro administrativo de Cliente/Paciente e preservar o autoatendimento limitado.

**Fundamentação:** RF-012, RF-018–022, RF-028; RN-004, RN-009; RNF-005; DEC-006.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `situacaoCadastral` | `SituacaoCadastral` | `ATIVO`, `SUSPENSO`, `INATIVO` (DEC-014). Não se confunde com situacaoConta. |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `atualizarCadastro(dadosPermitidos, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-05/PC-12: campos e tipos. | RF-019; CA-RF-019 | Exige Administrador autenticado e autorizado. Atualiza apenas dados administrativos aprovados, sem notas profissionais, credenciais ou mudança de situação por contorno. Campos/tipo: PC-05. |
| `alterarSituacao(novaSituacao, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-12: auditoria e colaboração de aplicação. | RF-020; RN-009; DEC-014 | Exige Administrador autenticado e autorizado; os valores `ATIVO`, `SUSPENSO` e `INATIVO` podem transitar entre si. Registra a alteração para auditoria. Não é setter irrestrito e não aceita estado arbitrário. |
| `consultarCadastroPermitido(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-05/PC-12: campos liberados e retorno. | RF-022; RN-004; CA-RF-022 | Consulta de autoatendimento: exige conta autenticada correspondente a este paciente. Expõe somente informações próprias liberadas, sem dados de terceiros ou notas restritas. Projeção/retorno: PC-05/PC-12. |

**Relacionamentos:** A04, A07, A12 e A14.

**Restrições/invariantes:** Alteração relevante de situação sem rastreabilidade não satisfaz o contrato. Consulta própria não equivale a consulta administrativa global nem concede acesso ao histórico profissional.

**Pendências:** PC-05, PC-09 e PC-12.

### Vinculo

**Finalidade e responsabilidade:** Representar a relação formal e autorizada entre exatamente um Psicologo e um Paciente.

**Fundamentação:** RF-017, RF-021, RF-024–025, RF-030–031; RN-003, RN-007.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `situacao` | `SituacaoVinculo` | `ATIVO` ou `ENCERRADO` (DEC-015); somente `ATIVO` autoriza acesso. |
| `dataInicio` | `Data` | Início do vínculo (DEC-015). |
| `dataFim` | `Data` | Fim do vínculo, preenchido no encerramento (DEC-015). |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `formalizar(psicologo: Psicologo, paciente: Paciente, solicitante: Usuario) Vinculo$` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-06/PC-09/PC-12: limites e colaboração. | RF-021; CA-RF-021 | Operação de criação: exige Administrador autenticado e autorizado e cadastros válidos. Produz vínculo para o par informado e o torna considerado nas autorizações profissionais. Não altera participantes de vínculo preexistente. Limites/duplicidade dependem de PC-06. |
| `estaAutorizado() Booleano` | Refinamento OO derivado | Contrato condicionado a definição pendente — PC-06/PC-12: critério completo e colaboração. | RN-003, RN-007; RF-021; DEC-015 | Consulta sem mutação derivada das regras; vínculo em situação `ATIVO` autoriza acesso, enquanto `ENCERRADO` não. Não substitui autenticação/permissão nem define sozinho todos os critérios de acesso. |
| `encerrar(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-12: auditoria e colaboração de aplicação. | DEC-015; RN-003/RN-007 | Encerra o vínculo, define `situacao = ENCERRADO` e `dataFim`; depois disso o vínculo não autoriza acesso. Agendamentos futuros não são cancelados automaticamente. |

**Relacionamentos:** A06 e A07. As referências aos dois participantes são propriedades de associação, não cópias de seus dados.

**Restrições/invariantes:** A existência de dois cadastros, sozinha, não constitui vínculo autorizado. Somente situação `ATIVO` autoriza acesso. Não oferecer reassociação genérica de participantes.

**Pendências:** PC-06: limites/duplicidade e critério completo de autorização; PC-12: colaboração de auditoria.

### Agenda

**Finalidade e responsabilidade:** Organizar disponibilidade e compromissos do profissional titular e apoiar a verificação de horários.

**Fundamentação:** RF-023–025, RF-029; RN-005, RN-010–011.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `adicionarDisponibilidade(disponibilidade: Disponibilidade, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: criação, validação e representação temporal. | RF-023; RN-011 | RF-023 sustenta cadastrar período na própria agenda por Psicólogo autenticado titular. Esta operação descreve a associação da instância recebida, considerando conflitos e compromissos. Criação da instância, validação completa e representação temporal ainda não estão detalhadas (PC-07/PC-12). Não transfere períodos de outro profissional. |
| `verificarDisponibilidade(horario) Booleano` | Refinamento OO derivado | Contrato condicionado a definição pendente — PC-07/PC-12: conflito e representação temporal. | RF-024–025; RN-005, RN-010 | Refinamento OO derivado para verificação interna de domínio, sem reserva ou alteração. Não substitui a consulta que apresenta horários disponíveis de RF-024. Considera período oferecido e conflitos ativos no instante da consulta. Tipo temporal, fronteiras de sobreposição e estados ativos: PC-07. Um resultado verdadeiro não dispensa nova verificação ao solicitar/confirmar. |

**Relacionamentos:** A08, A09 e A10.

**Restrições/invariantes:** Horários de outro profissional não podem ser administrados como próprios. A consulta de horários exposta ao paciente exige vínculo autorizado (RF-024); verificarDisponibilidade é uma verificação de regra, não um endpoint público de autoatendimento. A08 e A09 seguem as cardinalidades fechadas na tabela abaixo.

**Pendências:** PC-07, PC-09 e PC-12. Não foram escolhidos algoritmos de concorrência, recorrência ou fuso.

### Disponibilidade

**Finalidade e responsabilidade:** Representar o slot discreto oferecido pelo profissional na própria agenda (DEC-018).

**Fundamentação:** RF-023–025; RN-005, RN-010–011; glossário.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `periodo` | `DataHora` | Slot discreto oferecido (DEC-018); precisão/fuso e valor da duração fixa permanecem não especificados. |

**Operações públicas e contratos:**

Nenhuma operação própria acrescentada por conveniência. Não foram gerados getters, setters ou CRUD automaticamente.

**Relacionamentos:** A09.

**Restrições/invariantes:** Um slot pertence à agenda do próprio profissional. Cada slot pode estar ligado a no máximo um Agendamento (A17); a existência do slot não significa que esteja livre.

**Pendências:** PC-07 e PC-09. Não foram inventados setters, métodos de recorrência ou propriedades inicio/fim tipadas sem decisão temporal.

### SolicitacaoEspera

**Finalidade e responsabilidade:** Representar a inscrição do paciente em uma fila de interesse para um horário do psicólogo, conforme DEC-027 e RF-034 a RF-036.

**Fundamentação:** DEC-027; RF-034; RN-021; UC-034 a UC-036.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `situacao` | `SituacaoFila` | `AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU` (DEC-027); `OFERTADA` representa a oferta vigente. |
| `dataHoraEntrada` | `DataHora` | Instante de entrada na fila, usado na ordenação aprovada em DEC-027. |
| `prazoAceite` | `DataHora` | Prazo para aceitar a oferta, conforme DEC-027. |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `registrarEntrada(psicologo: Psicologo, paciente: Paciente, horario: DataHora, solicitante: Usuario) SolicitacaoEspera$` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: validações temporais e colaboração. | DEC-027; RF-034 | Cria a inscrição do paciente para um slot específico e registra a data/hora de entrada para ordenar a fila. |
| `abrirOferta(horario: DataHora, prazoAceite: DataHora)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: colaboração de notificação. | DEC-027; RF-035 | Transita a solicitação para `OFERTADA` quando o slot fica disponível; não cria uma entidade de oferta separada. |
| `aceitar(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: aceitação e colaboração de agenda. | DEC-027; RF-036 | Converte a solicitação em agendamento somente com aceite válido e disponibilidade mantida. |
| `recusar(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: avanço da fila. | DEC-027; RF-036 | Registra a recusa e permite continuar o fluxo da fila conforme a decisão aprovada. |
| `expirar()` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: processamento do prazo. | DEC-027; RF-036 | Encerra oferta não aceita dentro do prazo aprovado. |
| `encerrar(motivo, solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: motivo e rastreabilidade. | RF-034–036; DEC-027 | Encerra a participação por desistência, recusa ou expiração; não gera agendamento sem aceite válido. |
| `consultarPosicao() Inteiro` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: projeção da posição da fila. | RF-034; DEC-027 | Retorna posição numérica calculada pela ordem de entrada e estado atual da fila. |

**Relacionamentos:** A18, A19, A20 e A21.

**Restrições/invariantes:** A fila não substitui o agendamento; uma solicitação em situação `OFERTADA` representa a oferta. A conversão em `Agendamento` exige aceite e disponibilidade mantida.

### Agendamento

**Finalidade e responsabilidade:** Representar a reserva de horário e controlar o cancelamento sem confundir a sessão agendada com a sessão realizada.

**Fundamentação:** RF-025–029; RN-005–006, RN-009–010, RN-012–013; DEC-016 e DEC-017.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `horario` | `DataHora` | Slot solicitado, conforme RF-025 e DEC-018. |
| `situacao` | `SituacaoAgendamento` | `CONFIRMADO`, `CANCELADO`, `REALIZADO`, `NAO_COMPARECEU` (DEC-016); nome presente nas demais especificações UML/dossiê. |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `solicitar(psicologo: Psicologo, paciente: Paciente, horario: DataHora, solicitante: Usuario) Agendamento$` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: reserva e colaboração. | RF-025; RN-003, RN-005, RN-010; DEC-016–018 | Criação condicionada: exige conta autenticada do paciente indicado, vínculo autorizado com o profissional e slot disponível no momento da solicitação. O agendamento é criado diretamente em `CONFIRMADO`, sem passo separado de confirmação. Associa os participantes, o slot e a agenda coerente. |
| `cancelar(solicitante: Usuario)` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-07/PC-12: colaboração e auditoria. | RF-027; RN-006, RN-009, RN-012; DEC-011, DEC-028 | Pode ser feito pelo paciente titular ou pelo psicólogo responsável, antes do horário marcado; Administrador não cancela. Passa a `CANCELADO`, preserva rastreabilidade e impede posterior registro como atendimento realizado. |

**Relacionamentos:** A10, A11, A12, A15, A17 e A21.

**Restrições/invariantes:** `{agenda.psicologo = psicologo}`. Não há setSituacao(). A solicitação exige disponibilidade no instante da reserva. A relação A15 com `Atendimento` é associação simples: cada atendimento corresponde a um agendamento e cada agendamento tem `0..1` atendimento, sem composição. Cancelamento não pode ser usado para contornar regras da realização.

**Pendências:** PC-07, PC-09, PC-12. Não se presumem remarcação, confirmação automática, falta ou expiração.

### Atendimento

**Finalidade e responsabilidade:** Representar o registro conceitual de uma sessão efetivamente realizada.

**Fundamentação:** RF-030–031; RN-003, RN-006–007; DEC-008.

**Atributos privados:**

Nenhum atributo escalar fixado sem sustentação suficiente. As associações compõem a estrutura; ausência de campos escalares não significa ausência de identidade conceitual ou responsabilidades.

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `registrar(psicologo: Psicologo, paciente: Paciente, contextoSessao, solicitante: Usuario) Atendimento$` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-08/PC-10/PC-12, conforme classe: contexto, tipos e colaboração. | RF-030; RN-003, RN-006–007; CA-RF-030 | Operação de criação: exige conta autenticada do profissional indicado, participantes válidos, vínculo autorizado entre eles e sessão válida da agenda. Recusa contexto de agendamento cancelado. Produz registro conceitual com participantes coerentes com a sessão; conteúdo/tipo do contexto: PC-08. Não recebe um booleano fornecido pelo cliente como prova de validade. |

**Relacionamentos:** A13, A14 e A15. O parâmetro contextoSessao não fixa cardinalidade de A15 nem cria outra entidade.

**Restrições/invariantes:** `{agendamento.psicologo = psicologo e agendamento.paciente = paciente}`. Não existe Atendimento válido sem participantes e vínculo autorizado. Cancelamento impede posterior registro realizado. Não foram acrescentados prontuário completo, diagnóstico ou notas clínicas.

**Pendências:** PC-08, PC-09 e PC-12: conteúdo mínimo, dados temporais próprios, relação exata com Agendamento e semântica de duplicidade não definidos.

### RegistroAuditoria

**Finalidade e responsabilidade:** Preservar evento cronológico, rastreável e logicamente imutável da operação auditável.

**Fundamentação:** RF-013, RF-032; RN-008–009, RN-014; RNF-004.

**Atributos privados:**

| Atributo | Tipo | Semântica e fundamento |
|---|---|---|
| `data` | Data | Data da operação, explicitamente exigida por RF-032. Imutável após criação; precisão/contexto temporal: PC-10. |
| `hora` | Hora | Hora da operação, explicitamente exigida por RF-032. Imutável após criação; precisão/fuso: PC-10. |
| `operacao` | `Texto` | Identificação da operação exigida por RF-032. Vocabulário: PC-10. Imutável após criação. |

**Operações públicas e contratos:**

| Assinatura no diagrama | Natureza documental | Condicionamento | Base | Pré-condições, efeito e limites |
|---|---|---|---|---|
| `registrar(responsavel: Usuario, data: Data, hora: Hora, operacao: Texto) RegistroAuditoria$` | Comportamento diretamente sustentado | Contrato condicionado a definição pendente — PC-10/PC-12: vocabulário e colaboração. | RF-032; RN-009, RN-014; CA-RF-032 | Criação de novo evento a partir de uma operação efetivamente auditável. Responsável e dados temporais devem provir do contexto confiável dessa operação, não de entrada livre do paciente. Acrescenta registro sem modificar anteriores, sem senhas/segredos. Não é edição de instância existente. |

**Relacionamentos:** A16 representa o responsável pela operação (imutável após criação), não o objeto afetado nem quem pode consultar.

**Restrições/invariantes:** A exigência documental de imutabilidade consta no escopo 3.7, RF-032 e RN-014. A concretização OO escolhida é não oferecer atualizar(), excluir() ou setters e manter campos e associação ao responsável imutáveis após criação. Isso não define política de retenção, descarte ou administração extraordinária. A coleção/trilha deve preservar cronologia; datas isoladas não garantem ordenação. Consulta administrativa exige autorização e não altera registros.

**Pendências:** PC-10 e PC-12: eventos adicionais, ordenação de eventos simultâneos, representação da operação e integração com alterações auditáveis.

## 5. Relacionamentos e multiplicidades

Preservam-se as 21 associações simples A01–A21. Não há herança, agregação ou composição. “Esquerda por direita” indica quantidade de instâncias da classe esquerda para cada instância da direita.

| ID | Esquerda — direita | Esquerda por direita | Direita por esquerda | Fundamentação |
|---|---|---|---|---|
| A01 | Perfil — Usuario | 1 | 0..* | DEC-019 |
| A02 | Perfil — Permissao | 1..* | 1..* | RF-007–008 |
| A03 | Usuario — Psicologo | 0..1 | 0..1 | DEC-021 |
| A04 | Usuario — Paciente | 0..1 | 0..1 | DEC-021 |
| A05 | Psicologo — AreaAtuacao | PENDENTE | 0..* | RF-016 sustenta a associação; mínimo de áreas por psicólogo e compartilhamento de área entre psicólogos não definidos pelos requisitos; fica como pendência do grupo (PC-09). |
| A06 | Psicologo — Vinculo | 1 | 0..* | RF-021; RN-003 |
| A07 | Paciente — Vinculo | 1 | 0..* | RF-021; RN-007 |
| A08 | Psicologo — Agenda | 1 | 1 | RF-023, RF-029; RN-011 |
| A09 | Agenda — Disponibilidade | 1 | 0..* | RF-023; RN-011 |
| A10 | Agenda — Agendamento | 1 | 0..* | RF-029 |
| A11 | Psicologo — Agendamento | 1 | 0..* | RF-025–026 |
| A12 | Paciente — Agendamento | 1 | 0..* | RF-025, RF-028 |
| A13 | Psicologo — Atendimento | 1 | 0..* | RF-030; RN-007 |
| A14 | Paciente — Atendimento | 1 | 0..* | RF-030; RN-007 |
| A15 | Agendamento — Atendimento | 1 | 0..1 | RF-030; RN-006; DEC-030 |
| A16 | Usuario — RegistroAuditoria | 1 | 0..* | RF-032; RNF-004 |
| A17 | Disponibilidade — Agendamento | 1 | 0..1 | DEC-018; RN-005 |
| A18 | Psicologo — SolicitacaoEspera | 1 | 0..* | DEC-027; RF-034 |
| A19 | Paciente — SolicitacaoEspera | 1 | 0..* | DEC-027; RF-034 |
| A20 | Disponibilidade — SolicitacaoEspera | 1 | 0..* | DEC-027; RF-035 |
| A21 | SolicitacaoEspera — Agendamento | 0..1 | 0..1 | DEC-027; RF-035; RF-036 |

As cardinalidades A01, A03 e A04 refletem DEC-019 e DEC-021; A02 e A05 são justificadas pelos RFs indicados; A10 por RF-029. A08 e A09 estão fechadas como um titular por agenda e uma agenda por disponibilidade, com múltiplas disponibilidades por agenda, conforme a tabela do domínio.

Fechamento formal de A01 a A04 e A10 consta em [decisoes-modelagem.md](decisoes-modelagem.md) §7. A05 segue `PENDENTE` (PC-09).

A16 não concede consulta ao responsável pelo evento. A05 não fixa mínimo durante cadastro ou compartilhamento. A15 segue DEC-030: cada atendimento corresponde a um agendamento e cada agendamento tem zero ou um atendimento.

São propriedades de associação com extremo 1: participantes de Vinculo, titular de Agenda, agenda de Disponibilidade, participantes de Agendamento e Atendimento e responsável por RegistroAuditoria. Não foram duplicadas em campos de IDs nem convertidas em listas obrigatórias.

O profissional do compromisso deve ser coerente com o titular da agenda; participantes do atendimento correspondem à sessão válida e possuem vínculo autorizado. Parâmetros de métodos não criam associações estruturais adicionais nem decidem cardinalidades pendentes.

## 6. Cobertura funcional por requisito

A classificação descreve a cobertura documental desta versão, não aprovação do RF ou garantia de execução:

- **representado no modelo:** objetivo com classe/operação e contrato correspondente; tipos e colaboração podem continuar pendentes.
- **parcialmente representado:** estrutura ou parte da responsabilidade presente, com lacuna funcional identificada.
- **aguardando definição:** regra de negócio pendente impede fechar o contrato.
- **colaboração posterior:** objetivo de aplicação/consulta ainda sem responsabilidade operacional detalhada nas entidades atuais; deve ser alinhado ao Integrante 2.

A situação predominante aparece por RF; as pendências da última coluna continuam aplicáveis. Nenhuma classe ou método foi criado apenas para elevar cobertura.

| RF | Cobertura | Evidência e lacuna | Pendências |
|---|---|---|---|
| RF-001 | colaboração posterior | Conta e credencial dão suporte; fluxo de autenticação e autorização não detalhado. | PC-01/PC-02/PC-12 |
| RF-002 | colaboração posterior | Encerramento de sessão sem colaboração definida; não exige criar método artificial na entidade. | PC-12 |
| RF-003 | parcialmente representado | Usuario e associarPerfil durante cadastro; criação completa da conta não detalhada. | PC-01/PC-09/PC-12 |
| RF-004 | representado no modelo | Objetivo em atualizarDadosPermitidos; campos e assinatura ainda provisórios. | PC-01/PC-12 |
| RF-005 | representado no modelo | Objetivo em ativar; interpretação como desbloqueio permanece aberta. | PC-02/PC-12 |
| RF-006 | representado no modelo | Objetivo em bloquear; efeito em sessões abertas ainda pendente. | PC-02/PC-12 |
| RF-007 | parcialmente representado | Perfil e suas associações existem; cadastro, alteração e consulta do perfil não totalmente atribuídos. | PC-03/PC-12 |
| RF-008 | parcialmente representado | Perfil–Permissao e refinamentos adicionar/remover; manutenção e consulta completas ainda a validar. | PC-03/PC-09/PC-12 |
| RF-009 | colaboração posterior | Painel é interface, sem classe de domínio ou fluxo de aplicação criado aqui. | PC-12 |
| RF-010 | colaboração posterior | Consulta administrativa de usuários sem operação/colaboração atribuída; restrição de credencial permanece. | PC-01/PC-12 |
| RF-011 | colaboração posterior | Consulta administrativa de profissionais sem colaboração detalhada. | PC-04/PC-12 |
| RF-012 | colaboração posterior | Consulta administrativa de pacientes sem colaboração detalhada; não se confunde com consulta própria. | PC-05/PC-12 |
| RF-013 | colaboração posterior | RegistroAuditoria e restrição RN-008 presentes; consulta administrativa ainda não atribuída. | PC-10/PC-12 |
| RF-014 | parcialmente representado | Psicologo separado de Usuario; criação completa do cadastro não detalhada. | PC-04/PC-09/PC-12 |
| RF-015 | representado no modelo | Objetivo em atualizarDadosProfissionais; campos ainda pendentes. | PC-04/PC-12 |
| RF-016 | representado no modelo | Objetivo em associarAreaAtuacao; limites e catálogo não presumidos. | PC-03/PC-09/PC-12 |
| RF-017 | representado no modelo | Objetivo em consultarPacientesVinculados; critério completo e projeção pendentes. | PC-04/PC-06/PC-12 |
| RF-018 | parcialmente representado | Paciente separado da conta; criação completa do cadastro ainda não detalhada. | PC-05/PC-09/PC-12 |
| RF-019 | representado no modelo | Objetivo em atualizarCadastro; campos administrativos pendentes. | PC-05/PC-12 |
| RF-020 | representado no modelo | alterarSituacao contempla o objetivo; estados `ATIVO`, `SUSPENSO` e `INATIVO` seguem DEC-014. Auditoria permanece condicionada. | PC-05/PC-12 |
| RF-021 | representado no modelo | Objetivo em formalizar; duplicidade, limites e autorização completa pendentes. | PC-06/PC-09/PC-12 |
| RF-022 | representado no modelo | Objetivo em consultarCadastroPermitido; projeção de campos pendente. | PC-05/PC-12 |
| RF-023 | parcialmente representado | adicionarDisponibilidade recebe instância; criação, validação e representação temporal incompletas. | PC-07/PC-12 |
| RF-024 | colaboração posterior | Verificação booleana interna não apresenta a lista/faixas de horários ao paciente vinculado. | PC-07/PC-12 |
| RF-025 | representado no modelo | solicitar cria o agendamento diretamente como `CONFIRMADO` quando o slot está disponível, conforme DEC-016–018. | PC-07/PC-12 |
| RF-026 | parcialmente representado | A confirmação é automática na criação (DEC-017); não se modela operação separada `confirmar`. | PC-07/PC-12 |
| RF-027 | representado no modelo | cancelar aplica atores e antecedência de DEC-011/028; colaboração de auditoria permanece condicionada. | PC-07/PC-12 |
| RF-028 | colaboração posterior | Associação ao paciente e restrição de acesso existem; consulta dos próprios agendamentos não detalhada. | PC-12 |
| RF-029 | colaboração posterior | Agenda e titular existem; consulta da agenda própria não detalhada. | PC-09/PC-12 |
| RF-030 | parcialmente representado | registrar contempla vínculo e sessão válida; contexto e conteúdo mínimo incompletos. | PC-08/PC-09/PC-12 |
| RF-031 | parcialmente representado | consultarHistoricoPermitido presente; conteúdo, autorização completa e resultado pendentes. | PC-06/PC-08/PC-12 |
| RF-032 | parcialmente representado | Registro imutável e registrar presentes; colaboração de auditoria e escopo adicional pendentes. | PC-10/PC-12 |

RF-001–032 são requisitos registrados, não requisitos declarados estáveis/aprovados: o README de requisitos mantém a revisão do grupo pendente. A integração com casos de uso não está completa. As assinaturas e os mecanismos de criação, consulta, autorização e auditoria devem ser refinados com os Integrantes 1 e 2 sem pressupor novas funcionalidades.

## 7. Revisão cruzada

- Diagrama × especificação: correspondência de 13 classes e 21 associações; as tabelas documentam atributos, operações, contratos e pendências.
- Classes × requisitos: cada classe possui fontes, sem classes independentes de atores ou funcionalidades excluídas.
- Métodos × regras: os contratos contemplam RN-003/RN-004 nas consultas/autorização, RN-005 na solicitação/confirmação, RN-006/RN-007 no atendimento, RN-009 nas alterações relevantes e RN-014 na auditoria. Isso declara a preservação pretendida; os mecanismos e colaborações ainda não modelados não foram demonstrados.
- Relacionamentos × domínio: A01–A21 e seus extremos são preservados.
- Limites: revisão textual/estrutural não significa aprovação do grupo, execução dos contratos ou validação visual por renderizador Mermaid.

### Verificação P10

No diagrama oficial [diagrama-classes.mmd](diagrama-classes.mmd), `adicionarDisponibilidade` e `estaAutorizado` aparecem uma única vez cada. As tabelas desta especificação descrevem os contratos dessas operações sem duplicar declarações no diagrama.

**Adendo (08/11/2026):** os nomes duplicados foram unificados em `adicionarDisponibilidade` e `estaAutorizado` (OO-19). Nos artefatos do I3, `cadastrarDisponibilidade` e `estaAtivo` não são mais usados como nomes de operação.

