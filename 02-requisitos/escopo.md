# Escopo do Sistema

## 1. Escopo geral

O escopo deste projeto compreende a modelagem orientada a objetos de uma plataforma integrada para gestão administrativa e profissional voltada a psicólogos. O sistema visa estruturar as entidades, relações e fluxos operacionais necessários para centralizar cadastros, controlar permissões, gerenciar agendas, registrar conceitualmente atendimentos e assegurar trilhas de auditoria, garantindo segurança e integridade de dados.

## 2. Módulos contemplados

A plataforma é composta pelos seguintes módulos principais:
1. **Identidade e Acesso**
2. **Administração**
3. **Psicólogos**
4. **Clientes/Pacientes**
5. **Agenda**
6. **Atendimento**
7. **Auditoria**
8. **Inovação** — lista de espera inteligente (DEC-010)

## 3. Funcionalidades gerais por módulo

### 3.1 Identidade e Acesso
- Login e autenticação de usuários;
- Gestão de credenciais com armazenamento seguro;
- Gerenciamento de perfis de acesso;
- Atribuição e controle de permissões por perfil;
- Ativação e bloqueio de contas de usuários.

### 3.2 Administração
- Painel administrativo central;
- Gestão de usuários (criação, edição, bloqueio, vinculação de perfis);
- Gestão de psicólogos (cadastro, vinculação de áreas de atuação);
- Gestão de clientes/pacientes (cadastro administrativo, situação);
- Gestão de perfis e matriz de permissões;
- Consulta e monitoramento de logs de auditoria.

### 3.3 Psicólogos
- Gerenciamento do próprio perfil profissional;
- Associação a uma ou mais áreas de atuação;
- Consulta de clientes/pacientes autorizados mediante vínculo;
- Definição e gerenciamento de horários de disponibilidade;
- Consulta e acompanhamento de sua agenda de atendimentos;
- Execução de funções profissionais autorizadas;
- Registro conceitual de sessões de atendimento realizadas;
- Consulta ao histórico permitido de atendimentos.

### 3.4 Clientes/Pacientes
- Cadastro administrativo e acompanhamento de situação cadastral;
- Representação formal do vínculo com o psicólogo responsável;
- Acesso autenticado exclusivo com permissões restritas (autoatendimento);
- Consulta de horários e faixas de disponibilidade do psicólogo vinculado;
- Solicitação de agendamentos;
- Consulta aos próprios agendamentos;
- Cancelamento de agendamentos próprios antes do horário marcado (DEC-011);
- Entrada na lista de espera e resposta a ofertas de vaga (DEC-010).

### 3.5 Agenda
- Configuração de faixas e regras de disponibilidade dos profissionais;
- Criação e manutenção de agendamentos;
- Confirmação automática de agendamentos quando o horário está disponível e sem conflito (DEC-017);
- Cancelamento de agendamentos pelo paciente titular ou pelo psicólogo, antes do horário marcado (DEC-011);
- Controle das situações do agendamento: `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu` (DEC-016; não há situação `SOLICITADO`).

### 3.6 Atendimento
- Registro conceitual de sessões de atendimento;
- Acesso ao histórico permitido da sessão;
- Vínculo obrigatório com o psicólogo responsável;
- Vínculo obrigatório com o cliente/paciente atendido.

### 3.7 Auditoria
- Registro cronológico e imutável de operações relevantes realizadas no sistema;
- Identificação do usuário responsável pela ação;
- Registro de data, hora e identificação da operação realizada;
- Suporte a consultas administrativas para fins de conformidade e segurança.

### 3.8 Inovação
**Lista de espera inteligente** (DEC-010, aprovada em 25/10/2026): quando um agendamento for cancelado, o horário liberado poderá ser oferecido a outro paciente que aguarda na lista de espera do mesmo psicólogo, com aviso por e-mail (DEC-009). Requisitos: RF-034 a RF-036. Ordem da fila, prazo de aceite e tratamento de recusa ou ausência de resposta continuam pendentes (`PG-04` a `PG-09`).

## 4. Fora do escopo

Para manter a viabilidade e controlar a complexidade da modelagem dentro dos limites da AV3, os seguintes itens estão explicitamente **fora do escopo inicial**:
- Módulo de pagamentos e processamento financeiro;
- Faturamento e controle de caixa;
- Gestão e integração com operadoras de planos de saúde / convênios;
- Emissão de notas fiscais e documentos fiscais eletrônicos;
- Módulo de teleconsulta / videoconferência em tempo real;
- Prescrição de medicamentos ou emissão de receitas;
- Prontuário clínico eletrônico aprofundado/completo;
- Cobrança automatizada e régua de cobrança;
- Integrações com gateways financeiros e bancários.

## 5. Fronteiras do sistema

### 5.1 O que faz parte do sistema (Interno)
- Entidades de domínio, serviços de negócio e regras operacionais da plataforma;
- Interfaces e pontos de interação com os atores autenticados (Administrador, Psicólogo e Cliente/Paciente);
- Mecanismo de autenticação, autorização e controle de sessão;
- Camada de persistência relacional para armazenamento de dados da aplicação e auditoria.

### 5.2 O que é externo ao sistema (Fronteiras externas)
- Navegadores e dispositivos de acesso utilizados pelos usuários finais;
- Serviço Externo de E-mail, para confirmações, cancelamentos e ofertas de vaga (DEC-009, RF-033);
- Sistemas de cobrança, bancos ou operadoras (descartados pelo escopo negativo).

## 6. Premissas

- **PRE-001** — Cada usuário possuirá identificação própria.
- **PRE-002** — Psicólogos poderão possuir uma ou mais áreas de atuação.
- **PRE-003** — Clientes/Pacientes poderão possuir acesso autenticado limitado.
- **PRE-004** — O acesso às funcionalidades dependerá de perfil e permissões.
- **PRE-005** — Psicólogos somente acessarão pacientes vinculados.
- **PRE-006** — A persistência futura será modelada utilizando banco de dados relacional.

## 7. Restrições

- **RES-001** — Dados reais de pacientes não poderão ser utilizados.
- **RES-002** — Senhas não poderão ser armazenadas ou disponibilizadas em texto puro.
- **RES-003** — O projeto possui foco em modelagem e não exige implementação completa.
- **RES-004** — Os diagramas deverão utilizar UML 2.x quando aplicável.
- **RES-005** — A persistência será modelada considerando banco de dados relacional.
- **RES-006** — O Cliente/Paciente não poderá acessar informações pertencentes a outros pacientes.

## 8. Pendências de decisão

As pendências de inovação e de serviço externo foram resolvidas em 25/10/2026 (DEC-010 e DEC-009). As pendências abertas estão consolidadas em `PG-02` e `PG-04` a `PG-12`, em [`01-planejamento/decisoes.md`](../01-planejamento/decisoes.md).
