# Dossiê de Modelagem Orientada a Objetos — Plataforma para Psicólogos

**Versão:** v0.6 · **Data de montagem:** 28/10/2026 · **Situação:** dossiê em construção — seções 1 a 24 e 27 com conteúdo das Fases 1 a 6; seções 25, 26 e 28 a 36 com estrutura e texto disponível.
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

**Inovação:** o horário liberado por cancelamento pode ser oferecido a paciente da lista de espera do mesmo psicólogo, com aviso por e-mail (DEC-009). A oferta só vira agendamento se o paciente aceitar e o horário continuar disponível (RN-021). Ordem da fila, prazo de aceite, recusa ou ausência de resposta e abrangência da entrada **continuam pendentes** (PG-04 a PG-09).

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

O registro oficial está em `01-planejamento/decisoes.md`. Situação em 25/10/2026:

| Situação | Decisões |
|---|---|
| Aprovadas | DEC-001 a DEC-010, DEC-011 (redação revisada), DEC-016, DEC-017, DEC-025 (redação revisada) |
| Propostas aguardando o grupo | DEC-012 (prazo de 2 horas **não aprovado**), DEC-013, DEC-014, DEC-015, DEC-018 a DEC-024, DEC-026 |
| Pendências abertas | PG-02 e PG-04 a PG-12 |

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

**Não aprovado:** antecedência mínima de duas horas para cancelar; cancelamento pelo Administrador (PG-10); registro automático de `Não compareceu`; parâmetros da fila (PG-04 a PG-09).

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

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto cita **RF-001 a RF-032**; desde 25/10/2026 a baseline vai até **RF-037** (RF-033 e-mail, RF-034 a RF-036 lista de espera, RF-037 não comparecimento).
> - A linha "Notificação e sessão fora do domínio" trata **DEC-009 como pendente**; ela foi aprovada em 25/10/2026.
> - As multiplicidades "fechadas na Fase 5" eram da proposta CLS-001 v2 (retirada do repositório em 28/10/2026); o diagrama oficial do Integrante 3 ainda tem `PENDENTE` (Q5-01, INT-09).
> - A lista de espera (DEC-010) ainda não tem conceito no domínio (Q5-05).

### 18.1 Objetivo

O modelo de domínio representa os conceitos essenciais da plataforma para psicólogos, suas associações e as restrições sustentadas pelos requisitos (RF-001 a RF-032), pelas regras de negócio (RN-001 a RN-014) e pelas decisões do grupo (DEC-001 a DEC-010). É um modelo **conceitual de domínio**: define o que existe, como se relaciona e sob que regras, sem fixar tecnologia de persistência, interface ou arquitetura. Sua função no dossiê é dar uma base comum e rastreável para os diagramas de classes, objetos, sequência, estados e para o modelo relacional.

### 18.2 Elementos principais

O modelo reconheceu **doze conceitos**:

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
| 10 | `Agendamento` | Compromisso entre profissional e paciente, com situação | RF-025 a RF-030 |
| 11 | `Atendimento` | Registro conceitual da sessão realizada | RF-030, RF-031 |
| 12 | `RegistroAuditoria` | Trilha cronológica das operações relevantes | RF-013, RF-032 |

O modelo separa deliberadamente **identidade** (`Usuario`) de **autorização** (`Perfil` → `Permissao`) e de **cadastro** (`Psicologo`, `Paciente`): uma conta de acesso não é o cadastro profissional nem o cadastro do paciente. O `Atendente` foi excluído do escopo (DEC-007) e, por isso, não existe como ator nem classe.

### 18.3 Como interpretar

O diagrama do domínio (`03-uml/Dominio/diagrama-dominio.mmd`) apresenta as associações com identificadores `A01` a `A16`. Cada associação corresponde a uma relação do modelo de classes:

| ID | Associação | Leitura |
|---|---|---|
| A01 | `Usuario` — `Perfil` | Todo usuário tem um papel de acesso; o papel pode ser compartilhado por várias contas. |
| A02 | `Perfil` — `Permissao` | Um perfil agrupa permissões; a mesma permissão pode servir a vários perfis. |
| A03 | `Usuario` — `Psicologo` | A conta de acesso do profissional é distinta do cadastro profissional. |
| A04 | `Usuario` — `Paciente` | A conta de acesso do paciente é distinta do cadastro do paciente. |
| A05 | `Psicologo` — `AreaAtuacao` | O profissional atua em uma ou mais áreas catalogadas. |
| A06 / A07 | `Psicologo` / `Paciente` — `Vinculo` | O vínculo identifica **um** profissional e **um** paciente, e é a base do acesso autorizado. |
| A08 | `Psicologo` — `Agenda` | Cada profissional tem agenda própria (RN-011). |
| A09 | `Agenda` — `Disponibilidade` | Os períodos ofertados pertencem à agenda do titular. |
| A10 | `Agenda` — `Agendamento` | Os compromissos são apresentados na agenda do titular. |
| A11 / A12 | `Psicologo` / `Paciente` — `Agendamento` | Cada agendamento tem exatamente um profissional e um paciente. |
| A13 / A14 | `Psicologo` / `Paciente` — `Atendimento` | Cada atendimento tem um profissional responsável e um paciente. |
| A15 | `Agendamento` — `Atendimento` | A sessão realizada corresponde a, no máximo, um registro conceitual de atendimento. |
| A16 | `Usuario` — `RegistroAuditoria` | O registro de auditoria identifica o responsável pela operação. |

As **multiplicidades** dessas associações foram fechadas na Fase 5 (proposta do Integrante 2, aprovação do grupo pendente) e estão detalhadas na seção 19. Em todos os casos valem três invariantes: (i) um agendamento sempre pertence a uma agenda e a um vínculo válido; (ii) um agendamento cancelado não pode gerar atendimento (RN-006); (iii) toda operação administrativa relevante gera registro de auditoria com responsável, data, hora e operação (RN-009, RN-014).

### 18.4 Decisões de modelagem

| Decisão | Efeito no modelo | Base |
|---|---|---|
| Identidade separada de autorização | `Usuario`, `Perfil` e `Permissao` são três conceitos distintos, com duas associações 1:N | plano §5.2, DEC-002 (autorização por perfil e permissão) |
| Cadastros sem herança de `Usuario` | `Psicologo` e `Paciente` **não** herdam de `Usuario`; a relação é por associação | OO-01, plano §5.2 (evitar herança por permissão) |
| Vínculo como conceito de primeira classe | O acesso do profissional ao paciente depende do vínculo, não do cadastro | RN-003, RN-007, RF-017 |
| Disponibilidade como conceito da agenda | O profissional libera períodos na **própria** agenda | RN-011, RF-023 |
| Agendamento com situação | O compromisso tem estado explícito, o que sustenta a exclusividade de horário (RN-005) e a proibição de atender cancelado (RN-006) | RN-005, RN-006, RN-010 |
| Atendimento conceitual | O atendimento é um registro de ocorrência, sem conteúdo clínico | DEC-008, RF-030 |
| Auditoria como registro imutável | A trilha admite apenas acréscimos (append-only) e é identificada por responsável, data, hora e operação | RN-009, RN-014, RF-032 |
| Notificação e sessão fora do domínio | Notificação por e-mail (DEC-009) e sessão (RF-002) são responsabilidades de aplicação/fronteira, não entidades de domínio | DEC-009 (pendente), OO-16 |

