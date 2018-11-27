/*
Consulta para visualizar o número das fitas que cujo filme tem o título iniciando com “Harry Potter”.
*/

SELECT numero
FROM fitas
WHERE filme_identificador IN
      (SELECT identificador
       FROM filmes
       WHERE titulo LIKE 'Harry Potter%'
      )
;
