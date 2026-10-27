SELECT
  SUM(mobile_likes) AS me_gusta_desde_celular,
  SUM(www_likes) AS me_gusta_desde_computadora,
  SUM(CASE WHEN mobile_likes > www_likes THEN 1 ELSE 0 END) AS usuarios_mas_celular,
  SUM(CASE WHEN www_likes > mobile_likes THEN 1 ELSE 0 END) AS usuarios_mas_computadora,
  SUM(CASE WHEN mobile_likes = www_likes THEN 1 ELSE 0 END) AS usuarios_iguales
FROM db_eduardoantezana.fb_eduardoantezana
WHERE age BETWEEN 13 AND 25;
