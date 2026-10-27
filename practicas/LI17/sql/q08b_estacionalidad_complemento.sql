SELECT description, mes, unidades_mes, distribucion_pct
FROM (
    SELECT
        Description AS description,
        MONTH(InvoiceDate) AS mes,
        SUM(Quantity) AS unidades_mes,
        ROUND(SUM(Quantity) * 100.0 / SUM(SUM(Quantity)) OVER (PARTITION BY Description), 2) AS distribucion_pct
    FROM dbec_eduardoantezana.tec_eduardoantezana
    WHERE Quantity > 0
    GROUP BY Description, MONTH(InvoiceDate)
    HAVING SUM(Quantity) > 50
) estacional
WHERE distribucion_pct >= 40
ORDER BY distribucion_pct DESC, unidades_mes DESC
LIMIT 15;
