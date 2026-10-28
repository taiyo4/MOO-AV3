# MOO-AV3 — Plataforma para Psicólogos

Projeto da AV3 da disciplina de **Modelagem Orientada a Objetos** (Centro Universitário Jorge Amado, Prof. MSc. Celso Barreto): **Modelagem Orientada a Objetos de uma Plataforma para Psicólogos**.

O produto é um **dossiê de modelagem** completo e rastreável — requisitos, regras de negócio, modelos UML, persistência, arquitetura, qualidade, processo e documentação — capaz de orientar uma futura implementação. Não há sistema programado.

## Situação (28/10/2026)

| Fase | Período | Situação |
|---|---|---|
| 1 — Organização inicial | 01/09–14/09 | Concluída |
| 2 — Visão, escopo e contexto | até 14/09 | Concluída |
| 3 — Requisitos | 15/09–28/09 | Concluída; baseline atualizada com as decisões de 25/10/2026 |
| 4 — Casos de uso | 29/09–05/10 | Concluída; casos de uso para RF-028 e RF-033 a RF-037 pendentes |
| 5 — Modelo OO | 06/10–19/10 | Entregue; diagrama de classes oficial com multiplicidades pendentes e proposta v2 em avaliação |
| 6 — Comportamento | 20/10–02/11 | **Em andamento** — seis diagramas entregues; propagar DEC-016 (sem `SOLICITADO`) e modelar a lista de espera |
| 7 — Arquitetura e persistência | 03/11–09/11 | A iniciar |
| 8 — Qualidade e rastreabilidade | 10/11–16/11 | Plano de qualidade preliminar pronto |
| 9 — Consolidação e pitch | 17/11–23/11 | Dossiê v0.6 montado; roteiro preliminar do pitch |
| Entrega | 24/11/2026 | Meta interna: 23/11/2026 |

Decisões vigentes, propostas e pendências: [`01-planejamento/decisoes.md`](01-planejamento/decisoes.md).

## Onde está cada coisa

| Pasta | Conteúdo |
|---|---|
| [`01-planejamento/`](01-planejamento/) | Cronograma, equipe, decisões, atas e revisões das fases |
| [`02-requisitos/`](02-requisitos/) | Visão, escopo, atores, glossário, RF-001 a RF-037, RNF-001 a RNF-012, RN, critérios de aceite, histórias, matriz inicial |
| [`03-uml/`](03-uml/) | Diagramas (`.mmd`, `.drawio.xml`, `.pdf`) e especificações — inventário em [`03-uml/README.md`](03-uml/README.md) |
| [`04-persistencia/`](04-persistencia/) | Análises de persistência e arquitetura (Fases 3 a 6); DER e modelo relacional na Fase 7 |
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
