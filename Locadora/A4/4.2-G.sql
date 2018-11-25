/*
Consulta para visualizar todos os filmes cujo(s) nome(s) começa(m) com “Harry Potter”
*/

SELECT titulo
FROM filmes
WHERE titulo LIKE 'Harry Potter%';
