CREATE DATABASE IF NOT EXISTS dbec_eduardoantezana;

DROP TABLE IF EXISTS dbec_eduardoantezana.prueba_coma;
CREATE EXTERNAL TABLE dbec_eduardoantezana.prueba_coma (
  invoiceno STRING,
  stockcode STRING,
  description STRING,
  quantity STRING,
  invoicedate STRING,
  unitprice STRING,
  customerid STRING,
  country STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/li17/eduardoantezana_prueba'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS dbec_eduardoantezana.prueba_csv;
CREATE EXTERNAL TABLE dbec_eduardoantezana.prueba_csv (
  invoiceno STRING,
  stockcode STRING,
  description STRING,
  quantity STRING,
  invoicedate STRING,
  unitprice STRING,
  customerid STRING,
  country STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
  "separatorChar" = ",",
  "quoteChar" = "\"",
  "escapeChar" = "\""
)
STORED AS TEXTFILE
LOCATION '/li17/eduardoantezana_prueba'
TBLPROPERTIES ('skip.header.line.count'='1');

SELECT 'DELIMITADO' AS modo, invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.prueba_coma;

SELECT 'SERDE' AS modo, invoiceno, stockcode, description, quantity, invoicedate, unitprice, customerid, country
FROM dbec_eduardoantezana.prueba_csv;
