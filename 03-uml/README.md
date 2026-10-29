# UML

Esta pasta armazena os diagramas UML e seus arquivos editáveis.

## Convenção de entrega dos diagramas (Fases 5 e 6)

Todo diagrama entregue vem em **três formatos**, com o **mesmo nome-base**:

| Formato | Arquivo | Papel | Quem abre |
|---|---|---|---|
| Mermaid (`.mmd`) | `nome.mmd` | **fonte da verdade do conteúdo**; versionável e revisável em texto | editor de texto, GitHub |
| draw.io (`.drawio.xml`) | `nome.drawio.xml` | **fonte editável gráfica** (formato oficial do repositório) | diagrams.net (web ou desktop) |
| PDF | `nome.pdf` | **exportação para leitura e impressão** (dossiê) | leitor de PDF |

Regras:

1. o `.mmd` manda no **conteúdo**; o `.drawio.xml` e o `.pdf` são o mesmo
   diagrama em formato de edição e de leitura;
2. mudou o conteúdo, mudou o `.mmd` **e** os outros dois (no diagrams.net:
   *Arquivo > Exportar como > PDF* e *Arquivo > Salvar como* `.drawio.xml`);
3. arquivo de **proposta** do Integrante 2 começa com `proposta-I2-` e **não
   substitui** o artefato oficial do Integrante 3 — convém os dois;
4. os PDF exportados usam fonte **Arial** e página com o tamanho do desenho
   (sem margem), para que o diagrama entre legível no dossiê;
5. os diagramas comportamentais da Fase 6 usam **hints de layout** em
   comentários Mermaid, no formato `%% pos: <id> <x> <y>` (posição do centro
   do nó, em pixels). O Mermaid os ignora como comentário — o renderizador
   offline do repositório os usa para posicionar os nós de forma estável.
   O `id` da hint **tem de existir** no diagrama; se não existir, o nó cai no
   posicionamento automático.

## Inventário

| Diagrama | ID | Fonte (`.mmd`) | Editável (`.drawio.xml`) | PDF | Situação |
|---|---|---|---|---|---|
| Contexto | CTX-001 | — (Fase 2) | `Contexto/diagrama-contexto.drawio.xml` | `Contexto/diagrama-contexto.pdf` | reconstrução editável; o PDF original da Fase 2 (`Contexto/Diagrama de contexto fase 2.pdf`) foi preservado |
| Casos de uso | UC-001 | — (Fase 3) | `Casos de uso/Diagrama casos de uso uc001/Diagrama casos de uso uc001 .drawio.xml` | `Casos de uso/Diagrama casos de uso uc001/Cópia de Diagrama casos de uso uc001 .pdf` | oficial do grupo (Fase 3, nomes preservados) |
| Domínio | CLS-DOM | `Dominio/diagrama-dominio.mmd` | `Dominio/diagrama-dominio.drawio.xml` | `Dominio/diagrama-dominio.pdf` | oficial do Integrante 3 |
| Classes | CLS-001 | `Classes/diagrama-classes.mmd` | `Classes/diagrama-classes.drawio.xml` | `Classes/diagrama-classes.pdf` | oficial do Integrante 3 (multiplicidades `PENDENTE`) |
| Objetos | OBJ-001 | `Objetos/diagrama-objetos.mmd` | `Objetos/diagrama-objetos.drawio.xml` | `Objetos/diagrama-objetos.pdf` | oficial do Integrante 3 |
| Sequência — autenticar | SEQ-001 | `Sequências/proposta-I2-sequencia-seq-001-autenticar.mmd` | `Sequências/proposta-I2-sequencia-seq-001-autenticar.drawio.xml` | `Sequências/proposta-I2-sequencia-seq-001-autenticar.pdf` | **proposta** do Integrante 2 (Fase 6) · UC-001 |
| Sequência — agendar | SEQ-002 | `Sequências/proposta-I2-sequencia-seq-002-agendar.mmd` | `Sequências/proposta-I2-sequencia-seq-002-agendar.drawio.xml` | `Sequências/proposta-I2-sequencia-seq-002-agendar.pdf` | **proposta** do Integrante 2 (Fase 6) · UC-025 |
| Sequência — cancelar/confirmar | SEQ-003 | `Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.mmd` | `Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.drawio.xml` | `Sequências/proposta-I2-sequencia-seq-003-cancelar-confirmar.pdf` | **proposta** do Integrante 2 (Fase 6) · UC-027 (+ UC-035 `<<extend>>`) |
| Sequência — lista de espera | SEQ-004 | `Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd` | `Sequências/proposta-I2-sequencia-seq-004-lista-espera.drawio.xml` | `Sequências/proposta-I2-sequencia-seq-004-lista-espera.pdf` | **proposta** do Integrante 2 (Fase 6) · UC-034 a UC-036 (DEC-027) |
| Atividades | ATV-001 | `Atividade/proposta-I2-atividade-atv-001.mmd` | `Atividade/proposta-I2-atividade-atv-001.drawio.xml` | `Atividade/proposta-I2-atividade-atv-001.pdf` | **proposta** do Integrante 2 (Fase 6) |
| Comunicação | COM-001 | `Comunicação/proposta-I2-comunicacao-com-001.mmd` | `Comunicação/proposta-I2-comunicacao-com-001.drawio.xml` | `Comunicação/proposta-I2-comunicacao-com-001.pdf` | **proposta** do Integrante 2 (Fase 6) |
| Estados | EST-001 | `Estados/proposta-I2-estados-est-001.mmd` | `Estados/proposta-I2-estados-est-001.drawio.xml` | `Estados/proposta-I2-estados-est-001.pdf` | **proposta** do Integrante 2 (Fase 6) |

