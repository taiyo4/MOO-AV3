# Dossiê — Seções 25, 26 e 28 a 36 (texto disponível até a Fase 7)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Data:** 30/10/2026 · **Versão:** v0.7
**Uso:** estrutura das seções que fecham nas Fases 7 a 9. O que já pode ser escrito com base nos artefatos das Fases 1 a 6 está escrito; o que depende de artefato ainda não produzido está marcado como **a produzir**, com o responsável e a fonte. As seções 28 a 30 resumem os documentos do Integrante 5 em `05-qualidade/`.

---

## 25. Arquitetura: pacotes, componentes e implantação

**Situação:** rascunho v0.7 (30/10/2026), montado pelo Integrante 6 a partir dos artefatos do Integrante 4 (entregues em 29/10/2026). O Integrante 4 deve revisar o texto; o PDF dos três diagramas está pendente (Q7-01). Norma: ISO/IEC/IEEE 42010:2022.

**Estilo.** Arquitetura em camadas com inversão de dependência: `apresentação → aplicação → domínio ← infraestrutura`. A aplicação não conhece a infraestrutura; depende das interfaces de repositório e de `ServicoEnvioMensagem`, ambas no domínio (DEC-022). O pacote de configuração liga as pontas.

| Diagrama | ID | Fonte | O que mostra |
|---|---|---|---|
| Pacotes | PAC-001 | `03-uml/Pacotes/diagrama-pacotes.mmd` e `.drawio.xml` | Camadas, serviços de aplicação (autenticação, cadastro, autorização, agenda, lista de espera, auditoria, tempo, unidade de trabalho) e entidades do domínio |
| Componentes | CMP-001 | `03-uml/Componentes/diagrama-componentes.mmd` e `.drawio.xml` | Interface de usuário, serviços, repositórios (interfaces do domínio realizadas pela persistência), `ServicoEnvioMensagem` e `AdaptadorEmail` como único ponto de saída de e-mail |
| Implantação | IMP-001 | `03-uml/Implantacao/diagrama-implantacao.mmd` e `.drawio.xml` | Navegador → servidor de aplicação (HTTPS) → MySQL 8.0; servidor de aplicação → Serviço Externo de E-mail (SMTP/TLS) |

**Como ler.** Seta `-->` é dependência de compilação, `..>` é realização de interface e `-.->` é dependência de injeção, montada em tempo de execução. As exigências arquiteturais ARQ-01 a ARQ-08 e as fronteiras transacionais TRS-01 a TRS-07 (`04-persistencia/modelo-relacional.md` §7) explicam por que o envio de e-mail fica fora da transação de negócio: a falha de e-mail não desfaz a operação (DEC-029).

**Decisões que restringem a arquitetura.** DEC-003 (MySQL), DEC-020 (sessão volátil, sem servidor de sessão), DEC-022 (e-mail como interface de fronteira), DEC-029 (falha de e-mail registrada na auditoria) e RNF-016 (sem dependência de fila ou cache externo).

**Relação com a qualidade.** CQ-SEG-01 e CQ-CON-05 atendem; CQ-COM-02 parcial (serviço de e-mail ausente do contexto e do diagrama de casos de uso oficial); CQ-FLE-03 (ausência de ciclo entre pacotes) ainda a conferir (`05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`).

## 26. Persistência: DER, modelo relacional, dicionário e mapeamento objeto-relacional

**Situação:** rascunho v0.7 (30/10/2026), montado pelo Integrante 6 a partir de `04-persistencia/` (Integrante 4, 29/10/2026). O DDL não foi executado em MySQL (Q7-02).

| Artefato | Arquivo | Conteúdo |
|---|---|---|
| DER-001 | `04-persistencia/der/der-001.mmd`, `der-001.drawio.xml`, `der-001-logico.md` | 15 entidades e 22 relações (A01–A17 do modelo oficial, A18–A21 propostas) |
| Modelo relacional | `04-persistencia/modelo-relacional.md` | Chaves, unicidade, domínios, exclusão e inativação, fronteiras transacionais TRS-01 a TRS-07 |
| Dicionário de dados | `04-persistencia/dicionario-de-dados.md` | Colunas, tipos, nulidade, domínios e rastreabilidade RF → coluna |
| Mapeamento objeto-relacional | `04-persistencia/mapeamento-objeto-relacional.md` | Classe → tabela, atributo → coluna, agregados e interfaces de repositório |
| Normalização | `04-persistencia/normalizacao.md` | Formas normais e as três desnormalizações controladas |
| DDL | `04-persistencia/ddl/schema-mysql.sql` | 15 tabelas MySQL 8.0, restrições `CHECK` nomeadas, colunas geradas e triggers |

