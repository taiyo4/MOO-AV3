# Decisões de modelagem OO

**Responsável:** Integrante 3.  
**Status:** decisões de representação OO para revisão; não substituem DEC oficiais nem aprovam pendências de requisitos.

Referências: [especificação de classes](especificacao-classes.md), [diagrama de classes](diagrama-classes.mmd), [modelo de domínio](../Dominio/modelo-dominio.md), [RF](../../02-requisitos/requisitos-funcionais.md), [RN](../../02-requisitos/regras-negocio.md), [RNF](../../02-requisitos/requisitos-nao-funcionais.md), [glossário](../../02-requisitos/glossario.md), [decisões oficiais](../../01-planejamento/decisoes.md) e [escopo](../../02-requisitos/escopo.md).

## 1. Decisões tomadas nesta etapa

| ID local | Decisão e justificativa OO | Base e limite |
|---|---|---|
| OO-01 | Preservar Usuario, Psicologo e Paciente como classes distintas associadas. Conta de acesso e cadastros têm responsabilidades diferentes. | RF-014 distingue conta/cadastro; RF-018, DEC-006. Não há generalização automática. |
| OO-02 | Administrador é papel/perfil, sem classe independente. Perfil significa acesso, não perfil profissional. | Glossário; RF-007–008, RF-015. Nenhum cadastro próprio de Administrador foi exigido. |
| OO-03 | Preservar as 21 associações do domínio. Não há herança, agregação ou composição; A15 é associação simples `0..1–1`, conforme DEC-030. | Domínio A01–A21; RNF-007–008; DEC-030. Nenhuma exclusão em cascata foi presumida. |
| OO-04 | Declarar atributos privados e operações de intenção explícita; não gerar getters/setters. Associação também é propriedade encapsulada. | RNF-008; RN-003–007, RN-014. Encapsulamento estrutural não substitui autorização. |
| OO-05 | Separar estados da conta (`ATIVO`, `BLOQUEADO`, `INATIVO`), paciente (`ATIVO`, `SUSPENSO`, `INATIVO`), vínculo (`ATIVO`, `ENCERRADO`), fila e agendamento. | DEC-013–015, DEC-016–017, DEC-027. |
| OO-06 | Usar tipos conceituais justificados, incluindo `DataHora`, `Data`, `Texto`, `Inteiro` e `SituacaoConta`; não inventar nomes de tipo para estados cujo nome de enumeração ainda requer alinhamento. | RF-032; RF-024–025; DEC-013–015, DEC-018, DEC-027. |
| OO-07 | Métodos públicos OO continuam sujeitos a autenticação e autorização. Quando ator é conhecido, solicitante: Usuario explicita o contexto a validar. | RF e RNF-002. Instância passada por argumento não é prova de autorização; origem confiável pendente PC-12. |
| OO-08 | adicionarPermissao/removerPermissao são refinamentos OO derivados de manter/atualizar associações, não operações literais isoladas em RF-008. removerPermissao é proposta de possível revogação Perfil–Permissao, nunca exclusão da Permissao. | RF-008 e CA-RF-008. Natureza, fluxo e limites devem ser validados com Integrantes 1 e 2; PC-03/PC-09/PC-12 preservadas. |
| OO-09 | Paciente.alterarSituacao tem contrato condicionado e exige transição autorizada e auditoria. Não há setter irrestrito; os estados `ATIVO`, `SUSPENSO` e `INATIVO` seguem DEC-014. | RF-020; RN-009; DEC-014. A colaboração de auditoria continua pendente. |
| OO-10 | `formalizar` expressa RF-021; `estaAutorizado` é refinamento derivado. Vínculo tem `situacao`, `dataInicio` e `dataFim`; somente `ATIVO` autoriza acesso. | RN-003, RN-007; DEC-015; RF-021. Critério de autorização e colaboração continuam condicionados. |
| OO-11 | `adicionarDisponibilidade` representa slots de RF-023; A17 liga cada slot a no máximo um agendamento. `verificarDisponibilidade` não substitui a consulta RF-024. | RF-023–026; RN-005/RN-010; DEC-018. Precisão temporal e colaboração seguem pendentes. |
| OO-12 | Agendamento controla o ciclo de vida do compromisso e o cancelamento; a criação e a confirmação do agendamento são o mesmo ato, conforme DEC-016 e DEC-017. Atendimento registra sessão válida como objeto distinto. Contratos conhecidos não aprovam parâmetros ausentes. | RF-025–030; RN-006/RN-007/RN-012/RN-013; DEC-016/DEC-017. Sem estado `SOLICITADO` nem limite 1:1 inventado. |
| OO-12A | A relação entre `Agendamento` e `Atendimento` é modelada como `0..1 ↔ 1` (A15), porque o atendimento é um registro válido da sessão do compromisso, sem criar um atendimento inicial antes do agendamento ou uma composição automática. | RF-030; RN-006; DEC-030. Não se inventa um atendimento sem o agendamento correspondente. |
| OO-12B | A fila aprovada em DEC-027 é representada por `SolicitacaoEspera`; a situação `OFERTADA` indica que a vaga foi oferecida. A conversão em agendamento ocorre após aceite e disponibilidade mantida. | RF-034 a RF-036; DEC-027; RN-021; A18–A21. |
| OO-12C | Não existe classe independente `OfertaVaga`: a oferta é uma situação transitória da solicitação. Isso evita duplicar estado e prazo e mantém aceite, recusa e expiração no ciclo de vida da `SolicitacaoEspera`. | DEC-027; RF-034–036; RN-021; decisão de persistência no dicionário de dados e DER. |
| OO-13 | formalizar, solicitar e os dois registrar têm objetivo funcional sustentado. Representá-los como operações estáticas de criação com retorno é escolha OO proposta, não exigência literal dos RFs. | RF-021, RF-025, RF-030, RF-032. Validar colaboração com Integrante 2 (PC-12); não define cardinalidade histórica ou idempotência. |
| OO-14 | Exigência documental: imutabilidade da auditoria. Concretização OO: campos e responsável imutáveis após criação e ausência de métodos comuns de edição/exclusão/setters. | Escopo 3.7, RF-032, RN-014. Não define retenção, descarte ou administração extraordinária. Cronologia da trilha ainda exige colaboração não detalhada. |
| OO-15 | Registrar rastreabilidade como pós-condição obrigatória dos casos auditáveis; não criar dependência estrutural de toda classe para RegistroAuditoria. | RN-009, RF-032. Integração das mudanças com auditoria será detalhada nas sequências; não se presume gravação em banco pela entidade. |
| OO-16 | Não atribuir automaticamente operações de sistema (painel, login, sessão, busca global) a uma entidade ou criar classes técnicas para preencher cobertura. | RF-001–002, RF-009–013; RNF-008. Registrar colaboração ainda necessária com Integrante 2. |
| OO-17 | A05 permanece `PENDENTE` e é registrado como pendência declarada: mínimo de áreas por psicólogo e compartilhamento de área entre psicólogos não definidos pelos requisitos (PC-09). | RF-016; PC-09. |
| OO-18 | **Proposta (sujeita à aprovação do grupo):** OBJ-002 permanece separado de OBJ-001. OBJ-001 é fotografia estrutural com agendamento confirmado; OBJ-002 mostra o ciclo com situações `REALIZADO` e `CANCELADO`. Não se funde em uma única fotografia. | Pendência P9 (decisão sobre OBJ-002); `especificacao-objetos.md` §2. Não é DEC oficial. |
| OO-19 | Nomes canônicos das operações duplicadas (P10): `adicionarDisponibilidade` (não `cadastrarDisponibilidade`) e `estaAutorizado` (não `estaAtivo`). Os nomes do diagrama oficial são mantidos. | Q5-09; DEC-015; DEC-018. Alinhamento dos artefatos do I2 e do dossiê pendente (ver §7). |

