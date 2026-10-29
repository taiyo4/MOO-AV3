# Referências Normativas e sua Aplicação no Projeto

**Responsável:** Integrante 5 — Franklin Reis (Qualidade, normas e processo)
**Versão:** v0.6 (atualizada até a Fase 6, em 28/10/2026) · **Fecha em:** Fase 8 (seção 29 do dossiê)

O enunciado exige que as normas **não sejam tratadas como simples lista**: o grupo deve mostrar como cada referência influenciou requisitos, modelos, processo, qualidade ou avaliação, e normas retiradas só podem aparecer como referência histórica (barema §12 e §19). Este documento registra, para cada referência, **situação**, **onde foi aplicada** e **evidência no repositório**.

---

## 1. Quadro de situação e aplicação

| Referência | Situação | Para que o projeto usa | Onde foi aplicada (evidência) | Fase |
|---|---|---|---|---|
| ISO/IEC 9126-1:2001 | **Retirada** — uso histórico | Explicar a origem do modelo de qualidade e sua substituição pela família SQuaRE (ISO/IEC 25000) | §2 deste documento; seção 29 do dossiê | 1 |
| ISO/IEC 25010:2023 | Atual | Modelo de qualidade do produto: seleção de características e critérios mensuráveis sobre os modelos | `plano-qualidade-iso25010.md`; classificação dos RNF em `analises/fase-03-verificacao-requisitos.md` §6 | 2, 3, 5, 6 |
| ISO/IEC 25019:2023 | Atual | Qualidade em uso: contexto de uso e resultado esperado por stakeholder | `analises/fase-02-qualidade-visao-escopo-contexto.md` §6 | 2 |
| ISO/IEC 15504 (série) | **Retirada** — uso histórico | Explicar a antecessora da avaliação de processos e sua substituição pela família ISO/IEC 330xx | §2 deste documento; seção 30 do dossiê | 1 |
| Família ISO/IEC 330xx | Atual | Autoavaliação simplificada e baseada em evidências do processo de modelagem | `registro-processo.md` (evidências por fase; escala de atendimento) | 1–6 (registro), 8 (autoavaliação) |
| ISO/IEC/IEEE 12207:2026 | Atual | Nomear os processos do ciclo de vida usados no quadro `Processo → Objetivo → Atividades → Produto → Evidência → Situação → Melhoria` | `registro-processo.md` §2 | 1–6 |
| ISO/IEC/IEEE 29148:2018 | Atual | Qualidade de requisitos (necessário, não ambíguo, verificável, singular, consistente, rastreável) e rastreabilidade | `analises/fase-03-verificacao-requisitos.md`; `02-requisitos/rastreabilidade-inicial.md`; matrizes em `06-rastreabilidade/` | 2, 3, 4 |
| ISO/IEC/IEEE 42010:2022 | Atual | Descrição de arquitetura: stakeholders, *concerns*, *viewpoints* e *views* | Prevista para a Fase 7 (pacotes, componentes e implantação, Integrante 4). Critério preparado em `plano-qualidade-iso25010.md` (CQ-COM e CQ-MAN) | 7 |
| ISO/IEC 19505-2:2012 / UML 2 | Atual | Notação dos diagramas: multiplicidades, `include`/`extend`, composição, estados, fragmentos de sequência | Convenções em `03-uml/README.md`; revisões de notação em `analises/fase-04-*.md` §5, `fase-05-*.md` §2 e §4, `fase-06-*.md` §2 | 4, 5, 6 |

## 2. Normas retiradas: como aparecem no dossiê

| Norma retirada | Texto que o dossiê usa | Texto que o dossiê **não** usa |
|---|---|---|
| ISO/IEC 9126-1:2001 | "Modelo de qualidade histórico, substituído pela família SQuaRE; a ISO/IEC 25010 herdou e reorganizou suas características." | "O projeto segue a ISO/IEC 9126." |
| ISO/IEC 15504 | "Série histórica de avaliação de processos, substituída pela família ISO/IEC 330xx, usada na autoavaliação." | "O processo foi avaliado pela ISO/IEC 15504." |

Regra de verificação (DOD-Q07): antes do congelamento da versão final, uma busca no repositório por `9126` e `15504` deve encontrar essas normas **apenas** em contexto histórico.

## 3. Influência concreta de cada norma atual (resumo para o dossiê e o pitch)

| Norma | Influência concreta no projeto |
|---|---|
| ISO/IEC 25010:2023 | Levou à classificação dos 12 RNF por característica e à identificação de três lacunas (compatibilidade, capacidade de interação e confiabilidade sob concorrência — Q3-07 a Q3-09) |
| ISO/IEC 25019:2023 | Justificou a escolha das características pelo resultado em uso de cada stakeholder (privacidade para o paciente, agenda sem conflito para o psicólogo, trilha para o administrador) |
| ISO/IEC/IEEE 29148:2018 | Orientou a verificação da baseline: 37/37 RF com critério de aceite, termos vagos identificados, cenários negativos ausentes (Q3-02 a Q3-06) |
| ISO/IEC 19505-2 / UML 2 | Sustentou os achados de notação: multiplicidade `PENDENTE` não é multiplicidade UML; ausência de `«extend»` sem justificativa; composição citada e não desenhada (Q4-04, Q5-01, Q5-03) |
| ISO/IEC/IEEE 12207:2026 e ISO/IEC 330xx | Estruturaram o registro de evidências por fase e vão sustentar a autoavaliação da Fase 8 |
| ISO/IEC/IEEE 42010:2022 | Vai orientar a descrição da arquitetura na Fase 7 (views de pacotes, componentes e implantação ligadas a *concerns* de segurança, integração de e-mail e manutenção) |

## 4. Referências completas (formato para a seção 35 do dossiê)

- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC 9126-1:2001** — Software engineering — Product quality — Part 1: Quality model. Genebra: ISO, 2001. (Retirada.)
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC 25010:2023** — Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE) — Product quality model. Genebra: ISO, 2023.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC 25019:2023** — Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE) — Quality-in-use model. Genebra: ISO, 2023.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC 15504-2:2003** — Information technology — Process assessment — Part 2: Performing an assessment. Genebra: ISO, 2003. (Retirada.)
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **Família ISO/IEC 330xx** — Information technology — Process assessment. Genebra: ISO.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC/IEEE 12207:2026** — Systems and software engineering — Software life cycle processes. Genebra: ISO, 2026.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC/IEEE 29148:2018** — Systems and software engineering — Life cycle processes — Requirements engineering. Genebra: ISO, 2018.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC/IEEE 42010:2022** — Software, systems and enterprise — Architecture description. Genebra: ISO, 2022.
- INTERNATIONAL ORGANIZATION FOR STANDARDIZATION. **ISO/IEC 19505-2:2012** — Information technology — Object Management Group Unified Modeling Language (OMG UML) — Part 2: Superstructure. Genebra: ISO, 2012.

Os títulos seguem a lista de referências do enunciado (barema §24). Antes da entrega, o grupo deve conferir o formato exigido pela disciplina (ABNT ou outro).
