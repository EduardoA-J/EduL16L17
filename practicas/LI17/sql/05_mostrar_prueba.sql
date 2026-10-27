SELECT 'DELIMITADO' AS modo, invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.prueba_coma;

SELECT 'SERDE' AS modo, invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.prueba_csv;