### Precisão da classificação

As operações estão classificadas individualmente na especificação. Os contratos condicionados são uma classificação adicional: a existência de um objetivo não fecha assinatura, regra, tipo ou colaboração.

Usuario.associarPerfil tem suporte direto em RF-003 durante o cadastro. RF-007 apenas reforça a disponibilidade de perfis para associação; não detalha fluxo completo de alteração posterior. Manutenção posterior permanece condicionada à definição/validação em PC-09/PC-12.

Assinaturas ainda incompletas, incluindo cancelar, permanecem condicionadas. A01 segue DEC-019; A03/A04 seguem DEC-021; A02 e A10 seguem RF-007 e RF-029. A05 é sustentada por RF-016; RF-008, indicado no checklist, trata permissões e não fundamenta essa associação. A08/A09 estão fechadas como um profissional por agenda e múltiplas disponibilidades por agenda.

### Fechamento documental com evidência

| Associação | Decisão adotada | Evidência |
|---|---|---|
| A01 | Cada Usuario possui um Perfil; um Perfil pode ser compartilhado por várias contas. | DEC-019. |
| A02 | Perfil agrupa permissões conforme o gerenciamento de perfis. | RF-007. |
| A03, A04 | Conta e cadastro profissional/paciente são opcionais em ambos os lados, com cardinalidades 0..1. | DEC-021. |
| A05 | Psicologo associa-se a AreasAtuacao; a associação tem suporte em RF-016. RF-008 não é sua fundamentação. | RF-016. |
| A06, A07 | Um vínculo mantém exatamente um Psicólogo e um Paciente; o participante pode ter vários vínculos. | RF-021; RN-003; RN-007. |
| A08 | Um Psicologo tem uma Agenda e uma Agenda é de um único Psicologo. | RF-023; RF-029; RN-011. |
| A09 | Uma Agenda contém várias Disponibilidades; cada Disponibilidade pertence a uma Agenda. | RF-023; RN-011. |
| A10 | Uma Agenda apresenta vários Agendamentos; cada Agendamento pertence a exatamente uma Agenda. | RF-029; regra de agendamento e conflito de agenda. |
| A11, A12 | Um Agendamento é de um único Psicologo e de um único Paciente. | RF-025; RF-026; RN-005; RN-010. |
| A13, A14 | Um Atendimento é de um único Psicologo e de um único Paciente. | RF-030; RN-007; DEC-030. |
| A15 | Associação `0..1–1`, sem composição; o Atendimento sempre se refere a um Agendamento. | DEC-030; RN-006. |
| A17 | Um slot de Disponibilidade é ocupado por no máximo um Agendamento. | DEC-018; RN-005. |
| A18–A21 | `SolicitacaoEspera` modela a fila; a situação `OFERTADA` representa a oferta e a conversão exige aceite/disponibilidade. | DEC-027; RF-034 a RF-036; RN-021. |

