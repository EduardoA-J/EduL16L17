CREATE DATABASE db_eduardoantezana;
CREATE TABLE db_eduardoantezana.fb_eduardoantezana (
  userid INT,
  age INT,
  dob_day INT,
  dob_year INT,
  dob_month INT,
  gender STRING,
  tenure INT,
  friend_count INT,
  friendships_initiated INT,
  likes INT,
  likes_received INT,
  mobile_likes INT,
  mobile_likes_received INT,
  www_likes INT,
  www_likes_received INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

DESCRIBE FORMATTED db_eduardoantezana.fb_eduardoantezana;

LOAD DATA INPATH '/user/hive/warehouse/pseudo_facebook_EduardoAntezana.csv' INTO TABLE db_eduardoantezana.fb_eduardoantezana;

SELECT * FROM db_eduardoantezana.fb_eduardoantezana LIMIT 10;

SELECT COUNT(*) AS total_usuarios FROM db_eduardoantezana.fb_eduardoantezana;

SELECT COUNT(*) AS usuarios_mayores_25 FROM db_eduardoantezana.fb_eduardoantezana WHERE age > 25;

SELECT gender, COUNT(*) AS usuarios, AVG(friend_count) AS promedio_amigos
FROM db_eduardoantezana.fb_eduardoantezana
WHERE gender IN ('male', 'female')
GROUP BY gender;

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

SELECT dob_month AS mes_cumpleanos, COUNT(*) AS usuarios
FROM db_eduardoantezana.fb_eduardoantezana
GROUP BY dob_month
ORDER BY dob_month;

SELECT
  SUM(mobile_likes) AS me_gusta_desde_celular,
  SUM(www_likes) AS me_gusta_desde_computadora,
  SUM(CASE WHEN mobile_likes > www_likes THEN 1 ELSE 0 END) AS usuarios_mas_celular,
  SUM(CASE WHEN www_likes > mobile_likes THEN 1 ELSE 0 END) AS usuarios_mas_computadora,
  SUM(CASE WHEN mobile_likes = www_likes THEN 1 ELSE 0 END) AS usuarios_iguales
FROM db_eduardoantezana.fb_eduardoantezana
WHERE age BETWEEN 13 AND 25;

SELECT
  SUM(mobile_likes) AS me_gusta_desde_celular,
  SUM(www_likes) AS me_gusta_desde_computadora,
  SUM(CASE WHEN mobile_likes > www_likes THEN 1 ELSE 0 END) AS usuarios_mas_celular,
  SUM(CASE WHEN www_likes > mobile_likes THEN 1 ELSE 0 END) AS usuarios_mas_computadora,
  SUM(CASE WHEN mobile_likes = www_likes THEN 1 ELSE 0 END) AS usuarios_iguales
FROM db_eduardoantezana.fb_eduardoantezana
WHERE age > 25;
