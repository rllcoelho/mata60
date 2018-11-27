/*
Cria view para que os clientes possam pesquisar por filmes contendo seus atores favoritos e checar a disponibilidade desses filmes
*/

CREATE VIEW estrelas (filme,ator,disponibilidade) AS
  SELECT a.nomeReal, m.titulo, f.disponibilidade
  FROM atores a, filmes m, fitas f, estrelatos e
  WHERE e.filme_identificador = m.titulo 
    AND e.ator_identificador = a.identificador
  ORDER BY f.disponibilidade DESC;