### 18.5 Relação com requisitos, classes e banco

Cada um dos 32 requisitos funcionais tem ao menos um conceito do modelo associado, e cada conceito tem requisito associado — não há elemento órfão. O detalhamento completo (RF → RN/RNF → caso de uso → classe → operação → sequência → tabela → teste conceitual) está na **seção 31 (Matriz de rastreabilidade)**, em `06-rastreabilidade/matriz-rastreabilidade-fase5.md`. As tabelas correspondentes (`usuario`, `vinculo`, `agendamento`, entre outras) e as chaves estrangeiras são detalhadas na seção 26.

### 18.6 Arquivos

- Fonte editável do diagrama (Mermaid): `03-uml/Dominio/diagrama-dominio.mmd`
- Fonte editável no diagrams.net: `03-uml/Dominio/diagrama-dominio.drawio.xml`
- Versão para publicação no dossiê: `03-uml/Dominio/diagrama-dominio.pdf`
- Especificação do modelo: `03-uml/Dominio/modelo-dominio.md`
- Revisão da Fase 5: `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md`

---

## 19. Diagrama de classes

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - Na proposta CLS-001 v2 (retirada em 28/10/2026) e no oficial, conforme o caso, o enumerado `SituacaoAgendamento` ainda contém `SOLICITADO`; pela **DEC-016** os valores são apenas `CONFIRMADO`, `CANCELADO`, `REALIZADO` e `NAO_COMPARECEU` (Q5-02).
> - A guarda de `podeSerCancelado()` ("situação atual + prazo") deve ser lida como **"antes do horário marcado"** (DEC-011); o prazo de 2 horas não foi aprovado (PG-02).
> - Atributos e tipos ainda incompletos nas duas versões do diagrama (Q5-08).

### 19.1 Identificação e objetivo

**CLS-001 — Diagrama de classes do domínio da Plataforma para Psicólogos.**
O diagrama detalha as doze classes do modelo de domínio com seus atributos, operações, visibilidades, tipos e multiplicidades, de modo a tornar o modelo executável em termos de comportamento: é ele que mostra **quem** responde por cada regra de negócio e **quem** participa de cada fluxo de caso de uso.

### 19.2 Elementos principais

- **Classes com estado:** `Usuario` (situação da conta), `Paciente` (situação cadastral), `Vinculo` (situação e temporalidade) e `Agendamento` (situação do compromisso) — cada uma com um conjunto de valores nomeados, alinhado ao dicionário de dados do banco.
- **Classes de comportamento:** `Agendamento` (ciclo de vida da sessão), `Vinculo` (autorização), `Agenda`/`Disponibilidade` (oferta de horários), `RegistroAuditoria` (trilha), `Perfil`/`Permissao` (autorização).
- **Multiplicidades fechadas** nas dezesseis associações A01–A16, mais a associação condicional entre `Disponibilidade` e `Agendamento` (reserva de slot), incluída apenas se o grupo aprovar o modelo de horário discreto.
- **Visibilidade:** atributos privados (`-`) e operações públicas (`+`), sem exposição direta de estado interno.
- **Assinaturas completas** nas operações que manejam situação e autorização, com o ator solicitante explicitado (ex.: `cancelar(solicitante: Usuario, motivo: Texto)`), para que a autorização por papel/permissão seja auditável na própria operação.

### 19.3 Como interpretar

Cada operação corresponde a um passo verificável de um caso de uso:

| Família de operações | Passos de caso de uso que executa |
|---|---|
| `Usuario.podeAutenticar`, `confereCredencial` | UC-001 — validação de conta ativa (RN-001) e de credencial protegida (RN-002) |
| `Usuario.cadastrar`, `ativar`, `bloquear`, `atualizarDadosPermitidos`, `associarPerfil` | Gerenciar usuários e permissões (RF-003 a RF-008) |
| `Psicologo.cadastrar`, `atualizarDadosProfissionais`, `associarAreaAtuacao` | Gerenciar perfil profissional (RF-014 a RF-016) |
| `Paciente.cadastrar`, `atualizarCadastro`, `alterarSituacao`, `consultarCadastroPermitido` | Gerenciar pacientes e consultar meu cadastro (RF-018 a RF-022) |
| `Vinculo.formalizar`, `encerrar`, `estaAtivo` | UC-021 — vincular e encerrar vínculo (RF-021, RN-003) |
| `Agenda.cadastrarDisponibilidade`, `consultarHorariosDisponiveis`, `consultarCompromissos` | Gerenciar agenda e consultar horários (RF-023, RF-024, RF-029) |
| `Agendamento.solicitar`, `confirmar`, `cancelar`, `podeSerCancelado`, `concluir`, `registrarFalta`, `consultarMeus` | UC-025 e UC-027 — solicitar, confirmar, cancelar e listar (RF-025 a RF-028) |
| `Atendimento.registrar` (referenciando o `Agendamento`) | Atender pacientes vinculados (RF-030, RN-006, RN-007) |
| `RegistroAuditoria.registrar`, `consultar` | Registrar e consultar auditoria (RF-013, RF-032) |

A leitura de uma operação deve responder sempre a três perguntas: **qual regra implementa** (RN), **qual requisito satisfaz** (RF) e **quem pode invocá-la** (ator solicitante + permissão). Operação sem regra correspondente não foi incluída — ver a seção de revisões do dossiê, em que as sugestões descartadas estão registradas com justificativa.

### 19.4 Decisões de modelagem

- **Sem classes onipotentes:** nenhuma classe concentra operações de domínios distintos; responsabilidades de aplicação (sessão, notificação externa, consultas agregadas de painel) ficam em serviços, e não em entidades.
- **Herança apenas quando há relação "é um" real:** nenhuma herança foi usada para representar perfis de acesso; `Administrador`, `Psicólogo` e `Paciente` são papéis de `Perfil`, não subclasses de `Usuario`.
- **Encapsulamento da situação:** a situação de `Agendamento` só muda por operações de transição controladas (`confirmar`, `cancelar`, `concluir`, `registrarFalta`); não existe operação genérica de alteração de estado.
- **Guardas explícitas:** `podeSerCancelado()` materializa a condição de cancelamento (situação atual + prazo + autorização), usada tanto pelo caso de uso quanto pela regra RN-012.
- **Auditoria por colaboração, não por dependência estrutural:** `RegistroAuditoria` não é dependência de todas as classes; o registro é disparado pelo serviço de aplicação responsável pela operação (RN-009), o que evita acoplamento estrutural indevido.

### 19.5 Relação com requisitos, classes e banco

O diagrama é a origem do mapeamento classe ↔ tabela: cada uma das doze classes corresponde a uma tabela, e as duas tabelas associativas (`perfil_permissao` e `psicologo_area_atuacao`) resolvem os N:N. As colunas de situação (`usuario.status`, `paciente.situacao_cadastral`, `vinculo.situacao`, `agendamento.status`) recebem exatamente os mesmos valores nomeados do diagrama — o que atende à exigência de que **os mesmos estados apareçam no domínio, nos casos de uso e no banco**.

