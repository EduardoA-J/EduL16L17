SELECT
    ROUND(AVG(order_total), 2) AS ticket_promedio,
    PERCENTILE_APPROX(order_total, 0.5) AS mediana_ticket
FROM (
    SELECT
        InvoiceNo,
        SUM(Quantity * UnitPrice) AS order_total
    FROM dbec_eduardoantezana.tec_eduardoantezana
    WHERE Quantity > 0 AND UnitPrice > 0
    GROUP BY InvoiceNo
) orders;
