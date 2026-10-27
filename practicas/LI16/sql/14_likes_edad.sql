SELECT
  CASE
    WHEN age BETWEEN 13 AND 25 THEN '13_a_25'
    WHEN age > 35 THEN 'mayores_35'
  END AS grupo,
  COUNT(*) AS usuarios,
  SUM(likes_received) AS me_gusta_recibidos,
  AVG(likes_received) AS promedio_me_gusta_recibidos
FROM db_eduardoantezana.fb_eduardoantezana
WHERE age BETWEEN 13 AND 25 OR age > 35
GROUP BY
  CASE
    WHEN age BETWEEN 13 AND 25 THEN '13_a_25'
    WHEN age > 35 THEN 'mayores_35'
  END;
