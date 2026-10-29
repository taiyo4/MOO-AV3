# Fase 1 — Estrutura do Repositório, Convenções e Estrutura do Dossiê (Integrante 6)

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Fase do plano:** Fase 1 — Organização inicial
**Data deste registro:** 28/10/2026 · **Versão:** v1.0
**Registro de recuperação:** as atividades do Integrante 6 nas Fases 1 a 6 foram registradas em 28/10/2026, depois do período original de cada fase. Não há registro retroativo de participação: as datas dos documentos são as datas reais de versionamento, e a integração foi feita sobre o estado do repositório em 28/10/2026.

---

## 1. Papel do Integrante 6

| Frente | Responsabilidade | Onde fica |
|---|---|---|
| Documentação | Dossiê único, legível e completo, com todas as seções exigidas pelo enunciado (barema §16) | `07-dossie/dossie.md` |
| Integração | Juntar os textos preparados pelos integrantes, apontar divergências entre eles e entre eles e as decisões | `07-dossie/integracao/` |
| Repositório | Organização de pastas, README raiz e índices, nomes de arquivos, convenção de entrega | `README.md`, READMEs de pasta |
| Pitch | Roteiro, banco de pontos por fase, distribuição de falas e coerência entre dossiê e vídeo | `08-pitch/` |

O Integrante 6 **não altera** artefatos técnicos de outros integrantes: quando encontra divergência, registra um achado `INT-nn`, endereça ao responsável e, no dossiê, insere uma nota de integração indicando o que prevalece.

## 2. Estrutura do repositório verificada

| Pasta | Conteúdo | Responsável principal |
|---|---|---|
| `01-planejamento/` | Cronograma, equipe, decisões, atas, revisões | Integrante 1 (revisões: Integrante 2) |
| `02-requisitos/` | Visão, escopo, atores, glossário, RF, RNF, RN, CA, HU, matriz inicial | Integrante 1 |
| `03-uml/` | Contexto, casos de uso, domínio, classes, objetos, sequências, atividades, comunicação, estados | Integrantes 2 e 3 |
| `04-persistencia/` | Análises de persistência e (Fase 7) DER, modelo relacional, dicionário, mapeamento | Integrante 4 |
| `05-qualidade/` | Plano ISO/IEC 25010, normas, processo, revisões de qualidade | Integrante 5 |
| `06-rastreabilidade/` | Matrizes de rastreabilidade | Integrantes 1, 2 e 5 |
| `07-dossie/` | Seções preparadas, dossiê montado, registros de integração | Integrante 6 |
| `08-pitch/` | Roteiro e material do vídeo | Integrante 6 |

A estrutura é adequada ao barema ("Arquivos editáveis e repositório — fontes organizadas, versões e README", 0,30 ponto). Os diagramas seguem a convenção de três formatos com o mesmo nome-base (`.mmd`, `.drawio.xml`, `.pdf`) definida em `03-uml/README.md`.

## 3. Convenções adotadas pelo Integrante 6

| Convenção | Regra |
|---|---|
| Identificadores | Nunca renumerar; antes de criar ID novo, conferir o último livre (`PLANEJAMENTO_AV3` §6) |
| Mensagens de commit | Prefixo de área (`docs:`, `uml:`, `trace:`, `quality:`) e indicação do integrante (`I1`…`I6`), como os commits das Fases 5 e 6 |
| Textos para o dossiê | Cada integrante entrega em `07-dossie/secoes/` com o número das seções; o Integrante 6 monta o dossiê |
| Dossiê montado | `07-dossie/dossie.md` é gerado por `07-dossie/montar-dossie.py`; não se edita o arquivo gerado |
| Diagrama no dossiê | Título + identificador, objetivo, elementos, como interpretar, decisões, relação com requisitos/classes/banco e arquivos — mesma ordem usada pelo Integrante 2 nas seções 18 a 24 |
| Dados | Nenhum dado real de paciente nem senha em texto puro (DEC-005) |

## 4. Estrutura do dossiê

As seções 18 a 24, 26, 27, 28 e 31 já eram citadas por número nos textos do Integrante 2. O plano de execução que definiu essa numeração (`plano §16`) não está versionado no repositório; por isso o Integrante 6 completou a numeração de forma **compatível com os números já usados** e com a estrutura mínima do barema §16:

| Barema §16 | Seções do dossiê |
|---|---|
| Capa, resumo e identificação dos integrantes | 1, 2, 3 |
| Contexto, situação-problema, escopo, premissas e restrições | 4, 5, 6, 7, 11 (diagrama de contexto) |
| Stakeholders, atores, glossário, requisitos e regras de negócio | 8, 9, 10, 12, 13, 14, 15 |
| Casos de uso e especificações textuais | 16, 17 |
| Modelo de domínio e diagramas estruturais | 18, 19, 20 |
| Diagramas comportamentais e justificativas | 21, 22, 23, 24 |
| Arquitetura, pacotes, componentes e implantação | 25 |
| Persistência, DER, dicionário e mapeamento | 26 |
| (Princípios OO e SOLID — barema §11) | 27 |
| Plano de qualidade e aplicação das normas | 28, 29 |
| Matriz de rastreabilidade e verificação de consistência | 31, 32 |
| Autoavaliação do processo e melhorias | 30 |
| Conclusão, limitações, referências e anexos | 33, 34, 35, 36 |

## 5. Achados de integração

| ID | Achado | Tratamento |
|---|---|---|
| INT-01 | `01-planejamento/equipe.md` dizia "Os nomes serão adicionados posteriormente", embora o README raiz já listasse os nomes; o README raiz dizia "Fase inicial de planejamento" | **Resolvido pelo Integrante 6 em 28/10/2026** — nomes incluídos em `equipe.md`; README raiz atualizado |
| INT-02 | A numeração das seções do dossiê (plano §16) não está no repositório | Estrutura 1–36 proposta acima, compatível com os números já usados; se o plano de execução tiver numeração diferente, o script de montagem permite renumerar em um só lugar |

## 6. Situação ao final da Fase 1

Estrutura do repositório conferida, convenções registradas e estrutura do dossiê definida. O relatório de função e atuação de cada integrante (exigido pelo enunciado) tem lugar reservado na seção 3 e no anexo F do dossiê.
