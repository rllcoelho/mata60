CREATE ROLE almoxarifado;

GRANT SELECT,INSERT ON fitas TO almoxarifado;
GRANT SELECT,INSERT ON filmes TO almoxarifado;
GRANT SELECT,INSERT ON filmes_has_categorias TO almoxarifado;
GRANT SELECT ON categorias TO almoxarifado;
