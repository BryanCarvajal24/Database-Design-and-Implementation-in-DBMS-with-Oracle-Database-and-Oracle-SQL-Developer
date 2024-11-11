-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-08-25 23:51:46 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



USE pruebanetflix;


DROP TABLE IF EXISTS visualizacion;
DROP TABLE IF EXISTS episodio;
DROP TABLE IF EXISTS pago;
DROP TABLE IF EXISTS temporada;
DROP TABLE IF EXISTS contenido;
DROP TABLE IF EXISTS perfiles;
DROP TABLE IF EXISTS usuario;


CREATE TABLE usuario (
    id_usuario         INTEGER NOT NULL,
    nombre             VARCHAR(100),
    apellidos          VARCHAR(100),
    correo_electronico VARCHAR(100) NOT NULL,
    telefono           VARCHAR(50) NOT NULL,
    direccion          VARCHAR(255),
    fecha_registro     DATE NOT NULL,
    tipo_suscripcion   VARCHAR(50) NOT NULL,
    fecha_nacimiento   DATE,
    estado_pago_cuenta CHAR(1) NOT NULL,
    suscripcion_activa CHAR(1) NOT NULL,
    red                VARCHAR(50),
    plataforma         VARCHAR(50),
    contraseña         VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario)
);


CREATE TABLE perfiles (
    id_perfil                  INTEGER NOT NULL,
    nombre_perfil              VARCHAR(100) NOT NULL,
    preferencias_visualizacion TEXT,
    pin                        VARCHAR(4),
    usuario_id_usuario         INTEGER NOT NULL,
    PRIMARY KEY (id_perfil),
    CONSTRAINT fk_perfiles_usuario FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario)
);


CREATE TABLE contenido (
    id_contenido           INTEGER NOT NULL,
    titulo                 VARCHAR(255) NOT NULL,
    descripcion            TEXT,
    categoria              VARCHAR(100) NOT NULL,
    rating                 DECIMAL NOT NULL,
    fecha_lanzamiento      DATE NOT NULL,
    tipo_contenido         VARCHAR(50) NOT NULL,
    duracion               INTEGER NOT NULL,
    contenido_relacionado  VARCHAR(255),
    perfiles_id_perfil     INTEGER NOT NULL,
    PRIMARY KEY (id_contenido),
    CONSTRAINT fk_contenido_perfiles FOREIGN KEY (perfiles_id_perfil)
        REFERENCES perfiles (id_perfil)
);


CREATE TABLE temporada (
    id_temporada           INTEGER NOT NULL,
    numero_temporada       INTEGER NOT NULL,
    contenido_id_contenido INTEGER NOT NULL,
    PRIMARY KEY (id_temporada),
    CONSTRAINT fk_temporada_contenido FOREIGN KEY (contenido_id_contenido)
        REFERENCES contenido (id_contenido)
);


CREATE TABLE episodio (
    id_episodio            INTEGER NOT NULL,
    titulo_episodio        VARCHAR(255) NOT NULL,
    duracion               INTEGER NOT NULL,
    numero_episodio        INTEGER NOT NULL,
    temporada_id_temporada INTEGER NOT NULL,
    PRIMARY KEY (id_episodio),
    CONSTRAINT fk_episodio_temporada FOREIGN KEY (temporada_id_temporada)
        REFERENCES temporada (id_temporada)
);


CREATE TABLE pago (
    id_pago              INTEGER NOT NULL,
    monto                DECIMAL NOT NULL,
    fecha_pago           DATE NOT NULL,
    metodo_pago          VARCHAR(50) NOT NULL,
    estado_pago1         VARCHAR(50) NOT NULL,
    suscripcion_duracion VARCHAR(50) NOT NULL,
    fecha_expiracion     DATE NOT NULL,
    usuario_id_usuario   INTEGER NOT NULL,
    estado_pago          CHAR(1) NOT NULL,
    PRIMARY KEY (id_pago),
    CONSTRAINT fk_pago_usuario FOREIGN KEY (usuario_id_usuario)
        REFERENCES usuario (id_usuario)
);


