# MySQL/MariaDB data

default['backup']['db_name'] = node['application']['mariadb']['db_name'] || nil
default['backup']['db_user'] = node['application']['mariadb']['db_user'] || nil
default['backup']['db_password'] = node['application']['mariadb']['db_password'] || nil
default['backup']['db_socket'] = node['application']['mariadb']['socket'] || nil
