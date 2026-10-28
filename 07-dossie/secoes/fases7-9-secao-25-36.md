# Dossiê — Seções 25, 26 e 28 a 36 (estrutura e texto disponível até a Fase 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Data:** 28/10/2026 · **Versão:** v0.6
**Uso:** estrutura das seções que fecham nas Fases 7 a 9. O que já pode ser escrito com base nos artefatos das Fases 1 a 6 está escrito; o que depende de artefato ainda não produzido está marcado como **a produzir**, com o responsável e a fonte. As seções 28 a 30 resumem os documentos do Integrante 5 em `05-qualidade/`.

---

## 25. Arquitetura: pacotes, componentes e implantação

**Situação:** a produzir na Fase 7 (03/11 a 09/11) pelo Integrante 4, seguindo a ISO/IEC/IEEE 42010:2022.

Insumos já disponíveis:

- exigências arquiteturais `ARQ-01` a `ARQ-08` e impactos nos componentes `IMP-CMP-01` a `IMP-CMP-09` (`04-persistencia/analises/fase-06-impacto-comportamental-persistencia.md` §4.2 e §6.2);
- serviços de aplicação e fronteiras propostos na Fase 5 (`AP-01` a `AP-05`, entre eles o serviço de agenda e a interface de notificação) e interfaces de infraestrutura `IR-xx` citadas na matriz da Fase 6;
- integração externa aprovada: Serviço Externo de E-mail (DEC-009), que deve aparecer no diagrama de componentes e no de implantação (`PLANEJAMENTO_AV3` §6 regra 7);
- critérios de qualidade aplicáveis: CQ-COM-01, CQ-COM-02 e CQ-FLE-03 (`05-qualidade/plano-qualidade-iso25010.md`).

Estrutura prevista para cada diagrama (mesma das seções 18 a 24): identificação e objetivo, elementos principais, como interpretar, decisões, relação com requisitos/classes/banco, arquivos.

## 26. Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional

**Situação:** a produzir na Fase 7 pelo Integrante 4.

Insumos já disponíveis: revisão de dados por caso de uso (Fase 4), viabilidade de persistência do domínio com `INC-01` a `INC-13` e `P-01` a `P-19` (Fase 5), impactos no DER `IMP-DER-01` a `IMP-DER-10` e exigências transacionais `TRS-01` a `TRS-06` (Fase 6), todos em `04-persistencia/analises/`.

Condições para fechar sem divergência (achados de integração e de qualidade):

- usar a numeração oficial de requisitos de `02-requisitos/` (Q3-11);
- a coluna de situação do agendamento aceita apenas `CONFIRMADO`, `CANCELADO`, `REALIZADO` e `NAO_COMPARECEU` (DEC-016; sem `SOLICITADO`);
- a lista de espera, se persistida, precisa de classe correspondente (Q5-05);
- FKs e cardinalidades derivadas de um único diagrama de classes oficial (Q5-01).

## 28. Plano de qualidade (ISO/IEC 25010:2023)

**Situação:** versão preliminar v0.6; fecha na Fase 8 (Integrante 5).

O plano seleciona **sete características** — Segurança, Adequação funcional, Confiabilidade, Manutenibilidade, Flexibilidade, Compatibilidade e Capacidade de interação — e as converte em **31 critérios verificáveis** sobre o modelo (inspeção de artefato ou contagem no repositório). Medição em 28/10/2026: 18 critérios atendidos, 2 parciais, 6 não atendidos e 5 pendentes de decisão ou de artefato da Fase 7.

Os critérios não atendidos têm três causas: decisões de 25/10/2026 ainda não propagadas aos diagramas, casos de uso faltando para os requisitos novos (inclusive a inovação) e ausência de requisito de prevenção de erro do usuário.

Texto completo: `05-qualidade/plano-qualidade-iso25010.md`.

## 29. Normas aplicadas

**Situação:** v0.6; fecha na Fase 8 (Integrante 5).

| Referência | Situação | Influência no projeto |
|---|---|---|
| ISO/IEC 9126-1:2001 | Retirada (histórico) | Origem do modelo de qualidade, substituído pela família SQuaRE |
| ISO/IEC 25010:2023 | Atual | Classificação dos RNF, sete características e 31 critérios do plano |
| ISO/IEC 25019:2023 | Atual | Contexto de uso e resultado esperado por stakeholder |
| ISO/IEC 15504 | Retirada (histórico) | Antecessora da avaliação de processos, substituída pela família 330xx |
| Família ISO/IEC 330xx | Atual | Escala N-P-L-F do registro de processo e da autoavaliação |
| ISO/IEC/IEEE 12207:2026 | Atual | Processos do quadro de autoavaliação |
| ISO/IEC/IEEE 29148:2018 | Atual | Verificação da baseline de requisitos e rastreabilidade |
| ISO/IEC/IEEE 42010:2022 | Atual | Descrição da arquitetura (Fase 7) |
| ISO/IEC 19505-2:2012 / UML 2 | Atual | Notação de todos os diagramas e achados de notação |

Texto completo: `05-qualidade/normas-referencias.md`.

## 30. Autoavaliação do processo

**Situação:** registro de evidências v0.6; autoavaliação final na Fase 8 (Integrante 5), revisada por mais um integrante.

O quadro `Processo → Objetivo → Atividades → Produto de trabalho → Evidência → Situação → Melhoria proposta` está em `05-qualidade/registro-processo.md`, com onze processos da ISO/IEC/IEEE 12207 e situação na escala N-P-L-F. Até a Fase 6: definição de necessidades **F**; planejamento, requisitos, modelagem, configuração, verificação e decisões **L**; gestão de mudanças, validação, documentação e lições aprendidas **P**.

