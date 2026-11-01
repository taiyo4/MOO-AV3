# Requisitos Não Funcionais

Os critérios abaixo descrevem qualidades e restrições da solução modelada. Quando a Fase 2 não oferece métrica numérica, ela não é inventada; o valor fica para definição na etapa de qualidade.

## 1. Segurança

### RNF-001 — Proteção de credenciais

**Categoria:** Segurança

**Descrição:** Senhas não devem ser armazenadas nem disponibilizadas em texto puro.

**Critério de verificação:** O modelo deverá representar armazenamento seguro de credenciais e não deverá conter atributo conceitual de senha em texto puro.

### RNF-002 — Autorização por perfil e permissão

**Categoria:** Segurança

**Descrição:** O acesso às funcionalidades deverá respeitar os perfis e as permissões atribuídos ao usuário.

**Critério de verificação:** Para cada RF com acesso restrito, a rastreabilidade deverá indicar ator autorizado e a revisão do Integrante 2 deverá confirmar que os casos de uso preservam essa restrição.

### RNF-003 — Bloqueio de acesso de conta

**Categoria:** Segurança

**Descrição:** Usuários bloqueados não deverão conseguir autenticar-se.

**Critério de verificação:** O fluxo de autenticação modelado deverá negar acesso a uma conta bloqueada.

### RNF-004 — Auditoria de operações relevantes

**Categoria:** Segurança

**Descrição:** Operações administrativas relevantes deverão ser auditáveis, com usuário responsável, data, hora e operação identificáveis.

**Critério de verificação:** O requisito e o modelo futuro de auditoria deverão prever os quatro elementos de identificação e manter os registros rastreáveis.

### RNF-005 — Isolamento dos dados de pacientes

**Categoria:** Segurança

**Descrição:** O sistema deverá impedir que um Cliente/Paciente acesse informações pertencentes a outros pacientes.

**Critério de verificação:** Casos de uso e critérios de aceite deverão limitar cada consulta ao identificador do próprio Cliente/Paciente.

### RNF-006 — Acesso profissional por vínculo

**Categoria:** Segurança

**Descrição:** O Psicólogo deverá acessar somente clientes/pacientes com vínculo autorizado.

**Critério de verificação:** A autorização das consultas profissionais deverá exigir vínculo entre o Psicólogo autenticado e o Cliente/Paciente consultado.

## 2. Confiabilidade

### RNF-007 — Integridade entre elementos relacionados

**Categoria:** Confiabilidade

**Descrição:** A solução modelada deverá preservar a integridade das relações entre usuários, perfis, psicólogos, clientes/pacientes, vínculos, agenda, agendamentos, atendimentos e auditoria.

**Critério de verificação:** Os modelos de domínio e persistência futuros deverão explicitar as associações e restrições necessárias para impedir referências inválidas.

## 3. Manutenibilidade

### RNF-008 — Coesão e baixo acoplamento

**Categoria:** Manutenibilidade

**Descrição:** A solução deverá favorecer alta coesão entre responsabilidades relacionadas e baixo acoplamento entre módulos.

**Critério de verificação:** Na revisão dos modelos, cada responsabilidade deverá estar atribuída a elemento do domínio coerente e dependências entre módulos deverão estar justificadas.

## 4. Flexibilidade

### RNF-009 — Evolução modular

**Categoria:** Flexibilidade

**Descrição:** A organização dos módulos deverá permitir evolução futura sem exigir reestruturação completa da solução modelada.

**Critério de verificação:** A revisão arquitetural futura deverá identificar módulos e suas dependências, explicando como mudanças localizadas podem ser acomodadas.

## 5. Desempenho

### RNF-010 — Consulta interativa de agenda

**Categoria:** Desempenho

**Descrição:** Consultas de agenda deverão possuir tempo de resposta compatível com uso interativo normal.

**Critério de verificação:** inspeção no nível de modelagem, sem número de milissegundos inventado (a Fase 2 não definiu métrica de tempo ou carga): toda consulta de agenda acessa no máximo a agenda de um psicólogo e é atendida por índice sobre psicólogo e data na persistência (RNF-018). Uma meta numérica só entra se o grupo ou o cliente a definir.

## 6. Rastreabilidade e Qualidade da Modelagem

### RNF-011 — Rastreabilidade entre artefatos

**Categoria:** Rastreabilidade e Qualidade da Modelagem

**Descrição:** Os artefatos deverão manter rastreabilidade entre requisitos, regras de negócio, atores, casos de uso futuros e critérios de aceite.

**Critério de verificação:** Cada RF deverá constar na matriz inicial com ator, regra relacionada quando aplicável, caso de uso futuro e critério de aceite.

### RNF-012 — Consistência terminológica e semântica

**Categoria:** Rastreabilidade e Qualidade da Modelagem

