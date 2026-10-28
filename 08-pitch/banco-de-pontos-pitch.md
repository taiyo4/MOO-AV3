# Banco de Pontos e Roteiro Preliminar do Pitch

**Responsável:** Integrante 6 — Guilherme Freire (Documentação, integração, repositório e pitch)
**Versão:** v0.6 — pontos colhidos nas Fases 1 a 6 (28/10/2026) · **Roteiro final, gravação e edição:** Fase 9 (19/11 a 21/11)
**Base:** barema §17 (partes do pitch) e §18.2 (0,80 + 0,70 + 0,50 ponto); `PLANEJAMENTO_AV3` §1 Bloco B.

> **Regra de coerência (0,50 ponto):** o pitch só pode mostrar o que está no dossiê entregue. Por isso, cada ponto abaixo aponta a seção do dossiê e o artefato de origem, e pontos que dependem de decisão pendente estão marcados como **não usar até decidir**.

---

## 1. Pontos colhidos por fase

| Fase | Ponto para o pitch | Parte do pitch (§17) | Seção do dossiê / artefato | Situação |
|---|---|---|---|---|
| 1 | Seis papéis com revisão cruzada; repositório com histórico e fontes editáveis | Abertura / Qualidade | 3; `README.md` | Pronto |
| 2 | O problema real: cadastros, agenda e permissões espalhados em planilhas, sem controle de quem vê o quê | Abertura / Contexto | 4; `visao.md` | Pronto |
| 2 | Quem usa: Administrador, Psicólogo, Paciente com acesso limitado; e-mail como serviço externo | Contexto | 8, 11; CTX-001 | Pronto (CTX-001 precisa mostrar o e-mail como aprovado — INT-03) |
| 2 | O que ficou fora e por quê: financeiro, teleconsulta, prontuário clínico (DEC-008) | Decisões | 6 | Pronto |
| 3 | 37 RF, 12 RNF, 17 RN; 37 de 37 RF com critério de aceite | Solução / Qualidade | 12–15 | Pronto |
| 3 | Inovação: lista de espera inteligente — o horário cancelado vira oportunidade para outro paciente, com aviso por e-mail | Solução (inovação) | 6; RF-034 a RF-036; RN-021 | Pronto como requisito; **parâmetros da fila não usar até decidir** (PG-04 a PG-09) |
| 4 | Casos de uso críticos: autenticar, vincular, agendar, cancelar; `«include»` de auditoria e e-mail | Modelagem | 16, 17 | Pronto; inovação sem caso de uso (INT-07) |
| 5 | Identidade separada de cadastro: conta de acesso não é o psicólogo nem o paciente (sem herança artificial) | Decisões | 18, 19, 27; OO-01 | Pronto |
| 5 | Vínculo como conceito central: o psicólogo só vê pacientes vinculados | Modelagem / Qualidade (segurança) | 18; RN-003 | Pronto |
| 5 | Diagrama de objetos com dados fictícios mostra que agendamento cancelado não gera atendimento | Modelagem | 20; OBJ-002 | Pronto |
| 6 | Três sequências; toda mensagem tem operação de origem (82 de 82) | Modelagem / Qualidade | 21; matriz da Fase 6 | Pronto |
| 6 | Ciclo do agendamento: nasce `Confirmado` (confirmação automática), termina `Cancelado`, `Realizado` ou `Não compareceu` | Modelagem / Decisões | 24; DEC-016, DEC-017, DEC-025 | **Não usar o EST-001 atual até ser corrigido** (ainda mostra `SOLICITADO` — INT-11) |
| 6 | Alternativa considerada e descartada: estado `SOLICITADO` persistente; motivo: com confirmação automática ele não tem duração nem regra própria | Decisões | 10; DEC-016 (PG-01) | Pronto |
| 6 | Alternativa considerada e não aprovada: prazo mínimo de 2 horas para cancelar | Decisões | 10; DEC-012 | Pronto (dizer "não aprovado"; não apresentar como regra) |
| 2–6 | Normas aplicadas de verdade: 25010 virou 31 critérios medidos; 29148 verificou os requisitos; 9126 e 15504 só como história | Qualidade | 28, 29 | Pronto (números finais na Fase 8) |

## 2. Roteiro preliminar (estrutura do barema §17)

| # | Parte | Conteúdo | Artefato mostrado na tela | Quem fala |
|---|---|---|---|---|
| 1 | Abertura | Nome do projeto, integrantes, problema em uma frase | Capa do dossiê | A definir pelo grupo |
| 2 | Contexto | Usuários e por que modelar antes de programar | CTX-001 | A definir |
| 3 | Solução | Módulos e inovação (lista de espera) | Seção 6 do dossiê | A definir |
| 4 | Modelagem | Casos de uso → classes → sequência de agendamento → estados → arquitetura e persistência (Fase 7) | UC-001, CLS-001, SEQ-002, EST-001, DER | A definir |
| 5 | Qualidade | Rastreabilidade sem órfãos, critérios ISO/IEC 25010, normas atuais × retiradas | Matriz final, plano de qualidade | A definir |
| 6 | Decisões | Duas ou três alternativas descartadas e por quê (`SOLICITADO`, prazo de 2 h, herança de usuário) | Seção 10 | A definir |
| 7 | Encerramento | Valor para a implementação, limitações, próximos passos | Seções 33 e 34 | A definir |

Exigência do enunciado: **pelo menos dois alunos falando e defendendo partes diferentes**. Sugestão a decidir pelo grupo: cada integrante apresenta a parte da sua responsabilidade principal.

## 3. Pendências para o roteiro final (Fase 9)

- Decisão do grupo sobre quem fala e duração (confirmar se a disciplina fixa tempo).
- Diagramas corrigidos conforme DEC-016 antes de gravar (INT-11).
- Diagrama comportamental e caso de uso da lista de espera, para demonstrar a inovação (INT-07, INT-12).
- Arquitetura e persistência (Fase 7) para a parte "Modelagem".
- Números finais de qualidade e rastreabilidade (Fase 8).
