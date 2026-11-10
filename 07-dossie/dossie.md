# Dossiê de Modelagem Orientada a Objetos — Plataforma para Psicólogos

**Versão:** v0.7 · **Data de montagem:** 29/10/2026 · **Situação:** dossiê em construção — seções 1 a 24 e 27 com conteúdo das Fases 1 a 6; seções 25, 26 e 28 a 36 com estrutura e texto disponível.
**Montagem:** arquivo gerado por `07-dossie/montar-dossie.py` a partir de `07-dossie/secoes/` e de `02-requisitos/`. Não editar este arquivo diretamente: editar a seção de origem e rodar o script.
**Responsável pela integração:** Integrante 6 — Guilherme Freire.

> As seções preparadas pelos Integrantes 2, 4 e 5 são mantidas como entregues. Quando uma decisão aprovada depois da redação torna parte do texto desatualizada, uma **nota de integração** logo abaixo do título da seção indica o que prevalece. A correção do texto e dos diagramas cabe ao autor.

## Sumário

| Seção | Título | Origem do texto |
|---|---|---|
| 1 | Capa | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 2 | Resumo | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 3 | Equipe e funções | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 4 | Contexto e situação-problema | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 5 | Objetivos | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 6 | Escopo, fronteiras e escopo negativo | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 7 | Premissas e restrições | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 8 | Stakeholders e atores | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 9 | Glossário | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 10 | Decisões do projeto | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 11 | Diagrama de contexto | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 12 | Requisitos funcionais | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 13 | Requisitos não funcionais | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 14 | Regras de negócio | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 15 | Histórias de usuário e critérios de aceite | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 16 | Diagrama de casos de uso | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 17 | Especificações de casos de uso | Integrante 6 (a partir de 02-requisitos/, 01-planejamento/ e 03-uml/) |
| 18 | Modelo de domínio | Integrante 2 (Fase 5) |
| 19 | Diagrama de classes | Integrante 2 (Fase 5) |
| 20 | Diagrama de objetos | Integrante 2 (Fase 5) |
| 21 | Diagramas de sequência | Integrante 2 (Fase 6) |
| 22 | Diagrama de comunicação | Integrante 2 (Fase 6) |
| 23 | Diagrama de atividades | Integrante 2 (Fase 6) |
| 24 | Máquina de estados | Integrante 2 (Fase 6) |
| 25 | Arquitetura: pacotes, componentes e implantação | Integrante 4 (Fase 7, a produzir) |
| 26 | Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional | Integrante 4 (Fase 7, a produzir) |
| 27 | Princípios OO e SOLID | Integrante 2 (Fase 5) |
| 28 | Plano de qualidade (ISO/IEC 25010:2023) | Integrante 5 (resumo de 05-qualidade/) |
| 29 | Normas aplicadas | Integrante 5 (resumo de 05-qualidade/) |
| 30 | Autoavaliação do processo | Integrante 5 (resumo de 05-qualidade/) |
| 31 | Matriz de rastreabilidade | Integrantes 1, 2 e 5 |
| 32 | Verificação de consistência e revisões | Integrante 6 (consolidação) |
| 33 | Conclusão | Integrante 6 + grupo (Fase 9) |
| 34 | Limitações e próximos passos | Integrante 6 + grupo (Fase 9) |
| 35 | Referências | Integrante 6 + grupo (Fase 9) |
| 36 | Anexos | Integrante 6 + grupo (Fase 9) |

---
## 1. Capa

**Centro Universitário Jorge Amado** — UC Desenvolvimento Dinâmico
**Unidade curricular:** Modelagem Orientada a Objetos
**Atividade:** AV3 — Projeto de Modelagem
**Professor:** Prof. MSc. Celso Barreto
**Título:** Modelagem Orientada a Objetos de uma Plataforma para Psicólogos
**Subtítulo:** Especificação, UML, persistência, qualidade e processos do ciclo de vida de software
**Repositório oficial:** https://github.com/Pinho47/MOO-AV3
**Entrega prevista:** 24/11/2026

---

## 2. Resumo

Este dossiê modela uma plataforma que unifica cadastros, permissões, agenda e registro conceitual de atendimentos de uma organização de psicólogos de diferentes áreas, hoje dispersos em planilhas e ferramentas sem integração. O produto não é um sistema programado: é um conjunto integrado de requisitos, modelos UML, modelo relacional, decisões, critérios de qualidade e evidências de processo, suficiente para que outra equipe compreenda e implemente a solução.

A plataforma atende três atores humanos — Administrador, Psicólogo e Cliente/Paciente — e um ator externo, o Serviço Externo de E-mail. Os requisitos (37 funcionais, 12 não funcionais e 17 regras de negócio) são rastreados até casos de uso, classes, diagramas comportamentais e, na Fase 7, tabelas. A funcionalidade de inovação é a **lista de espera inteligente**: quando um agendamento é cancelado, o horário liberado pode ser oferecido a outro paciente que aguarda, com aviso por e-mail.

A qualidade é tratada pela ISO/IEC 25010:2023 (sete características com critérios mensuráveis), a engenharia de requisitos pela ISO/IEC/IEEE 29148:2018 e o processo pela ISO/IEC/IEEE 12207:2026 e pela família ISO/IEC 330xx. Normas retiradas (ISO/IEC 9126 e ISO/IEC 15504) aparecem apenas como referência histórica.

---

## 3. Equipe e funções

| Integrante | Nome | Função principal | Artefatos sob responsabilidade |
|---|---|---|---|
| 1 | Emmanuel de Pinho | Coordenação, planejamento e requisitos | Decisões, baseline RF/RNF/RN, histórias, critérios de aceite, matriz inicial, cronograma |
| 2 | Aquiles Angelo | Casos de uso e diagramas comportamentais | Contexto, casos de uso, especificações, sequências, comunicação, atividades, estados, revisões das Fases 5 e 6 |
| 3 | Andressa Caroline | Modelo OO e domínio | Domínio, classes, objetos, decisões de modelagem OO |
| 4 | Caio Cunha | Persistência e arquitetura | Análises de persistência, DER, modelo relacional, dicionário, mapeamento, pacotes, componentes e implantação |
| 5 | Franklin Reis | Qualidade, normas e processo | Plano ISO/IEC 25010, normas, registro de processo e autoavaliação, revisões de qualidade |
| 6 | Guilherme Freire | Documentação, integração, repositório e pitch | Dossiê único, README, organização do repositório, registros de integração, pitch |

A divisão é por responsabilidade principal, com revisão cruzada (DEC-004). O **relatório de função e atuação de cada integrante durante o projeto**, exigido pelo enunciado, é anexado a esta seção na consolidação (Fase 9), com base no histórico de commits e nos registros de cada fase.

---

## 4. Contexto e situação-problema

Nos processos de clínicas e consultórios de Psicologia, os cadastros de profissionais e pacientes estão distribuídos em ferramentas manuais, planilhas ou sistemas desconectados. O gerenciamento de permissões não é centralizado, as agendas não operam de forma integrada e as informações operacionais permanecem fragmentadas. Isso dificulta controlar quem pode visualizar e manipular cada dado e compromete o sigilo e a eficiência.

Problemas identificados (`02-requisitos/visao.md` §2):

- ausência de integração entre dados cadastrais, horários e histórico;
- dificuldade no controle de permissões;
- falta de representação formal dos relacionamentos entre usuários, perfis, psicólogos, pacientes, horários e atendimentos;
- risco de vazamento de dados sensíveis por falta de barreiras granulares;
- carência de especificação técnica para orientar a implementação.

**Questão do problema (enunciado):** como modelar uma plataforma flexível e segura para profissionais de Psicologia, garantindo que todos os diagramas, requisitos, regras, dados e critérios de qualidade descrevam o mesmo produto?

---

## 5. Objetivos

**Objetivo geral:** modelar uma plataforma integrada, flexível e segura para a gestão administrativa e profissional de psicólogos, representando usuários, permissões, profissionais, clientes/pacientes, agenda, atendimentos e auditoria de forma consistente e rastreável.

**Objetivos específicos:** centralizar cadastros; controlar o acesso por perfis e permissões granulares; associar psicólogos a uma ou mais áreas de atuação; representar os vínculos autorizados entre psicólogos e pacientes; gerenciar disponibilidade e o ciclo do agendamento; permitir autoatendimento limitado do paciente; representar conceitualmente atendimentos e históricos; prover auditoria; e produzir os artefatos de modelagem, persistência e qualidade que orientam a implementação.

---

## 6. Escopo, fronteiras e escopo negativo

**Módulos:** Identidade e Acesso · Administração · Psicólogos · Clientes/Pacientes · Agenda · Atendimento · Auditoria · **Inovação — lista de espera inteligente** (DEC-010).

