import csv
#import MySQLdb

caminho = 'data/movie_metadata.csv'
all_genres = set()
all_actors = set()

def unique_values_in_column(caminho, col):
	with open(caminho, 'r') as movies_file:
		all_genres = set()
		csv_reader = csv.reader(movies_file)
		for row in csv_reader:
			movie_genres = row[col]
			movie_genre_set = set(movie_genres.split("|"))
			all_genres = all_genres.union(movie_genre_set)
			return all_genres

def unique_values_in_3columns(caminho, col1, col2, col3):
	with open(caminho, 'r') as movies_file:
		all_actors = set()
		csv_reader = csv.reader(movies_file)
		for row in csv_reader:
			print('a')
			movie_actors = set([row[col1], row[col2], row[col3]])
			all_actors = all_actors.union(movie_actors)
			return all_actors

print(unique_values_in_3columns(caminho,6,10,14))
