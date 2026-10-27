SELECT
    ROUND(SUM(Quantity * UnitPrice), 2) AS ingreso_total
FROM dbec_eduardoantezana.tec_eduardoantezana
WHERE Quantity > 0
  AND UnitPrice > 0
  AND CustomerID IS NOT NULL;