**Agenda (decisões de 25/10/2026):** confirmação automática quando o horário está disponível e sem conflito (DEC-017); cancelamento pelo paciente titular ou pelo psicólogo antes do horário marcado (DEC-011); situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu` (DEC-016) — `SOLICITADO` **não** é situação persistente; `Não compareceu` registrado pelo Psicólogo após o horário marcado (DEC-025).

**Inovação:** o horário liberado por cancelamento pode ser oferecido a paciente da lista de espera do mesmo psicólogo, com aviso por e-mail (DEC-009). A oferta só vira agendamento se o paciente aceitar e o horário continuar disponível (RN-021). Parâmetros aprovados em 28/10/2026 (DEC-027): fila por ordem de entrada, uma oferta por vez, prazo de aceite curto e configurável com o horário reservado ao paciente, recusa ou ausência de resposta passa a oferta ao próximo, entrada por Psicólogo e horário específico, e o cancelamento do Psicólogo também gera oferta.

**Fronteira:** interno — entidades, serviços, regras, interfaces com os atores autenticados, autenticação/autorização e persistência relacional; externo — navegadores e dispositivos dos usuários e o Serviço Externo de E-mail.

**Fora do escopo (DEC-008):** pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição de medicamentos, prontuário clínico aprofundado, cobrança e integrações financeiras. O ator **Atendente** foi excluído (DEC-007).

---

## 7. Premissas e restrições

| ID | Premissa |
|---|---|
| PRE-001 | Cada usuário possui identificação própria |
| PRE-002 | Psicólogos podem possuir uma ou mais áreas de atuação |
| PRE-003 | Clientes/pacientes podem possuir acesso autenticado limitado |
| PRE-004 | O acesso às funcionalidades depende de perfil e permissões |
| PRE-005 | Psicólogos somente acessam pacientes vinculados |
| PRE-006 | A persistência é modelada em banco relacional |

| ID | Restrição |
|---|---|
| RES-001 | Dados reais de pacientes não podem ser utilizados |
| RES-002 | Senhas não podem ser armazenadas ou disponibilizadas em texto puro |
| RES-003 | O projeto tem foco em modelagem e não exige implementação |
| RES-004 | Os diagramas usam UML 2.x quando aplicável |
| RES-005 | A persistência considera banco de dados relacional |
| RES-006 | O Cliente/Paciente não pode acessar informações de outros pacientes |

---

## 8. Stakeholders e atores

**Stakeholders:** organização responsável pela plataforma; administradores; psicólogos; clientes/pacientes; equipe de engenharia da futura implementação; equipe de suporte e manutenção.

| Ator | Tipo | Responsabilidades | Limitações |
|---|---|---|---|
| Administrador | Humano, primário | Usuários, perfis, permissões, cadastros de psicólogos e pacientes, vínculos, auditoria | Não vê senhas em texto puro; toda operação é autorizada e auditada |
| Psicólogo | Humano, primário | Perfil profissional, áreas de atuação, disponibilidade, agenda, cancelamento na própria agenda, registro de atendimento e de `Não compareceu` | Acessa apenas pacientes vinculados; sem funções administrativas |
| Cliente/Paciente | Humano, primário | Login, consulta de horários, solicitação, consulta e cancelamento dos próprios agendamentos, lista de espera e resposta a ofertas | Sem acesso a dados de terceiros, auditoria ou registros profissionais restritos (DEC-006) |
| Serviço Externo de E-mail | Sistema externo, de suporte | Recebe solicitações de envio para confirmação, cancelamento e oferta de vaga (DEC-009, RF-033) | Não recebe senhas nem informações clínicas (RN-022) |

Não são atores: banco de dados, módulos internos, tabelas, classes e componentes de infraestrutura.

---

## 9. Glossário

| Termo | Definição |
|---|---|
| Usuário | Pessoa que possui acesso autenticado à plataforma. |
| Administrador | Usuário responsável por funções administrativas autorizadas e gestão do sistema. |
| Psicólogo | Profissional cadastrado na plataforma para prestar serviços de psicologia. |
| Cliente/Paciente | Pessoa vinculada a um psicólogo e que poderá possuir acesso autenticado limitado para autoatendimento. |
| Perfil | Agrupamento de responsabilidades e permissões atribuíveis aos usuários. |
| Permissão | Autorização formal para executar determinada operação ou transação na plataforma. |
| Área de atuação | Campo de especialidade ou linha teórica e prática na qual o psicólogo atua. |
| Vínculo | Relação formal e autorizada entre psicólogo e cliente/paciente no contexto do sistema. |
| Disponibilidade | Intervalo de tempo e dias oferecido pelo psicólogo para agendamento de atendimentos. |
| Agendamento | Reserva formal de horário entre um psicólogo e um cliente/paciente. |
| Atendimento | Registro conceitual de uma atividade ou sessão profissional realizada pelo psicólogo. |
| Auditoria | Registro cronológico, seguro e rastreável de operações relevantes realizadas no sistema. |
| Serviço Externo | Sistema externo utilizado pela plataforma para alguma integração (ex.: envio de mensagens). |
| Notificação | Comunicação enviada ao usuário sobre evento relevante do sistema; no escopo atual, e-mail de confirmação, cancelamento ou oferta de vaga (DEC-009). |
| Lista de espera | Registro de pacientes interessados em horário com um psicólogo, usado para oferecer horários liberados por cancelamento (DEC-010). |
| Oferta de vaga | Proposta, enviada a um paciente da lista de espera, de ocupar um horário liberado; só gera agendamento se aceita e se o horário continuar disponível. |
| Situação do agendamento | `Confirmado`, `Cancelado`, `Realizado` ou `Não compareceu` (DEC-016). |

Fonte: `02-requisitos/glossario.md`.

---

## 10. Decisões do projeto

O registro oficial está em `01-planejamento/decisoes.md`. Situação em 28/10/2026:

| Situação | Decisões |
|---|---|
| Aprovadas | DEC-001 a DEC-011, DEC-013 a DEC-030, exceto DEC-012 (DEC-011 e DEC-025 com redação revisada; DEC-013 a DEC-015, DEC-018 a DEC-024 e DEC-026 a DEC-030 aprovadas em 28/10/2026) |
| Não adotada | DEC-012 (prazo de 2 horas; superada pela DEC-028) |
| Propostas aguardando o grupo | nenhuma |
| Pendências abertas | nenhuma (PG-02 e PG-04 a PG-12 resolvidas em 28/10/2026) |

| Decisão aprovada | Conteúdo |
|---|---|
| DEC-001 a DEC-005 | Tipo de projeto, GitHub como repositório oficial, persistência relacional, equipe de seis com revisão cruzada, nenhum dado real de paciente |
| DEC-006 | Paciente é ator com acesso autenticado limitado |
| DEC-007 | Atendente fora do escopo |
| DEC-008 | Escopo negativo (financeiro, fiscal, teleconsulta, prescrição, prontuário aprofundado) |
| DEC-009 | Serviço Externo de E-mail para confirmação, cancelamento e oferta de vaga |
| DEC-010 | Inovação: lista de espera inteligente (parâmetros pendentes) |
| DEC-011 | Cancelamento por paciente titular ou psicólogo, antes do horário marcado |
| DEC-016 | Situações `Confirmado`, `Cancelado`, `Realizado`, `Não compareceu`; `SOLICITADO` não é persistente |
| DEC-017 | Confirmação automática quando o horário está disponível e sem conflito |
| DEC-025 | Psicólogo registra `Não compareceu` após o horário marcado |
| DEC-027 | Parâmetros da lista de espera |
| DEC-028 | Sem antecedência mínima para cancelar; o Administrador não cancela |
| DEC-029 | Falha no envio de e-mail não desfaz a operação |
| DEC-030 | Registro do atendimento leva o agendamento a `Realizado` |

**Não adotado:** antecedência mínima de duas horas (DEC-012); registro automático de `Não compareceu`.

---

## 11. Diagrama de contexto

### 11.1 Identificação e objetivo

**CTX-001 — Diagrama de contexto da Plataforma para Psicólogos.** Mostra a fronteira do sistema, os atores humanos e o sistema externo com que a plataforma troca informações.

### 11.2 Elementos principais

- Sistema: Plataforma para Psicólogos (fronteira única).
- Atores humanos: Administrador, Psicólogo, Paciente.
- Sistema externo: Serviço de e-mail.

### 11.3 Como interpretar

Cada ator troca informações com a plataforma pelas responsabilidades da seção 8; o Serviço de e-mail só recebe solicitações de envio. Nenhum componente interno (banco, módulo) aparece, porque o diagrama descreve a fronteira, não a estrutura.

### 11.4 Decisões e situação

O Atendente não aparece (DEC-007). **Nota de integração (I6):** o desenho versionado marca o Serviço de e-mail como "Pendente"; desde 25/10/2026 ele está aprovado (DEC-009). A atualização do desenho cabe ao Integrante 2 (achados Q2-01 e INT-03).

### 11.5 Relação com requisitos

Atores e fronteira correspondem a `stakeholders-atores.md`, `escopo.md` §5 e RF-033.

### 11.6 Arquivos

- Editável: `03-uml/Contexto/diagrama-contexto.drawio.xml`
- Publicação: `03-uml/Contexto/diagrama-contexto.pdf`
- Original da Fase 2 (preservado): `03-uml/Contexto/Diagrama de contexto fase 2.pdf`
- Interações por ator: `03-uml/Contexto/Interações_Processos.md`

---

## 12. Requisitos funcionais

Cada requisito tem descrição, ator, prioridade, pré e pós-condições, dependências e observações em `02-requisitos/requisitos-funcionais.md`. Resumo:

| ID | Requisito | Ator(es) | Prioridade |
|---|---|---|---|
| RF-001 | Autenticar usuário | Administrador, Psicólogo e Cliente/Paciente | Alta |
| RF-002 | Encerrar sessão | Administrador, Psicólogo e Cliente/Paciente | Média |
| RF-003 | Cadastrar usuário | Administrador | Alta |
| RF-004 | Alterar dados de usuário | Administrador, Psicólogo e Cliente/Paciente, dentro das respectivas permissões | Média |
| RF-005 | Ativar usuário | Administrador | Média |
| RF-006 | Bloquear usuário | Administrador | Alta |
| RF-007 | Gerenciar perfis | Administrador | Alta |
| RF-008 | Gerenciar permissões | Administrador | Alta |
| RF-009 | Consultar painel administrativo | Administrador | Média |
| RF-010 | Consultar usuários cadastrados | Administrador | Alta |
| RF-011 | Consultar psicólogos cadastrados | Administrador | Média |
| RF-012 | Consultar clientes/pacientes cadastrados | Administrador | Média |
| RF-013 | Consultar registros de auditoria | Administrador | Alta |
| RF-014 | Cadastrar psicólogo | Administrador | Alta |
| RF-015 | Atualizar perfil profissional | Psicólogo | Média |
| RF-016 | Associar área de atuação ao psicólogo | Psicólogo, Administrador | Média |
| RF-017 | Consultar clientes/pacientes vinculados | Psicólogo | Alta |
| RF-018 | Cadastrar cliente/paciente | Administrador | Alta |
| RF-019 | Atualizar cadastro administrativo de cliente/paciente | Administrador | Média |
| RF-020 | Alterar situação do cliente/paciente | Administrador | Média |
| RF-021 | Vincular cliente/paciente a psicólogo | Administrador | Alta |
| RF-022 | Consultar informações do próprio cadastro | Cliente/Paciente | Média |
| RF-023 | Cadastrar disponibilidade do psicólogo | Psicólogo | Alta |
| RF-024 | Consultar horários disponíveis | Cliente/Paciente | Alta |
| RF-025 | Solicitar agendamento | Cliente/Paciente | Alta |
| RF-026 | Confirmar agendamento automaticamente | Sistema (confirmação automática decorrente da solicitação do Cliente/Paciente) | Alta |
| RF-027 | Cancelar agendamento | Cliente/Paciente (agendamento próprio) e Psicólogo (agendamento da própria agenda) | Alta |
| RF-028 | Consultar os próprios agendamentos | Cliente/Paciente | Alta |
| RF-029 | Consultar agenda do psicólogo | Psicólogo | Alta |
| RF-030 | Registrar conceitualmente um atendimento | Psicólogo | Alta |
| RF-031 | Consultar histórico permitido de atendimentos | Psicólogo | Média |
| RF-032 | Registrar evento de auditoria | Sistema (registro decorrente de ações de Administrador, Psicólogo ou Cliente/Paciente) | Alta |
| RF-033 | Enviar notificação por e-mail | Sistema; Serviço Externo de E-mail (ator externo de suporte) | Média |
| RF-034 | Entrar na lista de espera | Cliente/Paciente | Média |
| RF-035 | Ofertar horário liberado à lista de espera | Sistema; Serviço Externo de E-mail (aviso da oferta) | Média |
| RF-036 | Responder à oferta de vaga | Cliente/Paciente | Média |
| RF-037 | Registrar não comparecimento | Psicólogo (agendamento da própria agenda) | Média |

---

## 13. Requisitos não funcionais

Os critérios de verificação completos estão em `02-requisitos/requisitos-nao-funcionais.md`; a correspondência com as características da ISO/IEC 25010:2023 está na seção 28.

| ID | Requisito | Categoria | Descrição |
|---|---|---|---|
| RNF-001 | Proteção de credenciais | Segurança | Senhas não devem ser armazenadas nem disponibilizadas em texto puro. |
| RNF-002 | Autorização por perfil e permissão | Segurança | O acesso às funcionalidades deverá respeitar os perfis e as permissões atribuídos ao usuário. |
| RNF-003 | Bloqueio de acesso de conta | Segurança | Usuários bloqueados não deverão conseguir autenticar-se. |
| RNF-004 | Auditoria de operações relevantes | Segurança | Operações administrativas relevantes deverão ser auditáveis, com usuário responsável, data, hora e operação identificáveis. |
| RNF-005 | Isolamento dos dados de pacientes | Segurança | O sistema deverá impedir que um Cliente/Paciente acesse informações pertencentes a outros pacientes. |
| RNF-006 | Acesso profissional por vínculo | Segurança | O Psicólogo deverá acessar somente clientes/pacientes com vínculo autorizado. |
| RNF-007 | Integridade entre elementos relacionados | Confiabilidade | A solução modelada deverá preservar a integridade das relações entre usuários, perfis, psicólogos, clientes/pacientes, vínculos, agenda, agendamentos, atendimentos e auditoria. |
| RNF-008 | Coesão e baixo acoplamento | Manutenibilidade | A solução deverá favorecer alta coesão entre responsabilidades relacionadas e baixo acoplamento entre módulos. |
| RNF-009 | Evolução modular | Flexibilidade | A organização dos módulos deverá permitir evolução futura sem exigir reestruturação completa da solução modelada. |
| RNF-010 | Consulta interativa de agenda | Desempenho | Consultas de agenda deverão possuir tempo de resposta compatível com uso interativo normal. |
| RNF-011 | Rastreabilidade entre artefatos | Rastreabilidade e Qualidade da Modelagem | Os artefatos deverão manter rastreabilidade entre requisitos, regras de negócio, atores, casos de uso futuros e critérios de aceite. |
| RNF-012 | Consistência terminológica e semântica | Rastreabilidade e Qualidade da Modelagem | Os requisitos e modelos deverão manter termos consistentes com o glossário e respeitar as decisões e fronteiras de escopo aprovadas. |
| RNF-013 | Integridade referencial com exclusão controlada | Confiabilidade | Nenhuma chave estrangeira deverá usar exclusão em cascata sobre dados históricos; a retirada de um registro deverá ocorrer por mudança de situação. |
| RNF-014 | Domínios fechados no banco | Confiabilidade | As situações e os enumerados deverão ter domínio fechado verificado no banco de dados. |
| RNF-015 | Atomicidade entre alteração de situação e auditoria | Confiabilidade | A alteração de situação e o seu registro de auditoria deverão ocorrer na mesma transação. |
| RNF-016 | Unicidade do horário ativo | Confiabilidade | No máximo um agendamento `Confirmado` deverá ocupar cada horário ofertado (RN-005), inclusive sob acesso concorrente; a confirmação automática deverá revalidar a disponibilidade no momento da gravação (RN-013). |
| RNF-017 | Imutabilidade da trilha de auditoria | Segurança | A conta da aplicação não deverá poder alterar nem excluir registros de auditoria. |
| RNF-018 | Consulta de agenda sem varredura completa | Desempenho | Os índices deverão cobrir as consultas de RF-024, RF-028 e RF-029. |
| RNF-019 | Valor anterior e novo na auditoria | Rastreabilidade e Qualidade da Modelagem | O registro de auditoria de uma mudança de situação deverá conter a situação anterior e a nova (DEC-024). |
| RNF-020 | Integridade temporal dos vínculos | Confiabilidade | A data de fim do vínculo deverá ser nula se e somente se o vínculo estiver ativo (DEC-015). |
| RNF-021 | Uma oferta aberta por horário da lista de espera | Confiabilidade | No máximo uma oferta de vaga aberta deverá existir por horário (DEC-027). |
| RNF-022 | Ordem estável da fila | Confiabilidade | A data e hora de entrada na lista de espera não deverá mudar depois da criação (DEC-027). |
| RNF-023 | Troca de provedor de e-mail sem alterar o domínio | Compatibilidade | A plataforma deverá se comunicar com o Serviço Externo de E-mail por uma interface própria (`ServicoEnvioMensagem`, DEC-022), de modo que a troca do provedor não altere o domínio. |
| RNF-024 | Confirmação explícita antes de ação irreversível | Capacidade de interação | Antes de cancelar um agendamento ou aceitar uma oferta de vaga, a operação deverá exigir confirmação explícita do usuário e informar o efeito (liberação do horário ou confirmação do agendamento). |

---

## 14. Regras de negócio

`RN-015` a `RN-019` estão reservados às propostas técnicas do Integrante 4 ainda não incorporadas; por isso a numeração salta de RN-014 para RN-020.

| ID | Regra | Requisitos relacionados |
|---|---|---|
| RN-001 | **Bloqueio de autenticação** — Usuários bloqueados não podem autenticar-se. | RF-001, RF-006 |
| RN-002 | **Proteção de senhas** — O Administrador não pode visualizar senhas em texto puro; senhas não podem ser armazenadas ou disponibilizadas dessa forma. | RF-003, RF-010, RNF-001 |
| RN-003 | **Acesso profissional condicionado a vínculo** — O Psicólogo somente pode acessar clientes/pacientes vinculados a ele por relação autorizada. | RF-017, RF-021, RF-031 |
| RN-004 | **Acesso do paciente ao próprio cadastro** — O Cliente/Paciente somente pode consultar informações relacionadas ao próprio cadastro e liberadas para seu acesso. | RF-022, RF-028 |
| RN-005 | **Exclusividade de horário ativo** — Um mesmo horário de um Psicólogo não pode possuir dois agendamentos ativos incompatíveis. | RF-023, RF-025, RF-026, RF-036 |
| RN-006 | **Agendamento cancelado** — Um agendamento cancelado não pode posteriormente ser registrado como atendimento realizado. | RF-027, RF-030 |
| RN-007 | **Vínculos obrigatórios do atendimento** — Um atendimento registrado deve estar associado a um Psicólogo e a um Cliente/Paciente válidos, com vínculo autorizado. | RF-021, RF-030, RF-031 |
| RN-008 | **Consulta restrita à auditoria** — Apenas usuários autorizados podem consultar registros de auditoria; no escopo atual, essa consulta cabe ao Administrador autorizado. | RF-013, RF-032 |
| RN-009 | **Rastreabilidade de alterações relevantes** — Alterações relevantes de situação devem preservar rastreabilidade por registro de auditoria. | RF-020, RF-026, RF-027, RF-032, RF-037 |
| RN-010 | **Solicitação em horário disponível** — Um Cliente/Paciente somente pode solicitar agendamento em horário que esteja disponível no momento da solicitação. | RF-024, RF-025 |
| RN-011 | **Disponibilidade na própria agenda** — Um Psicólogo somente pode disponibilizar horários vinculados à própria agenda. | RF-023, RF-029 |
| RN-012 | **Permissão para cancelamento** — Um agendamento na situação `Confirmado` somente pode ser cancelado pelo Cliente/Paciente titular ou pelo Psicólogo responsável pelo agendamento, e somente antes do horário marcado. O cancelamento libera o horário. | RF-027, RF-035 |
| RN-013 | **Confirmação automática de agendamento** — O agendamento é confirmado automaticamente pelo sistema quando o horário estiver disponível e não houver conflito de agenda; não há aprovação manual por outro ator. Sem disponibilidade ou com conflito, o agendamento não é confirmado. | RF-025, RF-026, RF-036 |
| RN-014 | **Imutabilidade lógica de auditoria** — Registros de auditoria devem ser cronológicos, rastreáveis e não devem ser alterados por operações comuns de consulta ou gestão. | RF-013, RF-032 |
| RN-020 | **Situações do agendamento** — O agendamento assume as situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu`. `SOLICITADO` não é situação persistente: o agendamento já nasce `Confirmado`. `Cancelado`, `Realizado` e `Não compareceu` somente são atribuídos a agendamento `Confirmado`. `Não compareceu` é registrado pelo Psicólogo após o horário marcado, se o agendamento não tiver sido cancelado nem concluído. | RF-026, RF-027, RF-030, RF-037 |
| RN-021 | **Oferta de horário da lista de espera** — Um horário liberado por cancelamento pode ser oferecido a paciente da lista de espera do mesmo Psicólogo, desde que o paciente possua vínculo autorizado com ele. A oferta só se converte em agendamento se o paciente aceitar e o horário continuar disponível e sem conflito no momento do aceite (RN-005, RN-013). | RF-027, RF-034, RF-035, RF-036 |
| RN-022 | **Eventos notificados por e-mail** — A confirmação de agendamento, o cancelamento de agendamento e a oferta de vaga da lista de espera devem gerar solicitação de envio de e-mail ao Serviço Externo de E-mail. A mensagem não deve conter senhas nem informações clínicas. | RF-026, RF-027, RF-033, RF-035 |

