# Pontos do Integrante 2 para o pitch — proposta ao Integrante 6

**Responsável:** Integrante 2 — Casos de uso e diagramas comportamentais (Aquiles Angelo).
**Data:** 29/10/2026 · **Versão:** v1.0 (proposta para o grupo).
**Tarefa do plano atendida:** Fase 9, bloco do Integrante 2 (`01-planejamento/etapas-e-responsabilidades.md` §3): **corrigir os últimos achados dos seus artefatos e participar do pitch**.
**Natureza:** **PROPOSTA.** O banco de pontos e o roteiro são do **Integrante 6** (`08-pitch/banco-de-pontos-pitch.md`); este documento traz o que o I2 entrega para ele incorporar, e não substitui o roteiro.

**Base:** barema §17 (partes do pitch) e §18.2 (0,80 + 0,70 + 0,50 ponto); banco de pontos v0.6; regra de coerência (o pitch só mostra o que está no dossiê).

---

## 1. O que muda no banco de pontos

O banco v0.6 foi escrito antes do fechamento da Fase 6. Quatro linhas ficaram **desatualizadas** e três **novos pontos** passam a existir.

| Linha do banco (v0.6) | Texto atual | Correção proposta | Motivo / artefato |
|---|---|---|---|
| linha 25 | "Três sequências; toda mensagem tem operação de origem (**82 de 82**)" | **Quatro sequências; 136 de 136 setas** (85 solicitações + 51 retornos) — SEQ-001 31, SEQ-002 21, SEQ-003 32, SEQ-004 52 | SEQ-004 criada e três sequências ampliadas; matriz da Fase 6 §2.1–2.4 |
| linha 26 | "**Não usar o EST-001 atual até ser corrigido** (ainda mostra `SOLICITADO` — INT-11)" | **Liberado**: EST-001 tem **4 situações e 4 transições**, sem `SOLICITADO` (DEC-016/017); INT-11 fechado | EST-001 v2.1; dossiê §24; FASE6-REV-I2 §6 |
| linha 21 | "inovação sem caso de uso (INT-07)" | **UC-034, UC-035 e UC-036** especificados e **SEQ-004** desenhada; `<<extend>>` no cancelamento | `proposta-I2-casos-de-uso-faltantes.md`; SEQ-004 |
| linha 20 | "parâmetros da fila **não usar até decidir** (PG-04 a PG-09)" | **Liberado**: DEC-027 aprovada — ordem de entrada, **uma oferta por vez**, prazo de aceite, recusa/vencimento passa ao próximo, horário **reservado** durante o prazo | DEC-010 + DEC-027; SEQ-004 |
| linha 17 | e-mail no CTX-001 como "Pendente" (INT-03) | manter, mas o **ponto do pitch** pode afirmar a decisão: e-mail é serviço externo aprovado (DEC-009/DEC-022) | DEC-022; UC-033 |

**Três pontos novos (a acrescentar ao banco):**

| # | Ponto | Parte (§17) | Seção / artefato | Situação |
|---|---|---|---|---|
| N1 | **Falha de e-mail não desfaz a operação**: o agendamento/cancelamento continua válido, a falha é auditada (`FALHA_ENVIO_EMAIL`) e o envio pode ser repetido | Decisões | 21–24; SEQ-002/003/004; DEC-029 | Pronto |
| N2 | **Arquitetura conferida contra os casos de uso**: 12 achados R7 com dono, incluindo a fronteira de e-mail sem tabela e a fila que exige tabela própria | Modelagem / Qualidade | 25–26; FASE7-REV-I2 | Pronto |
| N3 | **Testes conceituais na convenção `CT-0RF`**: 15 testes, 68 cenários e cobertura 4/4 das transições do EST-001 | Qualidade | 31; FASE8-REV-I2 | Pronto |

---

## 2. Falas sugeridas para o Integrante 2 (três blocos, ~40 s cada)

> Ajustar ao tempo total definido pelo grupo. Sugestão: os três blocos cobrem a parte "Modelagem" (bloco 4 do roteiro) e um retorno na parte "Qualidade".

### Bloco A — Comportamento: como o sistema agenda (parte "Modelagem")

