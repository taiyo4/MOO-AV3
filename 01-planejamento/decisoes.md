# Registro de Decisões do Projeto

Este arquivo será utilizado para registrar decisões relevantes
tomadas durante o desenvolvimento da AV3.

## Situação das decisões (atualizada em 25/10/2026)

| Situação | Decisões |
|---|---|
| Aprovadas | DEC-001 a DEC-010, DEC-011 (redação revisada), DEC-017 |
| Aprovada parcialmente | DEC-016 (quatro situações aprovadas; `SOLICITADO` pendente) |
| Propostas aguardando o grupo | DEC-012 (prazo de 2 horas **não aprovado**), DEC-013, DEC-014, DEC-015, DEC-018 a DEC-026 |
| Pendências abertas | PG-01 a PG-12 (seção "Pendências que exigem decisão do grupo") |

## DEC-001 — Tipo de projeto

O trabalho consiste na modelagem orientada a objetos de uma
plataforma destinada a profissionais de Psicologia.

## DEC-002 — Repositório

O GitHub será utilizado como repositório oficial do projeto,
mantendo histórico de versões e organização dos artefatos.

## DEC-003 — Persistência

O sistema será modelado considerando persistência em banco de
dados relacional.

## DEC-004 — Equipe

O grupo será composto por seis integrantes com responsabilidades
principais distintas e revisão cruzada dos artefatos.

## DEC-005 — Dados

Nenhum dado real de pacientes será utilizado nos artefatos,
diagramas ou exemplos do projeto.

## DEC-006 — Acesso do Cliente/Paciente

**Decisão:**  
O Cliente/Paciente será considerado ator do sistema e possuirá acesso autenticado limitado.

**Responsabilidades permitidas:**
- realizar login;
- consultar horários disponíveis;
- solicitar agendamento;
- consultar os próprios agendamentos;
- cancelar agendamento quando permitido;
- consultar somente informações disponibilizadas ao próprio usuário.

**Restrições:**
O Cliente/Paciente não terá acesso às funções administrativas, informações de outros usuários, auditoria ou informações profissionais restritas.

**Justificativa:**  
Permitir autoatendimento básico relacionado à agenda sem conceder privilégios administrativos ou profissionais.

## DEC-007 — Exclusão do Atendente no Escopo Atual

**Decisão:**  
O perfil/ator Atendente não será incluído no escopo da plataforma nesta fase do projeto.

**Justificativa:**  
Trata-se de um papel opcional. A sua exclusão neste momento evita acréscimo desnecessário de requisitos, regras, casos de uso e permissões, mantendo o foco nos objetivos pedagógicos centrais da AV3. Caso o grupo decida incluí-lo posteriormente, nova decisão formal será registrada.

## DEC-008 — Delimitação de Escopo Negativo Inicial

**Decisão:**  
Permanecerão explicitamente fora do escopo do projeto: pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição de medicamentos, prontuário clínico aprofundado e cobrança.

**Justificativa:**  
Limitar a amplitude do projeto para assegurar profundidade e rigor metodológico na modelagem orientada a objetos dos módulos essenciais.

## DEC-009 — Serviço Externo de E-mail

**Situação:** `APROVADA PELO GRUPO` (consenso registrado por mensagem; formalizada em 25/10/2026).

**Decisão:**  
A plataforma utilizará um **Serviço Externo de E-mail** como ator externo de suporte para enviar mensagens aos usuários nos seguintes eventos:

- confirmação de agendamento;
- cancelamento de agendamento;
- oferta de vaga da lista de espera (DEC-010).

**Efeitos nos requisitos:** o envio passa a ser especificado em `RF-033`; as regras correspondentes estão em `RN-022`.

**Fora desta decisão:** o envio de e-mail em outros eventos (por exemplo, `Realizado` ou `Não compareceu`) e o tratamento de falha no envio não foram decididos (ver `PG-11`).

**Histórico:** substitui o registro anterior "`PENDENTE DE DECISÃO DO GRUPO`".

## DEC-010 — Funcionalidade de Inovação: lista de espera inteligente

**Situação:** `APROVADA PELO GRUPO` (consenso registrado por mensagem; formalizada em 25/10/2026). Parâmetros operacionais pendentes.

**Decisão:**  
A funcionalidade de inovação será uma **lista de espera inteligente**: quando um agendamento for cancelado, o horário liberado **poderá** ser oferecido a outro paciente que aguarda na lista de espera. A oferta é comunicada por e-mail (DEC-009).

