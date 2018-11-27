/*
Consulta para visualizar quantos filmes tem a mesma duração de locação
*/

SELECT COUNT(duracaoLocacao), titulo
FROM filmes
GROUP BY titulo;
