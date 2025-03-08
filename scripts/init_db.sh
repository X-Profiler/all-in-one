# init unit test database script

set -ex

PASSWORD=${DB_PASSWORD:-}
# if password set, use -p to connect to mysql
if [ -n "${PASSWORD}" ]; then
    PASSWORD="-p${PASSWORD}"
fi

DB_SERVER_HOST=${DB_SERVER_HOST:-127.0.0.1}
DB_USERNAME=${DB_USERNAME:-root}

# current directory
CWD=$(cd $(dirname $0); pwd)

mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -e 'CREATE DATABASE IF NOT EXISTS `xprofiler_console`;'
mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -D 'xprofiler_console' < ${CWD}/init_xprofiler_console.sql
mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -D 'xprofiler_console' -e 'SHOW tables;'

mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -e 'CREATE DATABASE IF NOT EXISTS `xprofiler_logs`;'
mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -D 'xprofiler_logs' < ${CWD}/init_xprofiler_logs.sql
mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -D 'xprofiler_logs' < ${CWD}/init_xprofiler_logs_date.sql
mysql -u${DB_USERNAME} ${PASSWORD} -h ${DB_SERVER_HOST} -P 3306 -D 'xprofiler_logs' -e 'SHOW tables;'