---

## 15. Histórias de usuário e critérios de aceite

Os 37 requisitos funcionais têm critério de aceite no formato *Dado / Quando / Então* (`CA-RF-001` a `CA-RF-037`, em `02-requisitos/criterios-aceite.md`). As histórias de usuário estão em `02-requisitos/historias-usuario.md`:

| ID | História | Requisitos relacionados |
|---|---|---|
| HU-001 | Acesso à plataforma | RF-001, RF-002, RF-006 |
| HU-002 | Gerenciamento de usuários | RF-003, RF-004, RF-005, RF-006, RF-010 |
| HU-003 | Controle de perfis e permissões | RF-007, RF-008, RF-009 |
| HU-004 | Administração de psicólogos | RF-011, RF-014 |
| HU-005 | Administração de clientes/pacientes | RF-012, RF-018, RF-019, RF-020 |
| HU-006 | Manutenção profissional | RF-015, RF-016 |
| HU-007 | Consulta de pacientes vinculados | RF-017, RN-003 |
| HU-008 | Consulta do próprio cadastro | RF-022 |
| HU-009 | Disponibilidade profissional | RF-023 |
| HU-010 | Solicitação de agendamento | RF-024, RF-025, RF-026 |
| HU-011 | Acompanhamento de agendamentos | RF-027, RF-028 |
| HU-012 | Gestão da agenda profissional | RF-026, RF-027, RF-029, RF-037 |
| HU-013 | Registro de sessão realizada | RF-030, RF-031 |
| HU-014 | Consulta de auditoria | RF-013, RF-032 |
| HU-015 | Lista de espera inteligente | RF-034, RF-035, RF-036 |
| HU-016 | Avisos por e-mail | RF-033 |

Lacuna registrada: RF-021 não tem história própria (Q3-01).

---

## 16. Diagrama de casos de uso

### 16.1 Identificação e objetivo

**UC-001 (diagrama) — Casos de uso da Plataforma para Psicólogos.** Mostra o que cada ator pode fazer na plataforma e quais comportamentos são reaproveitados por `«include»`.

### 16.2 Elementos principais

| Ator | Casos de uso |
|---|---|
| Administrador | Autenticar-se · Gerenciar usuários e permissões · Gerenciar psicólogos e pacientes · Vincular psicólogo a paciente · Consultar auditoria |
| Psicólogo | Autenticar-se · Gerenciar perfil e agenda · Atender pacientes vinculados · Gerenciar meus agendamentos (cancelamento) |
| Paciente | Autenticar-se · Agendar consulta · Gerenciar meus agendamentos · Consultar meu cadastro |
| — («include») | Registrar evento de auditoria · Notificar por e-mail |

### 16.3 Como interpretar

`«include»` indica comportamento obrigatório reaproveitado: toda operação auditável inclui "Registrar evento de auditoria"; a confirmação do agendamento inclui "Notificar por e-mail". Os dois casos incluídos não têm ator próprio.

### 16.4 Decisões de modelagem

- "Consultar painel administrativo" não é caso de uso isolado: é o ponto de entrada visual dos casos administrativos (revisão dos casos futuros, Integrante 2).
- "Registrar evento de auditoria" é `«include»`, não caso iniciado por ator.
- Não há generalização entre atores: Administrador, Psicólogo e Paciente não têm relação "é um" (DEC-006; OO-01, OO-02).

**Nota de integração (I6):** o diagrama foi produzido na Fase 4 (06/10/2026), antes das decisões de 25/10/2026. Ainda não aparecem: o Serviço Externo de E-mail como ator secundário, a lista de espera (RF-034 a RF-036), o registro de `Não compareceu` (RF-037) e um `«extend»` justificado (candidato: oferta da lista de espera estende o cancelamento). Ver achados Q4-03 a Q4-05 e INT-07.

### 16.5 Relação com requisitos

A cobertura RF × caso de uso está na seção 31. Situação na Fase 6: 31 de 37 RF cobertos por especificação; faltam RF-028 e RF-033 a RF-037.

### 16.6 Arquivos

- Editável: `03-uml/Casos de uso/Diagrama casos de uso uc001/Diagrama casos de uso uc001 .drawio.xml`
- Publicação: `03-uml/Casos de uso/Diagrama casos de uso uc001/Cópia de Diagrama casos de uso uc001 .pdf`

---

## 17. Especificações de casos de uso

As especificações completas estão em `03-uml/Casos de uso/especificacoes-casos-de-uso-criticos.md` (UC-001, UC-021, UC-025, UC-027) e `especificacoes-casos-de-uso-demais.md`. Resumo dos casos críticos:

| UC | Atores | Pré-condição | Pós-condição de sucesso | Alternativos / exceções | Regras |
|---|---|---|---|---|---|
| UC-001 Autenticar usuário | Administrador, Psicólogo, Paciente | Conta cadastrada e ativa | Sessão autenticada restrita ao perfil | A1 encerrar sessão (RF-002) · E1 credenciais inválidas · E2 conta bloqueada | RN-001, RN-002 |
| UC-021 Vincular psicólogo a paciente | Administrador | Psicólogo e paciente cadastrados | Vínculo registrado e auditado | E1 cadastro não encontrado | RN-003, RN-007 |
| UC-025 Solicitar agendamento (confirmação automática) | Paciente | Paciente autenticado e vinculado; disponibilidade cadastrada | Agendamento `Confirmado` e e-mail de confirmação | A1 sem horários · E1 horário deixou de estar disponível → nenhum agendamento é criado (DEC-017) | RN-005, RN-010, RN-013 |
| UC-027 Cancelar agendamento | Paciente, Psicólogo | Agendamento `Confirmado` e horário ainda não iniciado | Situação `Cancelado`, horário liberado, auditoria e e-mail | E1 agendamento já realizado ou cancelado | RN-006, RN-012 |

Casos de uso "demais": Gerenciar usuários e permissões (RF-003 a RF-010) · Gerenciar psicólogos e pacientes (RF-011, RF-012, RF-014, RF-018 a RF-020) · Consultar auditoria (RF-013) · Gerenciar perfil e agenda (RF-015, RF-016, RF-023, RF-029) · Atender pacientes vinculados (RF-017, RF-030, RF-031) · Consultar meu cadastro (RF-022) · Registrar evento de auditoria (RF-032, «include») · Notificar por e-mail (RF-033, «include»).

**Nota de integração (I6):** as linhas de UC-025 e UC-027 acima já usam as decisões de 25/10/2026. O texto versionado das especificações ainda cita como pendentes `DEC-4` (conflito de horário), `DEC-5` (não compareceu) e `DEC-012` (prazo), resolvidos por DEC-017, DEC-025 e DEC-011 (Q4-06). As especificações também não têm o campo "Objetivo" nem, nos casos críticos, a linha "RFs cobertos" (Q4-01, Q4-02).

---

## 18. Modelo de domínio

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto cita **RF-001 a RF-032**; desde 25/10/2026 a baseline vai até **RF-037** (RF-033 e-mail, RF-034 a RF-036 lista de espera, RF-037 não comparecimento).
> - A linha "Notificação e sessão fora do domínio" trata **DEC-009 como pendente**; ela foi aprovada em 25/10/2026.
> - As multiplicidades "fechadas na Fase 5" eram da proposta CLS-001 v2 (retirada do repositório em 28/10/2026); o diagrama oficial do Integrante 3 ainda tem `PENDENTE` (Q5-01, INT-09).
> - A lista de espera (DEC-010) ainda não tem conceito no domínio (Q5-05).

### 18.1 Objetivo

O modelo de domínio representa os conceitos essenciais da plataforma para psicólogos, suas associações e as restrições sustentadas pelos requisitos (RF-001 a RF-037), pelas regras de negócio (RN-001 a RN-014 e RN-020 a RN-022) e pelas decisões do grupo (DEC-001 a DEC-030). É um modelo **conceitual de domínio**: define o que existe, como se relaciona e sob que regras, sem fixar tecnologia de persistência, interface ou arquitetura. Sua função no dossiê é dar uma base comum e rastreável para os diagramas de classes, objetos, sequência, estados e para o modelo relacional.

### 18.2 Elementos principais

O modelo reconhece **treze classes**:

| # | Conceito | Papel no domínio | Requisitos que responde |
|---|---|---|---|
| 1 | `Usuario` | Identidade e conta de acesso, com situação da conta | RF-001 a RF-006, RF-010 |
| 2 | `Perfil` | Papel de acesso do usuário | RF-001, RF-003, RF-007 |
| 3 | `Permissao` | Permissão individual agregada ao perfil | RF-001, RF-007, RF-008 |
| 4 | `Psicologo` | Cadastro profissional e suas áreas de atuação | RF-014 a RF-017, RF-030, RF-031 |
| 5 | `AreaAtuacao` | Catálogo de áreas de atuação profissional | RF-016 |
| 6 | `Paciente` | Cadastro do cliente/paciente e sua situação cadastral | RF-018 a RF-022, RF-028 |
| 7 | `Vinculo` | Autorização que habilita o profissional a atender o paciente | RF-021, RF-017, RF-030, RF-031 |
| 8 | `Agenda` | Agenda titular do profissional | RF-023, RF-024, RF-029 |
| 9 | `Disponibilidade` | Período/horário liberado pelo profissional | RF-023, RF-024 |
| 10 | `SolicitacaoEspera` | Inscrição na fila; `OFERTADA` representa a oferta do slot | RF-034 a RF-036 |
| 11 | `Agendamento` | Compromisso confirmado entre profissional e paciente, com situação | RF-025 a RF-030 |
| 12 | `Atendimento` | Registro conceitual da sessão realizada | RF-030, RF-031 |
| 13 | `RegistroAuditoria` | Trilha cronológica das operações relevantes | RF-013, RF-032 |

O modelo separa deliberadamente **identidade** (`Usuario`) de **autorização** (`Perfil` → `Permissao`) e de **cadastro** (`Psicologo`, `Paciente`): uma conta de acesso não é o cadastro profissional nem o cadastro do paciente. O `Atendente` foi excluído do escopo (DEC-007) e, por isso, não existe como ator nem classe.

### 18.3 Como interpretar

O diagrama do domínio (`03-uml/Dominio/diagrama-dominio.mmd`) apresenta as associações `A01` a `A21`. Cada associação corresponde a uma relação do modelo de classes:

