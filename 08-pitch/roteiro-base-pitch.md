# Roteiro-base do pitch (v0.1, 03/11/2026)

**Natureza:** esqueleto para o Integrante 6 fechar na Fase 9. Reúne o roteiro preliminar do `banco-de-pontos-pitch.md`, as falas do Integrante 2 (`proposta-I2-pontos-pitch.md`) e as do Integrante 4 (`04-persistencia/analises/fase-09-encerramento-e-pitch.md` §4). Nada aqui é número novo: tudo vem desses arquivos. Itens `[CONFIRMAR]` dependem do grupo ou do fechamento do modelo.
**Regra do barema:** pelo menos dois integrantes falando e defendendo partes diferentes; o vídeo mostra exatamente a versão entregue do dossiê (coerência entre dossiê e pitch).
**Duração total:** `[CONFIRMAR]` (o enunciado não fixa no que está no repositório). Os tempos abaixo são relativos, para ajustar depois.

## 1. Ordem, tela e quem fala (sugestão por responsabilidade)

| # | Parte | O que dizer (fonte) | Tela | Quem fala (sugestão) |
|---|---|---|---|---|
| 1 | Abertura | nome, integrantes, problema em uma frase (seção 1 do dossiê) | capa do dossiê | Integrante 1 |
| 2 | Contexto | usuários e por que modelar antes de programar (CTX-001) | CTX-001 | Integrante 1 |
| 3 | Solução e inovação | módulos e lista de espera inteligente (Bloco B do I2) | seção 6 do dossiê; SEQ-004 | Integrante 2 |
| 4a | Modelagem: comportamento | Bloco A do I2: quatro sequências, agendamento nasce `Confirmado` | SEQ-002; EST-001 | Integrante 2 |
| 4b | Modelagem: domínio | classes, objetos, OO e SOLID (seção 27) | CLS-001; OBJ-001 | Integrante 3 `[CONFIRMAR: falas ainda não escritas]` |
| 4c | Arquitetura e persistência | quatro falas do I4 (§4.1 da fase 9) e fechamento de 15 s | PAC-001; CMP-001; DER-001 | Integrante 4 |
| 5 | Qualidade | Bloco C do I2 + matriz sem órfãos, ISO 25010, normas atuais × retiradas | matriz final; plano de qualidade | Integrante 5 `[CONFIRMAR: quem apresenta]` |
| 6 | Decisões | duas ou três alternativas descartadas: estado `SOLICITADO`, prazo de 2 h (DEC-012), herança de usuário, **oferta como classe** (virou situação `OFERTADA`) | seção 10 do dossiê | Integrante 1 |
| 7 | Encerramento | valor para a implementação, limitações e próximos passos | seções 33 e 34 | Integrante 6 |

## 2. Antes de gravar (checagem de coerência)

- [ ] Diagrama de classes oficial já sem `OfertaVaga` e com A01 e A17 corrigidas (Q5-11, Q5-13); só então mostrar CLS-001 na tela.
- [ ] PDFs de pacotes, componentes e implantação exportados (Q7-01); até lá não dizer que os PDFs estão no dossiê.
- [ ] DDL executado no MySQL (Q7-02); até lá dizer "revisado linha a linha", não "validado".
- [ ] Números de rastreabilidade e qualidade na versão final (hoje v0.7: 37 de 37 RF, 17 de 17 RN, medição ISO parcial).
- [ ] Testes conceituais completos (15 de 37 escritos hoje; modelos em `06-rastreabilidade/modelos-testes-conceituais-fase8.md`). Não dizer "37 testes" antes disso.
- [ ] Dossiê regerado e o vídeo mostrando exatamente essa versão.

## 3. O que não dizer

| Não dizer | Dizer no lugar |
|---|---|
| que todos os diagramas oficiais incorporam OP-01 a OP-28 | só depois que o I3 fechar as classes |
| que a oferta de vaga é uma classe | a oferta é a situação `OFERTADA` da `SolicitacaoEspera` (decisão de 03/11/2026) |
| que a arquitetura está "sem ciclo" entre pacotes | há o par `AGENDA` ⇄ `FILA` (Q8-07); só dizer depois que o Integrante 4 resolver |
| que os achados Q de uma fase estão fechados | só depois que o I5 marcar Corrigido |
| nomes de tabela errados (`auditoria`, `fila`, campo `status`) | `registro_auditoria`, `solicitacao_espera`, `situacao` |
| mostrar tela de sistema ou código | o produto é um dossiê de modelagem |

## 4. Perguntas prováveis

Usar as tabelas já escritas: I2 em `proposta-I2-pontos-pitch.md` §4 e I4 em `fase-09-encerramento-e-pitch.md` §4.3. Faltam perguntas do domínio (Integrante 3) e de qualidade/processo (Integrante 5): `[PREENCHER]`.

## 5. Gravação (da Fase 9)

Roteiro final, ensaio, gravação e revisão do vídeo: Integrante 6 com pelo menos dois integrantes falando. Testar áudio, links e permissões antes de enviar.
