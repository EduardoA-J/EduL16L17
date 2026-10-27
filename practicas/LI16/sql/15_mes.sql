SELECT dob_month AS mes_cumpleanos, COUNT(*) AS usuarios
FROM db_eduardoantezana.fb_eduardoantezana
GROUP BY dob_month
ORDER BY dob_month;