**Decisões que moldam o esquema.** DEC-018 (o horário ofertado é a autoridade do tempo), DEC-021 (conta opcional para psicólogo e paciente), DEC-024 (situação anterior e nova na auditoria), DEC-027 (tabela de solicitações da lista de espera com seis situações), DEC-029 (falha de e-mail registrada como operação de auditoria), DEC-020 e DEC-022 (nenhuma tabela de sessão ou de notificação). Os RNF-013 a RNF-022, incorporados à baseline em 30/10/2026, dão critério verificável para cada uma.

**Pontos de atenção.** (a) Relações A18–A21 dependem do diagrama de classes oficial (Q7-05). (b) A unicidade condicional usa coluna gerada com `UNIQUE`, porque o MySQL 8.0 não tem índice único parcial. (c) Os campos provisórios estão listados no dicionário (§7).

## 28. Plano de qualidade (ISO/IEC 25010:2023)

**Situação:** versão v0.7 (30/10/2026); fecha na Fase 8 (Integrante 5).

O plano seleciona **sete características** — Segurança, Adequação funcional, Confiabilidade, Manutenibilidade, Flexibilidade, Compatibilidade e Capacidade de interação — e as converte em **31 critérios verificáveis**, cada um com medida, alvo, evidência e situação.

**Medição em 30/10/2026 (Fase 7):** 20 critérios atendem, 3 atendem em parte, 5 não atendem e 3 estão pendentes de decisão ou de medição. Os que não atendem têm causas conhecidas: decisões aprovadas ainda não propagadas ao diagrama de classes oficial e desenho oficial dos casos de uso sem os casos novos. Os requisitos de qualidade que faltavam foram incorporados à baseline (RNF-013 a RNF-024).

Texto completo: `05-qualidade/plano-qualidade-iso25010.md`. Revisão da Fase 7: `05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`.

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

**Situação:** registro de evidências e autoavaliação v0.7 (30/10/2026); a avaliação final da Fase 8 depende de revisão por mais um integrante (DOD-Q08).

O quadro `Processo → Objetivo → Atividades → Produto de trabalho → Evidência → Situação → Melhoria proposta` está em `05-qualidade/registro-processo.md`, com onze processos da ISO/IEC/IEEE 12207 avaliados na escala N-P-L-F da família ISO/IEC 330xx.

| Resultado em 30/10/2026 | Processos |
|---|---|
| F (plenamente) | 1 — necessidades dos stakeholders |
| L (largamente) | 9 — planejamento, requisitos, arquitetura e projeto, gestão de configuração, verificação, decisões, mudanças, informação e documentação, lições aprendidas |
| P (parcialmente) | 1 — validação (testes conceituais em 15 de 37 RF; sem ata de walkthrough) |
| N | nenhum |

Lições aprendidas até a Fase 7: consenso por mensagem precisa virar decisão registrada no mesmo dia; propostas paralelas precisam de dono para a escolha; revisão cruzada precisa de revisor nomeado; integração documental contínua evita acúmulo; uma lista de propagação com dono acelera a correção; o atraso de um dono bloqueia os seguintes; papel sem participação precisa de plano de cobertura.

## 31. Matriz de rastreabilidade

**Situação:** matriz final v0.7 gerada em 30/10/2026; fecha como v1.0 quando o diagrama de classes oficial incorporar as decisões (P7 a P10).

| Matriz | Conteúdo | Arquivo |
|---|---|---|
| Inicial (Fase 3) | RF → RN/RNF → ator → caso de uso → CA → HU → decisão | `02-requisitos/rastreabilidade-inicial.md` |
| Fase 5 | RF → RN/RNF → UC → classe → operação → sequência → tabela → teste conceitual | `06-rastreabilidade/matriz-rastreabilidade-fase5.md` |
| Fase 6 | RF/RN/UC × SEQ/ATV/COM/EST; mensagens × operações; órfãos | `06-rastreabilidade/matriz-rastreabilidade-fase6.md` |
| **Final (v0.7)** | **Requisito, regra, caso de uso, classe, operação, diagramas, tabela e coluna, critério de aceite, decisão, teste conceitual e qualidade, para os 37 RF** | `06-rastreabilidade/matriz-rastreabilidade-final.md`, gerada por `06-rastreabilidade/montar-matriz.py` |

**Resultado da verificação de órfãos (v0.7):** 37 de 37 RF e 17 de 17 RN rastreados; os RNF que não aparecem em linha de RF são transversais e estão cobertos pelo plano de qualidade. Lacunas: RF-021 sem diagrama comportamental; a lista de espera sem classe no diagrama oficial; 22 testes conceituais ainda a escrever (15 escritos).

As matrizes das Fases 5 e 6 permanecem como apêndices históricos (decisão do Integrante 5, `05-qualidade/analises/fase-06-revisao-cruzada-comportamental.md`).

## 32. Verificação de consistência e revisões

Revisões registradas até a Fase 7:

