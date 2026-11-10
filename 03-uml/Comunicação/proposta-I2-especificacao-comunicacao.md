# Especificação do diagrama de comunicação COM-001 — Fase 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais.
**Data:** 22/10/2026 · **Versão:** v2.0 (proposta para o grupo; revisão do lote de ajustes da Fase 6).
**Natureza:** **PROPOSTA.** Não substitui artefato oficial do grupo.

| Artefato | Arquivo |
|---|---|
| Fonte editável (verdade do conteúdo) | [`proposta-I2-comunicacao-com-001.mmd`](proposta-I2-comunicacao-com-001.mmd) |
| Editável (draw.io) | `proposta-I2-comunicacao-com-001.drawio.xml` |
| Dossiê (PDF) | `proposta-I2-comunicacao-com-001.pdf` |
| Cenário | Agendar, cancelar e concluir atendimento (UC-024 + UC-025 + UC-027 + UC-035) |
| **RFs cobertos** | **RF-024, RF-025, RF-026, RF-027, RF-030, RF-032, RF-033, RF-035** |
| Base de regras | RN-003, RN-005, RN-009, RN-010, RN-013 · DEC-022, DEC-027 |
| Diagramas correlatos | SEQ-002, SEQ-003, SEQ-004 e ATV-001 (mesmo cenário) |

---

## 1. Objetivo

O plano da AV3 pede "o diagrama de comunicação para um cenário relevante" (§6.1, Integrante 2). O COM-001 mostra **quais colaboradores trocam mensagens entre si** no cenário de agendamento, e **em que ordem**. É o diagrama que responde à pergunta "quem fala com quem", enquanto a sequência responde "o que acontece ao longo do tempo".

Por ser o mesmo cenário de ATV-001/SEQ-002/SEQ-003/SEQ-004, o COM-001 funciona como **visão estrutural** (topologia de vínculos) do mesmo comportamento.

## 2. Cenário

> Um paciente solicita um horário a um psicólogo vinculado. O serviço de agenda consulta as permissões, o vínculo, a agenda e a disponibilidade; **cria o agendamento já confirmado**; audita e **sempre** solicita o e-mail. Mais tarde o mesmo agendamento pode ser cancelado (com auditoria, e-mail e **oferta da vaga ao próximo da fila**) ou concluído pelo psicólogo, com registro do atendimento.

## 3. Colaboradores (14 objetos)

| Objeto | Forma no desenho | Natureza | Papel no cenário |
|---|---|---|---|
| `Paciente` | estádio | fronteira (ator) | Solicita e cancela. |
| `Psicólogo` | estádio | fronteira (ator) | Conclui a sessão realizada. |
| **`Serviço Externo de E-mail`** (`ServicoEnvioMensagem`) | estádio | **fronteira externa** (serviço de e-mail) | Envia confirmação, cancelamento e oferta de vaga (AP-04 / RF-033). |
| `ServicoAgenda` | hexágono | **serviço de aplicação — hub** | Coordena regra, auditoria e envio de mensagem (AP-03). |
| `ServicoAuditoria` | hexágono | **serviço de aplicação** | Dispara o registro auditável (AP-02). |
| **`ServicoListaEspera`** | hexágono | **serviço de aplicação** (novo, AP-06) | Coordena a fila e a oferta de vaga (DEC-027). |
| `Usuario` | retângulo | entidade de domínio | Autorização: o que o solicitante pode consultar (OP-04). |
| `Vinculo` | retângulo | entidade de domínio | Autorização do acesso ao paciente (OP-22). |
| `Agenda` | retângulo | entidade de domínio | Horários livres e verificação de slot (OP-11, RN-005/RN-010). |
| `Disponibilidade` | retângulo | entidade de domínio | Períodos liberados pelo profissional (A09). |
| `Agendamento` | retângulo | entidade de domínio | Criação **já confirmada** e cancelamento (OP-14). |
| **`SolicitacaoEspera`** | retângulo | **entidade de domínio** (novo, DEC-027) | Guarda a fila, a ordem de entrada e o prazo de aceite (OP-23/OP-25/OP-27). |
| `Atendimento` | retângulo | entidade de domínio | Registro da sessão realizada (OP-20). |
| `RegistroAuditoria` | retângulo | entidade de domínio | Trilha auditável (RF-032). |

**Leitura das formas:** `[ ]` entidade de domínio · `{ }` serviço de aplicação · `( )` fronteira (ator ou serviço externo).