| ID | Associação | Leitura |
|---|---|---|
| A01 | `Perfil` — `Usuario` | Cada conta tem no máximo um perfil; um perfil pode ser compartilhado por várias contas (DEC-019). |
| A02 | `Perfil` — `Permissao` | Um perfil agrupa permissões; a mesma permissão pode servir a vários perfis. |
| A03 | `Usuario` — `Psicologo` | A conta de acesso do profissional é distinta do cadastro profissional. |
| A04 | `Usuario` — `Paciente` | A conta de acesso do paciente é distinta do cadastro do paciente. |
| A05 | `Psicologo` — `AreaAtuacao` | RF-016 permite associar uma ou mais áreas; mínimo por cadastro e compartilhamento não são fixados nesta modelagem. |
| A06 / A07 | `Psicologo` / `Paciente` — `Vinculo` | O vínculo identifica **um** profissional e **um** paciente, e é a base do acesso autorizado. |
| A08 | `Psicologo` — `Agenda` | Cada profissional tem agenda própria (RN-011). |
| A09 | `Agenda` — `Disponibilidade` | Os períodos ofertados pertencem à agenda do titular. |
| A10 | `Agenda` — `Agendamento` | Os compromissos são apresentados na agenda do titular. |
| A11 / A12 | `Psicologo` / `Paciente` — `Agendamento` | Cada agendamento tem exatamente um profissional e um paciente. |
| A13 / A14 | `Psicologo` / `Paciente` — `Atendimento` | Cada atendimento tem um profissional responsável e um paciente. |
| A15 | `Agendamento` — `Atendimento` | Cada atendimento corresponde a um agendamento; cada agendamento tem no máximo um registro de atendimento (DEC-030). |
| A16 | `Usuario` — `RegistroAuditoria` | O registro de auditoria identifica o responsável pela operação. |
| A17 | `Disponibilidade` — `Agendamento` | Cada slot pode estar ocupado por no máximo um agendamento (DEC-018). |
| A18–A21 | `SolicitacaoEspera` e seus participantes/slot/agendamento | A solicitação representa a fila; `OFERTADA` representa a oferta e a conversão depende de aceite e slot disponível. |

As multiplicidades aprovadas e suas referências estão detalhadas na seção 19. Valem estes invariantes: (i) profissional do agendamento corresponde ao titular da agenda; (ii) slot de disponibilidade tem no máximo um agendamento; (iii) um agendamento cancelado não pode gerar atendimento (RN-006); (iv) toda operação auditável preserva responsável, data, hora e operação (RN-009, RN-014).

### 18.4 Decisões de modelagem

| Decisão | Efeito no modelo | Base |
|---|---|---|
| Identidade separada de autorização | `Usuario`, `Perfil` e `Permissao` são três conceitos distintos; A01 é 1:N e A02 é N:N | plano §5.2, DEC-002 e RF-007–008 (autorização por perfil e permissão) |
| Cadastros sem herança de `Usuario` | `Psicologo` e `Paciente` **não** herdam de `Usuario`; a relação é por associação | OO-01, plano §5.2 (evitar herança por permissão) |
| Vínculo como conceito de primeira classe | O acesso do profissional ao paciente depende do vínculo, não do cadastro | RN-003, RN-007, RF-017 |
| Disponibilidade como conceito da agenda | O profissional oferece slots discretos na **própria** agenda; cada slot pode ser ocupado por um agendamento | RN-011, RF-023, DEC-018 |
| Agendamento com situação | O compromisso tem estado explícito, o que sustenta a exclusividade de horário (RN-005) e a proibição de atender cancelado (RN-006) | RN-005, RN-006, RN-010 |
| Atendimento conceitual | O atendimento é um registro de ocorrência, sem conteúdo clínico | DEC-008, RF-030 |
| Auditoria como registro imutável | A trilha admite apenas acréscimos (append-only) e é identificada por responsável, data, hora e operação | RN-009, RN-014, RF-032 |
| Notificação e sessão fora do domínio | Notificação e sessão são responsabilidades de aplicação/fronteira, não entidades de domínio | DEC-020/022 |

### 18.5 Relação com requisitos, classes e banco

Cada um dos 37 requisitos funcionais tem ao menos um conceito do modelo associado, e cada conceito tem requisito associado — não há elemento órfão. O detalhamento completo (RF → RN/RNF → caso de uso → classe → operação → sequência → tabela → teste conceitual) está na **seção 31 (Matriz de rastreabilidade)**, em `06-rastreabilidade/matriz-rastreabilidade-fase5.md`. As tabelas correspondentes (`usuario`, `vinculo`, `agendamento`, entre outras) e as chaves estrangeiras são detalhadas na seção 26.

### 18.6 Arquivos

- Fonte editável do diagrama (Mermaid): `03-uml/Dominio/diagrama-dominio.mmd`
- Fonte editável no diagrams.net: `03-uml/Dominio/diagrama-dominio.drawio.xml`
- Versão para publicação no dossiê: `03-uml/Dominio/diagrama-dominio.pdf`
- Especificação do modelo: `03-uml/Dominio/modelo-dominio.md`
- Revisão da Fase 5: `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md`

---

## 19. Diagrama de classes

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - Na proposta CLS-001 v2 (retirada em 28/10/2026) e no oficial, conforme o caso, o enumerado `SituacaoAgendamento` ainda contém `SOLICITADO`; pela **DEC-016** os valores são apenas `CONFIRMADO`, `CANCELADO`, `REALIZADO` e `NAO_COMPARECEU` (Q5-02).
> - A guarda de `podeSerCancelado()` ("situação atual + prazo") deve ser lida como **"antes do horário marcado"** (DEC-011); o prazo de 2 horas não foi adotado e não há antecedência mínima (DEC-028, 28/10/2026).
> - Atributos e tipos ainda incompletos no diagrama (Q5-08).

### 19.1 Identificação e objetivo

**CLS-001 — Diagrama de classes do domínio da Plataforma para Psicólogos.**
O diagrama detalha as treze classes do modelo de domínio com seus atributos, operações, visibilidades, tipos conceituais e multiplicidades, mostrando **quem** responde por cada responsabilidade e **quem** participa de cada associação.

### 19.2 Elementos principais

- **Classes com estado:** `Usuario` (situação da conta), `Paciente` (situação cadastral), `Vinculo` (situação e temporalidade) e `Agendamento` (situação do compromisso) — cada uma com um conjunto de valores nomeados, alinhado ao dicionário de dados do banco.
- **Classes de comportamento:** `Agendamento` (ciclo de vida da sessão), `Vinculo` (autorização), `Agenda`/`Disponibilidade` (oferta de horários), `RegistroAuditoria` (trilha), `Perfil`/`Permissao` (autorização).
- **Multiplicidades:** A01 segue DEC-019; A03/A04 seguem DEC-021; A02 e A10 são referenciadas a RF-007 e RF-029; A05 é sustentada por RF-016 (RF-008 não sustenta a associação Psicologo–AreaAtuacao); A17 segue DEC-018. A03/A04 mantêm 0..1–0..1.
- **Visibilidade:** atributos privados (`-`) e operações públicas (`+`), sem exposição direta de estado interno.
- **Assinaturas:** os tipos conceituais e contratos definidos constam em `especificacao-classes.md`; assinaturas condicionadas não são descritas como contratos completos.

### 19.3 Como interpretar

Cada operação corresponde a um passo verificável de um caso de uso:

| Família de operações | Passos de caso de uso que executa |
|---|---|
| `Usuario.ativar`, `bloquear`, `associarPerfil`, `atualizarDadosPermitidos` | Conta, situação e associação de perfil (RF-003 a RF-008) |
| `Perfil.adicionarPermissao`, `removerPermissao` | Manutenção das permissões, com refinamentos condicionados (RF-007/008) |
| `Psicologo.atualizarDadosProfissionais`, `associarAreaAtuacao`, consultas | Cadastro profissional e consultas autorizadas (RF-014 a RF-017, RF-031) |
| `Paciente.atualizarCadastro`, `alterarSituacao`, `consultarCadastroPermitido` | Cadastro e consulta permitida (RF-018 a RF-022) |
| `Vinculo.formalizar`, `estaAutorizado`, `encerrar` | Vínculo ativo condiciona acesso (RF-021, RN-003/007, DEC-015) |
| `Agenda.adicionarDisponibilidade`, `verificarDisponibilidade` | Cadastro e verificação de slots (RF-023 a RF-025) |
| `SolicitacaoEspera.registrarEntrada`, `abrirOferta`, `aceitar`, `recusar`, `expirar`, `encerrar`, `consultarPosicao` | Fila e oferta representada por `OFERTADA` (RF-034 a RF-036, DEC-027) |
| `Agendamento.solicitar`, `cancelar` | Criação já confirmada e cancelamento conforme decisões (RF-025 a RF-027, DEC-016/017/028) |
| `Atendimento.registrar`; `RegistroAuditoria.registrar` | Atendimento válido e auditoria por colaboração (RF-030/032) |

A leitura de uma operação deve responder sempre a três perguntas: **qual regra implementa** (RN), **qual requisito satisfaz** (RF) e **quem pode invocá-la** (ator solicitante + permissão). Operação sem regra correspondente não foi incluída — ver a seção de revisões do dossiê, em que as sugestões descartadas estão registradas com justificativa.

### 19.4 Decisões de modelagem

- **Sem classes onipotentes:** nenhuma classe concentra operações de domínios distintos; responsabilidades de aplicação (sessão, notificação externa, consultas agregadas de painel) ficam em serviços, e não em entidades.
- **Herança apenas quando há relação "é um" real:** nenhuma herança foi usada para representar perfis de acesso; `Administrador`, `Psicólogo` e `Paciente` são papéis de `Perfil`, não subclasses de `Usuario`.
- **Encapsulamento da situação:** `Agendamento` não expõe alteração genérica de estado; o ciclo aprovado parte de `CONFIRMADO` (DEC-016/017) e termina em `REALIZADO`, `CANCELADO` ou `NAO_COMPARECEU`, conforme as regras aplicáveis.
- **Guardas explícitas:** `cancelar(solicitante)` é condicionado às regras e atores aprovados; não se presume uma operação `podeSerCancelado()` no modelo.
- **Auditoria por colaboração, não por dependência estrutural:** `RegistroAuditoria` não é dependência de todas as classes; o registro é disparado pelo serviço de aplicação responsável pela operação (RN-009), o que evita acoplamento estrutural indevido.

### 19.5 Relação com requisitos, classes e banco

O diagrama é a origem do mapeamento classe ↔ tabela: treze classes representam conceitos; associações e tabelas de persistência estão detalhadas no modelo relacional. As situações (`Usuario`, `Paciente`, `Vinculo`, `SolicitacaoEspera` e `Agendamento`) são distintas e seguem as decisões aprovadas.

### 19.6 Arquivos

- Fonte editável vigente (Mermaid): `03-uml/Classes/diagrama-classes.mmd` (Integrante 3)
- Fonte editável no diagrams.net: `03-uml/Classes/diagrama-classes.drawio.xml`
- Versão para publicação no dossiê: `03-uml/Classes/diagrama-classes.pdf`
- Especificação de classes: `03-uml/Classes/especificacao-classes.md`
- Decisões de modelagem OO: `03-uml/Classes/decisoes-modelagem.md`

---

## 20. Diagrama de objetos

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O objeto de notificação é descrito "enquanto DEC-009 não for decidida"; DEC-009 foi aprovada em 25/10/2026, e a notificação continua sendo objeto de aplicação, não classe de domínio (DEC-022, aprovada em 28/10/2026).

### 20.1 Identificação e objetivo

**OBJ-001 — Fotografia estrutural do modelo.** O diagrama mostra instâncias identificadas, valores fictícios e ligações existentes. OBJ-002 permanece separado como cenário textual do ciclo de agendamento, pois representa situações e transições diferentes e não deve ser confundido com a fotografia OBJ-001.

### 20.2 Elementos principais

- **OBJ-001:** contas e cadastros fictícios, vínculo, agenda, slot, um agendamento `CONFIRMADO`, o atendimento correspondente e um registro de auditoria.
- **OBJ-002 (separado):** cenário textual com o vínculo `ATIVO`, dois agendamentos (`REALIZADO` e `CANCELADO`), atendimento do primeiro e auditoria das operações; o envio de mensagem é responsabilidade da interface `ServicoEnvioMensagem`, não um objeto/classe de domínio.

### 20.3 Como interpretar

Cada caixa é uma **instância** (não uma classe nova) e a notação `nomeInstancia : Classe` explicita isso. OBJ-001 mostra as ligações concretas A03, A04, A06, A07, A08, A09, A15 e A16; não declara multiplicidades novas.

1. A15 é associação `Agendamento 1 — 0..1 Atendimento`, sem composição (DEC-030);
2. o agendamento `CONFIRMADO` e seu atendimento aparecem em OBJ-001 como fotografia, não como transição executável;
3. as situações `REALIZADO` e `CANCELADO` pertencem ao cenário OBJ-002, mantido separado no texto para não ampliar o diagrama OBJ-001.

Todos os valores são **fictícios** (`CONTA-FICTICIA-C01`, `SLOT-FICTICIO 2040-08-17 09h00`), conforme DEC-005: nenhum nome, documento, e-mail, registro profissional ou conteúdo clínico real aparece nos artefatos.

### 20.4 Decisões de modelagem

- O diagrama **não** declara multiplicidades: a fotografia exemplifica, a cardinalidade é do diagrama de classes.
- `ServicoEnvioMensagem` é a interface de fronteira aprovada (DEC-022), não uma classe/instância de domínio no diagrama de objetos.
- As situações mostradas são as mesmas do diagrama de classes e do dicionário de dados; se o grupo alterar os nomes, os três artefatos mudam juntos (revisão cruzada, plano §13).

### 20.5 Relação com requisitos, classes e banco

Cada objeto de OBJ-001 corresponde a uma instância conceitual; a persistência segue o mapeamento relacional, sem inferir tabelas ou estados novos. OBJ-002 é um cenário separado de ciclo de agendamento e deve ser avaliado contra os testes conceituais correspondentes.

### 20.6 Arquivos

- Fonte editável (Mermaid): `03-uml/Objetos/diagrama-objetos.mmd` (OBJ-001). OBJ-002 permanece como cenário textual separado nesta seção; a separação evita misturar uma fotografia confirmada com outro ciclo de vida.
- Fontes editáveis no diagrams.net: `03-uml/Objetos/diagrama-objetos.drawio.xml`
- Versões para publicação no dossiê: `03-uml/Objetos/diagrama-objetos.pdf`
- Especificações: `03-uml/Objetos/especificacao-objetos.md`

---

## 21. Diagramas de sequência

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto desta seção já é a **v2.1** (29/10/2026): aplica DEC-016/017 (o agendamento nasce `CONFIRMADO`), DEC-011/028 (guarda "antes do horário marcado"), DEC-009/029 (e-mail obrigatório, falha auditada e não desfaz) e DEC-010/027 (lista de espera, SEQ-004).
> - O fechamento da v2.1 desenha o que faltava do lote da fila e do e-mail: consulta de posição (`posicaoNaFila`, OP-28), saída da fila (`DESISTIU`), reserva do horário durante o prazo e `registrar("FALHA_ENVIO_EMAIL")` nos três eventos.
> - As sequências somam **136 setas** (85 solicitações e 51 retornos), não 114: SEQ-001 31, SEQ-002 21, SEQ-003 32 e SEQ-004 52.

