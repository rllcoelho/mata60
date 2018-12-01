import MySQLdb
import getpass
import ldap
import ldap.modlist

user = raw_input("Digite o usuario de acesso ao banco: ") 
password = getpass.getpass("Digite a senha: ")
database = raw_input("Digite o nome do banco: ")
qt_membros = int(raw_input("Digite o numero maximo de membros do comite: "))
qt_autores = int(raw_input("Digite o numero maximo de autores: "))
qt_total = qt_membros + qt_autores

'''
user = 'root'
password = ''
database = 'CASCONet'
'''

#conexao com o banco
mydb = MySQLdb.connect(host='localhost',
    user=user,
    passwd=password,
    db=database)
cursor = mydb.cursor()

#consulta por pessoas do banco
sql_select_query = "select * from Person"
cursor.execute(sql_select_query)
pessoas = cursor.fetchall()
cursor.close()

if (len(pessoas) < qt_membros + qt_autores):
    print 'A base mysql tem somente ' + str(len(pessoas)) + ' registros. O numero de membros do comite mais o numero de autores deve ser menor que a quantidade de registros.'
    exit()

#divisao das pessoas do banco entre membros do comite e autores
membrosComite = pessoas[:qt_membros]
autores = pessoas[qt_membros:qt_total]

#conexao com a base ldap
ldap_con = ldap.initialize('ldap:///localhost')

#insersao de membros do comite na base ldap
for row in membrosComite:
    dn = "uid=" + str(row[0]) + ',ou=membrosComite,ou=participantes,ou=2018,dc=congresso'
    modlist = {
            "uid": str([row[0]]),
            "name": [row[1]],
            "lastname": [row[2]]
            }
    result = ldap_con.add(dn, ldap.modlist.addModlist(modlist))
    print result

#insersao de autores na base ldap
for row in autores:
    dn = "uid=" + str(row[0]) + ',ou=autores,ou=participantes,ou=2018,dc=congresso'
    modlist = {
            "uid": str([row[0]]),
            "name": [row[1]],
            "lastname": [row[2]]
            }
    result = ldap_con.add(dn, ldap.modlist.addModlist(modlist))
    print result
