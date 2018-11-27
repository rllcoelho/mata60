/*
Junção externa da tabela 'clientes' com a tabela 'telefones'. Aparece todos os clientes e seus respectivos telefones - quando o telefone é nulo, os campos correspondentes são 'NULL'.
*/

SELECT clientes.*, telefones.*
FROM clientes
LEFT JOIN telefones
ON clientes.numAssociado = telefones.cliente_numAssociado
