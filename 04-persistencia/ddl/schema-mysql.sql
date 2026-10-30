-- =====================================================================
--  Plataforma para Psicologos - AV3
--  DDL do modelo relacional - Fase 7
--  Responsavel: Integrante 4 - Caio Cunha (persistencia e arquitetura)
--  Versao: 1.0 - 29/10/2026
--  SGBD: MySQL 8.0.16 ou superior (CHECK so e aplicado a partir de 8.0.16)
--
--  Fontes:
--    04-persistencia/der/der-001-logico.md      (DER-001)
--    04-persistencia/modelo-relacional.md       (restricoes)
--    04-persistencia/dicionario-de-dados.md     (colunas e dominios)
--
--  Decisoes aplicadas: DEC-013 a DEC-030.
--  Nao existem tabelas de sessao (DEC-020) nem de notificacao (DEC-022).
--
--  Observacoes de implementacao:
--   - O MySQL nao tem indice unico parcial. As regras "no maximo um X
--     ativo" usam coluna gerada que vale 1 na condicao e NULL fora dela;
--     o indice unico ignora os NULL. Ver normalizacao.md secao 5.3.
--   - Todas as FK sao ON DELETE RESTRICT: nao ha exclusao em cascata
--     sobre dado de negocio (RNF-009, RN-014).
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TRIGGER IF EXISTS trg_auditoria_sem_update;
DROP TRIGGER IF EXISTS trg_auditoria_sem_delete;
DROP TRIGGER IF EXISTS trg_se_entrada_imutavel;

DROP TABLE IF EXISTS registro_auditoria;
DROP TABLE IF EXISTS solicitacao_espera;
DROP TABLE IF EXISTS atendimento;
DROP TABLE IF EXISTS agendamento;
DROP TABLE IF EXISTS disponibilidade;
DROP TABLE IF EXISTS agenda;
DROP TABLE IF EXISTS vinculo;
DROP TABLE IF EXISTS paciente;
DROP TABLE IF EXISTS psicologo_area_atuacao;
DROP TABLE IF EXISTS psicologo;
DROP TABLE IF EXISTS area_atuacao;
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS perfil_permissao;
DROP TABLE IF EXISTS permissao;
DROP TABLE IF EXISTS perfil;

SET FOREIGN_KEY_CHECKS = 1;


