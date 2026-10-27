SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS clientes_unicos,
    ROUND(COUNT(DISTINCT CustomerID) * 100.0 /
        SUM(COUNT(DISTINCT CustomerID)) OVER (), 2) AS porcentaje
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE CustomerID IS NOT NULL
GROUP BY Country
ORDER BY clientes_unicos DESC;
