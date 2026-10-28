# Fase 5 — Integração do Modelo de Domínio, Classes e Objetos (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Fase do plano:** Fase 5 — Modelo de domínio, classes e objetos
**Data deste registro:** 28/10/2026 · **Versão:** v1.0 (registro de recuperação; ver Fase 1, cabeçalho)
**Insumos:** `07-dossie/secoes/fase5-secao-18-20-27.md` (Integrante 2); `03-uml/Dominio/`, `Classes/`, `Objetos/`; `05-qualidade/analises/fase-05-revisao-cruzada-modelo-dominio.md`; `decisoes.md`.

---

## 1. O que foi integrado ao dossiê

| Seção | Origem | Como foi integrada |
|---|---|---|
| 18 Modelo de domínio | Integrante 2 | Texto mantido como entregue + nota de integração |
| 19 Diagrama de classes | Integrante 2 | Texto mantido + nota de integração |
| 20 Diagrama de objetos | Integrante 2 | Texto mantido + nota de integração |
| 27 Princípios OO e SOLID | Integrante 2 | Texto mantido + nota de integração |

O Integrante 6 não reescreve o texto técnico de outro integrante. Onde uma decisão posterior tornou parte do texto desatualizada, o dossiê mostra, logo abaixo do título da seção, uma **nota de integração** com o que prevalece e o achado correspondente. As notas estão definidas em `07-dossie/montar-dossie.py` (`NOTAS_INTEGRACAO`) e saem do dossiê assim que o autor atualizar o texto.

## 2. Verificação de integração

| Verificação | Resultado |
|---|---|
| A seção segue a regra de inserção de diagramas (título + ID, objetivo, elementos, leitura, decisões, relação, arquivos) | **OK** nas seções 18, 19 e 20 |
| Os arquivos citados existem no repositório | **OK** — `.mmd`, `.drawio.xml` e `.pdf` de domínio, classes (oficial e v2) e objetos (OBJ-001 e OBJ-002) |
| O dossiê indica qual diagrama de classes é o oficial | **Parcial** (INT-09) |
| O texto concorda com as decisões de 25/10/2026 | **Divergente** (INT-10) |

## 3. Achados de integração

| ID | Achado | Responsável | Tratamento |
|---|---|---|---|
| INT-09 | Há dois diagramas de classes (oficial do Integrante 3, com `PENDENTE`; proposta v2 do Integrante 2, com multiplicidades). A seção 19 descreve multiplicidades "fechadas" que só existem na proposta (Q5-01) | Grupo + Integrante 3 | Nota de integração na seção 18; a figura do dossiê só pode ser escolhida quando o grupo definir o oficial |
| INT-10 | Seções 18 a 20 e 27 citam DEC-009 como pendente, RF até RF-032, `SOLICITADO` no ciclo do agendamento e composição `Agendamento`–`Atendimento` que não está desenhada (Q5-02, Q5-03, Q5-06, Q5-07) | Integrante 2 (texto) + Integrante 3 (modelo) | Notas de integração nas seções 18, 19, 20 e 27 |

## 4. Pontos para o pitch (Fase 5)

Registrados em `08-pitch/banco-de-pontos-pitch.md` (parte "Modelagem" e "Decisões").
