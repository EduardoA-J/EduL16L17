SELECT MIN(invoicedate) AS fecha_min, MAX(invoicedate) AS fecha_max
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT SUM(CASE WHEN invoicedate IS NULL THEN 1 ELSE 0 END) AS fechas_no_parseadas
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT
  invoiceno,
  invoicedate,
  YEAR(invoicedate) AS anio,
  MONTH(invoicedate) AS mes,
  DAY(invoicedate) AS dia,
  HOUR(invoicedate) AS hora,
  MINUTE(invoicedate) AS minuto,
  DAYOFWEEK(invoicedate) AS dia_semana
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE (invoiceno = '536365' AND stockcode = '85123A')
   OR invoiceno = 'A563185';
