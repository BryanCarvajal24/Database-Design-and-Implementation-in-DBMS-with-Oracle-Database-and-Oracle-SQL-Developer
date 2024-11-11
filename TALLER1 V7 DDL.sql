-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-08-20 20:43:39 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g

USE taller1;

DROP TABLE IF EXISTS renta;
DROP TABLE IF EXISTS reservacion;
DROP TABLE IF EXISTS copia_titulo;
DROP TABLE IF EXISTS afiliado;
DROP TABLE IF EXISTS titulo;


CREATE TABLE afiliado (
    idafiliado          INTEGER NOT NULL,
    nombres             VARCHAR(50) NOT NULL,
    apellidos           VARCHAR(50) NOT NULL,
    direccion           VARCHAR(50) NOT NULL,
    telefono            VARCHAR(15) NOT NULL, 
    fec_vinculacion     DATE NOT NULL,
    sexo                CHAR(1) NOT NULL,
    fec_nacimiento      DATE NOT NULL,
    afiliado_idafiliado INTEGER,
    CONSTRAINT afiliado_pk PRIMARY KEY (idafiliado)
);


CREATE TABLE titulo (
    idtitulo         INTEGER NOT NULL,
    nombre           VARCHAR(50) NOT NULL, 
    descripcion      VARCHAR(50) NOT NULL,
    rating           VARCHAR(50),
    categoria        VARCHAR(50),
    fecha_liberacion DATE,
    CONSTRAINT titulo_pk PRIMARY KEY (idtitulo)
);


CREATE TABLE copia_titulo (
    idcopia         INTEGER NOT NULL,
    estado          CHAR(1) NOT NULL,  
    formato         VARCHAR(50) NOT NULL,
    titulo_idtitulo INTEGER NOT NULL,
    CONSTRAINT copia_titulo_pk PRIMARY KEY (idcopia),
    CONSTRAINT copia_titulo_titulo_fk FOREIGN KEY (titulo_idtitulo)
        REFERENCES titulo (idtitulo)
);


CREATE TABLE renta (
    idrenta              INTEGER NOT NULL,
    fecha_renta          DATE NOT NULL,
    fec_devolucion       DATE NOT NULL,
    fec_entrega          DATE,
    afiliado_idafiliado  INTEGER NOT NULL,
    copia_titulo_idcopia INTEGER NOT NULL,
    CONSTRAINT renta_pk PRIMARY KEY (idrenta),
    CONSTRAINT renta_afiliado_fk FOREIGN KEY (afiliado_idafiliado)
        REFERENCES afiliado (idafiliado),
    CONSTRAINT renta_copia_titulo_fk FOREIGN KEY (copia_titulo_idcopia)
        REFERENCES copia_titulo (idcopia)
);


CREATE TABLE reservacion (
    fecha_reserva       DATE NOT NULL,
    afiliado_idafiliado INTEGER NOT NULL,
    titulo_idtitulo     INTEGER NOT NULL,
    CONSTRAINT reservacion_pk PRIMARY KEY (fecha_reserva),
    CONSTRAINT reservacion_afiliado_fk FOREIGN KEY (afiliado_idafiliado)
        REFERENCES afiliado (idafiliado),
    CONSTRAINT reservacion_titulo_fk FOREIGN KEY (titulo_idtitulo)
        REFERENCES titulo (idtitulo)
);


ALTER TABLE afiliado
    ADD CONSTRAINT afiliado_afiliado_fk FOREIGN KEY (afiliado_idafiliado)
        REFERENCES afiliado (idafiliado);


INSERT INTO afiliado 
(idafiliado, nombres, apellidos, direccion, telefono, fec_vinculacion, sexo, fec_nacimiento, afiliado_idafiliado)
VALUES
(101, 'Antonio', 'Rodriguez', 'Calle 1', '5512573', '2010-01-01', 'M', '1967-04-02', NULL),
(102, 'Nataly', 'Martinez', 'Calle 1', '5512573', '2010-01-01', 'F', '1967-11-02', 101),
(103, 'Natalia', 'Rodriguez', 'Calle 1', '5512573', '2010-01-01', 'F', '1998-06-21', 101),
(104, 'Sofia', 'Rodriguez', 'Calle 1', '5512573', '2010-02-28', 'F', '1998-10-08', 101),
(105, 'Ricardo', 'Ortega', 'Calle 2', '4665445', '2010-01-30', 'M', '1980-10-10', NULL),
(106, 'Camila', 'Ortega', 'Calle 2', '4665448', '2010-02-08', 'F', '1950-10-03', 105),
(107, 'Diego', 'Hernández', 'Cra 3', '5798779', '2010-01-01', 'M', '1957-07-10', NULL),
(109, 'Bryan', 'Burbano', 'Calle 13', '3135278552', '2024-08-24', 'M', '2006-03-24', NULL),
(108, 'Esteban', 'Cobo', 'Cra 8', '3215384547', '2024-08-24', 'M', '1957-07-10', 109),
(110, 'Santiago', 'Carvajal', 'Cra 6', '3188753070', '2024-08-24', 'M', '2005-08-13',109);