**Efeitos nos requisitos:** `RF-034`, `RF-035` e `RF-036`; regra `RN-021`.

**Pontos ainda não decididos pelo grupo:** ordem da fila (`PG-04`), quantos pacientes recebem a oferta ao mesmo tempo (`PG-05`), prazo para aceitar a vaga (`PG-06`), tratamento de recusa ou ausência de resposta (`PG-07`), abrangência da entrada na lista (`PG-08`) e se o cancelamento feito pelo psicólogo também gera oferta (`PG-09`). Nenhum desses parâmetros deve ser tratado como aprovado nos modelos.

**Histórico:** substitui o registro anterior "`PENDENTE DE DECISÃO DO GRUPO`".

## DEC-011 — Atores autorizados para cancelar um agendamento

**Situação:** `APROVADA PELO GRUPO` com redação revisada (formalizada em 25/10/2026). Originalmente submetida como proposta pelo Integrante 2 na Fase 5.

**Decisão:**  
O cancelamento (`RF-027`, `RN-012`) pode ser feito:

- pelo **Cliente/Paciente** titular do agendamento;
- pelo **Psicólogo** responsável pelo agendamento;

desde que o cancelamento ocorra **antes do horário marcado** para o início do atendimento.

**Não aprovado nesta decisão:**

- antecedência mínima de duas horas ou qualquer outro prazo mínimo (ver `DEC-012` e `PG-02`);
- cancelamento pelo Administrador, inclusive em operação corretiva, que constava da proposta original (ver `PG-10`).

**Justificativa:** Coerente com DEC-006 (autoatendimento limitado do paciente) e com RN-003 (o profissional só atua sobre pacientes vinculados).

## DEC-016 — Situações do agendamento

**Situação:** `APROVADA PARCIALMENTE PELO GRUPO` (formalizada em 25/10/2026). Originalmente submetida como proposta pelo Integrante 2 na Fase 5.

**Decisão aprovada:** o agendamento assume as situações:

| Situação | Identificador técnico sugerido nos modelos |
|---|---|
| Confirmado | `CONFIRMADO` |
| Cancelado | `CANCELADO` |
| Realizado | `REALIZADO` |
| Não compareceu | `NAO_COMPARECEU` |

Transições que decorrem das decisões aprovadas (DEC-011, DEC-017):

| De | Evento | Para | Base |
|---|---|---|---|
| — | solicitação aceita automaticamente | `Confirmado` | DEC-017 |
| `Confirmado` | cancelamento antes do horário, pelo paciente ou psicólogo | `Cancelado` | DEC-011 |
| `Confirmado` | atendimento realizado | `Realizado` | RF-030 |
| `Confirmado` | ausência do paciente | `Não compareceu` | RF-037 |

**Ainda não decidido:**

- se `SOLICITADO` será um estado **persistente** do agendamento ou apenas uma **etapa transitória** do fluxo de solicitação (`PG-01`). Enquanto isso não for decidido, a proposta original com `SOLICITADO` não deve ser tratada como vigente;
- quem registra `Não compareceu` e em que momento (`PG-03`, `DEC-025`);
- se `Cancelado`, `Realizado` e `Não compareceu` são situações finais sem reversão, como sugeria a proposta original (a regra RN-006 já impede que um agendamento cancelado seja registrado como realizado).

## DEC-017 — Confirmação automática do agendamento

**Situação:** `APROVADA PELO GRUPO` (formalizada em 25/10/2026). Originalmente submetida como proposta pelo Integrante 2 na Fase 5.

**Decisão:**  
O agendamento é **confirmado automaticamente** pelo sistema quando o horário solicitado estiver disponível e não houver conflito de agenda. Não há aprovação manual por outro ator. Se o horário não estiver disponível ou houver conflito, a solicitação não é confirmada (RN-005, RN-010).

**Efeitos nos requisitos:** `RF-025`, `RF-026`, `RN-013`; a confirmação gera o envio de e-mail de `RF-033` (DEC-009).

**Detalhe de modelagem não decidido pelo grupo:** a assinatura `confirmar(solicitante: Usuario)` e demais detalhes de operação continuam como proposta técnica do Integrante 2 e devem ser revistos depois de resolvida a `PG-01`.

---

# PENDÊNCIAS QUE EXIGEM DECISÃO DO GRUPO

