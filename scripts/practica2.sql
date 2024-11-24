-- Vista 1: Información de vuelos de mercancías con carga máxima
CREATE OR REPLACE VIEW Vuelos_Con_Maxima_Carga AS
SELECT DISTINCT
    v.Id AS Codigo_Viaje, 
    v.Fecha_Salida, 
    v.Fecha_Llegada,
    m.Cantidad_Carga AS Carga_Maxima
FROM VIAJE_ESPACIAL v
JOIN PARTICIPA p ON v.Id = p.Id_Viaje
JOIN MERCANCIA m ON p.Id_Nave = m.Id
WHERE m.Cantidad_Carga = (SELECT MAX(Cantidad_Carga) FROM MERCANCIA);

SELECT * FROM Vuelos_Con_Maxima_Carga;

-- Vista 2: Detalle de trabajadores con 5 años o más de experiencia
CREATE OR REPLACE VIEW Vista_Trabajadores_Experiencia AS
SELECT 
    t.Nombre, 
    t.Apellido, 
    tr.Salario, 
    tr.Experiencia AS Años_Experiencia
FROM TRIPULANTE t JOIN TRABAJADOR tr ON t.DNI = tr.DNI
WHERE tr.Experiencia >= 5;

SELECT * FROM Vista_Trabajadores_Experiencia;

-- Vista 3: Seleccionar los puertos espaciales que orbitan al Sol de manera directa o indirecta
CREATE OR REPLACE VIEW Puertos_Espaciales_Sol AS
SELECT DISTINCT
    p.Cod_Cuerpo || '-' || p.Id_Puerto AS Puerto
FROM PUERTO_ESPACIAL p JOIN CUERPO_ESPACIAL c ON p.Cod_Cuerpo = c.Cod
START WITH c.Id_Orbita = (SELECT Id FROM CUERPO_ESPACIAL WHERE Nombre = 'Sol')
CONNECT BY PRIOR c.Id = Id_Orbita;

SELECT * FROM Puertos_Espaciales_Sol;


-- 2. Restrinciones de integridad
-- Restricción 1: Validar fecha de llegada mayor a la de salida
ALTER TABLE VIAJE_ESPACIAL
ADD CONSTRAINT chk_fecha_viaje CHECK (Fecha_Llegada > Fecha_Salida);

INSERT INTO VIAJE_ESPACIAL VALUES (1, TO_DATE('2021/06/12', 'YYYY/MM/DD'), TO_DATE('2008/06/12', 'YYYY/MM/DD'), 1, 2, 1, 2);

-- Restricción 2: Verificar que la capacidad de carga no supere cierto límite
ALTER TABLE MERCANCIA
ADD CONSTRAINT chk_capacidad_carga CHECK (Cantidad_Carga <= 10000);

INSERT INTO MERCANCIA VALUES (1, 1, 9999999);

-- Restricción 3: Asegurar que el codigo de los puertos espaciales no tenga ningún guión
ALTER TABLE PUERTO_ESPACIAL
ADD CONSTRAINT chk_cod CHECK (REGEXP_LIKE(Cod_Cuerpo, '^[^-]*$'));

INSERT INTO PUERTO_ESPACIAL (Cod_Cuerpo, Id_Puerto, Capacidad, Anio_Inauguracion, Distancia) VALUES ('ABC-1', 3, 100, 1998, 1000);


-- 3. Disparadores
-- Disparador 1: Notificar cambio en el salario de un trabajador
CREATE OR REPLACE TRIGGER trg_actualizar_salario
AFTER UPDATE ON TRABAJADOR
FOR EACH ROW
BEGIN
    IF :NEW.Salario != :OLD.Salario THEN
        DBMS_OUTPUT.PUT_LINE('El salario del trabajador con DNI ' || :NEW.DNI || ' ha cambiado.');
    END IF;
END;

-- Disparador 2: Controlar el número máximo de tripulantes en un VIAJE_ESPACIAL
CREATE OR REPLACE TRIGGER trg_max_tripulantes
BEFORE INSERT ON PARTICIPA
FOR EACH ROW
DECLARE
    total_tripulantes NUMBER;
BEGIN
    SELECT COUNT(*) INTO total_tripulantes
    FROM PARTICIPA
    WHERE Id_Viaje = :NEW.Id_Viaje;
    
    IF total_tripulantes >= 10 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se pueden agregar más de 10 tripulantes a un viaje.');
    END IF;
END;

-- Disparador 3: Registrar la fecha de última actualización de un puerto PUERTO_ESPACIAL
CREATE OR REPLACE TRIGGER trg_actualizar_fecha_puerto
AFTER UPDATE ON PUERTO_ESPACIAL
FOR EACH ROW
BEGIN
    UPDATE PUERTO_ESPACIAL
    SET Ultima_Modificacion = SYSDATE
    WHERE ID_Puerto = :NEW.ID_Puerto;
END;