A ausência de herança, composição e agregação vale para a evidência atual. Administrador continua papel; Usuario, Psicologo e Paciente mantêm responsabilidades separadas. Nada disso autoriza subclasses apenas por permissões.

## 2. Hipóteses evitadas

- Não foram criados nome, CPF, telefone, e-mail, login, identificadores técnicos ou descrições em todas as classes por costume.
- O CRP aparece como processo candidato nas interações do Integrante 2; não foram definidos formato, validação ou obrigatoriedade sem confirmação dos campos profissionais.
- Não se presume que cada conta pertença obrigatoriamente a um cadastro profissional ou de paciente; A03/A04 seguem DEC-021. Uma conta possui no máximo um perfil (DEC-019).
- Não se define catálogo de áreas, remoção de área, desativação de profissional ou exclusão de registros.
- Não se criam atributos de coleção para transformar PENDENTE em 0..* implicitamente.
- Datas e estados de Vinculo seguem DEC-015; não se presume cancelamento automático de agendamentos futuros ao encerrar.
- Não se equipara ativar a desbloquear automaticamente.
- Não se modelam remarcação ou confirmação separada; o agendamento nasce confirmado (DEC-016/017). A duração fixa do slot segue DEC-018 e expiração de oferta DEC-027.
- Não se aceita um booleano enviado pelo cliente como prova de vínculo autorizado, sessão válida ou permissão.
- Não se presume que todo agendamento gere exatamente um atendimento, ou que uma operação repetida de registro seja idempotente.
- Não se fecha o conteúdo clínico do atendimento ou se expõem registros profissionais ao paciente.
- Não se incluem Pagamento, ProntuarioCompleto ou outras funcionalidades fora do escopo (DEC-008). A fila e a fronteira de e-mail seguem DEC-009/010/022.
- Não se acrescentam repositórios, controladores, serviços, mecanismos criptográficos ou modelo relacional nesta etapa.

## 3. Pendências de atributos, tipos e comportamento

Os códigos PC são locais. “Integrante 1” indica validação de requisito/regra; “Integrante 2” indica alinhamento com fluxos, mensagens e estados. Não se pede a esses integrantes aprovar uma funcionalidade excluída implicitamente.

