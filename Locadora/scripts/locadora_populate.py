import csv
import MySQLdb
import getpass

# variaveis do ambiente local
path = raw_input("Digite o caminho para o arquivo de metadados: ")
user = raw_input("Digite o usuario de acesso ao banco: ") 
password = getpass.getpass("Digite a senha: ")
database = raw_input("Digite o nome do banco: ")
qt_insertions = raw_input("Digite o numero maximo de insercoes: ")

'''
path = '../DATASET/movie_metadata.csv'
user = 'root'
password = ''
database = 'locadora'
'''

#conexao com o banco
mydb = MySQLdb.connect(host='localhost',
    user=user,
    passwd=password,
    db=database)
cursor = mydb.cursor()

# seta os contadores de ids 
count_titles = 1
count_actors = 1
count_genres = 1

# inicializa o dicionario de todos os generos de filmes e de todos os atores
dict_genres = dict() 
dict_actors = dict()

i = -1

with open(path, 'r') as movies_file:

    csv_reader = csv.reader(movies_file)

    # percorre as linhas do arquivo csv
    for row in csv_reader:
        if(i == -1):
            i+=1
        else:
            # limita o numero de linhas percorridas ao valor de qt_insertions, para reduzir o tempo de execucao
            if(i == int(qt_insertions)):
                exit(1)
            i+=1

            movie_title = row[11]
            movie_actors = set([row[6], row[10], row[14]])
            movie_genres = set(row[9].split("|"))

            # insere o titulo dos filmes
            sql = "INSERT INTO filmes (identificador, titulo, duracaoLocacao) VALUES (%s, %s, %s)"
            val = (count_titles, movie_title, 1)
            cursor.execute(sql,val)
            mydb.commit()

            # percorre o conjunto de generos
            for genre in movie_genres:
                # se o genero ja foi cadastrado
                if(genre in dict_genres):
                    # obtem o id referente ao genero
                    id_genre = dict_genres[genre]
                
                    # insere na tabela filme_has_categoria
                    sql = "INSERT INTO filmes_has_categorias (filme_identificador, categoria_identificador) VALUES (%s, %s)"
                    val = (count_titles, id_genre)
                    cursor.execute(sql,val)

                    # salva as mudancas
                    mydb.commit()

                # se o genero nao foi cadastrado ainda 
                else:
                    # insere na tabela categoria
                    sql = "INSERT INTO categorias (identificador, nome) VALUES (%s, %s)"
                    val = (count_genres, genre)
                    cursor.execute(sql,val)

                    # insere na tabela filme_has_categoria
                    sql = "INSERT INTO filmes_has_categorias (filme_identificador, categoria_identificador) VALUES (%s, %s)"
                    val = (count_titles, count_genres)
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
                    sql = "INSERT INTO estrelatos (filme_identificador, ator_identificador) VALUES (%s, %s)"
                    val = (count_titles, id_actor)
                    cursor.execute(sql,val)

                    # salva as mudancas
                    mydb.commit()

                # se o ator nao foi cadastrado ainda 
                else:
                    # insere na tabela ator
                    sql = "INSERT INTO atores (identificador, nomeReal) VALUES (%s, %s)"
                    val = (count_actors, actor)
                    cursor.execute(sql,val)

                    # insere na tabela estrelato
                    sql = "INSERT INTO estrelatos (filme_identificador, ator_identificador) VALUES (%s, %s)"
                    val = (count_titles, count_actors)
                    cursor.execute(sql,val)

                    # salva as mudancas
                    mydb.commit()

                    # atualiza valores
                    dict_actors[actor] = count_actors
                    count_actors+=1

            # incrementa o contador de filmes
            count_titles+=1

# encerra a conexao com o banco
cursor.close()
