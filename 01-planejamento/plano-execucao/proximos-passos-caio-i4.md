# Próximos passos: Caio (Integrante 4)

**Base:** master em 08/11/2026, depois do commit desta rodada.
**Regra:** só mexa nos seus artefatos (`03-uml/Pacotes`, `Componentes`, `Implantacao`, `04-persistencia`). Cite o achado (ex.: Q7-01, Q7-02, Q8-07) em cada commit.

## Já feito nesta rodada (não refazer)
- A18 a A21 deixam de ser "proposta" em `04-persistencia/der/der-001-logico.md` e `der-001.mmd`. O CLS-001 da Andressa já tem essas associações (merge 0180c3b).
- Oferta de vaga segue como situação `OFERTADA` (INC-17, MD-18). Nada a fazer nisso.

## Passo 1: PDFs de PAC-001, CMP-001 e IMP-001 (Q7-01)
- **Arquivos:** `03-uml/Pacotes/diagrama-pacotes.drawio.xml`, `03-uml/Componentes/diagrama-componentes.drawio.xml`, `03-uml/Implantacao/diagrama-implantacao.drawio.xml`
- **O que fazer:** abrir cada um no diagrams.net → Arquivo → Exportar → PDF, salvar na mesma pasta como `diagrama-pacotes.pdf`, `diagrama-componentes.pdf`, `diagrama-implantacao.pdf`.
- **Atenção:** exportar o pacote depois do Passo 4, senão o PDF fica com o ciclo.
- **Conferir:** os três PDFs existem e abrem; `git ls-files "03-uml/*/*.pdf"` lista os três.

## Passo 2: teste do DDL em MySQL 8.0 (Q7-02)
- **Arquivo:** `04-persistencia/ddl/schema-mysql.sql`
- **O que fazer:** rodar o script em um MySQL 8.0 limpo. Criar `04-persistencia/analises/teste-ddl.md` com versão do servidor, comando usado e saída. Se houver erro, corrigir o `.sql` e registrar a correção.
- **Depois:** em `04-persistencia/analises/fase-09-encerramento-e-pitch.md` (linha 35), trocar "Congelado" por "Testado em MySQL 8.0 (data)" se o teste passar.
- **Conferir:** `teste-ddl.md` tem a saída real, sem texto genérico.

## Passo 3: tabelas da ISO/IEC/IEEE 42010 (Q7-03)
- **Arquivo novo:** `04-persistencia/analises/iso-42010-tabelas.md`
- **O que fazer:** (a) tabela stakeholder → interesse → visão; (b) tabela de correspondência entre as quatro visões (pacotes, componentes, implantação, dados). Base: `fase-09-encerramento-e-pitch.md` (seção de arquitetura) e DEC-020, DEC-022, DEC-027, DEC-029.
- **Enviar:** ao Guilherme e ao Pinho para as seções 25 e 26 do dossiê.
- **Conferir:** cada visão aparece nas duas tabelas.

## Passo 4: ciclo AGENDA ↔ FILA (Q8-07)
- **Arquivo:** `03-uml/Pacotes/diagrama-pacotes.mmd` (linhas 95 e 96: `AGENDA --> FILA` e `FILA --> AGENDA`)
- **Decisão do grupo:** (a) quebrar o ciclo com evento de domínio ("horário liberado"), ficando só `FILA --> AGENDA`; ou (b) manter como exceção justificada no PAC-001. Leve a escolha ao Pinho antes de editar.
- **Depois:** atualizar `diagrama-pacotes.drawio.xml` e o PDF, e corrigir a fala 3 do pitch em `04-persistencia/analises/fase-09-encerramento-e-pitch.md` §4.1 (e `08-pitch/roteiro-base-pitch.md` se citar "sem ciclo").
- **Conferir:** o `.mmd` não tem par de setas nos dois sentidos, ou a exceção está registrada no PAC-001.

## Passo 5: fechar a Fase 7 para o I5 conferir
- Quando os passos 1 a 4 estiverem prontos, avise o Pinho. Ele marca Q7-01 a Q7-05 em `05-qualidade/analises/fase-07-revisao-arquitetura-persistencia.md`.
- Q7-04 (ator de e-mail no contexto e no caso de uso) depende do Aquiles (Passo 1 dele).

## Como avisar que terminou
Commit sugerido: `docs(persistencia): exporta diagramas, testa DDL e fecha ISO 42010 (Q7-01 a Q7-03, Q8-07)`.