| ID | Pendente | Base | Validação necessária |
|---|---|---|---|
| PC-01 | Tipo/formato de identificacao, representação da credencial protegida, campos de atualização da conta e tipo de dadosPermitidos. Não pressupor login/e-mail ou hash específico. | RF-003–004; RN-002; RNF-001 | Integrante 1 define informação permitida; Integrante 2 confirma fluxo. |
| PC-02 | Efeito de bloqueio em sessões abertas; sem alterar os valores aprovados por DEC-013. | RF-005–006; DEC-013 | Integrantes 1 e 2. |
| PC-03 | Atributos de Perfil, Permissao e AreaAtuacao; representação da autorização; catálogo; validação dos refinamentos adicionarPermissao e removerPermissao, incluindo possível revogação da associação sem exclusão de Permissao. | RF-007–008, RF-016; glossário | Integrante 1 valida limites; Integrante 2 valida manutenção e fluxos derivados. |
| PC-04 | Campos profissionais liberados, detalhamento do CRP citado como candidato, tipo de dadosPermitidos e projeção da consulta de pacientes. | RF-015–017; interações/processos | Integrantes 1 e 2. |
| PC-05 | Campos administrativos do paciente e informações liberadas ao próprio paciente; estados seguem DEC-014. | RF-019–022; DEC-014; RN-004/RN-009 | Integrantes 1 e 2. |
| PC-06 | Critério completo de autorização em diferentes contextos e histórico de vínculo; datas, situação e encerramento seguem DEC-015. | RF-021, RF-031; DEC-015; RN-003/RN-007 | Integrantes 1 e 2. |
| PC-07 | Precisão/fuso/formato temporal, sobreposição e colaboração; slot discreto e duração fixa seguem DEC-018; criação já confirmada e cancelamento seguem DEC-016–017 e DEC-028. | RF-023–027; DEC-016–018, DEC-028; RN-005, RN-010, RN-012–013 | Integrantes 1 e 2. |
| PC-08 | Conteúdo mínimo do atendimento, tipo/estrutura de contextoSessao, dados temporais próprios, histórico permitido e tratamento de registro repetido. | RF-030–031; RN-006–007 | Integrantes 1 e 2. Não inclui prontuário aprofundado. |
| PC-09 | Limites de áreas, catálogo e alcance da manutenção posterior de perfis; A01/A03/A04/A08/A09/A10 seguem decisões oficiais e fontes indicadas. | RF-007–008, RF-016; DEC-019/021; RF-023/029 | Integrantes 1 e 2. |
| PC-10 | Tipo/vocabulário de operacao da auditoria, precisão/fuso de Data/Hora, ordenação de eventos simultâneos e eventos não administrativos auditáveis. | RF-032; RN-009/RN-014; RNF-004 | Integrante 1 define escopo; Integrante 2 modela registro decorrente da ação. |
| PC-11 | Detalhes da integração e falhas do serviço externo; lista de espera e serviço de e-mail já aprovados. | DEC-009/010/022/027/029 | Integrante 2 detalha a colaboração. |
| PC-12 | Retornos/erros, consultas e assinaturas provisórias; identidade confiável, autorização e auditoria; criação de cadastros e de Disponibilidade, validação desta e colaboração dos refinamentos; manutenção posterior de perfil; validação da escolha de operações estáticas. Cobertura individual dos RF-001–032 na especificação. | RF correspondentes; RNF-002, RNF-007–008; RN-003–009, RN-014 | Integrante 2 detalha colaborações; Integrante 1 valida ambiguidades ou mudanças de regra. Nenhum mecanismo é considerado já demonstrado. |

Os tipos omitidos no Mermaid correspondem às pendências acima, não a tipos provisórios aprovados. Data e Hora representam exatamente as informações documentadas para auditoria; não estabelecem formato ou precisão. Booleano representa resultado de uma pergunta, não um atributo adicional de estado.

## 4. Cardinalidades pendentes

| Associações | O que não está definido |
|---|---|
| A05 | Mínimo durante o cadastro, limites e compartilhamento de áreas; RF-016 sustenta a associação. |
| A17–A21 | As multiplicidades constam no diagrama; validar apenas restrições e histórico da fila com o fluxo oficial. |

As cardinalidades fechadas estão registradas no [modelo de domínio](../Dominio/modelo-dominio.md) e na especificação; pendências não foram convertidas em multiplicidades por conveniência.

## 5. Avaliação das sugestões de métodos

