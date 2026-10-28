# Dossiê — Seções 1 a 17 (texto pronto)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Data:** 28/10/2026 · **Versão:** v1.0
**Uso:** texto das seções 1 a 17 do dossiê, que cobrem as Fases 1 a 4 (organização, concepção, requisitos e casos de uso). As tabelas marcadas com `<!-- TABELA:... -->` são geradas automaticamente a partir de `02-requisitos/` pelo script `07-dossie/montar-dossie.py`, para que o dossiê nunca diverja da baseline oficial do Integrante 1.
**Fontes:** `02-requisitos/`, `01-planejamento/decisoes.md`, `03-uml/Contexto/`, `03-uml/Casos de uso/`.

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

## 2. Resumo

Este dossiê modela uma plataforma que unifica cadastros, permissões, agenda e registro conceitual de atendimentos de uma organização de psicólogos de diferentes áreas, hoje dispersos em planilhas e ferramentas sem integração. O produto não é um sistema programado: é um conjunto integrado de requisitos, modelos UML, modelo relacional, decisões, critérios de qualidade e evidências de processo, suficiente para que outra equipe compreenda e implemente a solução.

A plataforma atende três atores humanos — Administrador, Psicólogo e Cliente/Paciente — e um ator externo, o Serviço Externo de E-mail. Os requisitos (37 funcionais, 12 não funcionais e 17 regras de negócio) são rastreados até casos de uso, classes, diagramas comportamentais e, na Fase 7, tabelas. A funcionalidade de inovação é a **lista de espera inteligente**: quando um agendamento é cancelado, o horário liberado pode ser oferecido a outro paciente que aguarda, com aviso por e-mail.

A qualidade é tratada pela ISO/IEC 25010:2023 (sete características com critérios mensuráveis), a engenharia de requisitos pela ISO/IEC/IEEE 29148:2018 e o processo pela ISO/IEC/IEEE 12207:2026 e pela família ISO/IEC 330xx. Normas retiradas (ISO/IEC 9126 e ISO/IEC 15504) aparecem apenas como referência histórica.

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

## 4. Contexto e situação-problema

Nos processos de clínicas e consultórios de Psicologia, os cadastros de profissionais e pacientes estão distribuídos em ferramentas manuais, planilhas ou sistemas desconectados. O gerenciamento de permissões não é centralizado, as agendas não operam de forma integrada e as informações operacionais permanecem fragmentadas. Isso dificulta controlar quem pode visualizar e manipular cada dado e compromete o sigilo e a eficiência.

Problemas identificados (`02-requisitos/visao.md` §2):

- ausência de integração entre dados cadastrais, horários e histórico;
- dificuldade no controle de permissões;
- falta de representação formal dos relacionamentos entre usuários, perfis, psicólogos, pacientes, horários e atendimentos;
- risco de vazamento de dados sensíveis por falta de barreiras granulares;
- carência de especificação técnica para orientar a implementação.

**Questão do problema (enunciado):** como modelar uma plataforma flexível e segura para profissionais de Psicologia, garantindo que todos os diagramas, requisitos, regras, dados e critérios de qualidade descrevam o mesmo produto?

## 5. Objetivos

**Objetivo geral:** modelar uma plataforma integrada, flexível e segura para a gestão administrativa e profissional de psicólogos, representando usuários, permissões, profissionais, clientes/pacientes, agenda, atendimentos e auditoria de forma consistente e rastreável.

**Objetivos específicos:** centralizar cadastros; controlar o acesso por perfis e permissões granulares; associar psicólogos a uma ou mais áreas de atuação; representar os vínculos autorizados entre psicólogos e pacientes; gerenciar disponibilidade e o ciclo do agendamento; permitir autoatendimento limitado do paciente; representar conceitualmente atendimentos e históricos; prover auditoria; e produzir os artefatos de modelagem, persistência e qualidade que orientam a implementação.

## 6. Escopo, fronteiras e escopo negativo

