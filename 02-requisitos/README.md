# Requisitos

## Objetivo e fase

Esta pasta reúne a especificação verificável e rastreável dos requisitos da Plataforma para Psicólogos. A baseline foi criada na Fase 3 e atualizada em 25/10/2026 e em 28/10/2026 (DEC-009 a DEC-030; nenhuma pendência PG aberta). O projeto está na **Fase 6**; os diagramas, o modelo de classes e a persistência estão em `03-uml/` e `04-persistencia/`.

## Documentos de visão e escopo

- [Documento de visão](visao.md)
- [Escopo do sistema](escopo.md)
- [Stakeholders e atores](stakeholders-atores.md)
- [Glossário](glossario.md)

## Especificação da Fase 3

- [Requisitos funcionais](requisitos-funcionais.md)
- [Requisitos não funcionais](requisitos-nao-funcionais.md)
- [Regras de negócio](regras-negocio.md)
- [Critérios de aceite](criterios-aceite.md)
- [Histórias de usuário](historias-usuario.md)
- [Matriz de rastreabilidade inicial](rastreabilidade-inicial.md)

## Pendências e limites

- **Inovação:** lista de espera inteligente aprovada (DEC-010), especificada em RF-034 a RF-036 e RN-021; parâmetros da fila aprovados em 28/10/2026 (DEC-027).
- **Serviço Externo de E-mail:** aprovado (DEC-009), especificado em RF-033 e RN-022.
- **Agendamento:** confirmação automática (DEC-017), cancelamento por paciente e psicólogo antes do horário (DEC-011) e situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu` (DEC-016) aprovados; `SOLICITADO` não é persistente (DEC-016) e o Psicólogo registra `Não compareceu` após o horário marcado (DEC-025). Em 28/10/2026: sem antecedência mínima e sem cancelamento pelo Administrador (DEC-028); falha de e-mail não desfaz a operação (DEC-029); registro do atendimento leva o agendamento a `Realizado` (DEC-030).
- **Numeração:** RF-001 a RF-037, RN-001 a RN-014 e RN-020 a RN-022. RN-015 a RN-019 estão reservados para propostas do Integrante 4 ainda não incorporadas.
- **Atendente:** fora do escopo atual.
- **Fora do escopo:** pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição, prontuário clínico completo, cobrança e integração financeira.
- **Dados:** não foram usados dados reais de pacientes.

## Status da revisão

A revisão de qualidade dos requisitos (Integrante 5, achados Q3-01 a Q3-11) está em `05-qualidade/analises/fase-03-verificacao-requisitos.md`. Os achados ainda abertos dependem do Integrante 1. O que falta para cada integrante está em `01-planejamento/etapas-e-responsabilidades.md`.
