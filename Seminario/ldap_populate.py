import MySQLdb
import getpass
import ldap
import ldap.modlist

user = raw_input("Digite o usuario de acesso ao banco SQL: ") 
password = getpass.getpass("Digite a senha: ")
database = raw_input("Digite o nome do banco SQL: ")
qt_membros = int(raw_input("Digite o numero maximo de membros do comite: "))
qt_autores = int(raw_input("Digite o numero maximo de autores: "))
ldap_pass = getpass.getpass("Digite a senha da base LDAP: ")
qt_total = qt_membros + qt_autores

'''
user = 'root'
database = 'CASCONet'
qt_membros = 10
qt_autores = 10
qt_total = qt_membros + qt_autores
'''

#conexao com o banco
mydb = MySQLdb.connect(host='localhost',
    user=user,
    passwd=password,
    db=database)
cursor = mydb.cursor()

#consulta por pessoas do banco
select_person_query = "select * from Person"
cursor.execute(select_person_query)
pessoas = cursor.fetchall()

#consulta por artigos no banco
select_paper_query = "select * from Papers"
cursor.execute(select_paper_query)
artigos = cursor.fetchall()
cursor.close()

#se o usuario quiser pegar mais registros do que tem na base, encerra o programa
if (len(pessoas) < qt_membros + qt_autores):
    print 'A base mysql tem somente ' + str(len(pessoas)) + ' registros. O numero de membros do comite mais o numero de autores deve ser menor que a quantidade de registros.'
    exit()

#divisao das pessoas do banco entre membros do comite e autores
membrosComite = pessoas[:qt_membros]
autores = pessoas[qt_membros:qt_total]

#conexao com a base ldap
try:
    ldap_con = ldap.initialize('ldap:///localhost')
    ldap_con.simple_bind_s("cn=admin,dc=ifip", ldap_pass)
except ldap.INVALID_CREDENTIALS:
    print "Usuario ou senha LDAP incorreto(s).Tente novamente"

#insersao de membros do comite na base ldap
for row in membrosComite:
    membro_cn = row[1] + ' ' + row[2]
    dn = "cn=" + membro_cn + ',ou=membrosComite,ou=2018,ou=SBBD,dc=ifip'
    modlist = {
            "objectClass": ["top", "person", "organizationalPerson"],
            "cn": [membro_cn],
            "sn": [row[2]]
            }
    try:
        result = ldap_con.add_s(dn, ldap.modlist.addModlist(modlist))
    except ldap.LDAPError, e:
        if type(e.message) == dict and e.message.has_key('desc'):
            print e.message['desc']    
        else: 
            print e
            sys.exit()

#insersao de autores e artigos na base ldap. Para cada autor, um artigo desse autor
for autor, artigo in zip(autores, artigos):
    # insercao de autor
    autor_cn = autor[1] + ' ' + autor[2]
    autor_dn = "cn=" + autor_cn + ',ou=autores,ou=2018,ou=SBBD,dc=ifip'
    autor_modlist = {
            "objectClass": ["top", "person", "organizationalPerson"],
            "cn": [autor_cn],
            "sn": [autor[2]]
            }
    try:
        result_autor = ldap_con.add_s(autor_dn, ldap.modlist.addModlist(autor_modlist))
    except ldap.LDAPError, e:
        if type(e.message) == dict and e.message.has_key('desc'):
            print e.message['desc']    
        else: 
            print e
            sys.exit()

    # insercao de artigo
    artigo_dn = "documentIdentifier=" + str(artigo[1]) + ',ou=artigos,ou=2018,ou=SBBD,dc=ifip' 
    artigo_modlist = {
            "objectClass": ["top", "document"],
            "documentIdentifier": str([artigo[1]]),
            "documentTitle": [artigo[0]],
            "documentAuthor": [autor_dn]
            }

    try:
        result_artigo = ldap_con.add_s(artigo_dn, ldap.modlist.addModlist(artigo_modlist))
    except ldap.LDAPError, e:
        if type(e.message) == dict and e.message.has_key('desc'):
            print e.message['desc']    
        else: 
            print e
            sys.exit()