> **Mudança em relação à v1.0:** `ServicoNotificacao` foi renomeado para **`ServicoEnvioMensagem`** (DEC-022) e ganhou o rótulo "Serviço Externo de E-mail"; entraram `ServicoListaEspera` e `SolicitacaoEspera` (DEC-027). Por isso o diagrama passa de **12 colaboradores e 14 mensagens** para **14 colaboradores e 17 mensagens**.

## 4. Vínculos e mensagens numeradas (1 a 17)

| # | Emissor → Receptor | Mensagem | Origem da autorização |
|---|---|---|---|
| 1 | `Paciente` → `ServicoAgenda` | `solicitar(horario)` | RF-025 / UC-024 |
| 2 | `ServicoAgenda` → `Usuario` | `consultarPermitidos()` | OP-04 / RN-003 |
| 3 | `ServicoAgenda` → `Vinculo` | `estaAutorizado()` | OP-22 / RN-005 |
| 4 | `ServicoAgenda` → `Agenda` | `consultarHorarios()` | OP-11 / RF-024 |
| 5 | `Agenda` → `Disponibilidade` | `slots livres` | A09 |
| 6 | `ServicoAgenda` → `Agenda` | `verificarDisponibilidade()` | RN-005 / RN-010 |
| 7 | `ServicoAgenda` → `Agendamento` | `solicitar(horario)` | `Agendamento.solicitar` / RF-025 + RF-026 |
| 8 | `ServicoAgenda` → `ServicoAuditoria` | `registrar(criacao)` | AP-02 / RN-009 |
| 9 | `ServicoAuditoria` → `RegistroAuditoria` | `registrar(tabela)` | RF-032 |
| 10 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(confirmacao)` | AP-04 / RF-033 |
| 11 | `ServicoAgenda` → `Agendamento` | `cancelar(motivo)` | OP-14 / RN-012 / antes do horário |
| 12 | `ServicoAgenda` → `Serviço Externo de E-mail` | `notificar(cancelamento)` | AP-04 / RF-033 |
| 13 | `ServicoAgenda` → `ServicoListaEspera` | `ofertarVaga()` | AP-06 / RF-035 / DEC-027 |
| 14 | `ServicoListaEspera` → `SolicitacaoEspera` | `proximoDaFila(psicologo)` | AP-06 / ordem de entrada (**decisão P10**: consulta da coleção, não operação da instância) |
| 15 | `ServicoListaEspera` → `Serviço Externo de E-mail` | `notificar(ofertaVaga)` | AP-04 / RF-033 |
| 16 | `Psicólogo` → `ServicoAgenda` | `concluir(agendamento)` | RF-030 / UC-027 |
| 17 | `ServicoAgenda` → `Atendimento` | `registrar(atendimento)` | OP-20 / RF-030 |

> **Vínculos com mais de uma mensagem:** 4 e 6 (`ServicoAgenda`—`Agenda`), 7 e 11 (`ServicoAgenda`—`Agendamento`) e 10/12 (`ServicoAgenda`—`E-mail`) percorrem o mesmo vínculo. A ordem é dada pela **numeração**, não pela posição da seta — limitação do renderizador offline, que desenha retas sem deslocamento lateral. **Os retornos** (valores devolvidos pelos colaboradores, inclusive "agendamento CONFIRMADO" e "entregue | falha de envio") **não** geram seta própria: percorrem o vínculo no sentido inverso, como é a notação de comunicação.

## 5. Por que `ServicoAgenda` é o hub

O COM-001 mostra de forma gráfica a regra do plano §5.2: **não existe uma classe "Sistema" ou "GerenciadorGeral"**. O papel de coordenação é do **serviço de aplicação** `ServicoAgenda` (AP-03), que:

- **consulta** as entidades que possuem a regra (permissões, vínculo, agenda, disponibilidade);
- **aciona** as entidades que possuem o estado (`Agendamento`);
- **dispara** os efeitos transversais (auditoria, envio de e-mail) chamando os serviços que os executam (`ServicoAuditoria`, `ServicoEnvioMensagem`) — em vez de auditar "de dentro" da entidade;
- **delega** a regra da fila ao `ServicoListaEspera` (AP-06), em vez de acumular mais uma responsabilidade.

A mesma topologia vale para `ServicoAuditoria`, que **chama** `RegistroAuditoria` (mensagem 9) em vez de gravar a trilha por conta própria, e para `ServicoListaEspera`, que **chama** `SolicitacaoEspera` (mensagem 14) em vez de guardar a fila em memória.

## 6. Vínculos com as sequências

| Mensagem do COM-001 | Sequência correspondente |
|---|---|
| 1, 4, 5, 6, 7, 8, 9, 10 | SEQ-002 (`solicitar`, `consultarHorariosDisponiveis`, `verificarDisponibilidade`, `Agendamento.solicitar` já confirmado, auditoria, e-mail) |
| 11, 12, 16, 17 | SEQ-003 (`cancelar`, `notificar(cancelamento)`, `concluir`, `Atendimento.registrar`) |
| 13, 14, 15 | SEQ-003 (`opt <<extend>> ofertarVaga`) e SEQ-004 (`ofertarVaga`, `proximoDaFila`, `notificar(ofertaVaga)`) |
| 2, 3 | SEQ-002 (`Vinculo.estaAutorizado`); a autorização por permissões aparece aqui como OP-04, o que explicita RN-003 |

**Divergência registrada:** SEQ-001 usa a infraestrutura `RepositorioAutorizacao.obterPermissoes` (IR-02) para carregar as permissões da sessão, enquanto o COM-001 usa `Usuario.consultarPermitidos` (OP-04) para **autorização por operação**. São coisas diferentes: IR-02 monta a sessão (infraestrutura), OP-04 verifica, a cada operação, o que o solicitante pode acessar (regra de domínio). O cotejo está na revisão FASE6-REV-I2.

## 7. Decisões de modelagem

1. **`ServicoEnvioMensagem` é fronteira, não entidade.** Aparece como "Serviço Externo de E-mail" (serviço externo), exatamente como pede o plano §5.2 para componentes externos, e **não** tem classe de domínio nem tabela (DEC-022).
2. **A notificação sai do hub (mensagens 10 e 12) e da fila (15), nunca da entidade `Agendamento`.** Notificar é efeito de aplicação, não regra do domínio, e a falha de envio não desfaz a operação (RF-033).
3. **`Usuario` aparece no COM-001** (e não nas sequências) porque o diagrama de comunicação destaca **vínculos**: mostrar que a autorização é uma *consulta* a uma entidade, e não uma condição implícita no ator, é um ganho de legibilidade que o diagrama de atividades não tem.
4. **Não há `Perfil`/`Permissao` como objetos.** O COM-001 é do cenário de agendamento; a estrutura de acesso (A01/A02) aparece no diagrama de classes e em SEQ-001.
5. **O objeto `Disponibilidade` é alcançado só por `Agenda`** (A09). Com o **slot discreto** (DEC-018) a associação A17 `Disponibilidade`—`Agendamento` passa a existir no modelo, mas a reserva continua interna a `Agendamento.solicitar` e não vira mensagem.
6. **A oferta de vaga é uma mensagem do hub para `ServicoListaEspera`** (13), e não um novo caso de uso iniciado por ator: é o `<<extend>>` do cancelamento (UC-035 / DEC-027).

## 8. Pendências registradas (não são lacunas desta entrega)

| Pendência | Causa | Tratamento |
|---|---|---|
| Incremento `SolicitacaoEspera` + `ServicoListaEspera` | DEC-027 aprovada na Fase 6 | o COM-001 já os mostra; o Integrante 3 precisa incorporá-los ao CLS-001 (não existem na Fase 5). |
| Reserva do slot (A17) | DEC-018 (interna ao domínio) | Não há mensagem entre `Disponibilidade` e `Agendamento`; a reserva é efeito de `Agendamento.solicitar`. |
| Canal de notificação | resolvido: e-mail (RF-033) | `ServicoEnvioMensagem` aparece como fronteira externa, com canal definido. |
| Prazo de cancelamento | resolvido: `[antes do horário marcado]` | A mensagem 11 não carrega prazo numérico porque não existe. |

## 9. Como ler e editar

- A **fonte editável** é o `.mmd` (Mermaid, `flowchart LR`).
- As **hints de layout** `%% pos: <id> <x> <y>` posicionam o centro de cada colaborador (o Mermaid as ignora; o renderizador offline do repositório as usa — ver `03-uml/README.md`).
- O `.drawio.xml` é a versão editável no draw.io; o `.pdf` é a versão do dossiê.