"Para modelar o comportamento, partimos dos casos de uso críticos e desenhamos **quatro sequências**, todas com fonte editável em Mermaid e PDF. A regra que nos guiou foi simples: **toda seta tem dono** — cada mensagem corresponde a uma operação do modelo, a um serviço de aplicação ou a uma interface de infraestrutura. São **136 setas**, 85 solicitações e 51 retornos, e nenhuma ficou órfã.
O caso do agendamento mostra a decisão importante: o agendamento **nasce `Confirmado`** — não existe estado `Solicitado`. Com confirmação automática, esse estado não teria duração nem regra própria. São quatro situações e quatro transições, e é isso que aparece no diagrama de estados, nas sequências e na futura coluna do banco."

**Na tela:** `proposta-I2-sequencia-seq-002-agendar.pdf` → depois EST-001.

### Bloco B — A inovação: lista de espera (parte "Modelagem"/"Solução")

"A inovação é a **lista de espera inteligente**: quando um horário é cancelado, ele não fica vazio — é ofertado ao próximo da fila. A modelagem respeita quatro regras: a fila é por **ordem de entrada**, existe **uma oferta por vez**, a oferta tem **prazo de aceite** e, se o paciente recusar ou o prazo vencer, a vaga **passa ao próximo**. Enquanto a oferta está aberta, o horário fica **reservado**. O paciente pode consultar a própria posição e sair da fila a qualquer momento, e quem desiste pode voltar depois.
Isso aparece em uma sequência própria, a **SEQ-004**, com 52 setas, e em três casos de uso — e a oferta ao cancelamento é um `«extend»`, porque só acontece quando há fila."

**Na tela:** `proposta-I2-sequencia-seq-004-lista-espera.pdf`.

### Bloco C — Qualidade: rastreabilidade e testes (parte "Qualidade")

"Fechamos com duas provas de coerência. A primeira é a **matriz da Fase 6**: cada requisito aponta para caso de uso, classe, operação, sequência, atividade, comunicação e estado — e a coluna de órfãos está zerada. A segunda são os **testes conceituais** na convenção `CT-0RF`, em que o número do teste é o número do requisito: são **15 testes e 68 cenários**, cobrindo as quatro transições do ciclo do agendamento e os três eventos de e-mail.
Também revisamos a arquitetura contra os casos de uso e registramos **12 achados com dono** — inclusive um que teria passado: a falha de envio de e-mail precisa ser auditada sem desfazer o agendamento."

**Na tela:** matriz da Fase 6 (§2) e `FASE8-REV-I2-testes-conceituais.md` (§5).

---

## 3. Ordem de demonstração na tela

