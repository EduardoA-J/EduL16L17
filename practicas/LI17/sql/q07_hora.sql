SELECT
    HOUR(InvoiceDate) AS hora,
    COUNT(DISTINCT InvoiceNo) AS pedidos,
    ROUND(SUM(Quantity * UnitPrice), 2) AS ingresos,
    ROUND(AVG(Quantity * UnitPrice), 2) AS ticket_promedio
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY HOUR(InvoiceDate)
ORDER BY hora;