**Módulos:** Identidade e Acesso · Administração · Psicólogos · Clientes/Pacientes · Agenda · Atendimento · Auditoria · **Inovação — lista de espera inteligente** (DEC-010).

**Agenda (decisões de 25/10/2026):** confirmação automática quando o horário está disponível e sem conflito (DEC-017); cancelamento pelo paciente titular ou pelo psicólogo antes do horário marcado (DEC-011); situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu` (DEC-016) — `SOLICITADO` **não** é situação persistente; `Não compareceu` registrado pelo Psicólogo após o horário marcado (DEC-025).

**Inovação:** o horário liberado por cancelamento pode ser oferecido a paciente da lista de espera do mesmo psicólogo, com aviso por e-mail (DEC-009). A oferta só vira agendamento se o paciente aceitar e o horário continuar disponível (RN-021). Ordem da fila, prazo de aceite, recusa ou ausência de resposta e abrangência da entrada **continuam pendentes** (PG-04 a PG-09).

**Fronteira:** interno — entidades, serviços, regras, interfaces com os atores autenticados, autenticação/autorização e persistência relacional; externo — navegadores e dispositivos dos usuários e o Serviço Externo de E-mail.

**Fora do escopo (DEC-008):** pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição de medicamentos, prontuário clínico aprofundado, cobrança e integrações financeiras. O ator **Atendente** foi excluído (DEC-007).

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

## 8. Stakeholders e atores

**Stakeholders:** organização responsável pela plataforma; administradores; psicólogos; clientes/pacientes; equipe de engenharia da futura implementação; equipe de suporte e manutenção.

| Ator | Tipo | Responsabilidades | Limitações |
|---|---|---|---|
| Administrador | Humano, primário | Usuários, perfis, permissões, cadastros de psicólogos e pacientes, vínculos, auditoria | Não vê senhas em texto puro; toda operação é autorizada e auditada |
| Psicólogo | Humano, primário | Perfil profissional, áreas de atuação, disponibilidade, agenda, cancelamento na própria agenda, registro de atendimento e de `Não compareceu` | Acessa apenas pacientes vinculados; sem funções administrativas |
| Cliente/Paciente | Humano, primário | Login, consulta de horários, solicitação, consulta e cancelamento dos próprios agendamentos, lista de espera e resposta a ofertas | Sem acesso a dados de terceiros, auditoria ou registros profissionais restritos (DEC-006) |
| Serviço Externo de E-mail | Sistema externo, de suporte | Recebe solicitações de envio para confirmação, cancelamento e oferta de vaga (DEC-009, RF-033) | Não recebe senhas nem informações clínicas (RN-022) |

Não são atores: banco de dados, módulos internos, tabelas, classes e componentes de infraestrutura.

## 9. Glossário

<!-- TABELA:GLOSSARIO -->

Fonte: `02-requisitos/glossario.md`.

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

## 12. Requisitos funcionais

Cada requisito tem descrição, ator, prioridade, pré e pós-condições, dependências e observações em `02-requisitos/requisitos-funcionais.md`. Resumo:

<!-- TABELA:RF -->

## 13. Requisitos não funcionais

Os critérios de verificação completos estão em `02-requisitos/requisitos-nao-funcionais.md`; a correspondência com as características da ISO/IEC 25010:2023 está na seção 28.

<!-- TABELA:RNF -->

## 14. Regras de negócio

`RN-015` a `RN-019` estão reservados às propostas técnicas do Integrante 4 ainda não incorporadas; por isso a numeração salta de RN-014 para RN-020.

<!-- TABELA:RN -->

## 15. Histórias de usuário e critérios de aceite

Os 37 requisitos funcionais têm critério de aceite no formato *Dado / Quando / Então* (`CA-RF-001` a `CA-RF-037`, em `02-requisitos/criterios-aceite.md`). As histórias de usuário estão em `02-requisitos/historias-usuario.md`:

<!-- TABELA:HU -->

Lacuna registrada: RF-021 não tem história própria (Q3-01).

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