| Sugestão | Resultado |
|---|---|
| Usuario.ativar/bloquear | Incluídos por RF-005/RF-006, com autorização e limites explícitos. |
| Perfil.adicionarPermissao/removerPermissao | Incluídos como refinamento da manutenção das associações em RF-008. |
| Psicologo.atualizarDadosProfissionais | Incluído por RF-015; campos e tipo pendentes. |
| Paciente.atualizarCadastro/alterarSituacao | Incluídos por RF-019/RF-020; alteração de situação condicionada às transições e auditoria. |
| Vinculo.encerrar | Incluído por DEC-015; registra data fim e bloqueia autorização posterior. |
| Vinculo.estaAtivo | Não incluído; `estaAutorizado` continua como refinamento derivado. Somente vínculo `ATIVO` autoriza acesso (DEC-015), embora o critério completo de autorização permaneça condicionado. |
| Agenda.adicionarDisponibilidade/verificarDisponibilidade | Cadastro de período é diretamente sustentado, mas criação/validação estão incompletas; verificação é refinamento derivado e não substitui RF-024. |
| Agendamento.confirmar/cancelar | A confirmação não é operação separada: o agendamento nasce confirmado (DEC-016/017). `cancelar` permanece contrato condicionado por RF-027 e RN-012. |
| Atendimento.registrar | Incluído como criação válida por RF-030, com RN-006/RN-007. |

## 6. Revisão cruzada e critério de conclusão

| Comparação | Resultado conceitual |
|---|---|
| Diagrama × especificação | 13 classes e 21 associações descritas; fila integrada a `SolicitacaoEspera` sem `OfertaVaga`. |
| Classes × requisitos | Cada classe possui fundamentação; classes sem atributos documentados permanecem sem campos inventados. |
| Métodos × regras | Contratos contemplam as regras e registram a preservação pretendida. Não demonstram mecanismos de autorização, ausência de conflitos ou integração de auditoria ainda não modelados. |
| Relacionamentos × domínio | A01–A21 sincronizadas; A01/A03/A04/A05/A10 e A17 têm referências documentadas. |
| Tipos e estados | Tipos conceituais e situações aprovadas sincronizados com DEC-013–015/018/027. |
| Escopo | Somente modelagem OO; nenhuma mudança no domínio ou nos documentos dos outros integrantes é necessária nesta etapa. |

A cobertura funcional foi desdobrada por RF na especificação, sem acrescentar classes ou métodos. A conclusão desta etapa é um modelo documental parcial com contratos declarados, não demonstração dos mecanismos nem fechamento das pendências do grupo. A revisão estática não certifica renderização Mermaid nem execução dos contratos. A conformidade final requer resolver PC pertinentes e validar os fluxos com os Integrantes 1 e 2.

## 7. Fechamento formal de associações e nomes (08/11/2026)

| Item | Situação | Fundamento | Onde está |
|---|---|---|---|
| A01 `Perfil` — `Usuario` (1 : 0..*) | **Fechada** | DEC-019: cada conta tem no máximo um perfil. | diagrama-classes.mmd; especificacao-classes.md §5 |
| A02 `Perfil` — `Permissao` (1..* : 1..*) | **Fechada** | RF-007, RF-008; N:N resolvida em `perfil_permissao` (I4). | idem |
| A03 `Usuario` — `Psicologo` (0..1 : 0..1) | **Fechada** | DEC-021: conta de acesso opcional para cadastro. | idem |
| A04 `Usuario` — `Paciente` (0..1 : 0..1) | **Fechada** | DEC-021 | idem |
| A10 `Agenda` — `Agendamento` (1 : 0..*) | **Fechada** | RF-029; o slot ocupado é definido por A17 (DEC-018). A persistência deriva A10 por junção (I4). | idem |
| A05 `Psicologo` — `AreaAtuacao` | **Não fechada (PENDENTE)** | PC-09: mínimo de áreas e compartilhamento não definidos pelos requisitos. Pendência do grupo, não do modelo. | idem |

**Nomes (P10):**

| Nome descartado | Nome adotado | Ocorrências já ajustadas nesta entrega | Ocorrências que permanecem |
|---|---|---|---|
| `cadastrarDisponibilidade` | `adicionarDisponibilidade` | `modelos-testes-conceituais-fase8.md` (CT-023); `matriz-rastreabilidade-final.md` (RF-023); `testes-conceituais-dominio.md` (espelho) | Revisões históricas Fase 5 e 6 (snapshots, não editadas); `07-dossie/dossie.md` (regerar após I3, I4 e I2 terminarem) |
| `estaAtivo` | `estaAutorizado` | Nenhuma ocorrência no diagrama oficial, na especificação ou no modelo de domínio | `SEQ-002`, `COM-001`, `ATV-001` e as revisões comportamentais do I2 (`estaAtivo`, OP-22); a alinhar pelo Integrante 2 |

**Limites desta etapa.** O fechamento de A01–A04 e A10 não resolve PC-01 a PC-12 nem altera os requisitos. Não houve regeneração dos `.drawio.xml` nem dos `.pdf` do diagrama de classes: a exportação depende do diagrams.net, e o PDF atual (21/10) segue desatualizado até nova exportação.