### 19.6 Arquivos

- Fonte editável vigente (Mermaid): `03-uml/Classes/diagrama-classes.mmd` (Integrante 3)
- Fonte editável no diagrams.net: `03-uml/Classes/diagrama-classes.drawio.xml`
- Versão para publicação no dossiê: `03-uml/Classes/diagrama-classes.pdf`
- Especificação de classes: `03-uml/Classes/especificacao-classes.md`
- Decisões de modelagem OO: `03-uml/Classes/decisoes-modelagem.md`

---

## 20. Diagrama de objetos

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O objeto de notificação é descrito "enquanto DEC-009 não for decidida"; DEC-009 foi aprovada em 25/10/2026, e a notificação continua sendo objeto de aplicação, não classe de domínio (proposta DEC-022).

### 20.1 Identificação e objetivo

**OBJ-001 / OBJ-002 — Fotografias do modelo em uso.**
O diagrama de objetos materializa o diagrama de classes: mostra instâncias identificadas, seus valores de atributo e as ligações entre elas, em uma fotografia parcial e coerente com um cenário real. É a evidência de que o modelo funciona com dados concretos e é a referência para o teste conceitual e para o mapeamento com o banco.

### 20.2 Elementos principais

- **OBJ-001 (cadastro):** conta de acesso do profissional e do paciente, os cadastros correspondentes, o vínculo entre eles, a agenda do profissional e um período de disponibilidade liberado.
- **OBJ-002 (ciclo de agendamento):** o mesmo par profissional–paciente com o vínculo `ATIVO`, a agenda, o período ofertado, **dois agendamentos** (um `REALIZADO` e um `CANCELADO`), o `Atendimento` do primeiro, os **registros de auditoria** das duas operações e o objeto de aplicação que representa a notificação enviada.

### 20.3 Como interpretar

Cada caixa é uma **instância** (não uma classe nova) e a notação `nomeInstancia : Classe` explicita isso. As ligações reproduzem as associações A01–A16 com instâncias concretas. Três ausências são significativas e estão anotadas no diagrama:

1. o agendamento `CANCELADO` **não** possui `Atendimento` — é a verificação visual de RN-006;
2. o agendamento `REALIZADO` possui **um único** `Atendimento` — verificação de A15 e de RF-030;
3. o `Vinculo` aparece com `situacao = ATIVO` e `dataInicio`, base da temporalidade que impede acesso a paciente após o encerramento do vínculo.

Todos os valores são **fictícios** (`CONTA-FICTICIA-C01`, `FAIXA-FICTICIA 2026-11-03 14h00 a 15h00`), conforme DEC-005: nenhum nome, documento, e-mail, registro profissional ou conteúdo clínico real aparece nos artefatos.

### 20.4 Decisões de modelagem

- O diagrama **não** declara multiplicidades: a fotografia exemplifica, a cardinalidade é do diagrama de classes.
- O objeto de notificação é marcado como **objeto de aplicação**, não como classe de domínio, enquanto DEC-009 não for decidida.
- As situações mostradas são as mesmas do diagrama de classes e do dicionário de dados; se o grupo alterar os nomes, os três artefatos mudam juntos (revisão cruzada, plano §13).

### 20.5 Relação com requisitos, classes e banco

Cada objeto corresponde a uma linha (ou a um conjunto de linhas) do modelo relacional: `contaPacienteCenario` ↔ `usuario`, `vinculoCenario` ↔ `vinculo`, `agendamentoRealizadoCenario` ↔ `agendamento` com `status = 'REALIZADO'`, e assim por diante. O OBJ-002 é, na prática, o **teste conceitual** do ciclo de agendamento (CT-025 a CT-030 da matriz de rastreabilidade).

### 20.6 Arquivos

- Fontes editáveis (Mermaid): `03-uml/Objetos/diagrama-objetos.mmd` (OBJ-001). O cenário OBJ-002 foi retirado em 28/10/2026 junto com a proposta de classes v2 (decisão do Integrante 1); a descrição dele acima permanece como texto até o Integrante 3 decidir se o incorpora ao OBJ-001
- Fontes editáveis no diagrams.net: `03-uml/Objetos/diagrama-objetos.drawio.xml`
- Versões para publicação no dossiê: `03-uml/Objetos/diagrama-objetos.pdf`
- Especificações: `03-uml/Objetos/especificacao-objetos.md`

---

## 21. Diagramas de sequência

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - A SEQ-002 mostra o agendamento criado como `SOLICITADO` e depois confirmado; pela **DEC-016** o agendamento já nasce `Confirmado` (Q6-01).
> - As referências a **DEC-009 (pendente)** e **DEC-012 (pendente)** estão superadas: DEC-009 foi aprovada; o cancelamento vale "antes do horário marcado" (DEC-011), e só a antecedência adicional continua pendente (PG-02).
> - A sequência da lista de espera (SEQ-004) ainda não existe; com a DEC-010 aprovada, ela deixou de estar bloqueada (Q6-05).

### 21.1 Identificação e objetivo

O plano da AV3 pede "pelo menos três diagramas de sequência para os casos de uso críticos aprovados, garantindo que mensagens, retornos, alternativas e exceções sejam coerentes com os fluxos textuais" (§6.1, Integrante 2). A Fase 6 entregou **três** diagramas de sequência, um para cada caso de uso crítico com comportamento observável:

| ID | Título | Caso de uso | Requisitos |
|---|---|---|---|
| **SEQ-001** | Autenticar usuário | UC-001 | RF-001, RF-002 |
| **SEQ-002** | Agendar atendimento | UC-025 (+ UC-024) | RF-024, RF-025, RF-026, RF-032 |
| **SEQ-003** | Cancelar / confirmar / concluir agendamento | UC-027 | RF-026, RF-027, RF-028, RF-030, RF-032 |

O objetivo comum é mostrar **quem fala com quem, em que ordem e sob qual condição**, de modo que cada passo do texto do caso de uso possa ser lido como uma mensagem entre participantes identificados.

### 21.2 SEQ-001 — Autenticar usuário (UC-001)

**Participantes (7):** Ator (paciente, psicólogo ou administrador) · `ServicoAutenticacao` (AP-01) · `RepositorioUsuario` (IR-01) · `Usuario` · `RepositorioAutorizacao` (IR-02) · `ServicoAuditoria` (AP-02) · `RegistroAuditoria`.

**Fluxo:** `autenticar(email, senha)` → `obterPorIdentificacao(identificacao)` → `podeAutenticar()` (OP-01, RN-001) → `confereCredencial(senha)` (OP-02, RN-002) → `obterPermissoes(idUsuario)` → `criarSessao(usuario)` → `registrar("LOGIN_CONCEDIDO" | "LOGIN_NEGADO", …)`.

**Alternativas e exceções:** `alt` **E1 — credencial inválida** (recusa + auditoria `LOGIN_NEGADO`); `alt` **E2 — conta bloqueada ou inativa** (recusa por RN-001 + auditoria); `opt` **A1 — encerrar sessão** (`invalidarSessaoAtiva`, AP-01).

### 21.3 SEQ-002 — Agendar atendimento (UC-025 + UC-024)

