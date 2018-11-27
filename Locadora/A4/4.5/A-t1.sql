START TRANSACTION;

  SET @clienteid = '1';

  SET @fitaid = (SELECT f.numero 
                 FROM fitas f 
                 INNER JOIN filmes m 
                 ON f.filme_identificador = m.identificador 
                 WHERE m.titulo = 'movie_title' LIMIT 1);

  INSERT INTO emprestimos (instanteLocacao, cliente_numAssociado, fita_numero, dataAluguel, preco) VALUES (10, @clienteid, @fitaid, 20181127, 3);

  UPDATE fitas SET disponibilidade = 0 WHERE numero = @fitaid;

COMMIT;