### 21.1 Identificação e objetivo

O plano da AV3 pede "pelo menos três diagramas de sequência para os casos de uso críticos aprovados, garantindo que mensagens, retornos, alternativas e exceções sejam coerentes com os fluxos textuais" (§6.1, Integrante 2). A Fase 6 entrega **quatro** diagramas de sequência — um a mais que o mínimo, para cobrir a lista de espera:

| ID | Título | Caso de uso | RFs cobertos |
|---|---|---|---|
| **SEQ-001** | Autenticar usuário | UC-001 | RF-001, RF-002, RF-032 |
| **SEQ-002** | Agendar atendimento | UC-025 (+ UC-024) | RF-024, RF-025, RF-026, RF-032, RF-033, RF-034 |
| **SEQ-003** | Cancelar / concluir / registrar falta | UC-027 (+ UC-035 `<<extend>>`) | RF-026, RF-027, RF-028, RF-030, RF-032, RF-033, RF-035, RF-037 |
| **SEQ-004** | Lista de espera e oferta de vaga | UC-034, UC-035, UC-036 | RF-025, RF-026, RF-027, RF-032, RF-033, RF-034, RF-035, RF-036 |

O objetivo comum é mostrar **quem fala com quem, em que ordem e sob qual condição**, de modo que cada passo do texto do caso de uso possa ser lido como uma mensagem entre participantes identificados.

### 21.2 SEQ-001 — Autenticar usuário (UC-001)

**Linhas de vida (7):** Ator (paciente, psicólogo ou administrador) · `ServicoAutenticacao` (AP-01) · `RepositorioUsuario` (IR-01) · `Usuario` · `RepositorioAutorizacao` (IR-02) · `ServicoAuditoria` (AP-02) · `RegistroAuditoria`.

**Fluxo:** `autenticar(email, senha)` → `obterPorIdentificacao(identificacao)` → `podeAutenticar()` (OP-01, RN-001) → `confereCredencial(senha)` (OP-02, RN-002) → `obterPermissoes(idUsuario)` → `criarSessao(usuario)` → `registrar("LOGIN_CONCEDIDO" | "LOGIN_NEGADO", …)`.

**Alternativas e exceções:** `alt` **E1 — credencial inválida** (recusa + auditoria `LOGIN_NEGADO`); `alt` **E2 — conta bloqueada ou inativa** (recusa por RN-001 + auditoria); `opt` **A1 — encerrar sessão** (`invalidarSessaoAtiva`, AP-01).

**Volume:** 31 setas (19 solicitações e 12 retornos).

### 21.3 SEQ-002 — Agendar atendimento (UC-025 + UC-024)

**Linhas de vida (8):** Ator (paciente) · `ServicoAgenda` (AP-03) · `Vinculo` · `Agenda` · `Agendamento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04).

**Fluxo:** consulta de horários (`consultarHorariosDisponiveis`, OP-11) → validação do vínculo (`estaAtivo`, OP-22) → escolha do horário → `verificarDisponibilidade(horario)` (RN-010) — o horário é um **slot discreto** (DEC-018), de modo que a consulta devolve slots reais e a exclusividade é verificada slot a slot → `Agendamento.solicitar(...)` → **agendamento devolvido já `CONFIRMADO`** (RF-026 / RN-013) → auditoria → **e-mail de confirmação** (na falha, `registrar("FALHA_ENVIO_EMAIL")` e o agendamento continua válido — DEC-029) → resposta ao ator.

**Alternativas e exceções:** `alt` **A1 — nenhum horário disponível** (informar e **oferecer a lista de espera**, RF-034 / SEQ-004); `alt` **E1 — conflito de horário** (recusa com sugestão de outro horário).

**Volume:** 21 setas (11 solicitações e 10 retornos).

> **Não há passo `confirmar`.** A v1.0 tinha `Agendamento.solicitar` → `confirmar(solicitante)` (OP-13) porque o agendamento nascia `SOLICITADO`. Com a remoção dessa situação, criar e confirmar passam a ser o **mesmo ato**: a mensagem `confirmar` desapareceu da sequência e a situação inicial do EST-001 é `CONFIRMADO`.

### 21.4 SEQ-003 — Cancelar / concluir / registrar falta (UC-027 + UC-035)

**Linhas de vida (8):** Ator (paciente ou psicólogo) · `ServicoAgenda` (AP-03) · `Agendamento` · `Atendimento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04) · `ServicoListaEspera` (AP-06).

**Fluxo do cancelamento:** `consultarMeus(solicitante)` (OP-19, RF-028 / UC-028) → `cancelar(agendamento, motivo)` → `podeSerCancelado()` (OP-15, RN-012) → **guarda `[antes do horário marcado]`** → `cancelar(solicitante, motivo)` (OP-14) → auditoria (`AGENDAMENTO_CANCELADO`) → **e-mail de cancelamento (sempre)** → `opt <<extend>> UC-035` oferta de vaga → resposta ao ator.

**Blocos `opt` alternativos (não são etapas obrigatórias em sequência):** conclusão da sessão realizada (`RF-030`, com `estaCancelada()` — OP-16/RN-006 —, `concluir` — OP-17 — e `Atendimento.registrar` — OP-20) e registro de não comparecimento (`RF-037`, `registrarFalta` — OP-18 — por ação do psicólogo, DEC-025).

**Alternativa:** `alt` **E1 — agendamento já realizado ou já cancelado** (recusa).

**Volume:** 32 setas (20 solicitações e 12 retornos).

> **A oferta de vaga é `<<extend>>`, não um caso de uso independente.** Ela aparece como `opt` **dentro** do ramo "pode ser cancelado" e só existe quando há cancelamento **e** fila (UC-035 / DEC-027). O detalhamento — uma oferta por vez, prazo de aceite, recusa passa ao próximo — está na SEQ-004.
>
> **A notificação do cancelamento é obrigatória e não bloqueante:** a mensagem `notificar(evento=cancelamento)` é sempre enviada; o retorno `entregue | falha de envio` deixa explícito que a falha **não desfaz** o cancelamento (RF-033 / DEC-022). A falha é **registrada na auditoria** e o envio pode ser **repetido** (DEC-029).

### 21.5 SEQ-004 — Lista de espera e oferta de vaga (UC-034 a UC-036)

**Linhas de vida (8):** Ator (paciente) · `ServicoListaEspera` (AP-06) · `SolicitacaoEspera` · `ServicoAgenda` (AP-03) · `Agendamento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoEnvioMensagem` (AP-04).

**Fluxo — entrada na fila:** `entrarNaFila(psicologo, paciente, periodo)` → `registrarEntrada(...)` (OP-23) → solicitação `AGUARDANDO` com `dataHoraEntrada` → auditoria → resposta com a posição (ordem de entrada).

**Fluxo — consulta da posição e saída da fila (`opt`):** `consultarPosicao(psicologo, paciente)` → `posicaoNaFila(...)` (OP-28) → posição atual e `dataHoraEntrada`; `sairDaFila(solicitacao)` → `encerrar(DESISTIU)` (OP-27) → auditoria `"ESPERA_ENCERRADA"`.

**Fluxo — oferta (`opt <<extend>>` do cancelamento):** `ServicoAgenda.ofertarVaga(horarioLiberado)` → `proximoDaFila(psicologo)` (OP-24) → `alt` **há solicitação e nenhuma oferta aberta** → `abrirOferta(horario, prazoAceite)` (OP-25) → `OFERTADA` com o **horário reservado até o prazo** → **e-mail de oferta** (falha auditada como `"FALHA_ENVIO_EMAIL"`) → auditoria; `else` **fila vazia ou oferta já aberta** → nenhuma oferta é criada.

**Fluxo — resposta (`alt` de três ramos):**

| Ramo | Comportamento |
|---|---|
| **Aceite dentro do prazo** | `validarPrazo()` (OP-26) → `ServicoAgenda.agendar(...)` → `Agendamento.solicitar` **já `CONFIRMADO`** → auditoria → e-mail de confirmação → `encerrar(ACEITA)` (OP-27). |
| **Recusa** | `encerrar(RECUSADA)` (OP-27) → auditoria → **reoferta ao próximo** (`ofertarVaga` recursivo). |
| **Prazo vencido** | `expirarOferta(prazoAceite)` → `EXPIRADA` (OP-27) → auditoria → **reoferta ao próximo**. |

**Volume:** 52 setas (35 solicitações e 17 retornos).

> **Por que a SEQ-004 existe.** Na v1.0 a sequência do "encaixe" estava bloqueada pela DEC-010. A DEC-027 resolveu a questão: o "encaixe" foi **substituído pela lista de espera**, com regras explícitas, e por isso a quarta sequência passou a ser obrigatória — ela é a única que mostra `SolicitacaoEspera`, OP-23…OP-27 e AP-06.
>
> **Ressalvas da DEC-027 fechadas na v2.1:** a **consulta da posição** (`consultarPosicao` → `posicaoNaFila`, OP-28), a **saída da fila** (`sairDaFila` → `encerrar(DESISTIU)`, OP-27) e a **reserva do horário durante o prazo** (devolvida por `abrirOferta(horario, prazoAceite)`) estão desenhadas. O horário reservado não aparece como livre; se a fila acabar (recusa/vencimento sem próximo), volta ao catálogo. A falha de envio é registrada na auditoria (`"FALHA_ENVIO_EMAIL"`) e não desfaz a oferta nem o agendamento (DEC-029).

### 21.6 Como interpretar

1. **A linha de vida é a unidade de responsabilidade.** `ServicoAgenda`, `ServicoAuditoria`, `ServicoAutenticacao`, `ServicoListaEspera` e `ServicoEnvioMensagem` são **responsabilidades de aplicação** (AP-01 a AP-06): concentram a orquestração e ficam **fora** do diagrama de classes de domínio, conforme o plano §5.2. As entidades (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `SolicitacaoEspera`, `RegistroAuditoria`) carregam as regras.
2. **Toda mensagem remete a uma operação ou responsabilidade conhecida.** As **136 setas** dos quatro diagramas (85 solicitações e 51 retornos) foram conferidas uma a uma contra as operações `OP-01…OP-28`, as responsabilidades `AP-01…AP-06` e as interfaces de infraestrutura `IR-01`/`IR-02`. Não existe mensagem "inventada para satisfazer um diagrama futuro" (plano §8).
3. **A seta tracejada é o retorno** (`-->>`) e não conta como mensagem nova na contagem.
4. **`alt` é alternativa de fluxo, `opt` é bloco condicional**, e ambos refletem o texto do caso de uso — nenhuma alternativa existe só no diagrama.
5. **As guardas aparecem entre colchetes** na própria mensagem (`[OP-15 / RN-012]`), de modo que a regra fica legível sem consultar a matriz.
6. **Repositórios são infraestrutura**, não domínio: aparecem como `RepositorioUsuario` e `RepositorioAutorizacao`, e apenas carregam dados.
7. **O e-mail é sempre solicitado** (RF-033) nos três eventos de agenda — confirmação, cancelamento e oferta de vaga. A resposta `entregue | falha de envio` é **retorno**, não desfaz a operação e não gera transição de estado; a falha é registrada na auditoria e o envio pode ser repetido (DEC-029).

### 21.7 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| A entidade decide, o repositório carrega | `podeAutenticar()` (OP-01) e `confereCredencial()` (OP-02) estão na entidade `Usuario`, não no repositório | plano §5.2, RN-001/RN-002 (achado **R6-03**) |
| Agendamento nasce `CONFIRMADO` | `Agendamento.solicitar` cria e confirma no mesmo ato; **não existe** mensagem `confirmar` nem situação `SOLICITADO` | RF-025 + RF-026, RN-013, DEC-016 revista |
| Notificação é fronteira externa **obrigatória** | `ServicoEnvioMensagem` é interface (DEC-022); o envio é sempre solicitado e a falha não bloqueia | RF-033, DEC-022, TRS-02 do Integrante 4 |
| Auditoria como efeito transversal | `registrar(...)` é sempre delegado a `ServicoAuditoria` e nunca executado "de dentro" da entidade | RN-009, RN-014 |
| Sessão fora do domínio | `criarSessao` / `invalidarSessaoAtiva` são responsabilidade de aplicação | RF-002, P-07 |
| Cancelamento exige verificação prévia | `podeSerCancelado()` (OP-15) é consultada antes de `cancelar` (OP-14), com guarda **`[antes do horário marcado]`** | RN-012, DEC-011 + DEC-028 |
| Oferta de vaga é `<<extend>>` | o `opt` de UC-035 fica **dentro** do ramo de cancelamento, não é participante obrigatório | UC-035, DEC-027 |
| Lista de espera é domínio | `SolicitacaoEspera` tem estado persistente, ordem e prazo → entidade; `ServicoListaEspera` (AP-06) coordena | DEC-027 |
| Consulta e saída da fila | `consultarPosicao`/`posicaoNaFila` (OP-28) e `sairDaFila`/`encerrar(DESISTIU)` (OP-27), com auditoria `"ESPERA_ENCERRADA"` | DEC-027, RF-034 |
| Oferta reserva o horário | `abrirOferta(horario, prazoAceite)` devolve `OFERTADA` com o slot reservado até o prazo | DEC-027, RN-010 |
| Falha de envio é auditada e repetível | `registrar("FALHA_ENVIO_EMAIL")` nos três eventos; a operação de agenda permanece válida | DEC-029, RF-033 |
| "Não compareceu" é manual | bloco `opt` próprio, iniciado pelo psicólogo, sem expiração automática | RF-037, DEC-025 |

### 21.8 Relação com requisitos, classes e banco