**Participantes (8):** Ator (paciente) · `ServicoAgenda` (AP-03) · `Vinculo` · `Agenda` · `Agendamento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoNotificacao` (AP-04).

**Fluxo:** consulta de horários (`consultarHorariosDisponiveis`, OP-11) → validação do vínculo (`estaAtivo`, OP-22) → escolha do horário → `verificarDisponibilidade(horario)` (RN-010) → `Agendamento.solicitar(...)` → `confirmar(solicitante)` (OP-13, RN-013) → auditoria → notificação → resposta ao ator.

**Alternativas e exceções:** `alt` **A1 — nenhum horário disponível** (informar e encerrar); `alt` **E1 — conflito de horário** (recusa com sugestão de outro horário).

### 21.4 SEQ-003 — Cancelar / confirmar / concluir / registrar falta (UC-027)

**Participantes (7):** Ator (paciente ou psicólogo) · `ServicoAgenda` (AP-03) · `Agendamento` · `Atendimento` · `ServicoAuditoria` (AP-02) · `RegistroAuditoria` · `ServicoNotificacao` (AP-04).

**Fluxo do cancelamento:** `consultarMeus(solicitante)` (OP-19, RF-028) → `cancelar(agendamento, motivo)` → `podeSerCancelado()` (OP-15, RN-012) → `cancelar(solicitante, motivo)` (OP-14) → auditoria (`AGENDAMENTO_CANCELADO`) → `notificar(cancelamento)` → resposta ao ator.

**Blocos `opt` alternativos (não são etapas obrigatórias em sequência):** confirmação (`RF-026`), conclusão da sessão realizada (`RF-030`, com `estaCancelada()` — OP-16/RN-006 —, `concluir` — OP-17 — e `Atendimento.registrar` — OP-20) e registro de falta (`plano §5.4` / INC-13, com `registrarFalta` — OP-18).

**Alternativa:** `alt` **E1 — agendamento já realizado ou já cancelado** (recusa).

### 21.5 Como interpretar

1. **A linha de vida é a unidade de responsabilidade.** `ServicoAgenda`, `ServicoAuditoria`, `ServicoAutenticacao` e `ServicoNotificacao` são **responsabilidades de aplicação** (AP-01 a AP-04): concentram a orquestração e ficam **fora** do diagrama de classes de domínio, conforme o plano §5.2. As entidades (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `RegistroAuditoria`) carregam as regras.
2. **Toda mensagem remete a uma operação ou responsabilidade conhecida.** As **82 setas** dos três diagramas (49 solicitações e 33 retornos; 35 mensagens de solicitação distintas) foram conferidas uma a uma contra as operações `OP-01…OP-22` da Fase 5, as responsabilidades `AP-01…AP-05` e as interfaces de infraestrutura `IR-01`/`IR-02`. Não existe mensagem "inventada para satisfazer um diagrama futuro" (plano §8).
3. **A seta tracejada é o retorno** (`-->>`) e não conta como mensagem nova na contagem.
4. **`alt` é alternativa de fluxo, `opt` é bloco condicional**, e ambos refletem o texto do caso de uso — nenhuma alternativa existe só no diagrama.
5. **As guardas aparecem entre colchetes** na própria mensagem (`[OP-15 / RN-012]`), de modo que a regra fica legível sem consultar a matriz.
6. **Repositórios são infraestrutura**, não domínio: aparecem como `RepositorioUsuario` e `RepositorioAutorizacao`, e apenas carregam dados.

### 21.6 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| A entidade decide, o repositório carrega | `podeAutenticar()` (OP-01) e `confereCredencial()` (OP-02) estão na entidade `Usuario`, não no repositório | plano §5.2, RN-001/RN-002 (achado **R6-03** da revisão da Fase 6) |
| Confirmação automática como operação do serviço | `confirmar(solicitante)` é executado por `ServicoAgenda`, não pelo ator | RN-013 ("ator **ou mecanismo** autorizado"), P-01 |
| Notificação é fronteira externa, condicional | `ServicoNotificacao` é interface; a mensagem está marcada como dependente de decisão do grupo | DEC-009 (pendente), TRS-02 do Integrante 4 |
| Auditoria como efeito transversal | `registrar(...)` é sempre delegado a `ServicoAuditoria` e nunca executado "de dentro" da entidade | RN-009, RN-014 |
| Sessão fora do domínio | `criarSessao` / `invalidarSessaoAtiva` são responsabilidade de aplicação | RF-002, P-07 |
| Cancelamento exige verificação prévia | `podeSerCancelado()` (OP-15) é consultada antes de `cancelar` (OP-14) | RN-012, DEC-012 (pendente) |
| "Não compareceu" só a partir de confirmado | o bloco `opt` de falta existe apenas para agendamento `CONFIRMADO` | INC-13 do Integrante 4, plano §5.4 |

### 21.7 Relação com requisitos, classes e banco

Cada mensagem dos três diagramas corresponde a uma **operação do modelo de classes** (`Usuario`, `Vinculo`, `Agenda`, `Agendamento`, `Atendimento`, `RegistroAuditoria`), a uma responsabilidade de aplicação ou a uma interface de infraestrutura — a matriz completa está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` (§2.1 a §2.3) e §3. No banco, os mesmos passos correspondem às tabelas `usuario`, `vinculo`, `agendamento`, `atendimento` e `registro_auditoria` (seção 26 do dossiê); a notificação **não** tem tabela, por ser serviço externo (DEC-009).

### 21.8 Arquivos

| Artefato | Arquivo |
|---|---|
| SEQ-001 (fonte, editável e PDF) | `03-uml/Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-002 | `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` · `.drawio.xml` · `.pdf` |
| SEQ-003 | `03-uml/Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` · `.drawio.xml` · `.pdf` |
| Especificação dos três | `03-uml/Sequências/proposta-I2-especificacao-sequencias.md` |
| Revisão da fase | `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` |

---

## 22. Diagrama de comunicação

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - A notificação aparece como fronteira **condicional**; desde a DEC-009 ela é obrigatória para confirmação, cancelamento e oferta de vaga (Q6-04).

### 22.1 Identificação e objetivo

**COM-001 — Diagrama de comunicação: ciclo do agendamento.**
O diagrama de comunicação representa **a mesma informação** do diagrama de sequência, mas com o foco invertido: em vez de mostrar a ordem no tempo, mostra **quais objetos colaboram** e **qual objeto coordena a colaboração**. Ele atende ao item do plano §6.1 ("diagrama de comunicação para um cenário relevante") e cumpre a função de **checagem cruzada**: o cenário é o mesmo do SEQ-002, do SEQ-003 e do ATV-001, de modo que qualquer objeto ou mensagem que apareça em um e não em outro fica evidente.

**Cenário:** "Agendar e concluir atendimento" (UC-024 + UC-025 + UC-027).

### 22.2 Elementos principais

**Doze colaboradores**, com natureza indicada pela forma:

| Collaborador | Natureza | Papel no cenário |
|---|---|---|
| `Paciente` | fronteira externa | solicita e cancela |
| `Psicólogo` | fronteira externa | conclui o atendimento |
| `Usuario` | entidade de domínio | sobre o qual recai a autorização por operação (OP-04) |
| `ServicoAgenda` | **serviço de aplicação (hub)** | coordena o cenário (AP-03) |
| `Vinculo` | entidade de domínio | autorização do vínculo (OP-22) |
| `Agenda` | entidade de domínio | catálogo de horários (OP-11) |
| `Disponibilidade` | entidade de domínio | slots ofertados (A09) |
| `Agendamento` | entidade de domínio | compromisso e seu ciclo (OP-13, OP-14) |
| `Atendimento` | entidade de domínio | registro da sessão (OP-20) |
| `ServicoAuditoria` | serviço de aplicação | trilha (AP-02) |
| `RegistroAuditoria` | entidade de domínio | registro imutável (RF-032) |
| `ServicoNotificacao` | fronteira externa | envio de mensagem (AP-04) |

### 22.3 Como interpretar

As **14 mensagens** estão numeradas na ordem de ocorrência, e cada seta carrega a identificação da operação e a regra/requisimento que a origina:

| # | Mensagem | Origem |
|---|---|---|
| 1 | `solicitar(horario)` | RF-025 |
| 2 | `consultarPermitidos(solicitante)` | OP-04 |
| 3 | `estaAtivo()` | OP-22 / RN-003 |
| 4 | `consultarHorarios(paciente, periodo)` | OP-11 |
| 5 | `slots livres` | A09 |
| 6 | `verificarDisponibilidade(horario)` | RN-005 |
| 7 | `solicitar(psicologo, paciente, horario)` | RF-025 |
| 8 | `confirmar(solicitante)` | OP-13 / RN-013 |
| 9 | `registrar(AGENDAMENTO_CONFIRMADO)` | AP-02 |
| 10 | `registrar(responsavel, data, hora, operacao)` | RF-032 |
| 11 | `notificar(confirmacao)` | AP-04 (DEC-009) |
| 12 | `cancelar(solicitante, motivo)` | OP-14 |
| 13 | `concluir(agendamento)` | RF-030 |
| 14 | `registrar(agendamento, contextoSessao)` | OP-20 |

**O `ServicoAgenda` é o hub** do diagrama: todas as mensagens que disparam regra passam por ele, e é ele que aciona auditoria e notificação. Isso é proposital — é a materialização da regra do plano §5.2 contra a **classe onipotente**: o poder de decisão fica dividido entre `ServicoAgenda` (orquestração), as entidades (regras) e `ServicoAuditoria`/`ServicoNotificacao` (efeitos).

### 22.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Um único diagrama de comunicação | o plano pede "um cenário relevante"; o cenário do agendamento é o de maior densidade de objetos | plano §6.1 |
| `ServicoAgenda` como hub | concentração da coordenação sem concentration de regra | plano §5.2 (AP-03) |
| Retornos não geram seta | o grafo tem 14 arestas, não 14 diálogo com resposta | notação de diagrama de comunicação |
| Notificação como fronteira externa | `ServicoNotificacao` é interface, não entidade | DEC-009 (pendente), TRS-02 |
| Autorização por operação (OP-04) separada das permissões da sessão | `consultarPermitidos` ≠ `obterPermissoes` | achado **R6-04** da revisão da Fase 6 |

### 22.5 Relação com requisitos, classes e banco

Os doze colaboradores são **onze classes do modelo de domínio** (`Usuario`, `Vinculo`, `Agenda`, `Disponibilidade`, `Agendamento`, `Atendimento`, `RegistroAuditoria` e demais) e **responsabilidades de aplicação/fronteira** (`ServicoAgenda`, `ServicoAuditoria`, `ServicoNotificacao`) — nenhuma classe nova foi criada. As mensagens 1 a 14 correspondem, uma a uma, aos passos do SEQ-002, do SEQ-003 e às atividades do ATV-001; a correspondência está em `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.4.

### 22.6 Arquivos

| Artefato | Arquivo |
|---|---|
| COM-001 (fonte, editável e PDF) | `03-uml/Comunicação/proposta-I2-comunicacao-com-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Comunicação/proposta-I2-especificacao-comunicacao.md` |

---

## 23. Diagrama de atividades

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O diagrama de atividades não inclui a oferta da lista de espera após o cancelamento (DEC-010, RF-035) (Q6-05).
> - A guarda do cancelamento deve ser "antes do horário marcado" (DEC-011) e o registro de falta ocorre "após o horário marcado", pelo Psicólogo (DEC-025).

### 23.1 Identificação e objetivo

**ATV-001 — Diagrama de atividades: ciclo do agendamento.**
O plano §6.1 pede "o diagrama de atividades com decisões, responsabilidades e paralelismo quando aplicável". O ATV-001 representa o **fluxo de negócio** do agendamento — do pedido do horário até a conclusão, o cancelamento ou a falta — destacando **quem** executa cada passo (**responsabilidade**) e **onde** a regra decide (**decisões**).

### 23.2 Elementos principais

- **Quatro pistas (swimlanes):** *Paciente* · *Sistema (aplicação e domínio)* · *Psicólogo* · *Auditoria e notificação*. A separação entre "Sistema" e "Auditoria e notificação" existe porque auditoria e notificação **não são regra de negócio**: são efeitos transversais (AP-02 e AP-04).
- **Quatro decisões:** `d1` (Há horários?), `d2` (Vínculo OK?), `d3` (Cancelamento?), `d5` (Sessão realizada?).
- **Três blocos paralelos (fork/join):**

| Bloco | Gatilho | Ramos paralelos | Join |
|---|---|---|---|
| `fork1`/`join1` | Confirmar (OP-13) | auditar confirmação ‖ notificar confirmação | `join1` |
| `fork2`/`join2` | Cancelar (OP-14) | liberar horário ‖ auditar cancelamento | `join2` |
| `fork3`/`join3` | Registrar atendimento (OP-20) | concluir (OP-17) ‖ auditar conclusão | `join3` |

- **Uma etapa sequencial de notificação** entre o `join2` e o fim do bloco de cancelamento: `Notificar cancelamento (AP-04)` — ela só pode ocorrer depois que o cancelamento está gravado e auditado (pós-commit, TRS-02) e antes da resposta ao ator, exatamente como no SEQ-003 (achado **R6-05**, corrigido na Fase 6).

### 23.3 Como interpretar

1. **A pista mostra a responsabilidade, não o objeto.** Uma atividade pode ser executada por uma entidade de domínio (`Confirmar (OP-13)`) ou por um serviço de aplicação (`Auditar confirmação`).
2. **O losango é uma decisão da regra**, e o texto no losango é curto por limitação de espaço; a condição completa está na especificação do diagrama e no caso de uso.
3. **A barra de paralelismo indica independência de regra**, não transação única: o paralelismo é lógico. A fronteira transacional é responsabilidade da camada de persistência (Fase 7) e é explicitamente o que o TRS-02 do Integrante 4 restringe.
4. **Cada rota tem um `Fim`** — a notação de atividade exige fim explícito em cada rota terminal (sem horários, recusa, cancelamento, sessão realizada e falta).
5. **O cancelamento e a sessão realizada são alternativas**, não etapas em sequência: `d3` separa "o paciente cancela" de "o paciente mantém".

### 23.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Quatro pistas, e não duas | separa a regra de negócio dos efeitos transversais | plano §5.2 |
| "Liberar horário" aparece só no cancelamento | é consequência da regra (RN-012/RN-010) sobre o catálogo de disponibilidade, não uma mensagem a um serviço de aplicação | RN-010, RN-012 |
| Notificação do cancelamento sequencial | mantém a ordem *auditar → notificar → responder* do SEQ-003 | TRS-02, achado **R6-05** |
| Sem lista de espera e sem sessão como atividade | ambos fora do domínio | plano §5.2, P-07 |
| Decisões `d1`, `d2`, `d3`, `d5` | uma decisão por desvio de rota do caso de uso | UC-024, UC-025, UC-027 |

### 23.5 Relação com requisitos, classes e banco

Cada atividade do ATV-001 corresponde a uma operação de domínio, a uma responsabilidade de aplicação ou a um efeito de regra (matriz `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2.5). Nenhuma atividade existe sem origem: as **26 atividades em pista** (das quais 4 são decisões) e os 5 nós `Fim` estão todos ancorados. As atividades de consulta de horário e de registro de atendimento correspondem, no banco, a leituras e escritas em `disponibilidade`, `agendamento` e `atendimento` (seção 26).