### Especificações dos diagramas comportamentais (Fase 6)

Cada diagrama da Fase 6 tem um texto de especificação com o **mesmo nome-base**,
na mesma pasta:

| Especificação | Arquivo |
|---|---|
| Sequências (SEQ-001/002/003/**004**) | `Sequências/proposta-I2-especificacao-sequencias.md` |
| Atividades (ATV-001) | `Atividade/proposta-I2-especificacao-atividade.md` |
| Comunicação (COM-001) | `Comunicação/proposta-I2-especificacao-comunicacao.md` |
| Estados (EST-001) | `Estados/proposta-I2-especificacao-estados.md` |

Todas as especificações da Fase 6 estão em **v2.0**: abrem com **Objetivo** e
**RFs cobertos** e seguem a ordem do plano §16.1.

Casos de uso novos e revisados (UC-028, UC-033 a UC-037, revisão de UC-025 e
UC-027 e as relações `<<extend>>`/`<<include>>` para o diagrama de casos):
`Casos de uso/proposta-I2-casos-de-uso-faltantes.md`.

Rastreabilidade e revisão da fase: `06-rastreabilidade/matriz-rastreabilidade-fase6.md`
e `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md`.
Texto pronto para as seções 21 a 24 do dossiê: `07-dossie/secoes/fase6-secao-21-24.md`.

## Convenções de leitura

- **Multiplicidades (padrão UML):** a multiplicidade escrita **ao lado de uma
  classe** indica **quantas instâncias dessa classe** se relacionam com **uma
  instância da outra**. Exemplo: `Usuario "0..*" -- "1" Perfil` = *cada conta tem
  exatamente 1 perfil* e *cada perfil atende 0..* contas*.
- **`PENDENTE` não é multiplicidade:** é anotação editorial do Integrante 3
  sobre cardinalidade ainda não fechada. O fechamento proposto na Fase 5 está
  em `01-planejamento/revisoes/FASE5-REV-I2-revisao-modelo-dominio.md` §7.
- **Stereótipos `<<enumeration>>`:** situação de `Usuario`, `Paciente`,
  `Vinculo` e `Agendamento` — os mesmos valores do dicionário de dados.
- **Notas:** caixas amarelas à direita do diagrama, com a referência "Nota para
  `<classe>`"; elas trazem ressalvas de modelagem e não alteram o modelo.
- **Valores fictícios:** todo valor de objeto é inventado
  (`CONTA-FICTICIA-*`, `FAIXA-FICTICIA-*`), conforme DEC-005 — nenhum dado
  real de paciente.
- **Barras de paralelismo (Fase 6):** a forma `[||]` do Mermaid é desenhada
  como **barra vertical** (fork/join) no diagrama de atividades.
- **Formas do diagrama de comunicação (Fase 6):** `[ ]` entidade de domínio,
  `{ }` serviço de aplicação, `( )` fronteira externa (ator ou serviço
  externo).

## Fases 5 e 6 — o que ainda está em aberto

As pastas `Atividade`, `Comunicação`, `Estados` e `Sequências` **não estão mais
vazias**: os **sete** diagramas comportamentais da Fase 6 já foram entregues
(SEQ-001 a **SEQ-004**, ATV-001, COM-001 e EST-001), cada um com `.mmd`,
`.drawio.xml` e `.pdf`.

O grupo decidiu as pendências em 28/10/2026 (DEC-009 a DEC-030). Os itens que
eram do **Integrante 2** — `SOLICITADO`, guarda de cancelamento, notificação
condicional, lista de espera e não comparecimento — foram **propagados aos
diagramas** nesta entrega (v2.0). O que resta depende de outros integrantes;
a lista completa, com dono, está em
[`../01-planejamento/etapas-e-responsabilidades.md`](../01-planejamento/etapas-e-responsabilidades.md).

| Pendência | Efeito nos diagramas | Quem fecha |
|---|---|---|
| Multiplicidades `PENDENTE` e situações do `Agendamento` no diagrama de classes oficial | os diagramas da Fase 6 **não dependem** de multiplicidades; a máquina de estados já usa as 4 situações da DEC-016 | Integrante 3 |
| Operações `OP-01…OP-27`, entidade `SolicitacaoEspera` e fronteira `ServicoListaEspera` (AP-06) fora do CLS-001 | enquanto não houver, os diagramas comportamentais estão apoiados no modelo proposto — ver **LAC-10** | Integrante 3 |
| `Agendamento.confirmar()` ainda declarada no diagrama de classes oficial | contraria a DEC-017 (a criação já nasce confirmada): a operação não é usada por nenhum diagrama da Fase 6 — ver **R6-09** | Integrante 3 |
| Ator "Serviço Externo de E-mail" e relações `<<extend>>`/`<<include>>` no diagrama de casos oficial | as relações estão especificadas, mas não desenhadas no artefato da Fase 3 — ver **LAC-12** | Integrante 3 |
| Tabela `solicitacao_espera` (ordem de entrada, situação, `prazoAceite`) no DER | a SEQ-004 pressupõe persistência da fila — ver **R6-10** | Integrante 4 |
| `CT-033…CT-036` na matriz da Fase 5 | os RFs novos (RF-033 a RF-036) não têm teste conceitual próprio — ver **LAC-11** | Integrante 5 |
| Reserva do slot como mensagem explícita | a reserva é interna a `Agendamento.solicitar` e o **modelo do horário já está decidido** (slot discreto, DEC-018) — ver **LAC-02** | fechada na decisão; incorporação pelo I3 |

**Não são mais pendências** (resolvidas pelo grupo ou por esta entrega):
DEC-009 e DEC-029 (e-mail é o canal, sempre nos três eventos, e a falha não
desfaz a operação), DEC-010 e DEC-027 ("encaixe" substituído pela **lista de
espera**), DEC-011 e DEC-028 (guarda `[antes do horário marcado]`, sem
antecedência mínima e sem cancelamento pelo Administrador), DEC-016 e DEC-017
(o agendamento **nasce `CONFIRMADO`**), DEC-018 (slot discreto), DEC-019
(cardinalidade conta—perfil), DEC-020 (sessão fora do domínio), DEC-022
(`ServicoEnvioMensagem`), DEC-025 (falta manual), DEC-026 (`UC-0RF`),
DEC-030 (atendimento referencia o agendamento) e P-14.

