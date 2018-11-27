/*
Consulta para visualizar o título e o nome de todos os filmes e todos os atores
*/

SELECT titulo, nomeReal                      
FROM estrelatos e                                         
INNER JOIN filmes f                                       
ON e.filme_identificador = f.identificador                
INNER JOIN atores a                                       
ON e.ator_identificador = a.identificador; 