### 23.6 Arquivos

| Artefato | Arquivo |
|---|---|
| ATV-001 (fonte, editável e PDF) | `03-uml/Atividade/proposta-I2-atividade-atv-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Atividade/proposta-I2-especificacao-atividade.md` |

---

## 24. Máquina de estados

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - **Divergência com decisão aprovada:** a máquina de estados versionada tem `SOLICITADO` como estado inicial e as transições T2 e T3. Pela **DEC-016** (25/10/2026), `SOLICITADO` não é situação persistente: a transição inicial vai direto para `CONFIRMADO` quando o horário está disponível e sem conflito, e T2/T3 deixam de existir (Q6-01).
> - A transição `CONFIRMADO → NAO_COMPARECEU` passa a ter guarda **"após o horário marcado"** e ator **Psicólogo** (DEC-025) (Q6-03).
> - Se `Cancelado`, `Realizado` e `Não compareceu` são finais sem reversão continua **não decidido** pelo grupo (DEC-016, "Ainda não decidido").

### 24.1 Identificação e objetivo

**EST-001 — Máquina de estados do `Agendamento`.**
O plano §5.4 fixa o ciclo de vida do compromisso — "Solicitado → Confirmado → Realizado; saídas para Cancelado e Não compareceu" — e o §6.1 pede a máquina de estados correspondente. A máquina registra **quais situações o agendamento pode ter, por qual evento sai de cada uma e o que é permitido a partir delas**.

### 24.2 Elementos principais

**Cinco situações**, exatamente os valores do enumerado `SituacaoAgendamento` do modelo de classes (Fase 5) e da coluna `agendamento.status` do banco:

| Situação | Significado |
|---|---|
| `SOLICITADO` | compromisso criado, aguardando confirmação (situação inicial) |
| `CONFIRMADO` | compromisso confirmado |
| `REALIZADO` | sessão realizada — **terminal** |
| `CANCELADO` | compromisso cancelado — **terminal** |
| `NAO_COMPARECEU` | falta registrada — **terminal** |

**Seis transições:**

| # | Transição | Evento | Guarda | Operação |
|---|---|---|---|---|
| T1 | `[*] → SOLICITADO` | `solicitar` | vínculo ATIVO e slot livre | `Agendamento.solicitar` (RF-025) |
| T2 | `SOLICITADO → CONFIRMADO` | `confirmar` | `[slot livre]` | OP-13 (RN-013) |
| T3 | `SOLICITADO → CANCELADO` | `cancelar` | `[prazo]` | OP-14 / OP-15 (RN-012) |
| T4 | `CONFIRMADO → CANCELADO` | `cancelar` | `[prazo]` | OP-14 / OP-15 (RN-012) |
| T5 | `CONFIRMADO → REALIZADO` | `concluir` | `[atendimento]` | OP-17 / OP-20 (RF-030) |
| T6 | `CONFIRMADO → NAO_COMPARECEU` | `registrarFalta` | — | OP-18 (plano §5.4) |

### 24.3 Como interpretar

1. **`SOLICITADO` é o estado inicial** e `REALIZADO`, `CANCELADO` e `NAO_COMPARECEU` são **terminais**: não há retorno de um compromisso encerrado.
2. **O evento é a causa; a guarda é a condição.** `cancelar` só se aplica a `SOLICITADO` ou `CONFIRMADO` e dentro do prazo (`[prazo]`, valor pendente de DEC-012/P-02); `concluir` pressupõe que existe atendimento.
3. **A ausência de transição é uma informação**: não existe `SOLICITADO → NAO_COMPARECEU`. Um agendamento que o paciente não compareceu só pode ter sido confirmado antes — é a INC-13 do Integrante 4, respondida por desenho.
4. **O cancelamento é possível em dois pontos** porque o paciente pode desistir antes da confirmação ou depois dela.
5. **A máquina é compatível com a confirmação automática**: se o grupo decidir (P-01) que a confirmação é assíncrona, `SOLICITADO` fica ocupado por um instante e T1/T2 apenas se separam no tempo — nenhum redesenho é necessário.

### 24.4 Decisões de modelagem

| Decisão | Efeito | Base |
|---|---|---|
| Cinco situações, três terminais | o compromisso encerrado não volta | plano §5.4 |
| `NAO_COMPARECEU` só a partir de `CONFIRMADO` | fecha a INC-13 do Integrante 4 e a pergunta P-14 | INC-13, plano §5.4 |
| `SOLICITADO` como situação inicial explícita | o diagrama de objetos e o banco precisam de um valor inicial | PC-07 (Fase 5) |
| Guardas `[prazo]` e `[slot livre]` no desenho | as condições dependem de decisões ainda abertas e ficam visíveis como pendência | RN-012, RN-010, DEC-012, P-05 |
| Sem situação "aguardando aprovação" | não há aprovação manual no escopo aprovado | RN-013 |

### 24.5 Relação com requisitos, classes e banco

As cinco situações são os valores do enumerado `SituacaoAgendamento` (modelo de classes, seção 19) e correspondem à coluna `agendamento.status` do modelo relacional (seção 26, com a restrição de domínio correspondente). Cada transição tem operação de origem (Tabela §2.6 da matriz da Fase 6) e caso de uso associado (UC-025 ou UC-027). Nenhuma situação existe sem atributo persistível e nenhuma transição existe sem operação.

### 24.6 Arquivos

| Artefato | Arquivo |
|---|---|
| EST-001 (fonte, editável e PDF) | `03-uml/Estados/proposta-I2-estados-est-001.mmd` · `.drawio.xml` · `.pdf` |
| Especificação | `03-uml/Estados/proposta-I2-especificacao-estados.md` |

---

## 25. Arquitetura: pacotes, componentes e implantação

**Situação:** a produzir na Fase 7 (03/11 a 09/11) pelo Integrante 4, seguindo a ISO/IEC/IEEE 42010:2022.

Insumos já disponíveis:

