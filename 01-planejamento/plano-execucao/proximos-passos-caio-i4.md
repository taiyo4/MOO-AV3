# Próximos passos: Caio (Integrante 4)

**Base:** master em 08/11/2026, depois do commit desta revisão.
**Regra:** só mexa nos seus artefatos (`03-uml/Pacotes`, `Componentes`, `Implantacao`, `04-persistencia`). Cite o achado (Q7-01, Q7-02, Q7-03, Q7-05, Q8-07) em cada commit.

## Já feito (não refazer)
- A18 a A21 deixam de ser "proposta" em `04-persistencia/der/der-001-logico.md`, `der-001.mmd` e `der-001.drawio.xml`. O CLS-001 da Andressa já tem essas associações (merge 0180c3b).
- Oferta de vaga segue como situação `OFERTADA` (INC-17, MD-18). Nada a fazer nisso.

## Passo 1: PDFs de PAC-001, CMP-001, IMP-001 e DER (Q7-01)
- **Arquivos:** `03-uml/Pacotes/diagrama-pacotes.drawio.xml`, `03-uml/Componentes/diagrama-componentes.drawio.xml`, `03-uml/Implantacao/diagrama-implantacao.drawio.xml`, `04-persistencia/der/der-001.drawio.xml`.
- **O que fazer:** abrir cada um no diagrams.net → Arquivo → Exportar como → PDF, salvar na mesma pasta: `diagrama-pacotes.pdf`, `diagrama-componentes.pdf`, `diagrama-implantacao.pdf`, `der-001.pdf`.
- **Atenção:** exportar pacotes só depois do Passo 4 (ciclo), senão o PDF fica desatualizado.
- **Atualizar o README** `03-uml/README.md` (linhas 48 a 50, coluna PDF) e a tabela da §9 de `04-persistencia/der/der-001-logico.md` (linha 13 e linha 207), trocando "pendente" pelo caminho do PDF.
- **Conferir:** os quatro PDFs existem e abrem; `git ls-files "*.pdf" | grep -i "pacotes\|componentes\|implantacao\|der-001"` lista os quatro.

## Passo 2: teste do DDL em MySQL 8.0 (Q7-02)
- **Arquivo:** `04-persistencia/ddl/schema-mysql.sql`.
- **O que fazer:** rodar o script em um MySQL 8.0 limpo. Criar `04-persistencia/analises/teste-ddl.md` com versão do servidor, comando usado e saída completa. Se houver erro, corrigir o `.sql` e registrar a correção no próprio `teste-ddl.md`.
- **Depois:** em `04-persistencia/analises/fase-09-encerramento-e-pitch.md` (linha 35), a linha do DDL deixa de ser "Congelado" sem teste e aponta para `teste-ddl.md`.
- **Conferir:** `teste-ddl.md` tem a saída real, não texto genérico.

## Passo 3: tabelas da ISO/IEC/IEEE 42010 (Q7-03)
- **Arquivo novo:** `04-persistencia/analises/iso-42010-tabelas.md`.
- **O que fazer:** (a) tabela stakeholder → interesse → visão; (b) tabela de correspondência entre as quatro visões (pacotes, componentes, implantação, dados). Base: a seção de arquitetura de `fase-09-encerramento-e-pitch.md` e DEC-020, DEC-022, DEC-027, DEC-029.
- **Enviar:** ao Guilherme e ao Pinho para as seções 25 e 26 do dossiê.
- **Conferir:** cada visão aparece nas duas tabelas e cada interesse tem visão.

## Passo 4: ciclo AGENDA ↔ FILA (Q8-07)
- **Arquivo:** `03-uml/Pacotes/diagrama-pacotes.mmd` (linhas 95 e 96: `AGENDA --> FILA` e `FILA --> AGENDA`).
- **Decisão do grupo:** (a) quebrar o ciclo com evento de domínio ("horário liberado"), ficando só `FILA --> AGENDA`; ou (b) manter como exceção justificada no PAC-001. Leve a escolha ao Pinho antes de editar.
- **Depois:** atualizar `diagrama-pacotes.drawio.xml` e o PDF; corrigir a fala 3 do pitch em `04-persistencia/analises/fase-09-encerramento-e-pitch.md` §4.1 e, se citar "sem ciclo", `08-pitch/roteiro-base-pitch.md`.
- **Conferir:** o `.mmd` não tem setas nos dois sentidos, ou a exceção está registrada no PAC-001.

## Passo 5: enumerações e mapeamento conferidos com o diagrama final
- **Valores oficiais (CLS-001):** `SituacaoConta` (ATIVO, BLOQUEADO, INATIVO), `Paciente.situacaoCadastral` (ATIVO, SUSPENSO, INATIVO), `Vinculo.situacao` (ATIVO, ENCERRADO), `SolicitacaoEspera.situacao` (AGUARDANDO, OFERTADA, ACEITA, RECUSADA, EXPIRADA, DESISTIU), `Agendamento.situacao` (CONFIRMADO, CANCELADO, REALIZADO, NAO_COMPARECEU).
- **Arquivos:** `04-persistencia/dicionario-de-dados.md`, `04-persistencia/modelo-relacional.md`, `04-persistencia/ddl/schema-mysql.sql`, `04-persistencia/der/der-001-logico.md`.
- **O que fazer:** conferir que cada nome aparece igual nesses quatro arquivos. Corrigir o que divergir (ex.: `ATIVO` no DDL, `SUSPENSO` no dicionário).
- **Conferir:** `grep -n "AGUARDANDO\|OFERTADA\|DESISTIU" 04-persistencia/*.md 04-persistencia/ddl/schema-mysql.sql` mostra os mesmos nomes.

## Passo 6: revisar o mapeamento objeto-relacional
- **Arquivo:** `04-persistencia/mapeamento-objeto-relacional.md` (linhas 252 e 277 sobre INC-17) e `04-persistencia/modelo-relacional.md` §5.3.
- **O que fazer:** marcar INC-17 como resolvida (situação `OFERTADA`, alternativa de tabela própria mantida só como registro). Revisar MD-18 e as operações de `SolicitacaoEspera` contra CLS-001 (`abrirOferta`, `aceitar`, `recusar`, `expirar`, `encerrar`, `consultarPosicao`).
- **Conferir:** `grep -n "INC-17" 04-persistencia/*.md` mostra "resolvida" nas linhas de decisão.

## Passo 7: fechar a Fase 7 para o I5 conferir
- Quando os passos 1 a 6 estiverem prontos, avise o Pinho. Ele marca Q7-01 a Q7-05 em `05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`.
- **Depende do Aquiles:** Q7-04 (ator de e-mail no caso de uso oficial, Passo 1 dele).

## Como avisar que terminou
Commit sugerido: `docs(persistencia): exporta diagramas e DER, testa DDL, fecha ISO 42010 e alinha enumerações (Q7-01 a Q7-05, Q8-07)`.
