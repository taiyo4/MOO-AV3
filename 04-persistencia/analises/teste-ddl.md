# Teste de execução do DDL no MySQL 8.0 (Q7-02)

**Responsável:** Integrante 4 - Caio Cunha (persistência e arquitetura)
**Fase do plano:** Fase 7 - fechamento do achado Q7-02 (revisão do Integrante 5)
**Data:** 10/11/2026 - **Versão:** v1.0
**Arquivo testado:** [`../ddl/schema-mysql.sql`](../ddl/schema-mysql.sql) (versão 1.0, 29/10/2026)
**Objetivo:** provar que o DDL executa em um MySQL 8.0 limpo, sem erro, e que o esquema criado bate com o censo declarado em `fase-09-encerramento-e-pitch.md` §2.

---

## 1. Ambiente

| Item | Valor |
|---|---|
| Sistema | Windows 10/11 (ambiente do Integrante 4) |
| SGBD | **MySQL 8.0.44** (ZIP portátil `mysql-8.0.44-winx64.zip`, sem instalação e sem serviço) |
| Cliente | `mysql.exe` 8.0.44, o mesmo do ZIP |
| Diretório de dados | `%TEMP%\opencode\mysql\data` (temporário, descartado ao final) |
| Porta | `3307` (TCP, `127.0.0.1`), para não conflitar com instalação existente |
| Banco de teste | `moo_av3_teste` (`utf8mb4` / `utf8mb4_0900_ai_ci`) |
| `sql_mode` | `ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION` |

O ZIP portátil foi escolhido para respeitar a preferência do grupo de **não instalar ferramentas novas**: nada foi gravado em `Program Files`, nenhum serviço foi criado e o diretório de dados foi removido ao final.

---

## 2. Comandos usados

```powershell
# 1. inicializar o diretório de dados (sem senha de root)
mysqld --no-defaults --initialize-insecure --basedir=<zip>\mysql-8.0.44-winx64 --datadir=<temp>\data

# 2. subir o servidor em segundo plano
mysqld --no-defaults --basedir=<zip>\mysql-8.0.44-winx64 --datadir=<temp>\data `
       --port=3307 --bind-address=127.0.0.1 --mysqlx=0

# 3. criar o banco de teste
mysql -u root --protocol=TCP -h 127.0.0.1 -P 3307 --default-character-set=utf8mb4 `
      -e "CREATE DATABASE moo_av3_teste CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"

# 4. executar o DDL (cópia sem espaços no caminho, por causa do cliente)
mysql -u root --protocol=TCP -h 127.0.0.1 -P 3307 --default-character-set=utf8mb4 `
      --database=moo_av3_teste -e "SOURCE C:/.../schema-mysql.sql"
```

---

## 3. Resultado da execução

| Item | Resultado |
|---|---|
| Código de saída do cliente | **0** |
| Erros (`ERROR`) no log `--verbose` | **0** |
| Linhas do log `--verbose` | 572 (instruções + carga inicial) |
| Avisos que impedissem a criação | nenhum |
| Correção no `.sql` | **nenhuma foi necessária** |

O script executa na ordem declarada: `SET NAMES utf8mb4`, `DROP TRIGGER`/`DROP TABLE` (idempotência), 15 `CREATE TABLE`, os índices, os 3 triggers e a carga inicial. O log completo foi gerado com `--verbose` e terminou na carga de permissões, sem `ERROR`.

---

## 4. Censo do esquema criado

Consulta usada (MySQL 8.0, `information_schema`):

```sql
SELECT COUNT(*) FROM information_schema.tables      WHERE table_schema='moo_av3_teste';
SELECT COUNT(*) FROM information_schema.columns     WHERE table_schema='moo_av3_teste';
SELECT COUNT(*) FROM information_schema.table_constraints
 WHERE table_schema='moo_av3_teste' AND constraint_type='FOREIGN KEY';
SELECT COUNT(*) FROM information_schema.table_constraints
 WHERE table_schema='moo_av3_teste' AND constraint_type='CHECK';
SELECT COUNT(*) FROM information_schema.columns
 WHERE table_schema='moo_av3_teste' AND generation_expression <> '';
