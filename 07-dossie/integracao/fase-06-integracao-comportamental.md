# Fase 6 — Integração dos Diagramas Comportamentais (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Fase do plano:** Fase 6 — Diagramas comportamentais
**Data deste registro:** 28/10/2026 · **Versão:** v1.0
**Insumos:** `07-dossie/secoes/fase6-secao-21-24.md` e sua "Nota de consolidação para o Integrante 6"; `01-planejamento/revisoes/FASE6-REV-I2-revisao-comportamental.md` (§10, item "Integrante 6 insere no dossiê as seções 21 a 24"); `05-qualidade/analises/fase-06-revisao-cruzada-comportamental.md`; `06-rastreabilidade/`.

---

## 1. Atendimento à nota de consolidação do Integrante 2

| Pedido do Integrante 2 | Atendimento |
|---|---|
| 1. Inserir as seis figuras nas seções 21 a 24 mantendo os identificadores nas legendas | Seções 21 a 24 integradas com os identificadores SEQ-001, SEQ-002, SEQ-003, COM-001, ATV-001 e EST-001 e a referência a cada `.pdf`. Na versão Markdown, a figura é o PDF referenciado; a imagem embutida entra na exportação final do dossiê (Fase 9) |
| 2. Conservar as ressalvas de estado ("proposta em revisão") | Mantidas. Como DEC-009, DEC-011, DEC-016, DEC-017 e DEC-025 foram aprovadas depois do texto, as notas de integração indicam o que já não é pendente e o que diverge |
| 3. Remeter as lacunas à seção de revisões/decisões | Feito na seção 32 (divergências abertas de maior impacto) |
| 4. Não inserir PNG/SVG separados | Respeitado |
| 5. Conferências automáticas da Fase 6 | Registradas pelo Integrante 2; o Integrante 6 conferiu que os 18 arquivos (6 × `.mmd`, `.drawio.xml`, `.pdf`) existem com o mesmo nome-base |

## 2. Demais integrações desta fase

| Item | Resultado |
|---|---|
| Dossiê único montado pela primeira vez (`07-dossie/dossie.md`, v0.6) | 36 seções: 1 a 24 e 27 com conteúdo; 25, 26 e 28 a 36 com estrutura e texto disponível |
| Script de montagem (`07-dossie/montar-dossie.py`) | Gera as tabelas de requisitos da baseline e aplica as notas de integração |
| README raiz atualizado (fase atual, mapa do repositório, situação das entregas) | Feito |
| `07-dossie/README.md`, `06-rastreabilidade/README.md`, `08-pitch/README.md` com índice | Feito |
| `01-planejamento/equipe.md` com nomes | Feito (INT-01) |
| Banco de pontos do pitch e roteiro preliminar | `08-pitch/banco-de-pontos-pitch.md` |

## 3. Achados de integração

| ID | Achado | Responsável | Tratamento |
|---|---|---|---|
| INT-11 | Seções 21 a 24, SEQ-002 e EST-001 usam `SOLICITADO`, guarda `[prazo]` da DEC-012 e notificação condicional; contrariam DEC-016, DEC-011 e DEC-009 aprovadas em 25/10/2026 (Q6-01 a Q6-04) | Integrante 2 | Notas de integração nas seções 21 a 24; item 1 da seção 32 |
| INT-12 | RF-033 a RF-037 (25/10/2026) não aparecem nas matrizes das Fases 5 e 6; a inovação não tem diagrama comportamental (Q6-05) | Integrantes 1 e 2 | Seção 31 registra a lacuna; a matriz final (Fase 8) deve incluí-los |

## 4. Situação ao final da Fase 6

O dossiê existe como documento único e reflete o estado real do repositório: o que está aprovado, o que é proposta e onde os textos de origem ficaram atrás das decisões. As correções de conteúdo cabem aos autores; quando forem feitas, basta remover a nota correspondente em `NOTAS_INTEGRACAO` e rodar o script de montagem.

## 5. Pontos para o pitch (Fase 6)

Registrados em `08-pitch/banco-de-pontos-pitch.md` (parte "Modelagem" — sequência e estados).
