SELECT COUNT(*) AS filas
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT
  SUM(CASE WHEN invoiceno = 'InvoiceNo' THEN 1 ELSE 0 END) AS encabezados,
  SUM(CASE WHEN invoicedate IS NULL THEN 1 ELSE 0 END) AS fechas_nulas,
  SUM(CASE WHEN customerid IS NULL THEN 1 ELSE 0 END) AS clientes_nulos,
  SUM(CASE WHEN invoiceno LIKE 'C%' THEN 1 ELSE 0 END) AS facturas_c
FROM dbec_eduardoantezana.tec_eduardoantezana;

SELECT invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE invoiceno = '536381' AND stockcode = '82567';
