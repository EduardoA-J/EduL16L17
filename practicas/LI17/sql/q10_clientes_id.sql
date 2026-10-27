SELECT
    CASE WHEN CustomerID IS NULL THEN 'Anónimo' ELSE 'Registrado' END AS tipo_cliente,
    COUNT(DISTINCT InvoiceNo) AS pedidos,
    ROUND(AVG(Quantity * UnitPrice), 2) AS ticket_promedio,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue_total
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY CASE WHEN CustomerID IS NULL THEN 'Anónimo' ELSE 'Registrado' END;
