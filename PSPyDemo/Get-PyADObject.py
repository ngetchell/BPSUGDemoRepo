import argparse
import ldap3
import getpass

# Collect the args...
parser = argparse.ArgumentParser(
    description="Simple, bad LDAP3 query wrapper")
parser.add_argument('-H', '--host')
parser.add_argument('-u', '--userprincipalname')
parser.add_argument('-p', '--password')
parser.add_argument('-b', '--search_base')
parser.add_argument('-f', '--search_filter')

# hash tables!
args = vars(parser.parse_args())
user = args['userprincipalname']
password = args['password']
ldap_host = args['host']
search_base = args['search_base']
search_filter = args['search_filter']

if password is None:
    password = getpass.getpass()

# Should be parameter
attributes = [
    'sAMAccountName',
    'uidNumber',
    'mail',
    'objectSid',
    'whenCreated',
    'whenChanged',
    'givenName',
    'sn',
    'homedirectory',
    'unixhomedirectory']

server = ldap3.Server(host=ldap_host,
                      use_ssl=True,
                      get_info=ldap3.ALL)
connection = ldap3.Connection(server,
                              user=user,
                              password=password)
connection.bind()

search_args = dict(search_scope='SUBTREE', paged_size=200,
                   generator=False)
accounts_raw = connection.extend.standard.paged_search(
    search_base=search_base,
    search_filter=search_filter,
    attributes=attributes,
    paged_size=200,
    generator=False)

accounts = []
for entry in connection.entries:
    accounts.append(entry.entry_to_json())

accounts_string = ", ".join(accounts)
print("[{}]".format(accounts_string))

connection.unbind()
