# Requisitos

## Objetivo e fase

Esta pasta reúne a especificação verificável e rastreável dos requisitos da Plataforma para Psicólogos. O projeto está na **Fase 3 — levantamento e especificação de requisitos**. Esta fase não inclui diagramas comportamentais, modelo de classes, persistência ou implementação.

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

- **Inovação:** lista de espera inteligente aprovada (DEC-010), especificada em RF-034 a RF-036 e RN-021; parâmetros da fila pendentes (`PG-04` a `PG-09`).
- **Serviço Externo de E-mail:** aprovado (DEC-009), especificado em RF-033 e RN-022.
- **Agendamento:** confirmação automática (DEC-017), cancelamento por paciente e psicólogo antes do horário (DEC-011) e situações `Confirmado`, `Cancelado`, `Realizado` e `Não compareceu` (DEC-016) aprovados. Pendentes: `SOLICITADO` persistente ou transitório (`PG-01`), antecedência mínima (`PG-02`; 2 horas não aprovado) e quem registra `Não compareceu` (`PG-03`).
- **Numeração:** RF-001 a RF-037, RN-001 a RN-014 e RN-020 a RN-022. RN-015 a RN-019 estão reservados para propostas do Integrante 4 ainda não incorporadas.
- **Atendente:** fora do escopo atual.
- **Fora do escopo:** pagamentos, faturamento, convênios, emissão fiscal, teleconsulta, prescrição, prontuário clínico completo, cobrança e integração financeira.
- **Dados:** não foram usados dados reais de pacientes.

## Status da revisão

Os documentos iniciais da Fase 3 foram preparados para revisão. A revisão cruzada pelos Integrantes 2 a 6 e a validação do grupo continuam pendentes; portanto, os requisitos ainda não estão marcados como aprovados ou estáveis.
