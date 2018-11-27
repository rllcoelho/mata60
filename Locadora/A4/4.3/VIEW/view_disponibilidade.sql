/*
Cria view para que os secretários da biblioteca possam visualizar os filmes e a quantidade de fitas disponíveis para aquele filme
*/

CREATE VIEW disponibilidade (filme, quantidade) AS
  SELECT m.titulo, COUNT(f.disponibilidade)
  FROM filmes m, fitas f
  GROUP BY f.disponibilidade;
