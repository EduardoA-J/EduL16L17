SELECT
    DAYOFWEEK(InvoiceDate) AS dia_semana,
    CASE DAYOFWEEK(InvoiceDate)
        WHEN 1 THEN 'Domingo' WHEN 2 THEN 'Lunes' WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles' WHEN 5 THEN 'Jueves' WHEN 6 THEN 'Viernes'
        ELSE 'Sábado' END AS dia_nombre,
    COUNT(DISTINCT InvoiceNo) AS pedidos,
    ROUND(SUM(Quantity * UnitPrice), 2) AS ingresos
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0 AND UnitPrice > 0
GROUP BY DAYOFWEEK(InvoiceDate)
ORDER BY dia_semana;
