# Fase 1 — Análise Inicial de Qualidade, Normas e Processo (Integrante 5)

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Fase do plano:** Fase 1 — Organização inicial (repositório, papéis, planejamento)
**Data deste registro:** 28/10/2026 · **Versão:** v1.0
**Registro de recuperação:** as atividades do Integrante 5 nas Fases 1 a 6 foram registradas no repositório em 28/10/2026, depois do período original de cada fase. Não há registro retroativo de participação: as datas dos documentos são as datas reais de versionamento, e cada análise foi feita sobre o estado do repositório em 28/10/2026, considerando as decisões formalizadas até 25/10/2026.

---

## 1. Papel do Integrante 5

Responsável por **qualidade, normas e processo** na Plataforma para Psicólogos (AV3 — MOO). Na prática, isso significa três frentes que percorrem todas as fases:

| Frente | O que o Integrante 5 faz | Onde fica a evidência |
|---|---|---|
| Qualidade do produto modelado | Converter características da ISO/IEC 25010:2023 em critérios verificáveis sobre os artefatos (requisitos, UML, persistência, arquitetura) | `05-qualidade/plano-qualidade-iso25010.md` |
| Normas e referências | Classificar cada norma do enunciado como **atual** ou **retirada**, registrar como ela influencia o projeto e impedir que norma retirada apareça como referência vigente | `05-qualidade/normas-referencias.md` |
| Processo | Registrar, fase a fase, as evidências do processo de modelagem para a autoavaliação simplificada baseada na ISO/IEC/IEEE 12207 e na família ISO/IEC 330xx | `05-qualidade/registro-processo.md` |

O Integrante 5 também faz a **revisão cruzada de qualidade** dos artefatos de cada fase. A revisão não altera o artefato do outro integrante: ela registra achados com identificador próprio (`Q<fase>-<nn>`) e endereça cada um ao responsável.

## 2. Artefatos sob responsabilidade do Integrante 5

| Artefato | Fase em que nasce | Fase em que fecha |
|---|---|---|
| Análise de qualidade por fase (`analises/fase-0N-*.md`) | Fases 1 a 6 (este conjunto) | Fase 8 |
| Referências normativas e sua aplicação | Fase 1 | Fase 8 (seção 29 do dossiê) |
| Plano de qualidade ISO/IEC 25010:2023 | Fase 2 (seleção preliminar) | Fase 8 (seção 28 do dossiê) |
| Registro de processo e evidências | Fase 1 | Fase 8 (seção 30 do dossiê — autoavaliação) |
| Verificação final da matriz de rastreabilidade (sem órfãos) | Fase 3 (critério) | Fase 8 |

Nenhum artefato definitivo de qualidade é congelado antes da Fase 8, conforme o cronograma (`01-planejamento/cronograma.md`: "Qualidade e rastreabilidade — 10/11 a 16/11").

## 3. Dependências com os outros integrantes

| Integrante | O que o Integrante 5 recebe | O que o Integrante 5 devolve |
|---|---|---|
| 1 — Coordenação e requisitos | Baseline RF/RNF/RN/CA, decisões (`decisoes.md`) | Verificação de qualidade dos requisitos (ISO/IEC/IEEE 29148); proposta de métricas para RNF sem valor (ex.: RNF-010) |
| 2 — Casos de uso e comportamento | Casos de uso, especificações, diagramas comportamentais, matrizes de fase | Revisão cruzada (Definition of Done) dos artefatos de casos de uso e comportamento |
| 3 — Modelo OO e domínio | Domínio, classes, objetos | Revisão cruzada sob manutenibilidade, coesão/acoplamento e conformidade UML |
| 4 — Persistência e arquitetura | Análises de persistência, DER e arquitetura (Fase 7) | Critérios de segurança, confiabilidade, compatibilidade e manutenibilidade aplicáveis ao DER e aos componentes |
| 6 — Documentação, integração e pitch | Estrutura do dossiê e do repositório | Texto das seções 28 (qualidade), 29 (normas) e 30 (processo) e pontos de qualidade para o pitch |

## 4. Normas do enunciado e classificação inicial

O enunciado (barema, §12 e §24) exige que as normas **não sejam lista decorativa** e que normas retiradas apareçam apenas como referência histórica. Classificação adotada desde a Fase 1:

