import csv
import MySQLdb

# variaveis do ambiente local
path = '../DATASET/movie_metadata.csv'
user = raw_input("Digite o user de acesso ao database: ") 
password = raw_input("Digite a password: ")
database = raw_input("Digite o nome do database: ")

#conexao com o database
mydb = MySQLdb.connect(host='localhost',
    user=user,
    passwd=password,
    db=database)
cursor = mydb.cursor()

# seta os contadores de ids 
count_tiles = 1
count_actors = 1
count_genres = 1

# inicializa o que sera o conjunto de todos os generos de filmes
dict_genres = dict() 
dict_actors = dict()

i = 0
with open(path, 'r') as movies_file:

    csv_reader = csv.reader(movies_file)

    # percorre as linhas do arquivo csv
    for row in csv_reader:

        # limita o numero de linhas percorridas ao valor de i, para evitar travamento
        if(i == 30):
            exit(1)
            print(i)
        i+=1

        movie_tile = row[11]
        movie_actors = set([row[6], row[10], row[14]])
        movie_genres = set(row[9].split("|"))

        # insere o titulo dos filmes
        sql = "INSERT INTO filme (identificador, titulo, duracaoLocacao) VALUES (%s, %s, %s)"
        val = (count_tiles, movie_tile, 1)
        cursor.execute(sql,val)
        mydb.commit()

        # percorre o conjunto de generos
        for genre in movie_genres:
            # se o genero ja foi cadastrado
            if(genre in dict_genres):
                # obtem o id referente ao genero
                id_genre = dict_genres[genre]
                
                # insere na tabela filme_has_categoria
                sql = "INSERT INTO filme_has_categoria (filme_identificador, categoria_identificador) VALUES (%s, %s)"
                val = (count_tiles, id_genre)
                cursor.execute(sql,val)

                # salva as mudancas
                mydb.commit()

            # se o genero nao foi cadastrado ainda 
            else:
                # insere na tabela categoria
                sql = "INSERT INTO categoria (identificador, nome) VALUES (%s, %s)"
                val = (count_genres, genre)
                cursor.execute(sql,val)

                # insere na tabela filme_has_categoria
                sql = "INSERT INTO filme_has_categoria (filme_identificador, categoria_identificador) VALUES (%s, %s)"
                val = (count_tiles, count_genres)
                cursor.execute(sql,val)

                # salva as mudancas
                mydb.commit()

                # atualiza valores
                dict_genres[genre] = count_genres
                count_genres+=1

        # percorre o conjunto de atores
        for actor in movie_actors:
            # se o ator ja foi cadastrado
            if(actor in dict_actors):
                # obtem o id referente ao ator
                id_actor = dict_actors[actor]
                
                # insere na tabela estrelato
                sql = "INSERT INTO estrelato (filme_identificador, ator_identificador) VALUES (%s, %s)"
                val = (count_tiles, id_actor)
                cursor.execute(sql,val)

                # salva as mudancas
                mydb.commit()

            # se o ator nao foi cadastrado ainda 
            else:
                # insere na tabela ator
                sql = "INSERT INTO ator (identificador, nomeReal) VALUES (%s, %s)"
                val = (count_actors, actor)
                cursor.execute(sql,val)

                # insere na tabela estrelato
                sql = "INSERT INTO estrelato (filme_identificador, ator_identificador) VALUES (%s, %s)"
                val = (count_tiles, count_actors)
                cursor.execute(sql,val)

                # salva as mudancas
                mydb.commit()

                # atualiza valores
                dict_actors[actor] = count_actors
                count_actors+=1

        # incrementa o contador de filmes
        count_tiles+=1

# encerra a conexao com o database
cursor.close()