INSERT INTO titulo 
(idtitulo, nombre, descripcion, rating, categoria, fecha_liberacion)
VALUES
(92, 'Harry Potter 1', 'Película de Acción', 'Todos', 'Ficción', '2000-01-01'),
(93, 'El señor de los Anillos', 'Película de Ficción', 'Todos', 'Ficción', '2001-01-01'),
(94, 'Monsters Inc.', 'Película de Aventuras para Niños', 'Todos', 'Niños', '2001-08-01'),
(95, 'Insomnia', 'Película de Suspenso', 'Mayores 12', 'Suspenso', '2002-12-01'),
(96, 'Rápido y Furioso', 'Acción en autos', 'Mayores 18', 'Acción', '2002-12-01'),
(97, 'Rápido y Furioso II', 'Acción en Autos', 'Mayores 18', 'Acción', '2003-02-01');


INSERT INTO copia_titulo 
(idcopia, titulo_idtitulo, estado, formato)
VALUES
(1, 92, 'D', 'DVD'),
(2, 93, 'D', 'BLUERAY'),
(3, 94, 'D', 'DVD'),
(4, 95, 'D', 'BLUERAY'),
(5, 96, 'R', 'BLUERAY'),
(6, 97, 'D', 'BLUERAY');



--Parte 2

ALTER TABLE renta
ADD COLUMN valor_renta INTEGER DEFAULT 5000,
ADD COLUMN valor_recargo INTEGER;


INSERT INTO renta 
(idrenta, fecha_renta, fec_devolucion, afiliado_idafiliado, copia_titulo_idcopia, valor_renta, valor_recargo)
VALUES (1, CURRENT_DATE, CURRENT_DATE + INTERVAL 2 DAY, 101, 5, 5000, NULL);


UPDATE copia_titulo
SET estado = 'R'
WHERE idcopia = 5;


-------------------------


INSERT INTO renta 
(idrenta, fecha_renta, fec_devolucion, afiliado_idafiliado, copia_titulo_idcopia, valor_renta, valor_recargo)
VALUES 
(2, CURRENT_DATE, CURRENT_DATE + INTERVAL 3 DAY, 102, 1, 5000, NULL),
(3, CURRENT_DATE, CURRENT_DATE + INTERVAL 5 DAY, 103, 2, 5000, NULL),
(4, CURRENT_DATE, CURRENT_DATE + INTERVAL 4 DAY, 104, 3, 5000, NULL),
(5, CURRENT_DATE, CURRENT_DATE + INTERVAL 6 DAY, 105, 4, 5000, NULL),
(6, CURRENT_DATE, CURRENT_DATE + INTERVAL 7 DAY, 106, 6, 5000, NULL);


UPDATE copia_titulo
SET estado = 'R'
WHERE idcopia IN (1, 2, 3, 4,6);



--PARTE 3


SELECT 
    UPPER(CONCAT(a.nombres, ' ', a.apellidos)) AS nombre_completo,
    UPPER(t.nombre) AS Titulo_pelicula,
    DATE_FORMAT(r.fecha_renta, '%e de %M de %Y') AS Fecha_Renta_Formateada,
    DATEDIFF(r.fec_devolucion, r.fecha_renta) AS dias_de_renta
FROM 
    afiliado a
LEFT JOIN 
    renta r ON a.idafiliado = r.afiliado_idafiliado
LEFT JOIN 
    copia_titulo c ON r.copia_titulo_idcopia = c.idcopia
LEFT JOIN 
    titulo t ON c.titulo_idtitulo = t.idtitulo;



--Parte 4


SELECT 
    UPPER(t.nombre) AS Titulo_pelicula,
    COUNT(CASE WHEN c.estado = 'R' THEN 1 END) AS Cantidad_Rentas,
    COUNT(*) AS Cantidad_por_pelicula,
    SUM(r.valor_renta) AS Valor_Total_Rentas,
    COALESCE(SUM(r.valor_recargo), 0) AS Valor_Total_Recargos
FROM 
    renta r
LEFT JOIN 
    copia_titulo c ON r.copia_titulo_idcopia = c.idcopia
LEFT JOIN 
    titulo t ON c.titulo_idtitulo = t.idtitulo
GROUP BY 
    t.nombre;





-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             5
-- CREATE INDEX                             0
-- ALTER TABLE                             11
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
