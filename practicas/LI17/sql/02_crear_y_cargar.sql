DROP TABLE IF EXISTS dbec_eduardoantezana.tec_eduardoantezana_landing;
CREATE EXTERNAL TABLE dbec_eduardoantezana.tec_eduardoantezana_landing (
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
LOCATION '/li17/eduardoantezana'
TBLPROPERTIES ('skip.header.line.count'='1');

DROP TABLE IF EXISTS dbec_eduardoantezana.tec_eduardoantezana;
CREATE TABLE dbec_eduardoantezana.tec_eduardoantezana (
  invoiceno STRING,
  stockcode STRING,
  description STRING,
  quantity INT,
  invoicedate TIMESTAMP,
  unitprice DECIMAL(12,3),
  customerid INT,
  country STRING
)
STORED AS ORC;

SET hive.stats.autogather=false;

INSERT OVERWRITE TABLE dbec_eduardoantezana.tec_eduardoantezana
SELECT
  invoiceno,
  stockcode,
  NULLIF(description, ''),
  CAST(quantity AS INT),
  CAST(from_unixtime(unix_timestamp(invoicedate, 'M/d/yyyy H:mm')) AS TIMESTAMP),
  CAST(unitprice AS DECIMAL(12,3)),
  CAST(NULLIF(customerid, '') AS INT),
  country
FROM dbec_eduardoantezana.tec_eduardoantezana_landing
WHERE invoiceno <> 'InvoiceNo';
