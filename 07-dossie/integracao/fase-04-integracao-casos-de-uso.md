# Fase 4 — Integração dos Casos de Uso (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Fase do plano:** Fase 4 — Casos de uso e especificações
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `03-uml/Casos de uso/`; `05-qualidade/analises/fase-04-revisao-qualidade-casos-de-uso.md`; `decisoes.md`.

---

## 1. O que foi integrado ao dossiê

| Seção | Conteúdo |
|---|---|
| 16 Diagrama de casos de uso | Identificação, atores × casos, leitura do `«include»`, decisões (painel não é caso isolado; auditoria como `«include»`; sem generalização de atores), nota de integração e arquivos |
| 17 Especificações de casos de uso | Quadro-resumo dos quatro casos críticos já com as decisões de 25/10/2026 e lista dos casos "demais" com os RF cobertos |

## 2. Verificação de integração

| Verificação | Resultado |
|---|---|
| Os casos de uso do diagrama têm especificação | **OK** — 12 casos, 12 especificações |
| O texto das especificações usa as decisões vigentes | **Divergente** — UC-025 e UC-027 citam pendências resolvidas (Q4-06); o resumo do dossiê usa as decisões vigentes e aponta a divergência |
| Os requisitos novos (RF-033 a RF-037) chegam aos casos de uso | **Não** (INT-07) |
| Os arquivos do diagrama têm nomes estáveis para referência no dossiê | **Parcial** (INT-08) |

## 3. Achados de integração

| ID | Achado | Responsável | Tratamento |
|---|---|---|---|
| INT-07 | O diagrama de casos de uso (06/10/2026) não mostra o Serviço Externo de E-mail, a lista de espera (RF-034 a RF-036), o registro de `Não compareceu` (RF-037) nem um `«extend»` justificado (Q4-03 a Q4-05) | Integrante 2 | Nota de integração nas seções 16.4 e 17 |
| INT-08 | Os arquivos do diagrama de casos de uso têm espaço antes da extensão e o PDF se chama "Cópia de …" (`Diagrama casos de uso uc001 .drawio.xml`, `Cópia de Diagrama casos de uso uc001 .pdf`). O Integrante 2 decidiu manter os nomes originais das fases anteriores (commit `f63553c`) | Integrante 2 (decisão mantida) | O dossiê cita os nomes exatos. Sugestão para a Fase 9: na próxima versão do diagrama, salvar com o nome-base padrão `diagrama-casos-de-uso` e preservar os arquivos antigos |

## 4. Pontos para o pitch (Fase 4)

Registrados em `08-pitch/banco-de-pontos-pitch.md` (parte "Modelagem").
