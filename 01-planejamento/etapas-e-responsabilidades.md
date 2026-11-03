# Etapas restantes e responsabilidades por integrante

**Versão:** v1.0 · **Data:** 28/10/2026 · **Responsável pelo documento:** Integrante 1 (coordenação), com apoio do Integrante 6
**Base:** plano de execução (fora do repositório), `decisoes.md`, achados Q (Integrante 5) e INT (Integrante 6).

Regra de ouro para evitar conflito: **cada artefato tem um dono**. Quem encontra um problema no artefato de outro **registra o achado** (Q ou INT) e o dono corrige. Ninguém corrige em silêncio o artefato de outro.

## 1. Quem é dono de quê

| Integrante | Papel | Artefatos de que é dono |
|---|---|---|
| 1 | Coordenação e requisitos | `02-requisitos/`, `01-planejamento/decisoes.md`, matriz de rastreabilidade |
| 2 | Casos de uso e comportamento | `03-uml/Casos de uso/`, Sequências, Comunicação, Atividade, Estados |
| 3 | Modelo OO | `03-uml/Dominio/`, `Classes/`, `Objetos/` (oficiais), princípios OO e SOLID |
| 4 | Persistência e arquitetura | `04-persistencia/`, pacotes, componentes, implantação, DER, dicionário, DDL |
| 5 | Qualidade, normas e processo | `05-qualidade/`, gate de qualidade, textos das seções 28 a 30 |
| 6 | Documentação, integração e pitch | `07-dossie/`, `08-pitch/`, README, relatório de atuação, pacote final |

Estado das decisões em 28/10/2026: nenhuma pendência PG aberta (DEC-027 a DEC-030). Todas as propostas da Fase 5 foram aprovadas em 28/10/2026 (DEC-013, 014, 015, 018 a 022, 024 e 026); não há proposta aberta.

## 2. O que falta antes de avançar (propagação das decisões)

As decisões de 25 e 28/10/2026 ainda não chegaram aos diagramas. É a prioridade antes da Fase 7.