-- =====================================================================
-- 1. PERFIL
--    RF-007 - catalogo de perfis de acesso.
-- =====================================================================
CREATE TABLE perfil (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome          VARCHAR(60)     NOT NULL,
  descricao     VARCHAR(255)        NULL,
  criado_em     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_perfil_nome (nome),
  CONSTRAINT ck_perfil_nome CHECK (CHAR_LENGTH(TRIM(nome)) > 0)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-007 - perfil de acesso';


-- =====================================================================
-- 2. PERMISSAO
--    RF-008 - operacao autorizavel. O codigo e a chave de negocio.
-- =====================================================================
CREATE TABLE permissao (
  id        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  codigo    VARCHAR(60)     NOT NULL,
  descricao VARCHAR(255)        NULL,
  criado_em DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_permissao_codigo (codigo),
  CONSTRAINT ck_permissao_codigo CHECK (codigo REGEXP '^[A-Z][A-Z0-9_]*$')
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-008 - permissao autorizavel';


-- =====================================================================
-- 3. PERFIL_PERMISSAO
--    Associativa do N:N A02 (Perfil x Permissao).
-- =====================================================================
CREATE TABLE perfil_permissao (
  id_perfil    BIGINT UNSIGNED NOT NULL,
  id_permissao BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (id_perfil, id_permissao),
  KEY ix_pp_permissao (id_permissao),
  CONSTRAINT fk_pp_perfil
    FOREIGN KEY (id_perfil)    REFERENCES perfil (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_pp_permissao
    FOREIGN KEY (id_permissao) REFERENCES permissao (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'A02 - N:N Perfil x Permissao';


-- =====================================================================
-- 4. USUARIO
--    RF-001 a RF-006. DEC-013 (situacao), DEC-019 (um perfil por conta).
--    Nao existe coluna de senha em texto puro (RN-002, RNF-001).
-- =====================================================================
CREATE TABLE usuario (
  id             BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  identificacao  VARCHAR(80)     NOT NULL,
  hash_senha     VARCHAR(255)    NOT NULL,
  situacao_conta VARCHAR(12)     NOT NULL DEFAULT 'ATIVO',
  id_perfil      BIGINT UNSIGNED NOT NULL,
  criado_em      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                 ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_usuario_identificacao (identificacao),
  KEY ix_usuario_situacao (situacao_conta),
  KEY ix_usuario_perfil (id_perfil),
  CONSTRAINT fk_usuario_perfil
    FOREIGN KEY (id_perfil) REFERENCES perfil (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_usuario_situacao
    CHECK (situacao_conta IN ('ATIVO', 'BLOQUEADO', 'INATIVO')),
  CONSTRAINT ck_usuario_identificacao
    CHECK (CHAR_LENGTH(TRIM(identificacao)) > 0),
  CONSTRAINT ck_usuario_hash
    CHECK (CHAR_LENGTH(hash_senha) >= 20)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-001..RF-006 - conta de acesso';


-- =====================================================================
-- 5. AREA_ATUACAO
--    RF-016 - catalogo de especialidades.
-- =====================================================================
CREATE TABLE area_atuacao (
  id        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nome      VARCHAR(80)     NOT NULL,
  descricao VARCHAR(255)        NULL,
  criado_em DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_area_atuacao_nome (nome),
  CONSTRAINT ck_area_atuacao_nome CHECK (CHAR_LENGTH(TRIM(nome)) > 0)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-016 - area de atuacao';


-- =====================================================================
-- 6. PSICOLOGO
--    RF-014, RF-015. DEC-021: conta de acesso opcional.
-- =====================================================================
CREATE TABLE psicologo (
  id                    BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario            BIGINT UNSIGNED     NULL,
  nome                  VARCHAR(120)    NOT NULL,
  registro_profissional VARCHAR(40)         NULL,
  email_contato         VARCHAR(160)        NULL,
  criado_em             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em         DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                        ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_psicologo_usuario (id_usuario),
  CONSTRAINT fk_psicologo_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_psicologo_nome CHECK (CHAR_LENGTH(TRIM(nome)) > 0),
  CONSTRAINT ck_psicologo_email
    CHECK (email_contato IS NULL OR email_contato LIKE '%_@_%._%')
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-014/RF-015 - cadastro profissional';


-- =====================================================================
-- 7. PSICOLOGO_AREA_ATUACAO
--    Associativa do N:N A05 (Psicologo x AreaAtuacao).
-- =====================================================================
CREATE TABLE psicologo_area_atuacao (
  id_psicologo    BIGINT UNSIGNED NOT NULL,
  id_area_atuacao BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (id_psicologo, id_area_atuacao),
  KEY ix_pa_area (id_area_atuacao),
  CONSTRAINT fk_pa_psicologo
    FOREIGN KEY (id_psicologo)    REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_pa_area
    FOREIGN KEY (id_area_atuacao) REFERENCES area_atuacao (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'A05 - N:N Psicologo x AreaAtuacao';


-- =====================================================================
-- 8. PACIENTE
--    RF-018 a RF-020, RF-022. DEC-014 (situacao), DEC-021 (conta opcional).
--    Nao ha dado clinico (DEC-008).
-- =====================================================================
CREATE TABLE paciente (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario         BIGINT UNSIGNED     NULL,
  nome               VARCHAR(120)    NOT NULL,
  email_contato      VARCHAR(160)        NULL,
  situacao_cadastral VARCHAR(10)     NOT NULL DEFAULT 'ATIVO',
  criado_em          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                     ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_paciente_usuario (id_usuario),
  KEY ix_paciente_situacao (situacao_cadastral),
  CONSTRAINT fk_paciente_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_paciente_situacao
    CHECK (situacao_cadastral IN ('ATIVO', 'SUSPENSO', 'INATIVO')),
  CONSTRAINT ck_paciente_nome CHECK (CHAR_LENGTH(TRIM(nome)) > 0),
  CONSTRAINT ck_paciente_email
    CHECK (email_contato IS NULL OR email_contato LIKE '%_@_%._%')
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-018..RF-020 - cadastro do cliente/paciente';


-- =====================================================================
-- 9. VINCULO
--    RF-017, RF-021. DEC-015 (situacao e temporalidade).
--    RN-016: no maximo um vinculo ATIVO por par (indice unico parcial
--    simulado pela coluna gerada 'vigente').
-- =====================================================================
CREATE TABLE vinculo (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_psicologo  BIGINT UNSIGNED NOT NULL,
  id_paciente   BIGINT UNSIGNED NOT NULL,
  situacao      VARCHAR(10)     NOT NULL DEFAULT 'ATIVO',
  data_inicio   DATE            NOT NULL,
  data_fim      DATE                NULL,
  vigente       TINYINT UNSIGNED GENERATED ALWAYS AS (
                  CASE WHEN situacao = 'ATIVO' THEN 1 ELSE NULL END
                ) STORED,
  criado_em     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_vinculo_vigente (id_psicologo, id_paciente, vigente),
  KEY ix_vinculo_psicologo (id_psicologo, situacao),
  KEY ix_vinculo_paciente (id_paciente, situacao),
  CONSTRAINT fk_vinculo_psicologo
    FOREIGN KEY (id_psicologo) REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_vinculo_paciente
    FOREIGN KEY (id_paciente) REFERENCES paciente (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_vinculo_situacao
    CHECK (situacao IN ('ATIVO', 'ENCERRADO')),
  CONSTRAINT ck_vinculo_temporal
    CHECK (
      (situacao = 'ATIVO' AND data_fim IS NULL)
      OR
      (situacao = 'ENCERRADO' AND data_fim IS NOT NULL AND data_fim >= data_inicio)
    )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-017/RF-021 - vinculo psicologo-paciente (RN-003, RN-016)';


-- =====================================================================
-- 10. AGENDA
--     RF-023, RF-029. A08 como 1:1.
--     uk_agenda_id_psicologo existe para sustentar a FK composta de
--     disponibilidade (RN-011).
-- =====================================================================
CREATE TABLE agenda (
  id            BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_psicologo  BIGINT UNSIGNED NOT NULL,
  criado_em     DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_agenda_psicologo (id_psicologo),
  UNIQUE KEY uk_agenda_id_psicologo (id, id_psicologo),
  CONSTRAINT fk_agenda_psicologo
    FOREIGN KEY (id_psicologo) REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'A08 - agenda do psicologo (1:1)';


-- =====================================================================
-- 11. DISPONIBILIDADE
--     RF-023, RF-024. DEC-018: slot discreto.
--     RN-011 garantida por FK composta (id_agenda, id_psicologo).
-- =====================================================================
CREATE TABLE disponibilidade (
  id               BIGINT UNSIGNED  NOT NULL AUTO_INCREMENT,
  id_agenda        BIGINT UNSIGNED  NOT NULL,
  id_psicologo     BIGINT UNSIGNED  NOT NULL,
  data             DATE             NOT NULL,
  hora_inicio      TIME             NOT NULL,
  duracao_minutos  SMALLINT UNSIGNED NOT NULL,
  criado_em        DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_disp_id_psicologo (id, id_psicologo),
  UNIQUE KEY uk_disp_slot (id_agenda, data, hora_inicio),
  CONSTRAINT fk_disp_agenda
    FOREIGN KEY (id_agenda) REFERENCES agenda (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_disp_agenda_psicologo
    FOREIGN KEY (id_agenda, id_psicologo) REFERENCES agenda (id, id_psicologo)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_disp_duracao CHECK (duracao_minutos BETWEEN 5 AND 480)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-023/RF-024 - slot de disponibilidade (DEC-018)';


-- =====================================================================
-- 12. AGENDAMENTO
--     RF-025 a RF-029, RF-037.
--     RN-005: um slot, no maximo um agendamento CONFIRMADO
--             (indice unico parcial simulado por 'slot_ativo').
--     RN-018: o slot ocupado e do psicologo do agendamento (FK composta).
--     DEC-016: nao existe 'SOLICITADO'.
-- =====================================================================
CREATE TABLE agendamento (
  id                        BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_disponibilidade        BIGINT UNSIGNED NOT NULL,
  id_psicologo              BIGINT UNSIGNED NOT NULL,
  id_paciente               BIGINT UNSIGNED NOT NULL,
  situacao                  VARCHAR(16)     NOT NULL DEFAULT 'CONFIRMADO',
  data_cancelamento         DATETIME            NULL,
  id_usuario_cancelamento   BIGINT UNSIGNED     NULL,
  data_nao_comparecimento   DATETIME            NULL,
  slot_ativo                BIGINT UNSIGNED GENERATED ALWAYS AS (
                              CASE WHEN situacao = 'CONFIRMADO'
                                   THEN id_disponibilidade
                                   ELSE NULL END
                            ) STORED,
  criado_em                 DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em             DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                            ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_agendamento_slot_ativo (slot_ativo),
  UNIQUE KEY uk_agendamento_tripla (id, id_psicologo, id_paciente),
  KEY ix_agendamento_psicologo (id_psicologo, situacao),
  KEY ix_agendamento_paciente (id_paciente, situacao),
  KEY ix_agendamento_cancelamento (id_usuario_cancelamento),
  CONSTRAINT fk_agendamento_slot
    FOREIGN KEY (id_disponibilidade, id_psicologo)
    REFERENCES disponibilidade (id, id_psicologo)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_agendamento_psicologo
    FOREIGN KEY (id_psicologo) REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_agendamento_paciente
    FOREIGN KEY (id_paciente) REFERENCES paciente (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_agendamento_cancelamento
    FOREIGN KEY (id_usuario_cancelamento) REFERENCES usuario (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_agendamento_situacao
    CHECK (situacao IN ('CONFIRMADO', 'CANCELADO', 'REALIZADO', 'NAO_COMPARECEU')),
  CONSTRAINT ck_agendamento_cancelamento
    CHECK (
      (situacao = 'CANCELADO')
      = (data_cancelamento IS NOT NULL AND id_usuario_cancelamento IS NOT NULL)
    ),
  CONSTRAINT ck_agendamento_nao_comparecimento
    CHECK (
      (situacao = 'NAO_COMPARECEU') = (data_nao_comparecimento IS NOT NULL)
    )
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-025..RF-029/RF-037 - agendamento (RN-005, RN-018, DEC-016)';


-- =====================================================================
-- 13. ATENDIMENTO
--     RF-030, RF-031.
--     RN-017: obrigatorio referenciar o agendamento (UNIQUE).
--     RN-019: o trio (agendamento, psicologo, paciente) e coerente
--             (FK composta para agendamento).
-- =====================================================================
CREATE TABLE atendimento (
  id                 BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_agendamento     BIGINT UNSIGNED NOT NULL,
  id_psicologo       BIGINT UNSIGNED NOT NULL,
  id_paciente        BIGINT UNSIGNED NOT NULL,
  data_hora_registro DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  contexto_sessao    VARCHAR(500)        NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uk_atendimento_agendamento (id_agendamento),
  KEY ix_atendimento_par (id_psicologo, id_paciente, data_hora_registro),
  CONSTRAINT fk_atendimento_agendamento
    FOREIGN KEY (id_agendamento, id_psicologo, id_paciente)
    REFERENCES agendamento (id, id_psicologo, id_paciente)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_atendimento_psicologo
    FOREIGN KEY (id_psicologo) REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_atendimento_paciente
    FOREIGN KEY (id_paciente) REFERENCES paciente (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_atendimento_contexto
    CHECK (contexto_sessao IS NULL OR CHAR_LENGTH(contexto_sessao) <= 500)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-030/RF-031 - atendimento (RN-017, RN-019)';


-- =====================================================================
-- 14. SOLICITACAO_ESPERA
--     RF-034 a RF-036, DEC-027.
--     RN-023: ordem por data_hora_entrada, sem coluna de posicao.
--     RN-024: no maximo uma oferta aberta por slot.
--     Uma linha por tentativa: recusar e reentrar cria nova linha.
-- =====================================================================
CREATE TABLE solicitacao_espera (
  id                     BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_psicologo           BIGINT UNSIGNED NOT NULL,
  id_paciente            BIGINT UNSIGNED NOT NULL,
  id_disponibilidade     BIGINT UNSIGNED NOT NULL,
  situacao               VARCHAR(12)     NOT NULL DEFAULT 'AGUARDANDO',
  data_hora_entrada      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  prazo_aceite           DATETIME            NULL,
  data_hora_encerramento DATETIME            NULL,
  id_agendamento         BIGINT UNSIGNED     NULL,
  fila_ativa             TINYINT UNSIGNED GENERATED ALWAYS AS (
                           CASE WHEN situacao IN ('AGUARDANDO', 'OFERTADA')
                                THEN 1 ELSE NULL END
                         ) STORED,
  oferta_aberta          TINYINT UNSIGNED GENERATED ALWAYS AS (
                           CASE WHEN situacao = 'OFERTADA'
                                THEN 1 ELSE NULL END
                         ) STORED,
  atualizado_em          DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP
                                         ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uk_se_agendamento (id_agendamento),
  UNIQUE KEY uk_se_fila (id_disponibilidade, id_paciente, fila_ativa),
  UNIQUE KEY uk_se_oferta (id_disponibilidade, oferta_aberta),
  KEY ix_se_slot (id_disponibilidade, situacao, data_hora_entrada),
  KEY ix_se_psicologo (id_psicologo, situacao, data_hora_entrada),
  KEY ix_se_paciente (id_paciente, situacao, data_hora_entrada),
  CONSTRAINT fk_se_psicologo
    FOREIGN KEY (id_psicologo) REFERENCES psicologo (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_se_paciente
    FOREIGN KEY (id_paciente) REFERENCES paciente (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_se_slot
    FOREIGN KEY (id_disponibilidade, id_psicologo)
    REFERENCES disponibilidade (id, id_psicologo)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_se_agendamento
    FOREIGN KEY (id_agendamento) REFERENCES agendamento (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_se_situacao
    CHECK (situacao IN ('AGUARDANDO', 'OFERTADA', 'ACEITA',
                        'RECUSADA', 'EXPIRADA', 'DESISTIU')),
  CONSTRAINT ck_se_prazo
    CHECK (situacao <> 'OFERTADA' OR prazo_aceite IS NOT NULL),
  CONSTRAINT ck_se_encerramento
    CHECK (situacao IN ('AGUARDANDO', 'OFERTADA')
           OR data_hora_encerramento IS NOT NULL),
  CONSTRAINT ck_se_aceite
    CHECK (situacao <> 'ACEITA' OR id_agendamento IS NOT NULL)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-034..RF-036 - lista de espera (DEC-027, RN-023, RN-024)';


-- =====================================================================
-- 15. REGISTRO_AUDITORIA
--     RF-013, RF-032. DEC-024: situacao anterior e nova.
--     DEC-029: falha de e-mail registrada como FALHA_ENVIO_EMAIL.
--     RN-014: append-only (ver triggers da secao 17).
--     id_entidade e polimorfico e sem FK, por decisao (MD-16).
-- =====================================================================
CREATE TABLE registro_auditoria (
  id                BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario        BIGINT UNSIGNED     NULL,
  data_hora         DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
  operacao          VARCHAR(60)     NOT NULL,
  entidade          VARCHAR(40)     NOT NULL,
  id_entidade       BIGINT UNSIGNED     NULL,
  situacao_anterior VARCHAR(20)         NULL,
  situacao_nova     VARCHAR(20)         NULL,
  resultado         VARCHAR(10)     NOT NULL DEFAULT 'SUCESSO',
  detalhe           VARCHAR(255)        NULL,
  PRIMARY KEY (id),
  KEY ix_auditoria_data (data_hora),
  KEY ix_auditoria_usuario (id_usuario, data_hora),
  KEY ix_auditoria_operacao (operacao, data_hora),
  CONSTRAINT fk_auditoria_usuario
    FOREIGN KEY (id_usuario) REFERENCES usuario (id)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT ck_auditoria_operacao CHECK (CHAR_LENGTH(TRIM(operacao)) > 0),
  CONSTRAINT ck_auditoria_entidade CHECK (CHAR_LENGTH(TRIM(entidade)) > 0),
  CONSTRAINT ck_auditoria_resultado
    CHECK (resultado IN ('SUCESSO', 'FALHA')),
  CONSTRAINT ck_auditoria_situacao_par
    CHECK ((situacao_anterior IS NULL) = (situacao_nova IS NULL))
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_0900_ai_ci
  COMMENT = 'RF-013/RF-032 - trilha de auditoria (RN-014, DEC-024, DEC-029)';


-- =====================================================================
-- 16. INDICES ADICIONAIS
--     Os indices das consultas de RF-013, RF-024, RF-028, RF-029,
--     RF-031 e RF-034 ja foram declarados nas tabelas. Nao ha indice
--     sobre hash_senha (nunca e buscado) nem sobre contexto_sessao
--     (nao e pesquisavel).
-- =====================================================================


-- =====================================================================
-- 17. GARANTIAS PROCEDURAIS (opcionais, recomendadas)
--     Aplicam o que o CHECK nao consegue expressar:
--       - RN-014: auditoria imutavel (sem UPDATE, sem DELETE);
--       - RN-023: data_hora_entrada imutavel.
--     Podem ser substituidas por privilegios de usuario (secao 19).
-- =====================================================================
DELIMITER $$

CREATE TRIGGER trg_auditoria_sem_update
BEFORE UPDATE ON registro_auditoria
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'registro_auditoria e append-only: UPDATE recusado (RN-014)';
END$$

CREATE TRIGGER trg_auditoria_sem_delete
BEFORE DELETE ON registro_auditoria
FOR EACH ROW
BEGIN
  SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'registro_auditoria e append-only: DELETE recusado (RN-014)';
END$$

CREATE TRIGGER trg_se_entrada_imutavel
BEFORE UPDATE ON solicitacao_espera
FOR EACH ROW
BEGIN
  IF NEW.data_hora_entrada <> OLD.data_hora_entrada THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'data_hora_entrada e imutavel: a ordem da fila nao pode ser reescrita (RN-023)';
  END IF;
END$$

DELIMITER ;


-- =====================================================================
-- 18. CARGA INICIAL MINIMA
--     Apenas os tres perfis citados em RF-001 e os codigos de permissao
--     usados pelo catalogo de auditoria (dicionario secao 4.2).
--     A matriz perfil x permissao e decisao de RF-007/RF-008 e NAO e
--     carregada aqui.
-- =====================================================================
INSERT INTO perfil (nome, descricao) VALUES
  ('Administrador',   'Perfil administrativo (RF-001)'),
  ('Psicologo',       'Perfil do profissional (RF-001)'),
  ('Cliente/Paciente','Perfil do cliente/paciente (RF-001)');

INSERT INTO permissao (codigo, descricao) VALUES
  ('USUARIO_CRIAR',            'Cadastrar usuario (RF-003)'),
  ('USUARIO_ALTERAR',          'Alterar dados de usuario (RF-004)'),
  ('USUARIO_ATIVAR',           'Ativar usuario (RF-005)'),
  ('USUARIO_BLOQUEAR',         'Bloquear usuario (RF-006)'),
  ('PERFIL_GERENCIAR',         'Gerenciar perfis (RF-007)'),
  ('PERMISSAO_GERENCIAR',      'Gerenciar permissoes (RF-008)'),
  ('PAINEL_CONSULTAR',         'Consultar painel administrativo (RF-009)'),
  ('USUARIO_CONSULTAR',        'Consultar usuarios cadastrados (RF-010)'),
  ('PSICOLOGO_CONSULTAR',      'Consultar psicologos (RF-011)'),
  ('PACIENTE_CONSULTAR',       'Consultar pacientes (RF-012)'),
  ('AUDITORIA_CONSULTAR',      'Consultar registros de auditoria (RF-013)'),
  ('PSICOLOGO_GERENCIAR',      'Cadastrar e atualizar psicologo (RF-014, RF-015)'),
  ('AREA_ATUACAO_ASSOCIAR',    'Associar area de atuacao (RF-016)'),
  ('PACIENTE_VINCULADO_CONSULTAR', 'Consultar pacientes vinculados (RF-017)'),
  ('PACIENTE_GERENCIAR',       'Cadastrar e atualizar paciente (RF-018, RF-019)'),
  ('PACIENTE_SITUACAO_ALTERAR','Alterar situacao do paciente (RF-020)'),
  ('VINCULO_GERENCIAR',        'Vincular paciente a psicologo (RF-021)'),
  ('PROPRIO_CADASTRO_CONSULTAR','Consultar o proprio cadastro (RF-022)'),
  ('DISPONIBILIDADE_GERENCIAR','Cadastrar disponibilidade (RF-023)'),
  ('HORARIO_CONSULTAR',        'Consultar horarios disponiveis (RF-024)'),
  ('AGENDAMENTO_SOLICITAR',    'Solicitar agendamento (RF-025)'),
  ('AGENDAMENTO_CANCELAR',     'Cancelar agendamento (RF-027)'),
  ('AGENDAMENTO_CONSULTAR',    'Consultar os proprios agendamentos (RF-028)'),
  ('AGENDA_CONSULTAR',         'Consultar agenda do psicologo (RF-029)'),
  ('ATENDIMENTO_REGISTRAR',    'Registrar atendimento (RF-030)'),
  ('HISTORICO_CONSULTAR',      'Consultar historico permitido (RF-031)'),
  ('LISTA_ESPERA_ENTRAR',      'Entrar na lista de espera (RF-034)'),
  ('LISTA_ESPERA_RESPONDER',   'Responder a oferta de vaga (RF-036)'),
  ('NAO_COMPARECIMENTO_REGISTRAR', 'Registrar nao comparecimento (RF-037)');


-- =====================================================================
-- 19. PRIVILEGIOS RECOMENDADOS (exemplo, nao executado)
--     A conta da aplicacao nao deve poder apagar nem reescrever historia.
-- =====================================================================
-- CREATE USER 'app_moo'@'%' IDENTIFIED BY '<definir-em-segredo>';
-- GRANT SELECT, INSERT, UPDATE ON moo.* TO 'app_moo'@'%';
-- REVOKE UPDATE ON moo.registro_auditoria FROM 'app_moo'@'%';
-- REVOKE DELETE ON moo.* FROM 'app_moo'@'%';
-- GRANT DELETE ON moo.perfil_permissao TO 'app_moo'@'%';
-- GRANT DELETE ON moo.psicologo_area_atuacao TO 'app_moo'@'%';
-- GRANT SELECT, INSERT ON moo.registro_auditoria TO 'app_moo'@'%';


-- =====================================================================
-- 20. CONSULTAS DE VERIFICACAO
-- =====================================================================

-- 20.1 Horarios livres de um psicologo em um dia (RF-024).
--      Slot livre = sem agendamento CONFIRMADO e sem oferta aberta.
-- SELECT d.id, d.data, d.hora_inicio, d.duracao_minutos
--   FROM disponibilidade d
--  WHERE d.id_psicologo = ?
--    AND d.data = ?
--    AND NOT EXISTS (SELECT 1 FROM agendamento a
--                     WHERE a.id_disponibilidade = d.id
--                       AND a.situacao = 'CONFIRMADO')
--    AND NOT EXISTS (SELECT 1 FROM solicitacao_espera s
--                     WHERE s.id_disponibilidade = d.id
--                       AND s.situacao = 'OFERTADA')
--  ORDER BY d.hora_inicio;

-- 20.2 Proximo da fila de um slot (RF-035, RN-023).
-- SELECT s.id, s.id_paciente, s.data_hora_entrada
--   FROM solicitacao_espera s
--  WHERE s.id_disponibilidade = ?
--    AND s.situacao = 'AGUARDANDO'
--  ORDER BY s.data_hora_entrada, s.id
--  LIMIT 1;

-- 20.3 Pacientes com vinculo ativo de um psicologo (RF-017).
-- SELECT v.id, p.nome, v.data_inicio
--   FROM vinculo v
--   JOIN paciente p ON p.id = v.id_paciente
--  WHERE v.id_psicologo = ?
--    AND v.situacao = 'ATIVO'
--    AND v.data_inicio <= CURDATE()
--    AND (v.data_fim IS NULL OR v.data_fim >= CURDATE());

-- 20.4 Agenda do psicologo com marcacao de vinculo encerrado (RF-029, DEC-015).
-- SELECT a.id, d.data, d.hora_inicio, a.situacao,
--        p.nome AS paciente,
--        CASE WHEN v.id IS NULL THEN 'SEM VINCULO ATIVO' ELSE 'OK' END AS vinculo
--   FROM agendamento a
--   JOIN disponibilidade d ON d.id = a.id_disponibilidade
--   JOIN paciente p        ON p.id = a.id_paciente
--   LEFT JOIN vinculo v    ON v.id_psicologo = a.id_psicologo
--                         AND v.id_paciente  = a.id_paciente
--                         AND v.situacao     = 'ATIVO'
--  WHERE a.id_psicologo = ?
--    AND d.data BETWEEN ? AND ?
--  ORDER BY d.data, d.hora_inicio;

-- =====================================================================
-- Fim do script.
-- =====================================================================
