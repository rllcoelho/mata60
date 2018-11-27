START TRANSACTION;

  SET @clienteid = '2';

  SET @fitaid = (SELECT f.numero
                 FROM fitas f
                 INNER JOIN filmes m
                 ON f.filme_identificador = m.identificador
                 WHERE m.titulo LIKE 'Avatar%');

  SET @fitadisponibilidade = (SELECT disponibilidade
                              FROM fitas
                              WHERE fita_numero=1);

COMMIT;
