SELECT
    Country,
    COUNT(CASE WHEN Quantity < 0 OR InvoiceNo LIKE 'C%' THEN 1 END) AS cancelaciones,
    COUNT(CASE WHEN Quantity > 0 THEN 1 END) AS ventas_validas,
    ROUND(
        COUNT(CASE WHEN Quantity < 0 OR InvoiceNo LIKE 'C%' THEN 1 END) * 100.0 /
        NULLIF(COUNT(*), 0), 2
    ) AS tasa_cancelacion_pct
FROM dbec_eduardoantezana.tec_eduardoantezana
GROUP BY Country
HAVING COUNT(*) >= 50
ORDER BY tasa_cancelacion_pct DESC;
