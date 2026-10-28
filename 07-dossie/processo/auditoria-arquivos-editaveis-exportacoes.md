# Auditoria de arquivos editáveis e exportações (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire · **Data:** 28/10/2026 · **Versão:** v0.6 (refeita a cada fase; fecha na Fase 9)
**Critério:** barema §19 — todo diagrama tem fonte editável e exportação legível no repositório (DOD-Q04, Integrante 5).

## 1. Resultado em 28/10/2026 (Fases 1 a 6)

| Pasta | Diagrama | Fonte editável | Exportação PDF | Observação |
|---|---|---|---|---|
| `03-uml/Contexto/` | Contexto | `.drawio.xml` | sim (2 PDFs) | Dois PDFs: `diagrama-contexto.pdf` e `Diagrama de contexto fase 2.pdf`. Confirmar com o autor qual vale (INT-nn a abrir) |
| `03-uml/Casos de uso/` | UC-001 | `.drawio.xml` | sim | PDF chama-se "Cópia de Diagrama…" e o nome tem espaços; sugerir renomear (autor do artefato) |
| `03-uml/Dominio/` | Domínio | `.drawio.xml` + `.mmd` | sim | OK |
| `03-uml/Classes/` | Classes v1 e v2 | `.drawio.xml` + `.mmd` (os dois) | sim (os dois) | Dois diagramas concorrentes (ver INT da Fase 5) |
| `03-uml/Objetos/` | Objetos v1 e v2 | `.drawio.xml` + `.mmd` (os dois) | sim (os dois) | OK |
| `03-uml/Sequências/` | SEQ-001, 002, 003 | `.drawio.xml` + `.mmd` | sim | OK |
| `03-uml/Comunicação/` | COM-001 | `.drawio.xml` + `.mmd` | sim | OK |
| `03-uml/Atividade/` | ATV-001 | `.drawio.xml` + `.mmd` | sim | OK |
| `03-uml/Estados/` | EST-001 | `.drawio.xml` + `.mmd` | sim | OK |

Total: 24 fontes editáveis (`.mmd` e `.drawio.xml`) e 14 PDFs. Não há PNG ou SVG; o PDF é a exportação adotada.

## 2. Lacunas

| Item | Situação |
|---|---|
| Diagramas dos RF-028, 033 a 037 (lista de espera, não comparecimento) | Não existem; já registrados como INT/Q das Fases 4 a 6 |
| Diagrama de componentes e DER | Previstos na Fase 7 (Integrante 4) |
| Casos de uso e contexto sem `.mmd` | Aceitável: a fonte é o `.drawio.xml` |

## 3. Como repetir a auditoria

```bash
find 03-uml \( -name '*.mmd' -o -name '*.drawio.xml' -o -name '*.pdf' \) | sort
```

Para cada `.mmd` ou `.drawio.xml` deve existir um `.pdf` com o mesmo nome. A auditoria **registra**; quem renomeia ou exporta é o autor do diagrama.