> Itens abertos em 25/10/2026. Não devem ser tratados como aprovados em requisitos, diagramas, persistência ou pitch. Ao decidir, registrar a decisão no item de origem (DEC) e remover a pendência daqui.

| ID | Pendência | Origem | Requisitos afetados |
|---|---|---|---|
| PG-01 | `SOLICITADO` é estado persistente do agendamento ou apenas etapa transitória do fluxo? | DEC-016, DEC-017 | RF-025, RF-026, RN-020 |
| PG-02 | Existe antecedência mínima para cancelar além de "antes do horário marcado"? A proposta de **2 horas não foi aprovada**. | DEC-011, DEC-012 | RF-027, RN-012 |
| PG-03 | Quem registra `Não compareceu` (psicólogo, outro ator ou o sistema automaticamente) e a partir de quando? | DEC-016, DEC-025 | RF-037, RN-020 |
| PG-04 | Ordem da fila da lista de espera (por exemplo, ordem de entrada ou outro critério). | DEC-010 | RF-035, RN-021 |
| PG-05 | A vaga é oferecida a um paciente por vez ou a vários ao mesmo tempo? | DEC-010 | RF-035, RN-021 |
| PG-06 | Prazo para o paciente aceitar a vaga oferecida e se o horário fica reservado para ele durante esse prazo. | DEC-010, DUV-005 | RF-036, RN-021 |
| PG-07 | Tratamento de recusa ou ausência de resposta dentro do prazo. | DEC-010, DUV-005 | RF-035, RF-036, RN-021 |
| PG-08 | Abrangência da entrada na lista: por psicólogo, por faixa de horário ou por horário específico; se o paciente pode consultar a posição e sair da lista. | DEC-010 | RF-034 |
| PG-09 | O cancelamento feito pelo psicólogo também libera o horário para a lista de espera? | DEC-010, DEC-011 | RF-027, RF-035, RN-021 |
| PG-10 | O Administrador pode cancelar agendamentos (por exemplo, em operação corretiva)? | DEC-011 | RF-027, RN-012 |
| PG-11 | Efeito de falha no envio de e-mail sobre a operação que o originou. | DEC-009 | RF-033, RN-022 |
| PG-12 | Relação entre o registro do atendimento e a situação `Realizado` (proposta DEC-023). | DEC-016, DEC-023 | RF-030, RN-020 |

---

# PROPOSTAS DE DECISÃO — FASE 5 (Integrante 2) · AGUARDANDO APROVAÇÃO DO GRUPO

> **Atenção:** o bloco abaixo **não é decisão vigente**. São propostas submetidas pelo Integrante 2 na Fase 5 (revisão do modelo de domínio), com o objetivo de destravar a Fase 6 (sequências) e a Fase 7 (persistência). Cada proposta só passa a valer quando o grupo a aprovar e quando o Integrante 1 mover a linha correspondente para o registro oficial de decisões.
>
> Atualização de 25/10/2026: **DEC-011**, **DEC-016** (parcialmente) e **DEC-017** foram aprovadas pelo grupo e movidas para o registro oficial acima, mantendo os números. As demais continuam como proposta.
>
> Numeração: as propostas **DEC-011** e **DEC-012** já são citadas nas especificações de caso de uso do Integrante 2 (`UC-027`) e por isso mantêm esses números. As demais são novas.
>
> Base completa: [`01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md`](revisoes/FASE5-REV-I2-revisao-modelo-dominio.md) e [`06-rastreabilidade/matriz-rastreabilidade-fase5.md`](../06-rastreabilidade/matriz-rastreabilidade-fase5.md).

## DEC-012 — Prazo de antecedência para cancelamento (proposta)

> **Atualização de 25/10/2026:** o grupo **não aprovou** a antecedência mínima de 2 horas. O consenso vigente (DEC-011) é que o cancelamento pode ocorrer **antes do horário marcado**. Se haverá algum prazo mínimo adicional continua em aberto (`PG-02`). As referências a `SOLICITADO` dependem da `PG-01`.

**Proposta original (não aprovada):** O cancelamento só é aceito quando o agendamento está em situação `SOLICITADO` ou `CONFIRMADO` **e** faltam no mínimo **2 horas** para o início do horário. Após o início, o compromisso só pode ser encerrado como `REALIZADO` ou `NAO_COMPARECEU`.