| # | Item | Dono | Achados | Situação em 30/10/2026 |
|---|---|---|---|---|
| P1 | Tirar `SOLICITADO` de EST-001, SEQ-002 e das seções 19, 21 e 24 (DEC-016) | 2 | Q6-01, INT-11 | Feito (I2, 29/10): EST-001 com 4 situações; falta o desenho oficial incorporar |
| P2 | Trocar a guarda `[prazo]` por "antes do horário marcado" (DEC-011, DEC-028) | 2 | Q6-02 | Feito (I2, 29/10) |
| P3 | Notificação por e-mail deixa de ser condicional (DEC-009, DEC-029) | 2 | Q6-03, Q6-04 | Feito (I2, 29/10) |
| P4 | Casos de uso para RF-028 e RF-033 a RF-037; ator Serviço Externo de E-mail; `«extend»` da oferta ao cancelamento | 2 | Q4-03 a Q4-05, INT-07 | Feito nas especificações (UC-028, UC-033 a UC-037, proposta I2); falta o desenho oficial dos casos de uso |
| P5 | Campo "Objetivo" e "RFs cobertos" nas especificações; IDs UC dos casos "demais" (DEC-026 pendente de aprovação) | 2, com 1 | Q4-01, Q4-02, Q4-08 | Feito (I2, 29/10): Objetivo, RFs cobertos e UC-0RF |
| P6 | Diagrama comportamental da lista de espera (SEQ-004) com os parâmetros da DEC-027 | 2 | Q6-05 | Feito (I2): SEQ-004 criada |
| P7 | Fechar `PENDENTE` nas multiplicidades do diagrama oficial de classes; tirar `SOLICITADO` do enumerado | 3 | Q5-01, Q5-02 | **Feito pelo I3 em 03/11 (0180c3b), a confirmar pelo I5**: A01 e A17 corrigidas, `SOLICITADO` fora do enumerado; sobram A05 com `PENDENTE` (justificado: mínimo de áreas não definido) e alguns atributos sem tipo (Q5-08) |
| P8 | Classes da lista de espera (`EntradaListaEspera`, `OfertaVaga`) e do registro de atendimento ligado ao agendamento (DEC-030) | 3 | Q5-05 | **Feito pelo I3 em 03/11 (0180c3b), a confirmar pelo I5**: a fila entra como `SolicitacaoEspera` com a oferta como situação `OFERTADA`; `OfertaVaga` removida (Q5-11) |
| P9 | Corrigir as justificativas OO/SOLID da seção 27 que não correspondem ao modelo; decidir a composição Agendamento–Atendimento; decidir se o cenário OBJ-002 entra no OBJ-001 | 3 | Q5-09, Q5-10 | **Parcial** (I3, 03/11): texto-fonte da seção 27 já diz "sem composição"; falta o dossiê ser regerado e o I5 conferir as justificativas de LSP, ISP e polimorfismo (Q5-10); OBJ-002 segue separado do OBJ-001 por decisão no diagrama |
| P10 | Operações duplicadas (`adicionarDisponibilidade`/`cadastrarDisponibilidade`, `estaAutorizado`/`estaAtivo`) | 3 | Q5-09 | **Feito pelo I3 em 03/11**: a especificação registra a verificação de P10 (`adicionarDisponibilidade` e `estaAutorizado` aparecem uma vez) |
| P11 | Alinhar a numeração de RF de `04-persistencia/impacto-requisitos.md` com a baseline; refletir lista de espera, `Não compareceu` e e-mail na persistência | 4 | Q3-11, INT-06 | Feito (I4, 29/10): numeração alinhada e Fase 7 entregue |
| P12 | Corrigir os textos antigos (CTX-001, atores, README de requisitos) | 1 e 2 | INT-03 a INT-05 | **Aberto** (I1 e I2): textos antigos como CTX-001 |
| P13 | Aplicar as DEC aprovadas em 28/10/2026: situações de conta, paciente e vínculo (013, 014, 015), slot de disponibilidade (018), cardinalidades (019, 021), sessão fora do domínio (020), `ServicoEnvioMensagem` como único nome (022), auditoria por serviço (024) e numeração UC-0RF/CT-0RF (026) | 2 (UC, nomes), 3 (classes), 4 (persistência), 1 (IDs) | — | Parcial: I4 aplicou DEC-013 a DEC-030 na persistência; I3 aplicou em 03/11 DEC-013, 014, 015, 018, 019, 021 e 027 nas classes; falta o I5 conferir DEC-020, 022 e 024 no diagrama de classes |

Depois de cada correção, o Integrante 5 confirma na tabela de controle de achados (Aberto → Corrigido) e o Integrante 6 regera o dossiê.

## 2.1 Andamento em 30/10/2026

- **Integrante 2:** concluiu P1 a P6, os testes conceituais CT-0RF (15 testes) e a revisão de coerência arquitetura × casos de uso (12 achados R7). Falta o desenho oficial dos casos de uso incorporar UC-028 e UC-033 a UC-037.
- **Integrante 4:** entregou a Fase 7 (pacotes, componentes, implantação, DER, relacional, dicionário, mapeamento, normalização, DDL). Faltam o PDF dos três diagramas, o teste do DDL e as tabelas de correspondência da ISO/IEC/IEEE 42010 (Q7-01 a Q7-03).
- **Integrante 3:** entregou em 02/11 e 03/11 (commits cfe7c2e, c316835, 25c5ad9 e o merge 0180c3b) classes, domínio e objetos com a fila de espera, `OfertaVaga` removida, A01 e A17 corrigidas e exportações `.drawio.xml` e `.pdf` regeradas. Falta o I5 conferir e o dossiê ser regerado; o DER-001 (A17 a A21) já pode tirar o "proposta".
- **Integrante 5 (executado pelo Integrante 1):** análises das Fases 1 a 7 registradas.
- **Integrante 6 (executado pelo Integrante 1):** dossiê v0.7; falta escrever o texto das seções 25 e 26 com o Integrante 4.

