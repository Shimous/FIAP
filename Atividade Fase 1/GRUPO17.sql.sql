-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   em:        2023-03-20 14:12:27 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cargo (
    cd_id     NUMBER(20) NOT NULL,
    descrição VARCHAR2(50),
    nivel     VARCHAR2(50),
    status    VARCHAR2(2)
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( cd_id );

CREATE TABLE t_sip_categoria (
    cd_id        NUMBER(20) NOT NULL,
    descrição    VARCHAR2(50) NOT NULL,
    status       VARCHAR2(2) NOT NULL,
    data_inicio  DATE NOT NULL,
    data_término DATE
);


CREATE SEQUENCE codigo_categoria
  minvalue 1
  maxvalue 999999
  START WITH 1
  INCREMENT BY 1
  nocache
  cycle;
  
  DROP SEQUENCE codigo_categoria;
  
ALTER TABLE t_sip_categoria ADD CONSTRAINT t_sip_categoria_pk PRIMARY KEY ( cd_id );

ALTER TABLE t_sip_categoria ADD CONSTRAINT un_sip_categoria UNIQUE ( cd_id,
                                                                     descrição );

CREATE TABLE t_sip_chamado (
    cd_id                   NUMBER(20) NOT NULL,
    data_hora_abertura      DATE NOT NULL,
    data_hora_atendimento   DATE,
    cd_funcionario          NUMBER(20),
    status                  VARCHAR2(2) NOT NULL,
    tempo_atendimento       DATE,
    insatisfação            VARCHAR2(4000),
    tipo                    VARCHAR2(50) NOT NULL,
    descrição               VARCHAR2(50) NOT NULL,
    t_sip_produto_cd_id     NUMBER(20),
    t_sip_cliente_cd_id     NUMBER(20),
    t_sip_funcionario_cd_id NUMBER(20)
);

CREATE SEQUENCE duvidas_sugestão
  minvalue 1
  maxvalue 10
  START WITH 1
  INCREMENT BY 1
  nocache
  cycle;
  
DROP SEQUENCE duvidas_sugestão;
  
ALTER TABLE t_sip_chamado ADD CONSTRAINT t_sip_chamado_pk PRIMARY KEY ( cd_id );

CREATE TABLE t_sip_cliente (
    sessão_ativa          NUMBER(10),
    cd_id                 NUMBER(20) NOT NULL,
    nm_cliente            VARCHAR2(50) NOT NULL,
    qtd_estrelas          NUMBER(10),
    telefone              VARCHAR2(50),
    login                 VARCHAR2(50) NOT NULL,
    senha                 NUMBER(20) NOT NULL,
    cpf                   NUMBER(20) NOT NULL,
    data_nasc             DATE NOT NULL,
    sexo                  CHAR(3) NOT NULL,
    genero_nasc           VARCHAR2(10),
    status                VARCHAR2(2) NOT NULL,
    data_fundação         DATE,
    cnpj                  NUMBER(30),
    nm_inscrição_estadual NUMBER(20)
);

ALTER TABLE t_sip_cliente ADD CONSTRAINT t_sip_cliente_pk PRIMARY KEY ( cd_id );

CREATE TABLE t_sip_funcionario (
    cd_id          NUMBER(20) NOT NULL,
    nm_funcionario VARCHAR2(50) NOT NULL,
    cpf            NUMBER(20) NOT NULL,
    data_nasc      DATE NOT NULL,
    telefone       VARCHAR2(20) NOT NULL,
    "E-mail"       VARCHAR2(50) NOT NULL,
    cargo          VARCHAR2(50) NOT NULL,
    departamento   VARCHAR2(50),
    cargo_cd_id    NUMBER(20)
);

ALTER TABLE t_sip_funcionario ADD CONSTRAINT t_sip_funcionario_pk PRIMARY KEY ( cd_id );

ALTER TABLE t_sip_funcionario ADD CONSTRAINT un_sip_funcionario UNIQUE ( cpf );

CREATE TABLE t_sip_produto (
    cd_id_1              NUMBER(20) NOT NULL,
    pr_unitario           NUMBER(10, 2) NOT NULL,
    cd_categoria          NUMBER(20),
    status                VARCHAR2(2),
    descrição_normal      VARCHAR2(100) NOT NULL,
    descrição_completa    VARCHAR2(100) NOT NULL,
    codigo_de_barras      NUMBER(20),
    t_sip_categoria_cd_id NUMBER(20)
);

CREATE SEQUENCE codigo_identificação
  minvalue 1
  maxvalue 999999
  START WITH 1
  INCREMENT BY 1
  nocache
  cycle;
  
    DROP SEQUENCE codigo_identificação;

ALTER TABLE t_sip_produto ADD CONSTRAINT t_sip_produto_pk PRIMARY KEY ( cd_id_1 );

ALTER TABLE t_sip_produto ADD CONSTRAINT un_sip_produto UNIQUE ( descrição_normal );

CREATE TABLE t_sip_video_classi (
    cd_id     NUMBER(20) NOT NULL,
    descrição VARCHAR2(50)
);

ALTER TABLE t_sip_video_classi ADD CONSTRAINT t_sip_video_classi_pk PRIMARY KEY ( cd_id );

CREATE TABLE t_sip_video_produto (
    cd_id_1                  NUMBER(20) NOT NULL,
    status                   VARCHAR2(2),
    data_cadastro            DATE,
    t_sip_produto_cd_id      NUMBER(20),
    t_sip_video_classi_cd_id NUMBER(20)
);

ALTER TABLE t_sip_video_produto ADD CONSTRAINT t_sip_video_produto_pk PRIMARY KEY ( cd_id_1 );

CREATE TABLE t_sip_visualização (
    cd_id                     NUMBER(20) NOT NULL,
    data_hora                 DATE NOT NULL,
    min                       DATE,
    seg                       DATE,
    cd_produto                NUMBER(20) NOT NULL,
    usuario                   VARCHAR2(50),
    t_sip_produto_cd_id       NUMBER(20),
    t_sip_video_produto_cd_id NUMBER(20)
);

ALTER TABLE t_sip_visualização ADD CONSTRAINT t_sip_visualização_pk PRIMARY KEY ( cd_id );

ALTER TABLE t_sip_produto
    ADD CONSTRAINT t_sip_categoria_fk FOREIGN KEY ( t_sip_categoria_cd_id )
        REFERENCES t_sip_categoria ( cd_id );

ALTER TABLE t_sip_chamado
    ADD CONSTRAINT t_sip_cliente_fk FOREIGN KEY ( t_sip_cliente_cd_id )
        REFERENCES t_sip_cliente ( cd_id );

ALTER TABLE t_sip_funcionario
    ADD CONSTRAINT t_sip_funcionario_cargo_fk FOREIGN KEY ( cargo_cd_id )
        REFERENCES cargo ( cd_id );

ALTER TABLE t_sip_chamado
    ADD CONSTRAINT t_sip_funcionario_fk FOREIGN KEY ( t_sip_funcionario_cd_id )
        REFERENCES t_sip_funcionario ( cd_id );

ALTER TABLE t_sip_video_produto
    ADD CONSTRAINT t_sip_produto_fk FOREIGN KEY ( t_sip_produto_cd_id )
        REFERENCES t_sip_produto ( cd_id_1 );

ALTER TABLE t_sip_visualização
    ADD CONSTRAINT t_sip_produto_fkv1 FOREIGN KEY ( t_sip_produto_cd_id )
        REFERENCES t_sip_produto ( cd_id_1 );

ALTER TABLE t_sip_chamado
    ADD CONSTRAINT t_sip_produto_fkv2 FOREIGN KEY ( t_sip_produto_cd_id )
        REFERENCES t_sip_produto ( cd_id_1 );

ALTER TABLE t_sip_video_produto
    ADD CONSTRAINT t_sip_video_classi_fk FOREIGN KEY ( t_sip_video_classi_cd_id )
        REFERENCES t_sip_video_classi ( cd_id );

ALTER TABLE t_sip_visualização
    ADD CONSTRAINT t_sip_video_produto_fk FOREIGN KEY ( t_sip_video_produto_cd_id )
        REFERENCES t_sip_video_produto ( cd_id_1 );

DROP database ORCL_FIAP;


-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             21
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
