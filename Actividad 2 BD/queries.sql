/* ============================
   queries.sql  (MySQL 8.0+)
   ============================ */

-- Q1: Proyectos y su docente jefe (verifica FK)
use proyecto;
SELECT p.proyecto_id, p.nombre AS proyecto, d.nombres AS docente_jefe
FROM proyecto p
JOIN docente d ON d.docente_id = p.docente_id_jefe;

-- Q2: Usar UDF de promedio de presupuesto por docente
SELECT d.docente_id, d.nombres, fn_promedio_presupuesto_por_docente(d.docente_id) AS promedio_presupuesto
FROM docente d;

-- Q3: Verificar trigger UPDATE
SELECT * FROM copia_actualizados_docente ORDER BY auditoria_id DESC LIMIT 10;

-- Q4: Verificar trigger DELETE
SELECT * FROM copia_eliminados_docente ORDER BY auditoria_id DESC LIMIT 10;

-- Q5: Validar CHECKs (debe devolver filas válidas)
SELECT proyecto_id, nombre, fecha_inicial, fecha_final, presupuesto, horas
FROM proyecto
WHERE (fecha_final IS NULL OR fecha_final >= fecha_inicial)
  AND presupuesto >= 0 AND horas >= 0;