- exigências arquiteturais `ARQ-01` a `ARQ-08` e impactos nos componentes `IMP-CMP-01` a `IMP-CMP-09` (`04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md` §4.2 e §6.2);
- serviços de aplicação e fronteiras propostos na Fase 5 (`AP-01` a `AP-05`, entre eles o serviço de agenda e a interface de notificação) e interfaces de infraestrutura `IR-xx` citadas na matriz da Fase 6;
- integração externa aprovada: Serviço Externo de E-mail (DEC-009), que deve aparecer no diagrama de componentes e no de implantação (`PLANEJAMENTO_AV3` §6 regra 7);
- critérios de qualidade aplicáveis: CQ-COM-01, CQ-COM-02 e CQ-FLE-03 (`05-qualidade/plano-qualidade-iso25010.md`).

Estrutura prevista para cada diagrama (mesma das seções 18 a 24): identificação e objetivo, elementos principais, como interpretar, decisões, relação com requisitos/classes/banco, arquivos.

---

## 26. Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional

**Situação:** a produzir na Fase 7 pelo Integrante 4.

Insumos já disponíveis: revisão de dados por caso de uso (Fase 4), viabilidade de persistência do domínio com `INC-01` a `INC-13` e `P-01` a `P-19` (Fase 5), impactos no DER `IMP-DER-01` a `IMP-DER-10` e exigências transacionais `TRS-01` a `TRS-06` (Fase 6), todos em `04-persistencia/analises/`.

Condições para fechar sem divergência (achados de integração e de qualidade):

- usar a numeração oficial de requisitos de `02-requisitos/` (Q3-11);
- a coluna de situação do agendamento aceita apenas `CONFIRMADO`, `CANCELADO`, `REALIZADO` e `NAO_COMPARECEU` (DEC-016; sem `SOLICITADO`);
- a lista de espera, se persistida, precisa de classe correspondente (Q5-05);
- FKs e cardinalidades derivadas de um único diagrama de classes oficial (Q5-01).

---

## 27. Princípios OO e SOLID

> **Nota de integração (Integrante 6, 28/10/2026).** O texto abaixo foi preparado antes das decisões de 25/10/2026 e é mantido como entregue pelo autor. Prevalecem `01-planejamento/decisoes.md` e a baseline de `02-requisitos/`:
> - O texto afirma que `Agendamento`–`Atendimento` "foi modelada como composição", mas nem o diagrama oficial (OO-03) nem a proposta v2 (retirada) desenhavam composição. Recomendação do Integrante 5: manter associação `1`–`0..1` e, se o grupo quiser evidenciar composição, usar `Agenda` ◆— `Disponibilidade` (Q5-03).
> - No SRP, o ciclo do agendamento é "Confirmado → Realizado / Cancelado / Não compareceu" (DEC-016), sem `SOLICITADO` (Q5-07).

### 27.1 Objetivo

Esta seção evidencia, com exemplos concretos do modelo entregue, como cada princípio Orientado a Objetos e cada princípio SOLID aparece no artefato. Não é uma lista genérica: cada linha aponta classe, operação ou regra que sustenta a afirmação.

### 27.2 Princípios OO

| Princípio | Evidência no modelo |
|---|---|
| **Abstração** | As doze classes representam conceitos do domínio (agenda, vínculo, disponibilidade, agendamento), não detalhes de implementação de banco ou de interface. `Disponibilidade` existe porque o profissional **libera períodos** (RF-023); `Vinculo` existe porque o acesso profissional é **autorizado** (RN-003), e não por conveniência de armazenamento. |
| **Encapsulamento** | Atributos são privados e as situações mudam apenas por operações controladas: `Agendamento` não expõe alteração genérica de situação, só `confirmar`, `cancelar`, `concluir` e `registrarFalta`, cada uma com guarda própria. A credencial aparece apenas como `credencialProtegida`, nunca em texto puro (RN-002, RNF-001). |
| **Coesão** | Cada classe tem uma responsabilidade focada: `Agenda` organiza a oferta de horários; `Agendamento` conduz o ciclo de vida da sessão; `RegistroAuditoria` mantém a trilha; `Perfil`/`Permissao` tratam autorização. Não existe classe que agregasse cadastro, agenda e auditoria. |
| **Baixo acoplamento** | As entidades não dependem umas das outras por referência a implementações: o registro de auditoria é solicitado por um serviço de aplicação, e não por dependência estrutural de todas as classes; a notificação externa é uma interface de fronteira (DIP), não uma chamada direta a um serviço de e-mail. |
| **Herança** | Usada apenas para relação "é um" real. Nenhuma herança representa perfis de acesso: `Administrador`, `Psicólogo` e `Paciente` são instâncias de `Perfil` com permissões distintas. `Psicologo` e `Paciente` são **associações** a `Usuario`, não subclasses, porque conta de acesso e cadastro têm responsabilidades diferentes (RF-014, DEC-006). |
| **Polimorfismo** | A interface de notificação externa (`ServicoEnvioMensagem`) admite implementações distintas — serviço de e-mail, registro interno — sem alterar o domínio. Onde a variação ainda não existe no escopo, o modelo **não** a antecipa: não há polimorfismo artificial. |
| **Composição** | `Atendimento` corresponde a uma sessão agendada (A15, `1` Agendamento para `0..1` Atendimento): o registro conceitual tem ciclo de vida dependente do agendamento, e um agendamento cancelado nunca o possui (RN-006). |

### 27.3 Princípios SOLID

| Princípio | Evidência no modelo |
|---|---|
| **S — Responsabilidade Única (SRP)** | `Agendamento` controla o ciclo de vida do compromisso (solicitado → confirmado → realizado/cancelado); `RegistroAuditoria` apenas registra; `Vinculo` apenas autoriza o acesso. O envio de avisos não é responsabilidade de entidade: cabe ao serviço de notificação, o que evita a classe onipotente vedada pelo plano §5.2. |
| **O — Princípio Aberto/Fechado (OCP)** | Novos papéis de acesso entram como novos `Perfil`/`Permissao`, sem alterar `Usuario` nem as entidades de domínio. Novas áreas de atuação entram no catálogo `AreaAtuacao`. O modelo não foi projetado para "adicionar psicólogo" ou "adicionar paciente" como casos especiais dentro das classes existentes. |
| **L — Princípio de Substituição de Liskov (LSP)** | As operações que recebem o mesmo parâmetro respeitam o mesmo contrato: toda operação de estado de `Agendamento` recebe o ator solicitante e só altera a situação quando a guarda é satisfeita; qualquer implementação futura de notificação ou persistência deve obedecer ao contrato da interface correspondente. |
| **I — Princípio de Segregação de Interfaces (ISP)** | As permissões são granulares (`Permissao` por operação) e o perfil agrega apenas as que o ator efetivamente possui; a restrição de ampliar permissões além do que o administrador tem é exatamente a materialização desse princípio (RN-002, RNF-002). |
| **D — Princípio de Inversão de Dependência (DIP)** | O domínio não depende de tecnologia: o `Agendamento` não conhece e-mail, banco ou interface; a auditoria é acionada por serviço; o serviço de notificação depende de uma interface de fronteira (`ServicoEnvioMensagem`). O modelo persiste por mapeamento objeto-relacional, sem regra de negócio dentro de gatilhos de banco. |

### 27.4 Observações e limites reconhecidos