| Referência | Situação | Uso no projeto |
|---|---|---|
| ISO/IEC 9126-1:2001 | **Retirada** | Somente histórico: origem do modelo de qualidade que evoluiu para a família SQuaRE (25000) |
| ISO/IEC 25010:2023 | Atual | Modelo de qualidade do produto; base do plano de qualidade |
| ISO/IEC 25019:2023 | Atual | Qualidade em uso; apoia a análise de valor para os stakeholders |
| ISO/IEC 15504 | **Retirada** (série) | Somente histórico: antecessora da família 330xx |
| Família ISO/IEC 330xx | Atual | Autoavaliação simplificada de processo, baseada em evidências |
| ISO/IEC/IEEE 12207:2026 | Atual | Estrutura dos processos do ciclo de vida usados no quadro de processo |
| ISO/IEC/IEEE 29148:2018 | Atual | Qualidade e rastreabilidade de requisitos |
| ISO/IEC/IEEE 42010:2022 | Atual | Descrição de arquitetura (stakeholders, concerns, viewpoints, views) — Fase 7 |
| ISO/IEC 19505-2:2012 / UML 2 | Atual | Notação UML de todos os diagramas |

Detalhamento e aplicação por fase: [`../normas-referencias.md`](../normas-referencias.md).

## 5. Critérios de qualidade mínimos para todo artefato (Definition of Done de qualidade)

Critérios adotados desde a Fase 1 e aplicados nas revisões das fases seguintes. Eles derivam do barema (§9, §19 e §21) e não substituem a aprovação do grupo.

| ID | Critério | Origem |
|---|---|---|
| DOD-Q01 | Todo elemento tem identificador estável (RF, RNF, RN, CA, HU, UC, SEQ, EST, DEC, PG…) e nenhum identificador é reutilizado ou renumerado | barema §21; `PLANEJAMENTO_AV3` §6 |
| DOD-Q02 | Todo artefato referencia os requisitos/decisões de que depende | barema §9 regra 2 |
| DOD-Q03 | Decisão não aprovada aparece como **proposta** ou **pendência**, nunca como decisão | `decisoes.md` |
| DOD-Q04 | Diagrama tem fonte editável e exportação legível no repositório | barema §19 |
| DOD-Q05 | Nenhum dado real de paciente e nenhuma senha em texto puro | DEC-005, RES-001, RES-002 |
| DOD-Q06 | Mudança em um artefato gera revisão dos artefatos relacionados | barema §9 regra 10 |
| DOD-Q07 | Norma retirada nunca é citada como referência vigente | barema §12, §19 |
| DOD-Q08 | O artefato foi revisado por pelo menos um integrante diferente do autor | DEC-004 (revisão cruzada) |

## 6. Riscos iniciais de qualidade e processo

| ID | Risco | Efeito | Tratamento |
|---|---|---|---|
| RQ-01 | Diagramas sem relação entre si | Perda de pontuação (barema §19) | Matriz de rastreabilidade por fase + revisão cruzada |
| RQ-02 | Normas apresentadas como lista decorativa | Perda em "Qualidade, normas e consistência" e em "Processo, qualidade e referências" | `normas-referencias.md` registra **onde** cada norma influenciou o projeto |
| RQ-03 | Decisões do grupo combinadas por mensagem e não registradas | Artefatos divergentes; pitch incoerente | Registro em `decisoes.md` antes de propagar (regra do `PLANEJAMENTO_AV3` §6) |
| RQ-04 | Entrada tardia de integrantes e concentração de trabalho | Falta de revisão cruzada; risco ao relatório de funções | Registro de processo com situação real e melhoria proposta |
| RQ-05 | RNF sem métrica | Critério não verificável | Plano de qualidade propõe métrica ou critério de inspeção |

## 6.1 Como a revisão, as evidências e as melhorias são registradas

O plano de execução pede que a Fase 1 defina esse registro. Fluxo adotado:

| Passo | Quem | Registro |
|---|---|---|
| 1. Revisão do artefato de uma fase | Integrante 5 | Documento `analises/fase-0N-*.md`, com achados `Q<fase>-<nn>`, responsável sugerido e critério violado (DOD-Qnn ou barema) |
| 2. Correção | Responsável pelo artefato (nunca o Integrante 5 nem o 6, que não corrigem em silêncio) | Commit do responsável citando o achado (`Q5-02`) |
| 3. Confirmação | Integrante 5 | Coluna "Situação" da tabela de controle de achados (`Aberto`, `Corrigido`, `Justificado`) em cada análise |
| 4. Evidência de processo | Integrante 5 | Linha da fase em `registro-processo.md` §1, com o commit |
| 5. Melhoria | Integrante 5 | Coluna "Melhoria proposta" do quadro de processo e lições aprendidas |

Gate de qualidade: fase só é dada como fechada pelo Integrante 5 quando não há achado crítico `Aberto` sem justificativa registrada.

## 7. Situação ao final da Fase 1

- Papel compreendido e frentes de trabalho definidas.
- Normas classificadas como atuais ou retiradas.
- Critérios mínimos de qualidade (DOD-Q01 a DOD-Q08) definidos para uso nas revisões das Fases 2 a 6.
- Pasta `05-qualidade/` organizada em `analises/` (uma análise por fase) e documentos transversais.