**Justificativa:** Fecha a pendência citada em `UC-027` ("prazo de antecedência mínimo para cancelar — ainda sem definição do grupo") e materializa a guarda `podeSerCancelado()`.

**Efeito no modelo:** a regra fica em uma única operação consultável, reutilizada pelo caso de uso e pelo teste conceitual CT-027.

**Alternativa a discutir:** 4 horas ou 24 horas, ou valor definido por faixa de horário.

**Situação:** prazo de 2 horas não aprovado; existência de prazo mínimo pendente (`PG-02`).

## DEC-013 — Situações da conta de usuário (proposta)

**Proposta:** `Usuario.situacaoConta` assume os valores `ATIVO`, `BLOQUEADO` e `INATIVO`. Apenas `ATIVO` permite autenticação (RN-001); `BLOQUEADO` recusa mesmo com credencial correta; `INATIVO` representa conta desativada sem penalidade.

**Justificativa:** Alinha o modelo ao dicionário de dados do plano §10.2 (`status` = ATIVO, BLOQUEADO, INATIVO) e dá significado operacional a RF-005/RF-006.

**Situação:** aguardando aprovação do grupo.

## DEC-014 — Situações cadastrais do paciente (proposta)

**Proposta:** `Paciente.situacaoCadastral` assume `ATIVO`, `SUSPENSO` e `INATIVO`, com transição livre entre si, sempre por administrador autorizado e com registro em auditoria (RN-009).

**Justificativa:** RF-020 exige "alterar a situação do cliente/paciente", mas o modelo não tinha valores definidos (pendência PC-05).

**Situação:** aguardando aprovação do grupo.

## DEC-015 — Situação e temporalidade do vínculo (proposta)

**Proposta:** `Vinculo` passa a ter `situacao` (`ATIVO`, `ENCERRADO`), `dataInicio` e `dataFim`. Ao encerrar, o vínculo deixa de autorizar o acesso do profissional ao paciente (RN-003, RN-007). Agendamentos futuros já marcados **não** são cancelados automaticamente: o sistema **alerta** o profissional para reagendar.

**Justificativa:** Fecha parcialmente a DUV-003 e a pendência P-12 do Integrante 4, e torna verificável a restrição de acesso ao longo do tempo.

**Ponto de atenção:** a alternativa "cancelar automaticamente os agendamentos futuros" é mais simples de implementar, mas retira decisão do profissional — o grupo precisa escolher.

**Situação:** aguardando aprovação do grupo.

## DEC-018 — Modelo de tempo da disponibilidade (proposta)

**Proposta:** O horário liberado pelo profissional é um **slot discreto** (data, hora de início e duração fixa), e não um intervalo contínuo livre. Cada `Disponibilidade` corresponde a um horário ofertado e consultável.

**Justificativa:** Torna a consulta de horários (RF-024) uma lista de slots reais, simplifica a exclusividade de RN-005 (um slot, no máximo um agendamento ativo) e permite vincular o agendamento ao slot reservado (associação A17).

**Efeito no modelo:** habilita a associação condicional `Disponibilidade` → `Agendamento` e o índice de exclusividade no banco.

**Situação:** aguardando aprovação do grupo (pendência P-05 do Integrante 4).

## DEC-019 — Cardinalidade entre usuário e perfil (proposta)

**Proposta:** Cada conta de acesso tem **no máximo um** perfil (`Usuario "0..1" — Perfil "1"`); toda conta que autentica possui exatamente um perfil. Um perfil pode ser compartilhado por várias contas.

**Justificativa:** Resolve a INC-01 do Integrante 4. O caminho de verificação de autorização (RF-001, RNF-002) fica simples e o N:N já previsto pelo plano §10.1 permanece apenas entre `Perfil` e `Permissao`.

**Situação:** aguardando aprovação do grupo (pendência P-06 do Integrante 4).

## DEC-020 — Sessão fora do modelo de domínio (proposta)

**Proposta:** A sessão autenticada (RF-002) **não** é entidade do modelo de domínio. É estado volátil de aplicação, tratado por um serviço de autenticação; no diagrama de classes aparece apenas como serviço, e nas sequências como objeto de fronteira.

**Justificativa:** Coerente com a análise do Integrante 4 (P-07) e com a decisão de modelagem OO-16 do Integrante 3. Evita inflar o domínio com conceito técnico e sem regra de negócio própria.

**Situação:** aguardando aprovação do grupo.

## DEC-021 — Conta de acesso opcional para os cadastros (proposta)