- **Composição e herança são ponto de partida, não dogma:** a associação `Agendamento`–`Atendimento` foi modelada como composição pelo ciclo de vida dependente; não se estendeu herança artificial para representar papéis de usuário.
- **Polimorfismo com escopo honesto:** onde não há variação real no escopo atual (notificação, persistência), o modelo declara **interfaces** e deixa a implementação para a arquitetura (seção 25), em vez de criar abstrações sem uso.
- **Responsabilidades de aplicação:** as operações de consulta agregada, de sessão e de notificação foram propositalmente mantidas **fora** das entidades, o que é uma decisão de coesão e de baixo acoplamento — e uma resposta direta à penalidade do plano §19 sobre modelagem sem responsabilidades claras.

### 27.5 Arquivos

- `03-uml/Classes/decisoes-modelagem.md` — decisões OO-01 a OO-16 do Integrante 3.
- `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` — seção 9: o que **não** foi proposto e por quê (evidência de disciplina de modelagem).
- `05-qualidade/` — plano de qualidade ISO/IEC 25010 e critérios mensuráveis (seção 28 do dossiê).

---

## 28. Plano de qualidade (ISO/IEC 25010:2023)

**Situação:** versão preliminar v0.6; fecha na Fase 8 (Integrante 5).

O plano seleciona **sete características** — Segurança, Adequação funcional, Confiabilidade, Manutenibilidade, Flexibilidade, Compatibilidade e Capacidade de interação — e as converte em **31 critérios verificáveis** sobre o modelo (inspeção de artefato ou contagem no repositório). Medição em 28/10/2026: 18 critérios atendidos, 2 parciais, 6 não atendidos e 5 pendentes de decisão ou de artefato da Fase 7.

Os critérios não atendidos têm três causas: decisões de 25/10/2026 ainda não propagadas aos diagramas, casos de uso faltando para os requisitos novos (inclusive a inovação) e ausência de requisito de prevenção de erro do usuário.

Texto completo: `05-qualidade/plano-qualidade-iso25010.md`.

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

**Situação:** registro de evidências v0.6; autoavaliação final na Fase 8 (Integrante 5), revisada por mais um integrante.

O quadro `Processo → Objetivo → Atividades → Produto de trabalho → Evidência → Situação → Melhoria proposta` está em `05-qualidade/registro-processo.md`, com onze processos da ISO/IEC/IEEE 12207 e situação na escala N-P-L-F. Até a Fase 6: definição de necessidades **F**; planejamento, requisitos, modelagem, configuração, verificação e decisões **L**; gestão de mudanças, validação, documentação e lições aprendidas **P**.

Lições aprendidas até a Fase 6: consenso por mensagem precisa virar decisão registrada no mesmo dia; propostas paralelas precisam de dono para a escolha; revisão cruzada precisa de revisor nomeado; integração documental deve ser contínua.

---

## 31. Matriz de rastreabilidade

**Situação:** matrizes por fase disponíveis; matriz final na Fase 8.

| Matriz | Conteúdo | Arquivo |
|---|---|---|
| Inicial (Fase 3) | RF → RN/RNF → ator → caso de uso → CA → HU → decisão | `02-requisitos/rastreabilidade-inicial.md` |
| Fase 5 (mestra até aqui) | RF → RN/RNF → UC → classe → operação → sequência → tabela → teste conceitual | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` |
| Fase 6 (complementar) | RF/RN/UC × SEQ/ATV/COM/EST; mensagens × operações; verificação de órfãos | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` |
| Final (Fase 8) | Requisito, caso de uso, classe, interação, persistência, qualidade e teste conceitual, sem órfãos | `06-rastreabilidade/matriz-rastreabilidade-final.md` (a produzir) |

Decisão do Integrante 5 sobre o formato: as matrizes das Fases 5 e 6 continuam como estão até a Fase 7 e depois viram apêndices históricos da matriz final (`05-qualidade/analises/fase-06-revisao-cruzada-comportamental.md` §5). RF-033 a RF-037 ainda não estão nas matrizes das Fases 5 e 6.

---

## 32. Verificação de consistência e revisões

Revisões registradas até a Fase 6:

| Revisão | Autor | Arquivo | Identificadores |
|---|---|---|---|
| Casos de uso futuros (Fase 3) | Integrante 2 | `03-uml/Casos de uso/CasosDeUsoFuturo.md` | — |
| Revisão de dados por caso de uso (Fase 4) | Integrante 4 | `04-persistencia/analises/fase-04-*.md` | — |
| Modelo de domínio (Fase 5) | Integrante 2 | `01-planejamento/revisoes/FASE5-REV-I2-*.md` | R5-01 a R5-17 |
| Viabilidade de persistência (Fase 5) | Integrante 4 | `04-persistencia/analises/fase-05-*.md` | INC-01 a INC-13, P-01 a P-19 |
| Diagramas comportamentais (Fase 6) | Integrante 2 | `01-planejamento/revisoes/FASE6-REV-I2-*.md` | R6-01 a R6-08, LAC-01 a LAC-09 |
| Impacto comportamental (Fase 6) | Integrante 4 | `04-persistencia/analises/fase-06-*.md` | DEP, TRS, ARQ, IMP-DER, IMP-CMP |
| Qualidade das Fases 2 a 6 (revisão cruzada) | Integrante 5 | `05-qualidade/analises/` | Q2-01 a Q6-07 |
| Integração das Fases 1 a 6 | Integrante 6 | `07-dossie/integracao/` | INT-01 a INT-12 |

Divergências abertas de maior impacto (precisam ser fechadas antes da Fase 7):

1. `SOLICITADO` ainda aparece na máquina de estados, na sequência SEQ-002, na proposta de classes v2 e nas seções 19, 21 e 24, contra DEC-016 (Q5-02, Q6-01).
2. A lista de espera (DEC-010) não tem caso de uso, classe nem diagrama comportamental (Q4-03, Q5-05, Q6-05).
3. O diagrama de classes oficial tem multiplicidades `PENDENTE`; a proposta com multiplicidades não foi adotada (Q5-01).
4. Contexto, casos de uso e textos das Fases 5 e 6 ainda tratam DEC-009 como pendente (Q2-01, Q4-05, Q5-06, Q6-04).

---

## 33. Conclusão

**Situação:** a redigir na Fase 9 (Integrante 6 com todos), depois do congelamento da versão. Deve responder à questão norteadora do enunciado (§22) com base nos números finais de cobertura, rastreabilidade e qualidade.

---

## 34. Limitações e próximos passos

Limitações conhecidas até a Fase 6 (a revisar na Fase 9):

- parâmetros da lista de espera não decididos (PG-04 a PG-09);
- efeito de falha no envio de e-mail não decidido (PG-11);
- relação entre registro de atendimento e situação `Realizado` em proposta (PG-12, DEC-023);
- antecedência mínima de cancelamento além de "antes do horário" não decidida (PG-02);
- RNF-010 sem métrica de desempenho;
- o modelo não cobre prontuário clínico, pagamentos nem teleconsulta, por decisão de escopo (DEC-008).

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
| F | Relatório de função e atuação dos integrantes | a incluir na Fase 9 (ver seção 3) |

---