Cada mensagem dos quatro diagramas corresponde a uma **operação do modelo de classes** (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `SolicitacaoEspera`, `RegistroAuditoria`), a uma responsabilidade de aplicação (`AP-01…AP-06`) ou a uma interface de infraestrutura (`IR-01`/`IR-02`) — a matriz completa está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (§2.1 a §2.4). No banco, os mesmos passos correspondem às tabelas `usuario`, `vinculo`, `agendamento`, `atendimento`, `solicitacao_espera` e `registro_auditoria` (seção 26 do dossiê); o envio de e-mail **não** tem tabela, por ser serviço externo (DEC-022).

### 21.9 Arquivos

| Artefato | Arquivo |
|---|---|
| SEQ-001 (fonte, editável e PDF) | `03-uml/Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-002 | `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-003 | `03-uml/Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-004 | `03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd` · `.drawio.xml` · `.pdf` |
| Especificação das quatro | `03-uml/Sequências/proposta-I2-especificacao-sequencias.md` |
| Casos de uso novos/revisados | `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` |
| Revisão da fase | `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` |

---

## 22. Diagrama de comunicação

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto desta seção já é a **v2.1**: 14 colaboradores e 17 mensagens, com `ServicoEnvioMensagem` (DEC-022) e `ServicoListaEspera` (DEC-027). A falha de envio é caminho de exceção nas sequências, não mensagem nova no COM-001.

### 22.1 Identificação e objetivo

**COM-001 — Diagrama de comunicação: ciclo do agendamento.**
O diagrama de comunicação representa **a mesma informação** do diagrama de sequência, mas com o foco invertido: em vez de mostrar a ordem no tempo, mostra **quais objetos colaboram** e **qual objeto coordena a colaboração**. Ele atende ao item do plano §6.1 ("diagrama de comunicação para um cenário relevante") e cumpre a função de **checagem cruzada**: o cenário é o mesmo da SEQ-002, da SEQ-003, da SEQ-004 e do ATV-001, de modo que qualquer objeto ou mensagem que apareça em um e não em outro fica evidente.

**Cenário:** "Agendar, cancelar e concluir atendimento" (UC-024 + UC-025 + UC-027 + UC-035).

### 22.2 Elementos principais

**Quatorze colaboradores**, com natureza indicada pela forma:

| Colaborador | Natureza | Papel no cenário |
|---|---|---|
| `Paciente` | fronteira externa | solicita e cancela |
| `Psicólogo` | fronteira externa | conclui o atendimento |
| **`Serviço Externo de E-mail`** (`ServicoEnvioMensagem`) | **fronteira externa** | envia confirmação, cancelamento e oferta de vaga (AP-04 / RF-033) |
| `Usuario` | entidade de domínio | sobre o qual recai a autorização por operação (OP-04) |
| `ServicoAgenda` | **serviço de aplicação (hub)** | coordena o cenário (AP-03) |
| `ServicoAuditoria` | serviço de aplicação | trilha (AP-02) |
| **`ServicoListaEspera`** | **serviço de aplicação** (AP-06) | coordena a fila e a oferta de vaga (DEC-027) |
| `Vinculo` | entidade de domínio | autorização do vínculo (OP-22) |
| `Agenda` | entidade de domínio | catálogo de horários (OP-11) |
| `Disponibilidade` | entidade de domínio | slots ofertados (A09) |
| `Agendamento` | entidade de domínio | compromisso e seu ciclo (OP-14) |
| **`SolicitacaoEspera`** | **entidade de domínio** (DEC-027) | fila, ordem de entrada e prazo (OP-24) |
| `Atendimento` | entidade de domínio | registro da sessão (OP-20) |
| `RegistroAuditoria` | entidade de domínio | registro imutável (RF-032) |

**Leitura das formas:** `[ ]` entidade de domínio · `{ }` serviço de aplicação · `( )` fronteira (ator ou serviço externo).

> **Mudança em relação à v1.0:** `ServicoNotificacao` foi renomeado para **`ServicoEnvioMensagem`** (DEC-022) e ganhou o rótulo "Serviço Externo de E-mail"; entraram `ServicoListaEspera` e `SolicitacaoEspera` (DEC-027). O diagrama passa de **12 colaboradores e 14 mensagens** para **14 colaboradores e 17 mensagens**.

### 22.3 Como interpretar

As **17 mensagens** estão numeradas na ordem de ocorrência, e cada seta carrega a identificação da operação e a regra/requisito que a origina:

| # | Emissor → Receptor | Mensagem | Origem |
|---|---|---|---|
| 1 | `Paciente` → `ServicoAgenda` | `solicitar(horario)` | RF-025 |
| 2 | `ServicoAgenda` → `Usuario` | `consultarPermitidos()` | OP-04 |
| 3 | `ServicoAgenda` → `Vinculo` | `estaAtivo()` | OP-22 / RN-003 |
| 4 | `ServicoAgenda` → `Agenda` | `consultarHorarios()` | OP-11 |
| 5 | `Agenda` → `Disponibilidade` | `slots livres` | A09 |
| 6 | `ServicoAgenda` → `Agenda` | `verificarDisponibilidade()` | RN-005 |
| 7 | `ServicoAgenda` → `Agendamento` | `solicitar(horario)` | RF-025 (cria `CONFIRMADO`) |
| 8 | `ServicoAgenda` → `ServicoAuditoria` | `registrar(criacao)` | AP-02 |
| 9 | `ServicoAuditoria` → `RegistroAuditoria` | `registrar(tabela)` | RF-032 |
| 10 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(confirmacao)` | RF-033 |
| 11 | `ServicoAgenda` → `Agendamento` | `cancelar(motivo)` | OP-14 (antes do horário) |
| 12 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(cancelamento)` | RF-033 |
| 13 | `ServicoAgenda` → `ServicoListaEspera` | `ofertarVaga()` | RF-035 / DEC-027 |
| 14 | `ServicoListaEspera` → `SolicitacaoEspera` | `proximoDaFila()` | OP-24 (ordem de entrada) |
| 15 | `ServicoListaEspera` → `Serviço Externo de E-mail` | `notificar(ofertaVaga)` | RF-033 |
| 16 | `Psicólogo` → `ServicoAgenda` | `concluir(agendamento)` | RF-030 |
| 17 | `ServicoAgenda` → `Atendimento` | `registrar(atendimento)` | OP-20 |

**Vínculos com mais de uma mensagem:** 4 e 6 (`ServicoAgenda`—`Agenda`), 7 e 11 (`ServicoAgenda`—`Agendamento`) e 10/12 (`ServicoAgenda`—`E-mail`) percorrem o **mesmo vínculo**. A ordem é dada pela **numeração**, não pela posição da seta — limitação do renderizador offline, que desenha retas sem deslocamento lateral. **Os retornos** (valores devolvidos pelos colaboradores, inclusive "agendamento `CONFIRMADO`" e "entregue | falha de envio") **não** geram seta própria: percorrem o vínculo no sentido inverso, como manda a notação de comunicação.

**A falha de envio não cria mensagem nova no COM-001**: ela é caminho de exceção nas sequências e percorre o mesmo vínculo 10/12/15, com o retorno `entregue | falha de envio`. O registro `"FALHA_ENVIO_EMAIL"` é feito pelo serviço que detectou a falha (SEQ-002/003/004), não pelo colaborador externo.

**O `ServicoAgenda` é o hub** do diagrama: todas as mensagens que disparam regra passam por ele, e é ele que aciona auditoria e envio de mensagem. Isso é proposital — é a materialização da regra do plano §5.2 contra a **classe onipotente**: o poder de decisão fica dividido entre `ServicoAgenda` (orquestração), as entidades (regras), `ServicoAuditoria`/`ServicoEnvioMensagem` (efeitos) e `ServicoListaEspera` (fila).

### 22.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Um único diagrama de comunicação | o plano pede "um cenário relevante"; o cenário do agendamento é o de maior densidade de objetos | plano §6.1 |
| `ServicoAgenda` como hub | concentração da coordenação sem concentração de regra | plano §5.2 (AP-03) |
| Retornos não geram seta | o grafo tem 17 arestas (mensagens), não 17 diálogos com resposta | notação de diagrama de comunicação |
| Notificação como fronteira externa | `ServicoEnvioMensagem` é interface, não entidade; o rótulo diz "Serviço Externo de E-mail" | DEC-022, RF-033 |
| A notificação sai do hub (10, 12) e da fila (15) | notificar é efeito de aplicação, não regra do domínio | RF-033, TRS-02 |
| Oferta de vaga vem do hub para `ServicoListaEspera` (13) | é `<<extend>>` do cancelamento, não um caso iniciado por ator | UC-035, DEC-027 |
| Autorização por operação (OP-04) separada das permissões da sessão | `consultarPermitidos` ≠ `obterPermissoes` | achado **R6-04** |

### 22.5 Relação com requisitos, classes e banco

Os quatorze colaboradores são **dez classes do modelo de domínio** (`Usuario`, `Vinculo`, `Agenda`, `Disponibilidade`, `Agendamento`, `SolicitacaoEspera`, `Atendimento`, `RegistroAuditoria` e demais) e **responsabilidades de aplicação/fronteira** (`ServicoAgenda`, `ServicoAuditoria`, `ServicoListaEspera`, `ServicoEnvioMensagem`) — nenhuma classe nova foi criada além do incremento da DEC-027. As mensagens 1 a 17 correspondem, uma a uma, aos passos da SEQ-002, da SEQ-003, da SEQ-004 e às atividades do ATV-001; a correspondência está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.5.

### 22.6 Arquivos

| Artefato | Arquivo |
|---|---|
| COM-001 (fonte, editável e PDF) | `03-uml/Comunicação/proposta-I2-comunicacao-com-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Comunicação/proposta-I2-especificacao-comunicacao.md` |

---

## 23. Diagrama de atividades

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto desta seção já é a **v2.1**: inclui a notificação do cancelamento e a oferta de vaga (DEC-027); 4 pistas, 37 nós e 39 arestas.

### 23.1 Identificação e objetivo

**ATV-001 — Diagrama de atividades: ciclo do agendamento.**
O plano §6.1 pede "o diagrama de atividades com decisões, responsabilidades e paralelismo quando aplicável". O ATV-001 representa o **fluxo de negócio** do agendamento — do pedido do horário até a conclusão, o cancelamento ou a falta — destacando **quem** executa cada passo (**responsabilidade**) e **onde** a regra decide (**decisões**).

### 23.2 Elementos principais

- **Quatro pistas (swimlanes):** *Paciente* · *Sistema (aplicação e domínio)* · *Psicólogo* · **Auditoria, notificação e extensão**. A quarta pista mudou de nome na v2.0 porque passou a conter também a **oferta de vaga** (a extensão do cancelamento), além de auditoria e notificação.
- **Quatro decisões:** `d1` (Há horários?), `d2` (Vínculo OK?), `d3` (Cancelamento? — inclui a guarda "antes do horário marcado"), `d5` (Sessão realizada?).
- **Três blocos paralelos (fork/join):**

| Bloco | Gatilho | Ramos paralelos | Join |
|---|---|---|---|
| `fork1`/`join1` | Criar agendamento (CONFIRMADO) | auditar criação ‖ notificar confirmação | `join1` |
| `fork2`/`join2` | Cancelar (OP-14) | liberar horário ‖ auditar cancelamento | `join2` |
| `fork3`/`join3` | Registrar atendimento (OP-20) | concluir (OP-17) ‖ auditar conclusão | `join3` |

- **Duas etapas sequenciais** entre o `join2` e o fim do bloco de cancelamento: `Notificar cancelamento (RF-033)` → `Ofertar vaga se houver fila (UC-035)`. A notificação só pode ocorrer depois que o cancelamento está gravado e auditado (pós-commit, TRS-02) e antes da oferta; a oferta só pode ocorrer depois do slot liberado e da notificação (ordem idêntica à da SEQ-003: `registrar` → `notificar` → `ofertar`).
- **A condição "se houver fila" fica no rótulo do nó**, e não em um quinto losango: o `<<extend>>` é opcional por definição e não altera o caminho principal.

### 23.3 Como interpretar

1. **A pista mostra a responsabilidade, não o objeto.** Uma atividade pode ser executada por uma entidade de domínio (`Criar agendamento (CONFIRMADO)`) ou por um serviço de aplicação (`Auditar criação`).
2. **O losango é uma decisão da regra**, e o texto no losango é curto por limitação de espaço; a condição completa está na especificação do diagrama e no caso de uso.
3. **A barra de paralelismo indica independência de regra**, não transação única: o paralelismo é lógico. A fronteira transacional é responsabilidade da camada de persistência (Fase 7) e é explicitamente o que o TRS-02 do Integrante 4 restringe.
4. **Cada rota tem um `Fim`** — a notação de atividade exige fim explícito em cada rota terminal (sem horários, recusa, cancelamento, sessão realizada e falta = 5 nós `Fim`).
5. **O cancelamento e a sessão realizada são alternativas**, não etapas em sequência: `d3` separa "o paciente cancela" de "o paciente mantém".
6. **Não existe atividade de "confirmar".** A criação já produz o agendamento `CONFIRMADO`; o antigo par `Criar → Confirmar (OP-13)` foi colapsado em um único nó.

### 23.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Quatro pistas, e não duas | separa a regra de negócio dos efeitos transversais e da extensão | plano §5.2 |
| "Liberar horário" aparece só no cancelamento | é consequência da regra (RN-012/RN-010) sobre o catálogo de disponibilidade, não uma mensagem a um serviço de aplicação | RN-010, RN-012 |
| Notificação do cancelamento sequencial, antes da oferta | mantém a ordem *auditar → notificar → ofertar* do SEQ-003 | TRS-02, RF-033, achado **R6-05** |
| Oferta de vaga na pista de extensão e **sem 5º losango** | é `<<extend>>` do cancelamento; a condição "se houver fila" está no rótulo | UC-035, DEC-027 |
| Auditoria e notificação sempre executadas | efeitos obrigatórios: auditoria (RN-009) e e-mail (RF-033), sem caráter condicional | RN-009, RF-033 |
| Sem sessão como atividade | sessão está fora do domínio | plano §5.2, P-07 |
| Decisões `d1`, `d2`, `d3`, `d5` | uma decisão por desvio de rota do caso de uso | UC-024, UC-025, UC-027 |

### 23.5 Relação com requisitos, classes e banco

Cada atividade do ATV-001 corresponde a uma operação de domínio, a uma responsabilidade de aplicação ou a um efeito de regra (matriz `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.6). Nenhuma atividade existe sem origem: os **37 nós** do diagrama são **1 início + 21 atividades + 4 decisões + 3 forks + 3 joins + 5 nós `Fim`**, ligados por **39 arestas**. As atividades de consulta de horário e de registro de atendimento correspondem, no banco, a leituras e escritas em `disponibilidade`, `agendamento` e `atendimento` (seção 26); a oferta de vaga corresponde a `solicitacao_espera`.

