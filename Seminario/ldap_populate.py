import csv
import MySQLdb
import getpass
import ldap

path = '../DATASET/movie_metadata.csv'
user = 'root'
password = ''
database = 'CASCONet'

#conexao com o banco
mydb = MySQLdb.connect(host='localhost',
    user=user,
    passwd=password,
    db=database)
cursor = mydb.cursor()

#consulta por pessoas do banco
sql_selesct_query = "select * from Person"
cursor.execute(sql_select_query)
records_pessoas = cursor.fetchall()
cursor.close()

#conexao com a base ldap
ldap_con = ldap.initialize(ldap:///localhost)

for row in records_pessoas:
	#insere id row[0]
	#insere nome de row[1]
	#insere sobrenome de row[2] 