CREATE TABLE visualizacion (
    id_visualizacion       INTEGER NOT NULL,
    fecha_visualizacion    DATE NOT NULL,
    tiempo_visto           INTEGER NOT NULL,
    contenido_id_contenido INTEGER NOT NULL,
    PRIMARY KEY (id_visualizacion),
    CONSTRAINT fk_visualizacion_contenido FOREIGN KEY (contenido_id_contenido)
        REFERENCES contenido (id_contenido)
);




INSERT INTO usuario (id_usuario, nombre, apellidos, correo_electronico, telefono, direccion, fecha_registro, tipo_suscripcion, fecha_nacimiento, estado_pago_cuenta, suscripcion_activa, red, plataforma, contraseña)
VALUES
(101, 'Juan', 'Perez', 'juan.perez@example.com', '1234567890', 'Calle Falsa 123', '2023-01-01', 'Premium', '1985-05-15', '1', '1', 'Fibra Óptica', 'PC', 'juan2024'),
(102, 'Ana', 'Gomez', 'ana.gomez@example.com', '0987654321', 'Avenida Siempre Viva 742', '2023-02-01', 'Básico', '1990-08-22', '1', '1', 'Wi-Fi', 'Smart TV', 'ana2024'),
(103, 'Pepe', 'Restrepo', 'pepe.restrepo@example.com', '1234567890', 'Calle 4534', '2023-05-01', 'Básico', '1990-10-22', '1', '1', 'Wi-Fi', 'PC', 'pepe2024'),
(104, 'Carlos', 'Mendez', 'carlos.mendez@example.com', '1122334455', 'Calle Luna 456', '2023-03-01', 'Estándar', '1987-03-12', '1', '1', 'Wi-Fi', 'Tablet', 'carlos2023'),
(105, 'Lucia', 'Martinez', 'lucia.martinez@example.com', '5566778899', 'Avenida Sol 789', '2023-04-15', 'Premium', '1992-07-19', '1', '1', 'Fibra Óptica', 'Smartphone', 'lucia2023');


INSERT INTO perfiles (id_perfil, nombre_perfil, preferencias_visualizacion, pin, usuario_id_usuario)
VALUES
(201, 'Perfil 1', 'Preferencia A', '1234', 101),
(202, 'Perfil 2', 'Preferencia B', '4567', 102),
(203, 'Perfil 3', 'Preferencia C', '3561', 103),
(204, 'Perfil 4', 'Preferencia D', '8082', 104),
(205, 'Perfil 5', 'Preferencia E', '2354', 105);


INSERT INTO contenido (id_contenido, titulo, descripcion, categoria, rating, fecha_lanzamiento, tipo_contenido, duracion, contenido_relacionado, perfiles_id_perfil)
VALUES
(10001, 'Stranger Things', 'Una serie de ciencia ficción y terror que sigue a un grupo de niños en los años 80 enfrentando fenómenos paranormales.', 'Ciencia Ficción', 8.7, '2016-07-15', 'Serie', 50, NULL, 201),
(10002, 'The Crown', 'Serie dramática sobre el reinado de la Reina Isabel II del Reino Unido.', 'Drama', 8.6, '2016-11-04', 'Serie', 60, NULL, 202),
(10003, 'Breaking Bad', 'Serie sobre un profesor de química que se convierte en fabricante de metanfetaminas.', 'Drama', 9.5, '2008-01-20', 'Serie', 45, NULL, 203),
(10004, 'Inception', 'Película sobre un ladrón que roba secretos mediante el uso de la tecnología de los sueños.', 'Ciencia Ficción', 8.8, '2010-07-16', 'Película', 148, NULL, 204),
(10005, 'The Irishman', 'Película sobre un sicario de la mafia y su vida en la organización criminal.', 'Drama', 7.8, '2019-11-27', 'Película', 209, NULL, 205);


INSERT INTO temporada (id_temporada, numero_temporada, contenido_id_contenido)
VALUES
(20001, 1, 10001),
(20002, 2, 10001),
(20003, 1, 10002),
(20004, 2, 10002),
(20005, 1, 10003),
(20006, 2, 10003);