**Proposta:** A relação entre `Usuario` e os cadastros `Psicologo` e `Paciente` é de `0..1` para `0..1`: o cadastro pode existir sem conta (registros importados, cadastros em_regularização) e uma conta atende a no máximo um cadastro de cada tipo.

**Justificativa:** Fecha a INC-12/P-11 do Integrante 4 e preserva a distinção entre conta de acesso e cadastro (RF-014, RF-018, DEC-006).

**Situação:** aguardando aprovação do grupo.

## DEC-022 — Notificação por e-mail como fronteira de aplicação (proposta)

> **Atualização de 25/10/2026:** a DEC-009 foi aprovada e o requisito foi numerado como `RF-033`. A condição "enquanto o grupo não decidir" deixou de existir. Continua como proposta apenas a forma de modelagem (interface de fronteira, sem classe de domínio e sem tabela).

**Proposta:** Enquanto o grupo não decidir a DEC-009, a notificação é modelada como **fronteira de aplicação** (interface `ServicoEnvioMensagem`), sem classe de domínio e sem tabela. Se a DEC-009 for aprovada, o Integrante 1 deve numerar o requisito correspondente (RF-033) e a notificação passa a aparecer no diagrama de componentes da Fase 7.

**Justificativa:** O plano §6.1 penaliza elementos órfãos; criar a classe `Notificacao` sem requisito seria um órfão. A include UC "Notificar paciente por e-mail" já existe e hoje não tem responsável modelada (achado R5-12).

**Situação:** forma de modelagem aguardando aprovação do grupo (DEC-009 já aprovada).

## DEC-023 — Registro de atendimento referencia o agendamento (proposta)

> **Atualização de 25/10/2026:** depende da `PG-01` (a proposta cita `CONFIRMADO` como situação de origem) e da `PG-12`.

**Proposta:** O `Atendimento` referencia o `Agendamento` do qual decorre (A15, `1` para `0..1`). O registro só é permitido para agendamento em situação `CONFIRMADO`, e o atendimento é criado quando o agendamento passa a `REALIZADO`.

**Justificativa:** Torna verificáveis "sessão válida da agenda" (RF-030) e "agendamento cancelado não pode ser registrado como realizado" (RN-006), fechando a pendência PC-08 do Integrante 3 e a INC-09 do Integrante 4.

**Situação:** aguardando aprovação do grupo.

## DEC-024 — Colaboração de auditoria e conteúdo mínimo (proposta)

**Proposta:** O registro de auditoria é disparado por um **serviço de aplicação** após cada operação auditável, e não por dependência estrutural das entidades. O conteúdo mínimo do registro é: responsável, data, hora, operação, **situação anterior** e **nova situação** quando a operação alterou uma situação.

**Justificativa:** Fecha a pendência PC-12 do Integrante 3 (colaborações) e a INC-07 do Integrante 4 (situação anterior/nova), e mantém RN-009 e RN-014 verificáveis sem acoplar todas as classes ao `RegistroAuditoria`.

**Situação:** aguardando aprovação do grupo.

## DEC-025 — "Não compareceu" é registrado manualmente (proposta)

> **Atualização de 25/10/2026:** a situação `Não compareceu` foi aprovada (DEC-016), mas **quem a registra e quando continua sem decisão** (`PG-03`). Esta proposta não deve ser tratada como aprovada.

**Proposta:** A situação `NAO_COMPARECEU` é registrada manualmente pelo **psicólogo**, após o término do horário. Não há expiração automática.

**Justificativa:** Fecha a pendência "DEC-5" citada em `UC-027`. A alternativa automática exigiria um mecanismo de temporização, que traria complexidade (e risco) sem regra aprovada.

**Situação:** aguardando aprovação do grupo.

## DEC-026 — Convenção de numeração de casos de uso e de testes (proposta)

**Proposta:** A numeração de casos de uso segue a convenção já adotada nos casos críticos, `UC-0RF` (o número do caso é o número do requisito), e a de teste conceitual idem, `CT-0RF`. Os casos críticos recebem a linha "RFs cobertos", como já existe nos demais casos.

**Justificativa:** Torna a [matriz de rastreabilidade](../06-rastreabilidade/matriz-rastreabilidade-fase5.md) auditável linha a linha e elimina a interpretação manual dos vínculos (achados R5-16 e R5-17).

**Situação:** aguardando aprovação do grupo.

