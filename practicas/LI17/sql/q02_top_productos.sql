SELECT
    Description,
    SUM(Quantity) AS unidades_vendidas,
    COUNT(DISTINCT InvoiceNo) AS pedidos_con_producto
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0
GROUP BY Description
ORDER BY unidades_vendidas DESC
LIMIT 10;
