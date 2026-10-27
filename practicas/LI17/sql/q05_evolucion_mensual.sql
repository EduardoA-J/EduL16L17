SELECT
    YEAR(InvoiceDate) AS anio,
    MONTH(InvoiceDate) AS mes,
    COUNT(DISTINCT InvoiceNo) AS pedidos,
    ROUND(SUM(Quantity * UnitPrice), 2) AS ingresos
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY anio, mes;
