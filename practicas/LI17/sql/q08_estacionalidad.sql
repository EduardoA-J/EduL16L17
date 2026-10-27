SELECT
    Description,
    MONTH(InvoiceDate) AS mes,
    SUM(Quantity) AS unidades_mes,
    ROUND(SUM(Quantity) * 100.0 / SUM(SUM(Quantity)) OVER (PARTITION BY Description), 2) AS distribucion_pct
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0
GROUP BY Description, MONTH(InvoiceDate)
HAVING SUM(Quantity) > 50
ORDER BY Description, mes;