Lições aprendidas até a Fase 6: consenso por mensagem precisa virar decisão registrada no mesmo dia; propostas paralelas precisam de dono para a escolha; revisão cruzada precisa de revisor nomeado; integração documental deve ser contínua.

## 31. Matriz de rastreabilidade

**Situação:** matrizes por fase disponíveis; matriz final na Fase 8.

| Matriz | Conteúdo | Arquivo |
|---|---|---|
| Inicial (Fase 3) | RF → RN/RNF → ator → caso de uso → CA → HU → decisão | `02-requisitos/rastreabilidade-inicial.md` |
| Fase 5 (mestra até aqui) | RF → RN/RNF → UC → classe → operação → sequência → tabela → teste conceitual | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` |
| Fase 6 (complementar) | RF/RN/UC × SEQ/ATV/COM/EST; mensagens × operações; verificação de órfãos | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` |
| Final (Fase 8) | Requisito, caso de uso, classe, interação, persistência, qualidade e teste conceitual, sem órfãos | `06-rastreabilidade/matriz-rastreabilidade-final.md` (a produzir) |

Decisão do Integrante 5 sobre o formato: as matrizes das Fases 5 e 6 continuam como estão até a Fase 7 e depois viram apêndices históricos da matriz final (`05-qualidade/analises/fase-06-revisao-cruzada-comportamental.md` §5). RF-033 a RF-037 ainda não estão nas matrizes das Fases 5 e 6.

## 32. Verificação de consistência e revisões

Revisões registradas até a Fase 6:

| Revisão | Autor | Arquivo | Identificadores |
|---|---|---|---|
| Casos de uso futuros (Fase 3) | Integrante 2 | `03-uml/Casos de uso/CasosDeUsoFuturo.md` | — |
| Revisão de dados por caso de uso (Fase 4) | Integrante 4 | `04-persistencia/analises/fase-04-*.md` | — |
| Modelo de domínio (Fase 5) | Integrante 2 | `01-planejamento/revisoes/FASE5-REV-I2-*.md` | R5-01 a R5-17 |
| Viabilidade de persistência (Fase 5) | Integrante 4 | `04-persistencia/analises/fase-05-*.md` | INC-01 a INC-13, P-01 a P-19 |
| Diagramas comportamentais (Fase 6) | Integrante 2 | `01-planejamento/revisoes/FASE6-REV-I2-*.md` | R6-01 a R6-08, LAC-01 a LAC-09 |
| Impacto comportamental (Fase 6) | Integrante 4 | `04-persistencia/analises/fase-06-*.md` | DEP, TRS, ARQ, IMP-DER, IMP-CMP |
| Qualidade das Fases 2 a 6 (revisão cruzada) | Integrante 5 | `05-qualidade/analises/` | Q2-01 a Q6-07 |
| Integração das Fases 1 a 6 | Integrante 6 | `07-dossie/integracao/` | INT-01 a INT-12 |

Divergências abertas de maior impacto (precisam ser fechadas antes da Fase 7):

1. `SOLICITADO` ainda aparece na máquina de estados, na sequência SEQ-002, na proposta de classes v2 e nas seções 19, 21 e 24, contra DEC-016 (Q5-02, Q6-01).
2. A lista de espera (DEC-010) não tem caso de uso, classe nem diagrama comportamental (Q4-03, Q5-05, Q6-05).
3. O diagrama de classes oficial tem multiplicidades `PENDENTE`; a proposta com multiplicidades não foi adotada (Q5-01).
4. Contexto, casos de uso e textos das Fases 5 e 6 ainda tratam DEC-009 como pendente (Q2-01, Q4-05, Q5-06, Q6-04).

## 33. Conclusão

**Situação:** a redigir na Fase 9 (Integrante 6 com todos), depois do congelamento da versão. Deve responder à questão norteadora do enunciado (§22) com base nos números finais de cobertura, rastreabilidade e qualidade.

## 34. Limitações e próximos passos

Limitações conhecidas até a Fase 6 (a revisar na Fase 9):

- decisões de 28/10/2026 (DEC-027 a DEC-030) ainda não propagadas aos diagramas, à persistência e às seções 18 a 24;
- RNF-010 sem métrica de desempenho;
- o modelo não cobre prontuário clínico, pagamentos nem teleconsulta, por decisão de escopo (DEC-008).

## 35. Referências

Referências normativas completas em `05-qualidade/normas-referencias.md` §4 (ISO/IEC 9126-1:2001 — retirada; ISO/IEC 25010:2023; ISO/IEC 25019:2023; ISO/IEC 15504-2:2003 — retirada; família ISO/IEC 330xx; ISO/IEC/IEEE 12207:2026; ISO/IEC/IEEE 29148:2018; ISO/IEC/IEEE 42010:2022; ISO/IEC 19505-2:2012). Documento-base: enunciado e barema da AV3 (Prof. MSc. Celso Barreto, UNIJORGE). Outras referências bibliográficas que o grupo usar devem ser acrescentadas aqui até a Fase 9.

## 36. Anexos

| Anexo | Conteúdo | Local |
|---|---|---|
| A | Fontes editáveis e PDFs de todos os diagramas | `03-uml/` (inventário em `03-uml/README.md`) |
| B | Baseline completa de requisitos | `02-requisitos/` |
| C | Registro de decisões e pendências | `01-planejamento/decisoes.md` |
| D | Revisões e análises por fase | `01-planejamento/revisoes/`, `04-persistencia/analises/`, `05-qualidade/analises/`, `07-dossie/integracao/` |
| E | Matrizes de rastreabilidade | `02-requisitos/rastreabilidade-inicial.md`, `06-rastreabilidade/` |
| F | Relatório de função e atuação dos integrantes | a incluir na Fase 9 (ver seção 3) |
