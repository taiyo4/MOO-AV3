# Dossiê — Seções 18, 19, 20 e 27 (texto pronto)

**Responsável:** Integrante 2 (Fase 5) · **Data:** 21/10/2026 · **Versão:** v1.0.
**Uso:** texto para as seções 18 (Modelo de domínio), 19 (Diagrama de classes), 20 (Diagrama de objetos) e 27 (Princípios OO e SOLID) do dossiê final (estrutura do plano §16).
**Regra de inserção de diagramas (plano §16.1):** cada diagrama entra no dossiê com título + identificador, objetivo, elementos principais, como interpretar, decisões de modelagem, relação com requisitos/classes/banco e **referência ao arquivo editável** no repositório. Os diagramas da Fase 5 já têm **PDF e fonte editável (`.drawio.xml`)** versionados em `03-uml/` — ver a convenção de entrega em `03-uml/README.md`; se o grupo quiser PNG/SVG additional, eles são gerados a partir do `.drawio.xml` no diagrams.net.

> **Estado dos modelos:** esta seção foi revisada para refletir as decisões aprovadas em `01-planejamento/decisoes.md`, incluindo DEC-013–015, DEC-018–019, DEC-027 e DEC-030.

---

## 18. Modelo de domínio

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

## 27. Princípios OO e SOLID

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