**Descrição:** Os requisitos e modelos deverão manter termos consistentes com o glossário e respeitar as decisões e fronteiras de escopo aprovadas.

**Critério de verificação:** A revisão cruzada deverá verificar nomenclatura, atores, escopo negativo, privacidade e ausência de contradição entre artefatos.

## 7. Requisitos incorporados em 30/10/2026 (persistência, integração e interação)

Os requisitos RNF-013 a RNF-022 foram propostos pelo Integrante 4 (`04-persistencia/impacto-requisitos.md` §4.2) e já sustentam o DDL da Fase 7; RNF-023 e RNF-024 respondem aos achados Q3-07 e Q3-08 do Integrante 5. O achado Q3-09 (concorrência) é atendido pelo RNF-016. Foram incorporados à baseline pelo Integrante 1 em 30/10/2026 e podem ser revistos pelo grupo.

### RNF-013 — Integridade referencial com exclusão controlada

**Categoria:** Confiabilidade

**Descrição:** Nenhuma chave estrangeira deverá usar exclusão em cascata sobre dados históricos; a retirada de um registro deverá ocorrer por mudança de situação.

**Critério de verificação:** Inspeção do DDL e tentativa de exclusão, que deverá falhar.

### RNF-014 — Domínios fechados no banco

**Categoria:** Confiabilidade

**Descrição:** As situações e os enumerados deverão ter domínio fechado verificado no banco de dados.

**Critério de verificação:** Inserção com valor fora do domínio deverá ser recusada.

### RNF-015 — Atomicidade entre alteração de situação e auditoria

**Categoria:** Confiabilidade

**Descrição:** A alteração de situação e o seu registro de auditoria deverão ocorrer na mesma transação.

**Critério de verificação:** Teste com falha injetada na auditoria: a alteração não deverá persistir.

### RNF-016 — Unicidade do horário ativo

**Categoria:** Confiabilidade

**Descrição:** No máximo um agendamento `Confirmado` deverá ocupar cada horário ofertado (RN-005), inclusive sob acesso concorrente; a confirmação automática deverá revalidar a disponibilidade no momento da gravação (RN-013).

**Critério de verificação:** Inserção concorrente do mesmo horário deverá violar a restrição.

### RNF-017 — Imutabilidade da trilha de auditoria

**Categoria:** Segurança

**Descrição:** A conta da aplicação não deverá poder alterar nem excluir registros de auditoria.

**Critério de verificação:** Teste de permissão no SGBD.

### RNF-018 — Consulta de agenda sem varredura completa

**Categoria:** Desempenho

**Descrição:** Os índices deverão cobrir as consultas de RF-024, RF-028 e RF-029.

**Critério de verificação:** Plano de execução sem varredura completa da tabela.

### RNF-019 — Valor anterior e novo na auditoria

**Categoria:** Rastreabilidade e Qualidade da Modelagem

**Descrição:** O registro de auditoria de uma mudança de situação deverá conter a situação anterior e a nova (DEC-024).

**Critério de verificação:** Registro de auditoria com os dois valores.

### RNF-020 — Integridade temporal dos vínculos

**Categoria:** Confiabilidade

**Descrição:** A data de fim do vínculo deverá ser nula se e somente se o vínculo estiver ativo (DEC-015).

**Critério de verificação:** Restrição de coerência no banco.

### RNF-021 — Uma oferta aberta por horário da lista de espera

**Categoria:** Confiabilidade

**Descrição:** No máximo uma oferta de vaga aberta deverá existir por horário (DEC-027).

**Critério de verificação:** Restrição de unicidade e teste concorrente.

### RNF-022 — Ordem estável da fila

**Categoria:** Confiabilidade

**Descrição:** A data e hora de entrada na lista de espera não deverá mudar depois da criação (DEC-027).

**Critério de verificação:** Tentativa de alteração deverá ser recusada.

### RNF-023 — Troca de provedor de e-mail sem alterar o domínio

**Categoria:** Compatibilidade

**Descrição:** A plataforma deverá se comunicar com o Serviço Externo de E-mail por uma interface própria (`ServicoEnvioMensagem`, DEC-022), de modo que a troca do provedor não altere o domínio.

**Critério de verificação:** Inspeção: o domínio e a aplicação dependem só da interface; o diagrama de componentes mostra o adaptador na infraestrutura.

### RNF-024 — Confirmação explícita antes de ação irreversível

**Categoria:** Capacidade de interação

**Descrição:** Antes de cancelar um agendamento ou aceitar uma oferta de vaga, a operação deverá exigir confirmação explícita do usuário e informar o efeito (liberação do horário ou confirmação do agendamento).

**Critério de verificação:** Inspeção dos fluxos de UC-027 e UC-036 e dos critérios CA-RF-027 e CA-RF-036.