| Revisão | Autor | Arquivo | Identificadores |
|---|---|---|---|
| Casos de uso futuros (Fase 3) | Integrante 2 | `03-uml/Casos de uso/CasosDeUsoFuturo.md` | — |
| Revisão de dados por caso de uso (Fase 4) | Integrante 4 | `04-persistencia/analises/fase-04-*.md` | — |
| Modelo de domínio (Fase 5) | Integrante 2 | `01-planejamento/revisoes/FASE5-REV-I2-*.md` | R5-01 a R5-17 |
| Viabilidade de persistência (Fase 5) | Integrante 4 | `04-persistencia/analises/fase-05-*.md` | INC-01 a INC-13, P-01 a P-19 |
| Diagramas comportamentais (Fase 6) | Integrante 2 | `01-planejamento/revisoes/FASE6-REV-I2-*.md` | R6-01 a R6-13, LAC-01 a LAC-15 |
| Impacto comportamental (Fase 6) | Integrante 4 | `04-persistencia/analises/fase-06-*.md` | DEP, TRS, ARQ, IMP-DER, IMP-CMP |
| Coerência arquitetura × casos de uso (Fase 7) | Integrante 2 | `01-planejamento/revisoes/FASE7-REV-I2-*.md` | R7-01 a R7-12 |
| Testes conceituais (Fase 8) | Integrante 2 | `01-planejamento/revisoes/FASE8-REV-I2-*.md` | CT-0RF |
| Qualidade das Fases 2 a 7 | Integrante 5 | `05-qualidade/analises/` | Q2-01 a Q7-06 |
| Integração das Fases 1 a 6 | Integrante 6 | `07-dossie/integracao/` | INT-01 a INT-12 |

Divergências abertas de maior impacto em 30/10/2026:

1. O diagrama de classes oficial tem multiplicidades `PENDENTE` e não incorpora as decisões DEC-013 a DEC-030 nem as classes da lista de espera (P7 a P10; Q5-01, Q5-05).
2. O desenho oficial dos casos de uso e o diagrama de contexto não mostram o Serviço Externo de E-mail nem os casos novos UC-028 e UC-033 a UC-037 (Q2-01, Q4-05).
3. Os PDFs de PAC-001, CMP-001 e IMP-001 estão pendentes e o DDL não foi executado (Q7-01, Q7-02).
4. As relações A18–A21 do DER dependem do diagrama de classes oficial (Q7-05).

Resolvidas desde 28/10/2026: `SOLICITADO` nos diagramas comportamentais, guarda de prazo, e-mail condicional e a sequência da lista de espera (SEQ-004).

## 33. Conclusão

**Situação:** rascunho v0.7 (30/10/2026), a fechar na Fase 9 com os números finais de cobertura, rastreabilidade e qualidade.

A modelagem entrega, para uma plataforma de psicólogos sem código programado, 37 requisitos funcionais com critério de aceite, 24 requisitos não funcionais com critério de verificação, 17 regras de negócio, casos de uso especificados, modelo de domínio, classes e objetos, sete diagramas comportamentais, três diagramas de arquitetura e um modelo de dados com DDL MySQL 8.0, ligados por uma matriz de rastreabilidade sem requisito órfão. A inovação, a lista de espera inteligente, percorre todas as camadas: requisito, caso de uso, sequência, tabela e regras de oferta. As decisões que mais mudaram o desenho foram a confirmação automática do agendamento, a retirada do estado `SOLICITADO` e o tratamento da falha de e-mail como evento auditável.

**Resposta à questão norteadora (§22 do enunciado):** a modelagem orientada a objetos torna o sistema implementável porque cada requisito chega a uma classe, a um comportamento e a uma tabela verificáveis, e porque cada decisão está registrada. O que falta para sustentar essa resposta com números finais: diagrama de classes oficial atualizado, testes conceituais restantes e medição final do plano de qualidade.

## 34. Limitações e próximos passos

Limitações conhecidas em 30/10/2026:

- o diagrama de classes oficial ainda não incorpora as decisões DEC-013 a DEC-030 (Integrante 3);
- o DDL não foi executado em MySQL e os PDFs dos diagramas de arquitetura estão pendentes (Integrante 4);
- 22 dos 37 testes conceituais ainda não foram escritos;
- nenhuma ata de walkthrough foi realizada;
- RNF-010 tem critério de inspeção e não meta numérica de tempo, porque o cliente não definiu uma;
- o modelo não cobre prontuário clínico, pagamentos nem teleconsulta, por decisão de escopo (DEC-008).

Próximos passos: `01-planejamento/etapas-e-responsabilidades.md`.

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
| F | Relatório de função e atuação dos integrantes | modelo e preenchimento parcial em `07-dossie/processo/relatorio-atuacao-individual-modelo.md`; versão final na Fase 9 (ver seção 3) |
| G | Auditoria de editáveis e exportações; convenção de backup; modelo de ata | `07-dossie/processo/` |
