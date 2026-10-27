SELECT
    Description,
    ROUND(AVG(UnitPrice), 2) AS precio_promedio,
    COUNT(DISTINCT InvoiceNo) AS pedidos_con_producto,
    ROUND(AVG(UnitPrice) * COUNT(DISTINCT InvoiceNo), 2) AS score_margen_proxy
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY Description
HAVING COUNT(DISTINCT InvoiceNo) >= 5
ORDER BY score_margen_proxy DESC
LIMIT 20;
