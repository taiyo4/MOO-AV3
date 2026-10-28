# Fase 3 — Integração dos Requisitos (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Fase do plano:** Fase 3 — Requisitos
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `02-requisitos/` na versão de 25/10/2026; `04-persistencia/impacto-requisitos.md`; `05-qualidade/analises/fase-03-verificacao-requisitos.md`.

---

## 1. O que foi integrado ao dossiê

| Seção | Conteúdo | Como |
|---|---|---|
| 12 Requisitos funcionais | RF-001 a RF-037 com requisito, ator e prioridade | Tabela **gerada automaticamente** de `requisitos-funcionais.md` pelo `montar-dossie.py` |
| 13 Requisitos não funcionais | RNF-001 a RNF-012 com categoria e descrição | Tabela gerada de `requisitos-nao-funcionais.md` |
| 14 Regras de negócio | RN-001 a RN-014 e RN-020 a RN-022 | Tabela gerada de `regras-negocio.md` |
| 15 Histórias e critérios de aceite | HU-001 a HU-016; referência aos 37 CA | Tabela gerada de `historias-usuario.md` |

**Decisão de integração:** as tabelas de requisitos são geradas a partir da baseline em vez de copiadas à mão. Assim, quando o Integrante 1 alterar um requisito, basta rodar `python3 07-dossie/montar-dossie.py` para o dossiê refletir a mudança, e o dossiê nunca diverge da baseline oficial (`PLANEJAMENTO_AV3` §6 regra 1).

## 2. Verificação de integração

| Verificação | Resultado |
|---|---|
| Quantidades no dossiê = quantidades na baseline | **OK** — 37 RF, 12 RNF, 17 RN, 37 CA, 16 HU |
| IDs reservados documentados (RN-015 a RN-019) | **OK** — nota na seção 14 |
| Pendências citadas como pendências (PG-02, PG-04 a PG-12) | **OK** em 25/10/2026; resolvidas em 28/10/2026 (DEC-027 a DEC-030) e seções atualizadas |
| Documentos de outras pastas usam a mesma numeração | **Divergente** (INT-06) |

## 3. Achados de integração

| ID | Achado | Responsável | Tratamento |
|---|---|---|---|
| INT-05 | `02-requisitos/README.md` diz que o projeto "está na Fase 3"; o repositório está na Fase 6 (Q3-10) | Integrante 1 | O README raiz e o dossiê informam a fase atual |
| INT-06 | `04-persistencia/impacto-requisitos.md` usa numeração própria de RF (ex.: "RF-006 — Agendamentos sem conflito"), divergente da baseline (Q3-11) | Integrante 4 | O dossiê cita apenas a numeração oficial; a seção 26 registra a condição de usar os IDs oficiais |

## 4. Pontos para o pitch (Fase 3)

Registrados em `08-pitch/banco-de-pontos-pitch.md` (parte "Solução" e "Qualidade").
