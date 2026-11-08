# Próximos passos: Aquiles (Integrante 2)

**Base:** master em 08/11/2026, depois do commit desta revisão.
**Regra:** só mexa nos seus artefatos (`proposta-I2-*`, casos de uso, estados, sequências, atividade, comunicação e textos do contexto). Cite o achado (LAC-12, P10, P12, Q5-09, Q7-04) em cada commit.

## Já feito (não refazer)
- `estaAtivo` trocado por `estaAutorizado` (OP-22 mantido) em `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.{mmd,drawio.xml}`, `proposta-I2-especificacao-sequencias.md`, `03-uml/Comunicação/proposta-I2-comunicacao-com-001.{mmd,drawio.xml}`, `proposta-I2-especificacao-comunicacao.md` e `03-uml/Atividade/proposta-I2-especificacao-atividade.md` (decisão OO-19).
- P12 no texto: `03-uml/Contexto/Interações_Processos.md` diz "Serviço Externo de E-mail (DEC-009, DEC-022, DEC-029)".
- Nome do ator trocado no `03-uml/Contexto/diagrama-contexto.drawio.xml`.

## Passo 1: desenho oficial de casos de uso (LAC-12)
- **Arquivo:** `03-uml/Casos de uso/Diagrama casos de uso uc001/Diagrama casos de uso uc001 .drawio.xml`
- **Acrescentar:** UC-028 e UC-033 a UC-037; o ator "Serviço Externo de E-mail" ligado ao UC-033; `<<include>>` do UC-033 nos casos de confirmação e cancelamento; `<<extend>>` da oferta de vaga ao cancelamento (UC-035).
- **Base:** `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` e `especificacoes-casos-de-uso-demais.md`.
- **Exportar:** PDF no diagrams.net, na mesma pasta, com o nome que já existe (`Cópia de Diagrama casos de uso uc001 .pdf`, ou o nome novo se preferir, atualizando o README).
- **Conferir:** `grep -o "UC-0[23][0-9]" "03-uml/Casos de uso/Diagrama casos de uso uc001/Diagrama casos de uso uc001 .drawio.xml" | sort -u` deve listar UC-028 e UC-033 a UC-037; o PDF mostra o ator.

## Passo 2: alinhar SEQ-004 à classe SolicitacaoEspera (P10, Q5-09)
Hoje a SEQ-004 não bate com o diagrama de classes oficial. Diferenças em `03-uml/Sequências/proposta-I2-sequencia-seq-004-lista-espera.mmd`:

| Na SEQ-004 | Na classe `SolicitacaoEspera` (CLS-001) | O que fazer |
|---|---|---|
| `posicaoNaFila(psicologo, paciente)` [OP-28] | `consultarPosicao() Inteiro` | trocar pelo nome da classe |
| `expirarOferta(prazoAceite)` [OP-27] | `expirar()` | trocar pelo nome da classe |
| `encerrar(ACEITA)`, `encerrar(RECUSADA)` | `aceitar(solicitante)`, `recusar(solicitante)` | trocar por `aceitar` e `recusar` |
| `encerrar(DESISTIU)` | `encerrar(motivo, solicitante)` | ajustar a chamada aos parâmetros |
| `registrarEntrada(psicologo, paciente, periodo)` | `registrarEntrada(psicologo, paciente, horario, solicitante)` | usar `horario` e incluir `solicitante` |
| `proximoDaFila(psicologo)` [OP-24] | não existe | **decidir:** incluir na classe ou manter como operação de `ServicoListaEspera` e registrar isso |
| `validarPrazo()` [OP-26] | não existe | **decidir:** incluir na classe (`prazoAceite` já existe) ou remover a mensagem |

- **Depois:** atualizar as especificações `proposta-I2-especificacao-sequencias.md` (tabela de operações) e `.drawio.xml`.
- **Conferir:** cada mensagem `SolicitacaoEspera` na SEQ-004 aparece em `03-uml/Classes/diagrama-classes.mmd`, ou está registrada como decisão.

## Passo 3: estados da fila (EST-001)
- **Arquivos:** `03-uml/Estados/proposta-I2-especificacao-estados.md` e `proposta-I2-estados-est-001.mmd`.
- **Problema:** o EST-001 só cobre o `Agendamento` (CONFIRMADO, CANCELADO, REALIZADO, NAO_COMPARECEU). A fila de espera não tem máquina de estados.
- **O que fazer:** acrescentar a máquina de `SolicitacaoEspera` com os estados oficiais de CLS-001: AGUARDANDO, OFERTADA, ACEITA, RECUSADA, EXPIRADA, DESISTIU. Transições pela SEQ-004 (`abrirOferta`, `aceitar`, `recusar`, `expirar`, `encerrar`). Pode ser um EST-002 separado, se for mais claro.
- **Conferir:** os mesmos seis nomes aparecem em CLS-001, na SEQ-004, no DDL (`04-persistencia/ddl/schema-mysql.sql`, linhas 443 a 484) e no EST.

## Passo 4: exportar os PDFs que mudaram
- `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.pdf` e `proposta-I2-sequencia-seq-004-lista-espera.pdf`
- `03-uml/Comunicação/proposta-I2-comunicacao-com-001.pdf`
- `03-uml/Contexto/diagrama-contexto.pdf`
- `03-uml/Atividade/proposta-I2-atividade-atv-001.pdf` (se a ATV-001 mudou)
- Os PDFs do EST (passo 3) e do caso de uso (passo 1).
- **Conferir:** abrir cada PDF e procurar `estaAtivo` (não deve aparecer), "Serviço Externo de E-mail" no contexto e os nomes novos da SEQ-004.

## Passo 5: decisão do grupo sobre as propostas I2
- SEQ-001 a SEQ-004, ATV-001, COM-001 e EST-001 aparecem como "proposta" em `03-uml/README.md` (linhas 41 a 47).
- **Ação:** levar a lista ao Pinho para aprovar. Depois de aprovado, trocar o status para "oficial" no README e nos arquivos. Não renomeie antes da aprovação.

## Passo 6: seção 27 do dossiê, junto com a Andressa
- **Arquivo:** `07-dossie/secoes/fase5-secao-18-20-27.md` (e `07-dossie/dossie.md`, que sai da regeração).
- **O que mudar:** "doze classes" vira 13 (contagem em `03-uml/Classes/decisoes-modelagem.md`, linha 127). Confirmar com a Andressa os itens da seção 27 (Q5-03, Q5-07, Q5-10).
- **Conferir:** `grep -n "doze" 07-dossie/secoes/fase5-secao-18-20-27.md` volta vazio.

## Passo 7: fechar e avisar
- Commit sugerido: `docs(uml): casos de uso oficiais UC-028/033 a 037, SEQ-004 alinhada à classe, estados da fila (LAC-12, P10, P12)`.
- Depois avise o Pinho. Ele registra no I5 (`05-qualidade/analises/`).
- **Depende de outros:** a SEQ-004 depende das decisões de `proximoDaFila` e `validarPrazo` com a Andressa; a seção 27 depende dela também.
