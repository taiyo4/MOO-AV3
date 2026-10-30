# MOO-AV3 — Plataforma para Psicólogos

Projeto da AV3 da disciplina de **Modelagem Orientada a Objetos** (Centro Universitário Jorge Amado, Prof. MSc. Celso Barreto): **Modelagem Orientada a Objetos de uma Plataforma para Psicólogos**.

O produto é um **dossiê de modelagem** completo e rastreável — requisitos, regras de negócio, modelos UML, persistência, arquitetura, qualidade, processo e documentação — capaz de orientar uma futura implementação. Não há sistema programado.

## Situação (30/10/2026)

Fases e janelas conforme o plano de execução da equipe de seis integrantes. Cada fase só fecha com revisão, pendências críticas corrigidas e checkpoint registrado. Nenhuma pendência de decisão (`PG`) está aberta: todas foram resolvidas até 28/10/2026 (DEC-009 a DEC-030).

| Fase | Período | Situação |
|---|---|---|
| 1 — Organização inicial | 05/10–07/10 | Concluída |
| 2 — Visão, escopo e contexto | 08/10–11/10 | Concluída |
| 3 — Requisitos | 12/10–18/10 | Concluída; baseline atualizada com as decisões de 25/10/2026 |
| 4 — Casos de uso | 19/10–25/10 | Concluída; UC-028 e UC-033 a UC-037 especificados pelo Integrante 2; especificações oficiais em v1.1 (Objetivo/RFs cobertos, DEC-026); desenho oficial pendente (Integrante 3) |
| 5 — Modelo OO | 26/10–01/11 | Entregue; proposta v2 do Integrante 2 removida em 28/10/2026; falta fechar multiplicidades e incorporar DEC-013 a DEC-030 no diagrama oficial (Integrante 3) |
| 6 — Comportamento | 02/11–08/11 | **Concluída no que é do Integrante 2** — sete diagramas (SEQ-001 a SEQ-004, ATV-001, COM-001, EST-001) em v2.0/v2.1, com DEC-009 a DEC-030 aplicadas e LAC-13/14/15 fechadas; falta o Integrante 3 incorporar o modelo (R6-09/LAC-10) |
| 7 — Arquitetura e persistência | 09/11–13/11 | Revisão de coerência arquitetura × casos de uso entregue pelo Integrante 2 (`01-planejamento/revisoes/FASE7-REV-I2-…`), com 12 achados R7; pacotes, componentes, DER e DDL são do Integrante 4 |
| 8 — Qualidade e rastreabilidade | 14/11–18/11 | Testes conceituais do Integrante 2 entregues (15 testes / 68 cenários, `CT-0RF`); homologação na matriz mestra é do Integrante 5 |
| 9 — Consolidação e pitch | 19/11–24/11 | Dossiê v0.7 montado; pontos do Integrante 2 para o pitch encaminhados ao Integrante 6 |
| Entrega | 24/11/2026 | Congelar funcionalidades em 19/11; meta interna 23/11; reserva de 25 a 30/11 só para emergência |

Papéis: 1 coordenação e requisitos · 2 casos de uso e comportamento · 3 domínio, classes e objetos · 4 arquitetura e persistência · 5 qualidade, normas e processo · 6 documentação, integração, repositório e pitch.

Decisões vigentes, propostas e pendências: [`01-planejamento/decisoes.md`](01-planejamento/decisoes.md).
Etapas restantes e responsabilidades: [`01-planejamento/etapas-e-responsabilidades.md`](01-planejamento/etapas-e-responsabilidades.md).

## Onde está cada coisa

| Pasta | Conteúdo |
|---|---|
| [`01-planejamento/`](01-planejamento/) | Cronograma, equipe, decisões, atas e revisões das fases |
| [`02-requisitos/`](02-requisitos/) | Visão, escopo, atores, glossário, RF-001 a RF-037, RNF-001 a RNF-012, RN, critérios de aceite, histórias, matriz inicial |
| [`03-uml/`](03-uml/) | Diagramas (`.mmd`, `.drawio.xml`, `.pdf`) e especificações — inventário em [`03-uml/README.md`](03-uml/README.md) |
| [`04-persistencia/`](04-persistencia/) | Análises de persistência e arquitetura (Fases 3 a 6); arquitetura, DER e modelo relacional na Fase 7 |
| [`05-qualidade/`](05-qualidade/) | Plano ISO/IEC 25010, normas, registro de processo e revisões de qualidade por fase |
| [`06-rastreabilidade/`](06-rastreabilidade/) | Matrizes de rastreabilidade |
| [`07-dossie/`](07-dossie/) | **Dossiê único** ([`dossie.md`](07-dossie/dossie.md)), seções por fase, script de montagem e registros de integração |
| [`08-pitch/`](08-pitch/) | Banco de pontos e roteiro do vídeo-pitch |

## Escopo

Identidade e acesso · Administração · Psicólogos · Clientes/pacientes · Agenda · Atendimento · Auditoria · **Inovação: lista de espera inteligente** (DEC-010). Serviço Externo de E-mail para confirmação, cancelamento e oferta de vaga (DEC-009). Fora do escopo: pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição, prontuário clínico aprofundado e cobrança (DEC-008).

## Convenções

- Identificadores (`RF`, `RNF`, `RN`, `CA`, `HU`, `UC`, `SEQ`, `EST`, `DEC`, `PG`…) nunca são renumerados; a baseline oficial está em `02-requisitos/`.
- Proposta não é decisão: só vale o que está aprovado em `decisoes.md`.
- Todo diagrama tem fonte editável e PDF com o mesmo nome-base (`03-uml/README.md`).
- Nenhum dado real de paciente e nenhuma senha em texto puro (DEC-005).

## Equipe

| Integrante | Nome | Responsabilidade |
|---|---|---|
| 1 | Emmanuel de Pinho | Coordenação, planejamento e requisitos |
| 2 | Aquiles Angelo | Casos de uso e diagramas comportamentais |
| 3 | Andressa Caroline | Modelo OO e domínio |
| 4 | Caio Cunha | Persistência e arquitetura |
| 5 | Franklin Reis | Qualidade, normas e processo |
| 6 | Guilherme Freire | Documentação, integração, repositório e pitch |