### 23.6 Arquivos

| Artefato | Arquivo |
|---|---|
| ATV-001 (fonte, editável e PDF) | `03-uml/Atividade/proposta-I2-atividade-atv-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Atividade/proposta-I2-especificacao-atividade.md` |

---

## 24. Máquina de estados

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto desta seção já é a **v2.1**: 4 situações e 4 transições (T0–T3), sem `SOLICITADO` (DEC-016/017) e com a guarda da DEC-011/028. Falta o Integrante 3 retirar `Agendamento.confirmar()` do CLS-001 (R6-09) e incorporar OP-23…OP-28/AP-06 (LAC-10).

### 24.1 Identificação e objetivo

**EST-001 — Máquina de estados do `Agendamento`.**
O §6.1 do plano pede a máquina de estados de uma entidade relevante, com **eventos, condições e ações nas transições**. O EST-001 fixa o ciclo de vida da situação do compromisso, usando exatamente as **quatro situações** do enumerado `SituacaoAgendamento` (CLS-001 v2): `CONFIRMADO`, `REALIZADO`, `CANCELADO` e `NAO_COMPARECEU`.

### 24.2 Elementos principais

**Quatro situações** — os valores do enumerado `SituacaoAgendamento` e da coluna `agendamento.status` do banco:

| Situação | Significado | Pode sair? |
|---|---|---|
| `CONFIRMADO` | horário reservado e confirmado — **situação inicial** | Sim (3 transições) |
| `REALIZADO` | sessão realizada e registrada | **Não** (terminal) |
| `CANCELADO` | cancelamento antes do horário marcado | **Não** (terminal) |
| `NAO_COMPARECEU` | falta registrada pelo psicólogo | **Não** (terminal) |

**Quatro transições** (uma de criação + três de saída):

| # | Transição | Evento | Guarda | Operação |
|---|---|---|---|---|
| **T0** (criação) | `[*] → CONFIRMADO` | `solicitar` | `[vínculo ATIVO e slot livre]` | `Agendamento.solicitar` (RF-025 / RF-026 / RN-013) |
| **T1** | `CONFIRMADO → CANCELADO` | `cancelar` | **`[antes do horário marcado]`** | OP-14 / OP-15 (RN-012) |
| **T2** | `CONFIRMADO → REALIZADO` | `concluir` | `[atendimento registrado e vinculado ao agendamento]` | OP-17 / OP-20 (RF-030 / DEC-030) |
| **T3** | `CONFIRMADO → NAO_COMPARECEU` | `registrarFalta` | `[horário já passou; ação do psicólogo]` | OP-18 (RF-037 / DEC-025) |

### 24.3 Como interpretar

1. **`CONFIRMADO` é o estado inicial** e `REALIZADO`, `CANCELADO` e `NAO_COMPARECEU` são **terminais**: não há retorno de um compromisso encerrado.
2. **O evento é a causa; a guarda é a condição.** `cancelar` só se aplica a `CONFIRMADO` e **antes do horário marcado**; depois do início, o compromisso só pode terminar como `REALIZADO` ou `NAO_COMPARECEU`.
3. **A ausência de transição é uma informação**: não existe `CONFIRMADO → SOLICITADO` nem qualquer retorno a `CONFIRMADO`; a correção de um encerramento é um **novo agendamento**.
4. **Não existe transição de cancelamento a partir de `REALIZADO`**: um atendimento realizado não é "des-cancelado" nem "des-realizado".
5. **A oferta de vaga não é transição**: é efeito colateral de T1 (ver §24.5).

### 24.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| **Quatro situações, três terminais** | o compromisso encerrado não volta | plano §5.4, DEC-016 revista |
| **`CONFIRMADO` é a situação inicial** | não há passo de aprovação; criação e confirmação são o mesmo ato | RF-025 + RF-026, RN-013 |
| `NAO_COMPARECEU` só a partir de `CONFIRMADO` | fecha a INC-13 do Integrante 4 e a pergunta P-14 | INC-13, RF-037, DEC-025 |
| **Guarda `[antes do horário marcado]`** | não existe antecedência mínima; a condição é o início do horário | RN-012, DEC-028 (a DEC-012 não foi adotada) |
| **Sem situação "aguardando aprovação"/`SOLICITADO`** | não há aprovação manual nem confirmação posterior no escopo | RN-013 |
| **A máquina tem 4 situações e 4 transições** (T0–T3) | qualquer contagem diferente em outro artefato é divergência a corrigir | esta entrega |

### 24.5 Relação com requisitos, classes e banco

As quatro situações são os valores do enumerado `SituacaoAgendamento` (modelo de classes, seção 19) e correspondem à coluna `agendamento.status` do modelo relacional (seção 26, com a restrição de domínio correspondente). Cada transição tem operação de origem (Tabela §2.7 da matriz da Fase 6) e caso de uso associado (UC-025, UC-027 ou UC-037). Nenhuma situação existe sem atributo persistível e nenhuma transição existe sem operação.

**A oferta de vaga não é transição:** o agendamento cancelado permanece `CANCELADO`; a fila e o prazo de aceite vivem em `SolicitacaoEspera` (SEQ-004). Tentar representá-la como estado do agendamento duplicaria o ciclo de vida em duas entidades.

**Pendência registrada (não é lacuna desta entrega):** o diagrama de classes oficial (CLS-001) ainda declara `Agendamento.confirmar()` e não fixa o enumerado das quatro situações; as propostas da Fase 5 que traziam esse enumerado foram retiradas do repositório em 28/10/2026. A máquina e os diagramas da Fase 6 já usam exatamente as quatro situações da DEC-016; o **Integrante 3** precisa retirar `confirmar()` e incorporar o enumerado (achado **R6-09**).

### 24.6 Arquivos

| Artefato | Arquivo |
|---|---|
| EST-001 (fonte, editável e PDF) | `03-uml/Estados/proposta-I2-estados-est-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Estados/proposta-I2-especificacao-estados.md` |

---

## 25. Arquitetura: pacotes, componentes e implantação

**Situação:** rascunho v0.7 (30/10/2026), montado pelo Integrante 6 a partir dos artefatos do Integrante 4 (entregues em 29/10/2026). O Integrante 4 deve revisar o texto; o PDF dos três diagramas está pendente (Q7-01). Norma: ISO/IEC/IEEE 42010:2022.

**Estilo.** Arquitetura em camadas com inversão de dependência: `apresentação → aplicação → domínio ← infraestrutura`. A aplicação não conhece a infraestrutura; depende das interfaces de repositório e de `ServicoEnvioMensagem`, ambas no domínio (DEC-022). O pacote de configuração liga as pontas.

| Diagrama | ID | Fonte | O que mostra |
|---|---|---|---|
| Pacotes | PAC-001 | `03-uml/Pacotes/diagrama-pacotes.mmd` e `.drawio.xml` | Camadas, serviços de aplicação (autenticação, cadastro, autorização, agenda, lista de espera, auditoria, tempo, unidade de trabalho) e entidades do domínio |
| Componentes | CMP-001 | `03-uml/Componentes/diagrama-componentes.mmd` e `.drawio.xml` | Interface de usuário, serviços, repositórios (interfaces do domínio realizadas pela persistência), `ServicoEnvioMensagem` e `AdaptadorEmail` como único ponto de saída de e-mail |
| Implantação | IMP-001 | `03-uml/Implantacao/diagrama-implantacao.mmd` e `.drawio.xml` | Navegador → servidor de aplicação (HTTPS) → MySQL 8.0; servidor de aplicação → Serviço Externo de E-mail (SMTP/TLS) |

**Como ler.** Seta `-->` é dependência de compilação, `..>` é realização de interface e `-.->` é dependência de injeção, montada em tempo de execução. As exigências arquiteturais ARQ-01 a ARQ-08 e as fronteiras transacionais TRS-01 a TRS-07 (`04-persistencia/modelo-relacional.md` §7) explicam por que o envio de e-mail fica fora da transação de negócio: a falha de e-mail não desfaz a operação (DEC-029).

**Decisões que restringem a arquitetura.** DEC-003 (MySQL), DEC-020 (sessão volátil, sem servidor de sessão), DEC-022 (e-mail como interface de fronteira), DEC-029 (falha de e-mail registrada na auditoria) e RNF-016 (sem dependência de fila ou cache externo).

**Relação com a qualidade.** CQ-SEG-01 e CQ-CON-05 atendem; CQ-COM-02 parcial (serviço de e-mail ausente do contexto e do diagrama de casos de uso oficial); CQ-FLE-03 (ausência de ciclo entre pacotes) ainda a conferir (`05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`).

---

## 26. Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional

**Situação:** rascunho v0.7 (30/10/2026), montado pelo Integrante 6 a partir de `04-persistencia/` (Integrante 4, 29/10/2026). O DDL não foi executado em MySQL (Q7-02).

| Artefato | Arquivo | Conteúdo |
|---|---|---|
| DER-001 | `04-persistencia/der/der-001.mmd`, `der-001.drawio.xml`, `der-001-logico.md` | 15 entidades e 22 relações (A01–A17 do modelo oficial, A18–A21 propostas) |
| Modelo relacional | `04-persistencia/modelo-relacional.md` | Chaves, unicidade, domínios, exclusão e inativação, fronteiras transacionais TRS-01 a TRS-07 |
| Dicionário de dados | `04-persistencia/dicionario-de-dados.md` | Colunas, tipos, nulidade, domínios e rastreabilidade RF → coluna |
| Mapeamento objeto-relacional | `04-persistencia/mapeamento-objeto-relacional.md` | Classe → tabela, atributo → coluna, agregados e interfaces de repositório |
| Normalização | `04-persistencia/normalizacao.md` | Formas normais e as três desnormalizações controladas |
| DDL | `04-persistencia/ddl/schema-mysql.sql` | 15 tabelas MySQL 8.0, restrições `CHECK` nomeadas, colunas geradas e triggers |

**Decisões que moldam o esquema.** DEC-018 (o horário ofertado é a autoridade do tempo), DEC-021 (conta opcional para psicólogo e paciente), DEC-024 (situação anterior e nova na auditoria), DEC-027 (tabela de solicitações da lista de espera com seis situações), DEC-029 (falha de e-mail registrada como operação de auditoria), DEC-020 e DEC-022 (nenhuma tabela de sessão ou de notificação). Os RNF-013 a RNF-022, incorporados à baseline em 30/10/2026, dão critério verificável para cada uma.

**Pontos de atenção.** (a) Relações A18–A21 dependem do diagrama de classes oficial (Q7-05). (b) A unicidade condicional usa coluna gerada com `UNIQUE`, porque o MySQL 8.0 não tem índice único parcial. (c) Os campos provisórios estão listados no dicionário (§7).

---

## 27. Princípios OO e SOLID

> **Nota de integração (Integrante 6, 28/10/2026).** Situação desta seção frente às decisões do grupo; prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto afirma que `Agendamento`–`Atendimento` "foi modelada como composição", mas nem o diagrama oficial (OO-03) nem a proposta v2 (retirada) desenhavam composição. Recomendação do Integrante 5: manter associação `1`–`0..1` e, se o grupo quiser evidenciar composição, usar `Agenda` ◆— `Disponibilidade` (Q5-03).
> - No SRP, o ciclo do agendamento é "Confirmado → Realizado / Cancelado / Não compareceu" (DEC-016), sem `SOLICITADO` (Q5-07).

### 27.1 Objetivo

Esta seção evidencia, com exemplos concretos do modelo entregue, como cada princípio Orientado a Objetos e cada princípio SOLID aparece no artefato. Não é uma lista genérica: cada linha aponta classe, operação ou regra que sustenta a afirmação.

### 27.2 Princípios OO

| Princípio | Evidência no modelo |
|---|---|
| **Abstração** | As treze classes representam conceitos do domínio (agenda, vínculo, disponibilidade, agendamento e fila), não detalhes de banco ou interface. `Disponibilidade` representa slots (RF-023/DEC-018); `Vinculo` representa a autorização profissional (RN-003). |
| **Encapsulamento** | Atributos são privados e não há alteração genérica de situação. O ciclo do `Agendamento` é **confirmado → realizado / cancelado / não compareceu**; a credencial é protegida e nunca aparece em texto puro (RN-002, RNF-001). |
| **Coesão** | Cada classe tem uma responsabilidade focada: `Agenda` organiza a oferta de horários; `Agendamento` conduz o ciclo de vida da sessão; `RegistroAuditoria` mantém a trilha; `Perfil`/`Permissao` tratam autorização. Não existe classe que agregasse cadastro, agenda e auditoria. |
| **Baixo acoplamento** | As entidades não dependem umas das outras por referência a implementações: o registro de auditoria é solicitado por um serviço de aplicação, e não por dependência estrutural de todas as classes; a notificação externa é uma interface de fronteira (DIP), não uma chamada direta a um serviço de e-mail. |
| **Herança** | Nenhuma herança representa perfis de acesso: `Administrador` é um papel e os perfis de acesso são instâncias de `Perfil` com permissões distintas. `Psicologo` e `Paciente` são cadastros ligados a `Usuario` por **associação** (A03, A04), não subclasses, porque conta de acesso e cadastro têm responsabilidades diferentes (RF-014, DEC-006). |
| **Polimorfismo** | A interface de fronteira `ServicoEnvioMensagem` está definida para o envio externo (DEC-022). O modelo não especifica implementações concretas nem afirma outro mecanismo polimórfico. |
| **Composição** | Não há composição no modelo. `Agendamento`–`Atendimento` é associação `0..1–1` (A15), sem composição (DEC-030). |

