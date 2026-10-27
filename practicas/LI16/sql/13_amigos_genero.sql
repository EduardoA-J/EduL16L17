SELECT gender, COUNT(*) AS usuarios, AVG(friend_count) AS promedio_amigos
FROM db_eduardoantezana.fb_eduardoantezana
WHERE gender IN ('male', 'female')
GROUP BY gender;