## 3. Fases restantes

Janelas conforme o plano de execução (`cronograma.md` e README foram alinhados a elas em 30/10/2026): Fase 7 de 09 a 13/11, Fase 8 de 14 a 18/11, Fase 9 de 19 a 24/11. Congelar novas funcionalidades em 19/11. Entrega em 24/11/2026.

### Fase 7 — Arquitetura e persistência (09 a 13/11)

| Integrante | Tarefas |
|---|---|
| 1 | Atualizar requisitos e rastreabilidade após a propagação; fechar métricas dos RNF (RNF-010 e as lacunas de compatibilidade, interação e concorrência) |
| 2 | Concluir P1 a P6; revisar a coerência dos diagramas de arquitetura com os casos de uso |
| 3 | Concluir P7 a P10; apoiar o mapeamento classe → tabela |
| 4 | Diagramas de pacotes, componentes e implantação; DER, modelo relacional, dicionário de dados, mapeamento ORM e DDL (se exigido) |
| 5 | Entregar a 4 os critérios CQ-SEG-01, CQ-CON-04, CQ-CON-05, CQ-COM-02 e CQ-FLE-03; revisar a descrição de arquitetura segundo a ISO/IEC/IEEE 42010; análise `fase-07-*.md` |
| 6 | Seções 25 e 26 do dossiê; conferir editáveis e exportações; atualizar índice e README |

### Fase 8 — Qualidade, processo, testes conceituais e rastreabilidade (14 a 18/11)

| Integrante | Tarefas |
|---|---|
| 1 | Matriz final de rastreabilidade `06-rastreabilidade/matriz-rastreabilidade-final.md` (RF → RN → UC → classe → diagrama → persistência → CA), sem órfãos |
| 2 | Testes conceituais de casos de uso e comportamento (convenção da DEC-026, se aprovada) |
| 3 | Testes conceituais do modelo de domínio; versão final das seções 18 a 20 e 27 |
| 4 | Testes conceituais de persistência e arquitetura; versão final das seções 25 e 26 |
| 5 | Medição final do plano ISO 25010 (v1.0); autoavaliação N/P/L/F; gate de qualidade; textos das seções 28, 29 e 30 |
| 6 | Seções 28 a 33; auditoria de README, estrutura, editáveis, exportações e histórico; estrutura-base do roteiro do pitch |

### Fase 9 — Consolidação, pitch e entrega (19 a 24/11)

| Integrante | Tarefas |
|---|---|
| 1 | Revisão final de requisitos e decisões; conferir que nada pendente aparece como aprovado |
| 2 a 4 | Corrigir os últimos achados dos seus artefatos; participar do pitch |
| 5 | Auditoria final do checklist do barema; parte "Qualidade e processo" do pitch; gate antes do fechamento |
| 6 | Dossiê final (índice, formatação, referências, anexos); relatório de função e atuação dos seis; roteiro, ensaio, gravação e revisão do vídeo (ao menos duas pessoas falando); testar links, permissões, editáveis e exportações; pacote final |

## 4. Marcos e checagens

| Data | Marco |
|---|---|
| Até 08/11 | P1 a P13 concluídos e confirmados pelo Integrante 5 |
| 13/11 | Fase 7 fechada (arquitetura e persistência) |
| 18/11 | Matriz final sem órfãos; plano de qualidade v1.0 |
| 19/11 | Congelamento de funcionalidades |
| 23/11 | Meta interna: pacote pronto |
| 24/11 | Entrega |

## 5. Como registrar o andamento

1. Cada integrante marca em `decisoes.md` apenas decisões aprovadas pelo grupo.
2. Cada correção cita o achado no commit (por exemplo, `Q6-01`).
3. O Integrante 5 atualiza a coluna "Situação" dos achados; o Integrante 6 regera o dossiê com `python3 07-dossie/montar-dossie.py`.
4. Dúvidas que dependem do grupo viram pendência `PG-xx` em `decisoes.md`; ninguém assume a resposta.