| Ordem | Arquivo | O que apontar |
|---|---|---|
| 1 | `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.pdf` | Criação já `CONFIRMADO`, auditoria, e-mail e o `alt` "Falha de envio — não desfaz" |
| 2 | `03-uml/Estados/proposta-I2-estados-est-001.pdf` | 4 situações / 4 transições; T0 criação e T3 não comparecimento |
| 3 | `03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.pdf` | Consulta/saída da fila, oferta com prazo, aceite/recusa/vencimento |
| 4 | `03-uml/Atividade/proposta-I2-atividade-atv-001.pdf` | Pistas por ator, 4 decisões, paralelismo do e-mail |
| 5 | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` §2 | A seta → operação/serviço (136/136) |
| 6 | `01-planejamento/revisoes/FASE8-REV-I2-testes-conceituais.md` §5 | Cobertura: 4 de 4 transições |

**Dica de gravação:** abrir o PDF em tela cheia e aumentar o zoom no fragmento citado; não rolar a página durante a fala.

---

## 4. Perguntas prováveis e respostas curtas

| Pergunta | Resposta (30 s) |
|---|---|
| "Por que não existe `Solicitado`?" | Porque a confirmação é automática (DEC-017): o sistema valida vínculo, disponibilidade e conflito e cria o agendamento já `Confirmado`. Um estado intermediário sem duração e sem regra própria só criaria inconsistência (DEC-016). |
| "E se o e-mail falhar? O agendamento é desfeito?" | Não. O envio é um efeito externo: a falha é registrada na auditoria como `FALHA_ENVIO_EMAIL` e o envio pode ser repetido; o agendamento continua válido (DEC-029). |
| "Como vocês garantem que dois pacientes não pegam o mesmo horário?" | A reserva é **atômica** no repositório (`reservarSeLivre`), com índice único como última defesa, e a regra de conflito é decidida no domínio — não no banco (R7-07, RN-005). |
| "A lista de espera não é só um `JOIN`?" | Não: ela tem estado próprio (`AGUARDANDO`, `OFERTADA`, `ACEITA`, `RECUSADA`, `EXPIRADA`, `DESISTIU`), ordem por `dataHoraEntrada`, prazo de aceite e reserva do horário — por isso exige tabela e serviço próprios (R7-04). |
| "Por que a oferta é `«extend»` e não um caso independente?" | Porque só existe quando há cancelamento **e** fila; sem isso o fluxo principal não muda. |
| "O que falta para implementar?" | Incorporar as operações ao diagrama de classes oficial (I3), fechar o DER e os componentes (I4) e homologar os testes na matriz final (I5). O modelo de comportamento já está fechado. |
| "Como vocês sabem que os diagramas estão coerentes entre si?" | Pela matriz da Fase 6 (136/136 setas ancoradas) e pela revisão cruzada que gerou os achados R6 e R7 — todos com dono e situação. |
| "Por que o e-mail não virou classe nem tabela?" | Porque é integração externa: modelamos como **interface** (`ServicoEnvioMensagem`), o que permite trocar o provedor sem mexer no domínio (DEC-009/DEC-022). |

---

## 5. Números do Integrante 2 (folha de consulta)

| Indicador | Valor | Onde conferir |
|---|---|---|
| Diagramas comportamentais | **7** (SEQ-001…004, ATV-001, COM-001, EST-001) | `03-uml/README.md` |
| Setas nas sequências | **136** (85 pedidos + 51 retornos) | matriz da Fase 6 §2 |
| Participantes / mensagens do COM-001 | **14 / 17** | COM-001 |
| Pistas / nós / arestas do ATV-001 | **4 / 37 / 39** | ATV-001 |
| Situações / transições do agendamento | **4 / 4** | EST-001 |
| Operações do modelo | **28** (OP-01…OP-28) | matriz da Fase 6 |
| Serviços de aplicação | **6** (AP-01…AP-06) | FASE5-REV-I2 + FASE6-REV-I2 |
| Casos de uso do I2 | **10** (UC-001, 024, 025, 027, 028, 033–037) | `proposta-I2-casos-de-uso-faltantes.md` |
| Testes conceituais | **15 testes / 68 cenários** | FASE8-REV-I2 |
| Achados R7 | **12** (5 severidade A) | FASE7-REV-I2 §3 |
| Órfãos na matriz da Fase 6 | **0** | matriz §3 |

---

## 6. O que **não** usar no pitch (ressalvas de coerência)

| Item | Por quê | Até quando |
|---|---|---|
| Dizer que **todos** os diagramas oficiais já incorporam OP-01…OP-28 | O CLS-001 oficial ainda declara `Agendamento.confirmar()` e não fixa o enumerado (R6-09, I3) | I3 incorporar |
| Apresentar **DER, componentes ou implantação como prontos** | São da Fase 7 do I4 e a análise dele ainda cita `notificacao` condicional e fila fora do DER (R7-01 a R7-05) | I4 fechar |
| Citar a tabela de achados Q6 como "fechada" | Q6-01…Q6-07 ainda aparecem **Aberto** na tabela do I5 (os artefatos estão corrigidos) | I5 homologar |
| Usar as **especificações oficiais** de casos de uso como exemplo de formato | Elas não têm "Objetivo"/"RFs cobertos" e citam DEC-012, não adotada (R7-06) | I2 revisar na Fase 9 |
| Mostrar tela de sistema / código | O produto é um **dossiê de modelagem**; não há sistema programado | sempre |

---

## 7. Encaminhamento ao Integrante 6

1. **Substituir** as quatro linhas desatualizadas do banco (linha 25, 26, 21 e 20) pelos textos da §1.
2. **Acrescentar** os três pontos novos (N1, N2, N3) na tabela §1 do banco.
3. **Retirar** as pendências já resolvidas da §3 do banco: "diagramas corrigidos conforme DEC-016" e "diagrama comportamental e caso de uso da lista de espera" estão **fechados** (INT-11 e INT-07); permanecem apenas "arquitetura e persistência (Fase 7)" e "números finais de qualidade (Fase 8)".
4. **Decidir** quem fala e a duração; a proposta da §2 pressupõe o I2 na parte "Modelagem" e um retorno na "Qualidade".
5. **Conferir** a coerência com o dossiê montado (`07-dossie/dossie.md` v0.7) antes de gravar — nenhum ponto acima cita artefato que não esteja versionado.

**Registro de participação:** Integrante 2 (Aquiles Angelo) — atualização de quatro pontos do banco, três pontos novos, três blocos de fala, ordem de demonstração, oito perguntas e respostas e folha de números para o pitch.
