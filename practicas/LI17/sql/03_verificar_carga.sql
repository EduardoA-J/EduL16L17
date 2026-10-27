SELECT COUNT(*) AS filas
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT
  SUM(CASE WHEN invoiceno = 'InvoiceNo' THEN 1 ELSE 0 END) AS encabezados,
  SUM(CASE WHEN invoicedate IS NULL THEN 1 ELSE 0 END) AS fechas_nulas,
  SUM(CASE WHEN customerid IS NULL THEN 1 ELSE 0 END) AS clientes_nulos,
  SUM(CASE WHEN invoiceno LIKE 'C%' THEN 1 ELSE 0 END) AS facturas_c,
  SUM(CASE WHEN description LIKE 'AIRLINE LOUNGE,METAL SIGN' THEN 1 ELSE 0 END) AS filas_con_coma
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE invoiceno = '536381' AND stockcode = '82567';

SELECT invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE invoiceno = '536365' AND stockcode = '85123A';

SELECT
  invoicedate,
  YEAR(invoicedate) AS anio,
  MONTH(invoicedate) AS mes,
  HOUR(invoicedate) AS hora,
  DAYOFWEEK(invoicedate) AS dia_semana
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE invoiceno = '536365' AND stockcode = '85123A';

SELECT invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.tec_eduardoantezana
LIMIT 10;
