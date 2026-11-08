# Próximos passos: Aquiles (Integrante 2)

**Base:** master em 08/11/2026, depois do commit desta rodada.
**Regra:** só mexa nos seus artefatos (`proposta-I2-*`, casos de uso e contexto). Cite o achado (ex.: LAC-12, P10, P12) em cada commit.

## Já feito nesta rodada (não refazer)
- `estaAtivo` trocado por `estaAutorizado` (OP-22 mantido) em `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.*`, `03-uml/Comunicação/proposta-I2-comunicacao-com-001.*`, `proposta-I2-especificacao-sequencias.md`, `proposta-I2-especificacao-comunicacao.md` e `03-uml/Atividade/proposta-I2-especificacao-atividade.md`. Decisão OO-19.
- P12 no texto: `03-uml/Contexto/Interações_Processos.md` agora diz "Serviço Externo de E-mail (DEC-009, DEC-022, DEC-029)".
- Ator renomeado para "Serviço Externo de E-mail" em `03-uml/Contexto/diagrama-contexto.drawio.xml` (o PDF ainda é antigo).

## Passo 1: desenho oficial de casos de uso (LAC-12, Q7-04)
- **Arquivo:** `03-uml/Casos de uso/Diagrama casos de uso uc001/Diagrama casos de uso uc001 .drawio.xml`
- **O que mudar:** acrescentar UC-028 e UC-033 a UC-037; o ator "Serviço Externo de E-mail" ligado a UC-033; `<<include>>` do UC-033 nos casos de confirmação e cancelamento; `<<extend>>` da oferta de vaga ao cancelamento (UC-035).
- **Base:** `03-uml/Casos de uso/proposta-I2-casos-de-uso-faltantes.md` e `especificacoes-casos-de-uso-demais.md`.
- **Exportar:** PDF pelo diagrams.net na mesma pasta (ferramenta externa, por isso fica com você).
- **Conferir:** `grep -c "UC-03[3-7]\|UC-028" "03-uml/Casos de uso/Diagrama casos de uso uc001/"*.drawio.xml` deve contar os UCs novos; o PDF deve mostrar o ator.

## Passo 2: exportar os PDFs que mudaram nesta rodada
- `03-uml/Sequências/proposta-I2-sequencia-seq-002-agendar.pdf`
- `03-uml/Comunicação/proposta-I2-comunicacao-com-001.pdf`
- `03-uml/Contexto/` (diagrama de contexto, com o ator novo)
- **Conferir:** abrir o PDF e procurar `estaAutorizado` e "Serviço Externo de E-mail".

## Passo 3: decisão do grupo sobre as propostas I2
- Hoje SEQ-001 a SEQ-004, ATV-001, COM-001 e EST-001 aparecem como "proposta" em `03-uml/README.md` (linhas 41 a 47).
- **Ação:** levar a lista ao Pinho para aprovar. Depois de aprovado, trocar o status para "oficial" no README e nos arquivos. Não renomeie sem aprovação.

## Passo 4: seção 27 do dossiê, junto com a Andressa
- **Arquivo:** `07-dossie/secoes/fase5-secao-18-20-27.md`
- **O que mudar:** o texto diz "doze classes"; o modelo final tem 13 (ver `03-uml/Classes/decisoes-modelagem.md`, linha 127). Confira com a Andressa a lista da seção 27 (Q5-03, Q5-07, Q5-10).
- **Conferir:** `grep -n "doze" 07-dossie/secoes/fase5-secao-18-20-27.md` deve voltar vazio.

## Passo 5: conferir SEQ-004 depois do ciclo de pacotes
- Os nomes de SEQ-004 já batem com `SolicitacaoEspera` (`abrirOferta`, `aceitar`, `recusar`, `expirar`, `consultarPosicao`).
- **Ação:** confirmar só depois que o Caio decidir o ciclo AGENDA/FILA (Q8-07), porque UC-035 e UC-036 dependem disso.

## Como avisar que terminou
Mande os arquivos novos no commit com a mensagem `docs(uml): casos de uso oficiais UC-028/033 a 037 e contexto (LAC-12, P10, P12)`. Depois avise o Pinho para o I5 conferir Q7-04 e P10.
