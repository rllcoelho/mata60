INSERT INTO cliente (numAssociado, nome, sobrenome, CEP, numero)
VALUES (1, 'Rafael', 'Coelho', 41000000);
INSERT INTO cliente (numAssociado, nome, sobrenome, CEP, numero)
VALUES (2, 'Fábio', 'Vicente', 41000000);
INSERT INTO cliente (numAssociado, nome, sobrenome, CEP, numero)
VALUES (1, 'Fernanda', 'Barros', 41000000);
INSERT INTO cliente (numAssociado, nome, sobrenome, CEP, numero)
VALUES (1, 'Vaninha', 'Vieira', 41000000);


INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (1, 71991929394);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (1, 7132350694);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (1, 71999991234);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (2, 71999999999);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (2, 71999999991);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (3, 71991234567);
INSERT INTO telefone (cliente_numAssociado, numero)
VALUES (4, 71997654321);


INSERT INTO filme (identificador, titulo, duracao, duracaoLocacao, categoria)
VALUES (1, 'E o vento levou', 2, 'Romance');
INSERT INTO filme (identificador, titulo, duracao, duracaoLocacao, categoria)
VALUES (2, 'A Noiva de Chuck', 2, 'Terror');


INSERT INTO fita (numero, filme_identificador, fita_numero, disponibilidade)
VALUES (12, 2, NULL, 'disponivel');
INSERT INTO fita (numero, filme_identificador, fita_numero, disponibilidade)
VALUES (13, 2, NULL, 'emprestada');
INSERT INTO fita (numero, filme_identificador, fita_numero, disponibilidade)
VALUES (18, 1, NULL, 'disponivel');
INSERT INTO fita (numero, filme_identificador, fita_numero, disponibilidade)
VALUES (27, 1, 18, 'disponivel');


INSERT INTO ator (identificador, nomeReal, dataNascimento)
VALUES (12321, 'Kevin Costner', '1956-07-12');


INSERT INTO estrelato (filme_identificador, ator_identificador)
VALUES (1, 123321);
INSERT INTO estrelato (filme_identificador, ator_identificador)
VALUES (2, 123321);


INSERT INTO emprestimo (instanteLocacao, cliente_numAssociado, fita_numero, dataAluguel, preco)
VALUES (20181010181247, 1, 1, '2018-10-10', 7);