### 27.3 Princípios SOLID

| Princípio | Evidência no modelo |
|---|---|
| **S — Responsabilidade Única (SRP)** | `Agendamento` trata o ciclo **confirmado → realizado / cancelado / não compareceu**; `RegistroAuditoria` mantém a trilha; `Vinculo` representa autorização. O envio de avisos fica na fronteira `ServicoEnvioMensagem`, não em uma entidade. |
| **O — Princípio Aberto/Fechado (OCP)** | Novos papéis de acesso entram como novos `Perfil`/`Permissao`, sem alterar `Usuario` nem as entidades de domínio. Novas áreas de atuação entram no catálogo `AreaAtuacao`. O modelo não foi projetado para "adicionar psicólogo" ou "adicionar paciente" como casos especiais dentro das classes existentes. |
| **L — Princípio de Substituição de Liskov (LSP)** | Não se aplica ao modelo atual, pois não existe herança nem hierarquia de substituição. |
| **I — Princípio de Segregação de Interfaces (ISP)** | O modelo declara somente a interface de fronteira `ServicoEnvioMensagem` para o envio externo (DEC-022). Não há interfaces de domínio adicionais no diagrama para avaliar segregação. |
| **D — Princípio de Inversão de Dependência (DIP)** | O domínio não depende de tecnologia: `Agendamento` não conhece e-mail ou banco; auditoria é acionada por serviço de aplicação; a fronteira de envio usa `ServicoEnvioMensagem`. |

### 27.4 Observações e limites reconhecidos

- **Associações e herança:** A15 é associação simples `Agendamento 1 — 0..1 Atendimento`; não existe composição nem herança no modelo atual.
- **Polimorfismo com escopo honesto:** `ServicoEnvioMensagem` é a interface existente; o modelo não afirma implementações ou mecanismos não descritos.
- **Responsabilidades de aplicação:** as operações de consulta agregada, de sessão e de notificação foram propositalmente mantidas **fora** das entidades, o que é uma decisão de coesão e de baixo acoplamento — e uma resposta direta à penalidade do plano §19 sobre modelagem sem responsabilidades claras.

### 27.5 Arquivos

- `03-uml/Classes/decisoes-modelagem.md` — decisões OO-01 a OO-16 do Integrante 3.
- `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` — seção 9: o que **não** foi proposto e por quê (evidência de disciplina de modelagem).
- `05-qualidade/` — plano de qualidade ISO/IEC 25010 e critérios mensuráveis (seção 28 do dossiê).

---

## 28. Plano de qualidade (ISO/IEC 25010:2023)

**Situação:** versão v0.7 (30/10/2026); fecha na Fase 8 (Integrante 5).

O plano seleciona **sete características** — Segurança, Adequação funcional, Confiabilidade, Manutenibilidade, Flexibilidade, Compatibilidade e Capacidade de interação — e as converte em **31 critérios verificáveis**, cada um com medida, alvo, evidência e situação.

**Medição em 30/10/2026 (Fase 7):** 20 critérios atendem, 3 atendem em parte, 5 não atendem e 3 estão pendentes de decisão ou de medição. Os que não atendem têm causas conhecidas: decisões aprovadas ainda não propagadas ao diagrama de classes oficial e desenho oficial dos casos de uso sem os casos novos. Os requisitos de qualidade que faltavam foram incorporados à baseline (RNF-013 a RNF-024).

Texto completo: `05-qualidade/plano-qualidade-iso25010.md`. Revisão da Fase 7: `05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`.

---

## 29. Normas aplicadas

**Situação:** v0.6; fecha na Fase 8 (Integrante 5).

| Referência | Situação | Influência no projeto |
|---|---|---|
| ISO/IEC 9126-1:2001 | Retirada (histórico) | Origem do modelo de qualidade, substituído pela família SQuaRE |
| ISO/IEC 25010:2023 | Atual | Classificação dos RNF, sete características e 31 critérios do plano |
| ISO/IEC 25019:2023 | Atual | Contexto de uso e resultado esperado por stakeholder |
| ISO/IEC 15504 | Retirada (histórico) | Antecessora da avaliação de processos, substituída pela família 330xx |
| Família ISO/IEC 330xx | Atual | Escala N-P-L-F do registro de processo e da autoavaliação |
| ISO/IEC/IEEE 12207:2026 | Atual | Processos do quadro de autoavaliação |
| ISO/IEC/IEEE 29148:2018 | Atual | Verificação da baseline de requisitos e rastreabilidade |
| ISO/IEC/IEEE 42010:2022 | Atual | Descrição da arquitetura (Fase 7) |
| ISO/IEC 19505-2:2012 / UML 2 | Atual | Notação de todos os diagramas e achados de notação |

Texto completo: `05-qualidade/normas-referencias.md`.

---

## 30. Autoavaliação do processo

**Situação:** registro de evidências e autoavaliação v0.7 (30/10/2026); a avaliação final da Fase 8 depende de revisão por mais um integrante (DOD-Q08).

O quadro `Processo → Objetivo → Atividades → Produto de trabalho → Evidência → Situação → Melhoria proposta` está em `05-qualidade/registro-processo.md`, com onze processos da ISO/IEC/IEEE 12207 avaliados na escala N-P-L-F da família ISO/IEC 330xx.

| Resultado em 30/10/2026 | Processos |
|---|---|
| F (plenamente) | 1 — necessidades dos stakeholders |
| L (largamente) | 9 — planejamento, requisitos, arquitetura e projeto, gestão de configuração, verificação, decisões, mudanças, informação e documentação, lições aprendidas |
| P (parcialmente) | 1 — validação (testes conceituais em 15 de 37 RF; sem ata de walkthrough) |
| N | nenhum |

Lições aprendidas até a Fase 7: consenso por mensagem precisa virar decisão registrada no mesmo dia; propostas paralelas precisam de dono para a escolha; revisão cruzada precisa de revisor nomeado; integração documental contínua evita acúmulo; uma lista de propagação com dono acelera a correção; o atraso de um dono bloqueia os seguintes; papel sem participação precisa de plano de cobertura.

---

## 31. Matriz de rastreabilidade

**Situação:** matriz final v0.7 gerada em 30/10/2026; fecha como v1.0 quando o diagrama de classes oficial incorporar as decisões (P7 a P10).

| Matriz | Conteúdo | Arquivo |
|---|---|---|
| Inicial (Fase 3) | RF → RN/RNF → ator → caso de uso → CA → HU → decisão | `02-requisitos/rastreabilidade-inicial.md` |
| Fase 5 | RF → RN/RNF → UC → classe → operação → sequência → tabela → teste conceitual | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` |
| Fase 6 | RF/RN/UC × SEQ/ATV/COM/EST; mensagens × operações; órfãos | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` |
| **Final (v0.7)** | **Requisito, regra, caso de uso, classe, operação, diagramas, tabela e coluna, critério de aceite, decisão, teste conceitual e qualidade, para os 37 RF** | `06-rastreabilidade/matriz-rastreabilidade-final.md`, gerada por `06-rastreabilidade/montar-matriz.py` |

**Resultado da verificação de órfãos (v0.7):** 37 de 37 RF e 17 de 17 RN rastreados; os RNF que não aparecem em linha de RF são transversais e estão cobertos pelo plano de qualidade. Lacunas: RF-021 sem diagrama comportamental; a lista de espera sem classe no diagrama oficial; 22 testes conceituais ainda a escrever (15 escritos).

As matrizes das Fases 5 e 6 permanecem como apêndices históricos (decisão do Integrante 5, `05-qualidade/analises/fase-06-revisao-cruzada-comportamental.md`).

---

## 32. Verificação de consistência e revisões

Revisões registradas até a Fase 7:

| Revisão | Autor | Arquivo | Identificadores |
|---|---|---|---|
| Casos de uso futuros (Fase 3) | Integrante 2 | `03-uml/Casos de uso/CasosDeUsoFuturo.md` | — |
| Revisão de dados por caso de uso (Fase 4) | Integrante 4 | `04-persistencia/analises/fase-04-*.md` | — |
| Modelo de domínio (Fase 5) | Integrante 2 | `01-planejamento/revisoes/FASE5-REV-I2-*.md` | R5-01 a R5-17 |
| Viabilidade de persistência (Fase 5) | Integrante 4 | `04-persistencia/analises/fase-05-*.md` | INC-01 a INC-13, P-01 a P-19 |
| Diagramas comportamentais (Fase 6) | Integrante 2 | `01-planejamento/revisoes/FASE6-REV-I2-*.md` | R6-01 a R6-13, LAC-01 a LAC-15 |
| Impacto comportamental (Fase 6) | Integrante 4 | `04-persistencia/analises/fase-06-*.md` | DEP, TRS, ARQ, IMP-DER, IMP-CMP |
| Coerência arquitetura × casos de uso (Fase 7) | Integrante 2 | `01-planejamento/revisoes/FASE7-REV-I2-*.md` | R7-01 a R7-12 |
| Testes conceituais (Fase 8) | Integrante 2 | `01-planejamento/revisoes/FASE8-REV-I2-*.md` | CT-0RF |
| Qualidade das Fases 2 a 7 | Integrante 5 | `05-qualidade/analises/` | Q2-01 a Q7-06 |
| Integração das Fases 1 a 6 | Integrante 6 | `07-dossie/integracao/` | INT-01 a INT-12 |

Divergências abertas de maior impacto em 30/10/2026:

1. O diagrama de classes oficial tem multiplicidades `PENDENTE` e não incorpora as decisões DEC-013 a DEC-030 nem as classes da lista de espera (P7 a P10; Q5-01, Q5-05).
2. O desenho oficial dos casos de uso e o diagrama de contexto não mostram o Serviço Externo de E-mail nem os casos novos UC-028 e UC-033 a UC-037 (Q2-01, Q4-05).
3. Os PDFs de PAC-001, CMP-001 e IMP-001 estão pendentes e o DDL não foi executado (Q7-01, Q7-02).
4. As relações A18–A21 do DER dependem do diagrama de classes oficial (Q7-05).

Resolvidas desde 28/10/2026: `SOLICITADO` nos diagramas comportamentais, guarda de prazo, e-mail condicional e a sequência da lista de espera (SEQ-004).

---

## 33. Conclusão

**Situação:** rascunho v0.7 (30/10/2026), a fechar na Fase 9 com os números finais de cobertura, rastreabilidade e qualidade.

A modelagem entrega, para uma plataforma de psicólogos sem código programado, 37 requisitos funcionais com critério de aceite, 24 requisitos não funcionais com critério de verificação, 17 regras de negócio, casos de uso especificados, modelo de domínio, classes e objetos, sete diagramas comportamentais, três diagramas de arquitetura e um modelo de dados com DDL MySQL 8.0, ligados por uma matriz de rastreabilidade sem requisito órfão. A inovação, a lista de espera inteligente, percorre todas as camadas: requisito, caso de uso, sequência, tabela e regras de oferta. As decisões que mais mudaram o desenho foram a confirmação automática do agendamento, a retirada do estado `SOLICITADO` e o tratamento da falha de e-mail como evento auditável.

**Resposta à questão norteadora (§22 do enunciado):** a modelagem orientada a objetos torna o sistema implementável porque cada requisito chega a uma classe, a um comportamento e a uma tabela verificáveis, e porque cada decisão está registrada. O que falta para sustentar essa resposta com números finais: diagrama de classes oficial atualizado, testes conceituais restantes e medição final do plano de qualidade.

---

## 34. Limitações e próximos passos

Limitações conhecidas em 30/10/2026:

- o diagrama de classes oficial ainda não incorpora as decisões DEC-013 a DEC-030 (Integrante 3);
- o DDL não foi executado em MySQL e os PDFs dos diagramas de arquitetura estão pendentes (Integrante 4);
- 22 dos 37 testes conceituais ainda não foram escritos;
- nenhuma ata de walkthrough foi realizada;
- RNF-010 tem critério de inspeção e não meta numérica de tempo, porque o cliente não definiu uma;
- o modelo não cobre prontuário clínico, pagamentos nem teleconsulta, por decisão de escopo (DEC-008).

Próximos passos: `01-planejamento/etapas-e-responsabilidades.md`.

---

## 35. Referências

Referências normativas completas em `05-qualidade/normas-referencias.md` §4 (ISO/IEC 9126-1:2001 — retirada; ISO/IEC 25010:2023; ISO/IEC 25019:2023; ISO/IEC 15504-2:2003 — retirada; família ISO/IEC 330xx; ISO/IEC/IEEE 12207:2026; ISO/IEC/IEEE 29148:2018; ISO/IEC/IEEE 42010:2022; ISO/IEC 19505-2:2012). Documento-base: enunciado e barema da AV3 (Prof. MSc. Celso Barreto, UNIJORGE). Outras referências bibliográficas que o grupo usar devem ser acrescentadas aqui até a Fase 9.

---

## 36. Anexos

| Anexo | Conteúdo | Local |
|---|---|---|
| A | Fontes editáveis e PDFs de todos os diagramas | `03-uml/` (inventário em `03-uml/README.md`) |
| B | Baseline completa de requisitos | `02-requisitos/` |
| C | Registro de decisões e pendências | `01-planejamento/decisoes.md` |
| D | Revisões e análises por fase | `01-planejamento/revisoes/`, `04-persistencia/analises/`, `05-qualidade/analises/`, `07-dossie/integracao/` |
| E | Matrizes de rastreabilidade | `02-requisitos/rastreabilidade-inicial.md`, `06-rastreabilidade/` |
| F | Relatório de função e atuação dos integrantes | modelo e preenchimento parcial em `07-dossie/processo/relatorio-atuacao-individual-modelo.md`; versão final na Fase 9 (ver seção 3) |
| G | Auditoria de editáveis e exportações; convenção de backup; modelo de ata | `07-dossie/processo/` |

---