```

Saída real:

```text
+-----------------+
| versao_servidor |
+-----------------+
| 8.0.44          |
+-----------------+
+---------+
| tabelas |
+---------+
|      15 |
+---------+
+---------+
| colunas |
+---------+
|      97 |
+---------+
+----+
| pk |
+----+
| 15 |
+----+
+---------+
| uniques |
+---------+
|      17 |
+---------+
+-----+
| fks |
+-----+
|  24 |
+-----+
+--------+
| checks |
+--------+
|     26 |
+--------+
+-----------------------+
| colunas_geradas_reais |
+-----------------------+
|                     4 |
+-----------------------+
+----------+
| triggers |
+----------+
|        3 |
+----------+
+------------+
| indices_ix |
+------------+
|         17 |
+------------+
+--------+
| perfis |
+--------+
|      3 |
+--------+
+------------+
| permissoes |
+------------+
|         29 |
+------------+
```

As quatro colunas geradas são exatamente as documentadas:

```text
+--------------------+---------------+------------------+
| TABLE_NAME         | COLUMN_NAME   | EXTRA            |
+--------------------+---------------+------------------+
| agendamento        | slot_ativo    | STORED GENERATED |
| solicitacao_espera | fila_ativa    | STORED GENERATED |
| solicitacao_espera | oferta_aberta | STORED GENERATED |
| vinculo            | vigente       | STORED GENERATED |
+--------------------+---------------+------------------+
```

As 15 tabelas criadas: `agenda`, `agendamento`, `area_atuacao`, `atendimento`, `disponibilidade`, `paciente`, `perfil`, `perfil_permissao`, `permissao`, `psicologo`, `psicologo_area_atuacao`, `registro_auditoria`, `solicitacao_espera`, `usuario`, `vinculo`.

**Conferência:** 15 tabelas, 97 colunas, 15 PK, 17 UNIQUE, 24 FK, 26 CHECK, 4 colunas geradas `STORED`, 3 triggers, 17 índices `ix_` e a carga inicial de 3 perfis + 29 permissões - **todos os números batem** com o censo de `fase-09-encerramento-e-pitch.md` §2 e com o dicionário/modelo relacional.

---

## 5. Testes de restrição (amostra dos TDB-01, TDB-07 e TDB-08)

Os testes completos TDB-01 a TDB-14 estão definidos em `fase-08-verificacao-qualidade-persistencia.md`. Como o DDL agora executa, foram rodadas as três restrições mais diretas, com o resultado real:

| Teste | Comando (resumo) | Saída real | Veredito |
|---|---|---|---|
| **TDB-01a** - situação inválida | `INSERT INTO usuario (..., situacao_conta) VALUES (..., 'INVALIDO')` | `ERROR 3819 (HY000): Check constraint 'ck_usuario_situacao' is violated.` | recusa correta |
| **TDB-01b** - hash curto | `INSERT INTO usuario (..., hash_senha) VALUES (..., 'curto')` | `ERROR 3819 (HY000): Check constraint 'ck_usuario_hash' is violated.` | recusa correta |
| **TDB-01c** - conta válida | `INSERT INTO usuario (...) VALUES (..., 'ATIVO')` | `Query OK`; linha `1  teste_ok  ATIVO` | inserção correta |
| **TDB-08** - par de situação | `INSERT INTO registro_auditoria (..., situacao_anterior) VALUES (..., 'ATIVO')` sem `situacao_nova` | `ERROR 3819 (HY000): Check constraint 'ck_auditoria_situacao_par' is violated.` | recusa correta |
| **TDB-07a** - auditoria imutável (`UPDATE`) | `UPDATE registro_auditoria SET operacao='ALTERADO' ...` | `ERROR 1644 (45000): registro_auditoria e append-only: UPDATE recusado (RN-014)` | recusa correta |
| **TDB-07b** - auditoria imutável (`DELETE`) | `DELETE FROM registro_auditoria ...` | `ERROR 1644 (45000): registro_auditoria e append-only: DELETE recusado (RN-014)` | recusa correta |

Os demais TDB dependem de massa de dados (psicólogo, paciente, vínculo, slot e agendamento) e continuam como roteiro de execução na Fase 8; não foram necessários para provar que o DDL executa.

---

## 6. Conclusão

1. O `schema-mysql.sql` **executa sem erro** em MySQL 8.0.44 limpo, com `STRICT_TRANS_TABLES` ativo.
2. O esquema criado **confere com o censo declarado**: 15 tabelas, 97 colunas, 15 PK, 17 UNIQUE, 24 FK, 26 CHECK, 4 colunas geradas, 3 triggers e 17 índices `ix_`.
3. As restrições amostradas **recusam** o dado inválido com a mensagem esperada e **aceitam** o dado válido.
4. **Nenhuma correção no DDL foi necessária**; o arquivo permanece na versão 1.0.
5. O ambiente de teste foi descartado (banco `moo_av3_teste` removido e servidor encerrado); o procedimento é reprodutível com o ZIP portátil do MySQL 8.0.