INSERT INTO episodio (id_episodio, titulo_episodio, duracion, numero_episodio, temporada_id_temporada)
VALUES
(30001, 'Chapter One: Stranger Things', 50, 1, 20001),
(30002, 'Chapter Two: The Weirdo on Maple Street', 55, 2, 20001),
(30003, 'Episode 1', 60, 1, 20003),
(30004, 'Episode 2', 60, 2, 20003),
(30005, 'Episode 1', 50, 1, 20005);


INSERT INTO pago (id_pago, monto, fecha_pago, metodo_pago, estado_pago1, suscripcion_duracion, fecha_expiracion, usuario_id_usuario, estado_pago)
VALUES
(601, 100.50, '2023-01-01', 'Tarjeta de Crédito', 'Completado', '1 mes', '2023-02-01', 101, '1'),
(602, 50.00, '2023-02-15', 'PayPal', 'Completado', '1 mes', '2023-03-15', 102, '1'),
(603, 70.75, '2023-03-20', 'Tarjeta de Crédito', 'Completado', '1 mes', '2023-04-20', 103, '1'),
(604, 80.20, '2023-04-25', 'Tarjeta de Débito', 'Completado', '1 mes', '2023-05-25', 104, '1'),
(605, 120.00, '2023-05-30', 'Tarjeta de Crédito', 'Completado', '1 mes', '2023-06-30', 105, '1');


INSERT INTO visualizacion (id_visualizacion, fecha_visualizacion, tiempo_visto, contenido_id_contenido)
VALUES
(701, '2023-07-01', 120, 10001),
(702, '2023-07-15', 90, 10002),
(703, '2023-07-20', 45, 10003),
(704, '2023-08-05', 110, 10004),
(705, '2023-08-10', 50, 10005);



--CONSULTAS


--Consulta de Información de Usuarios, Perfiles, Contenido Visualizado y sus Calificaciones
SELECT 
    UPPER(CONCAT(u.nombre, ' ', u.apellidos)) AS "Nombre Completo",
    p.nombre_perfil AS "Nombre del Perfil",
    c.titulo AS "Título del Contenido",
    c.categoria AS "Categoría",
    c.rating AS "Calificación",
    v.fecha_visualizacion AS "Fecha de Visualización",
    v.tiempo_visto AS "Tiempo Visto (minutos)"
FROM 
    usuario u
JOIN 
    perfiles p ON u.id_usuario = p.usuario_id_usuario
JOIN 
    contenido c ON p.id_perfil = c.perfiles_id_perfil
JOIN 
    visualizacion v ON c.id_contenido = v.contenido_id_contenido
ORDER BY 
    v.fecha_visualizacion DESC;
    
--Consulta de Información de Temporadas, Episodios, Rating y Episodio que Está Viendo
SELECT 
    c.titulo AS "Título del Contenido",
    c.categoria AS "Categoría",
    c.rating AS "Calificación",
    t.numero_temporada AS "Número de Temporada",
    e.numero_episodio AS "Número de Episodio",
    e.titulo_episodio AS "Título del Episodio"
FROM 
    contenido c
JOIN 
    temporada t ON c.id_contenido = t.contenido_id_contenido
JOIN 
    episodio e ON t.id_temporada = e.temporada_id_temporada
ORDER BY 
    c.titulo, t.numero_temporada, e.numero_episodio;

--Consulta de Información de Pagos y Tipo de Suscripción
SELECT 
    UPPER(CONCAT(u.nombre, ' ', u.apellidos)) AS "Nombre Completo",
    u.tipo_suscripcion AS "Tipo de Suscripción",
    CONCAT(pa.monto, ' USD') AS "Monto Pagado",
    pa.metodo_pago AS "Método de Pago",
    pa.fecha_pago AS "Fecha de Pago"
FROM 
    usuario u
JOIN 
    pago pa ON u.id_usuario = pa.usuario_id_usuario
ORDER BY 
    pa.fecha_pago DESC;










-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             14
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
