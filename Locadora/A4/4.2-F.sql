/*
Consulta para visualizar o nome de todas as fitas cujo atributo fita_numero não é nulo, ou seja, fitas que referenciam outras fitas (filmes que estão contidos em mais de uma fita física).
*/

SELECT f.titulo
FROM filmes f, fitas z
WHERE z.fita_numero IS NOT NULL;
