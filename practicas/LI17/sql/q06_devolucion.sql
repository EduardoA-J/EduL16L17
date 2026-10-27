SELECT
    Description,
    COUNT(CASE WHEN Quantity < 0 OR InvoiceNo LIKE 'C%' THEN 1 END) AS devoluciones,
    COUNT(CASE WHEN Quantity > 0 THEN 1 END) AS ventas_validas,
    ROUND(
        COUNT(CASE WHEN Quantity < 0 OR InvoiceNo LIKE 'C%' THEN 1 END) * 100.0 /
        NULLIF(COUNT(*), 0), 2
    ) AS tasa_devolucion_pct
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE CustomerID IS NOT NULL
GROUP BY Description
HAVING COUNT(*) >= 10
ORDER BY tasa_devolucion_pct DESC
LIMIT 15;
