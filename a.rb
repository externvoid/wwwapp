require 'sqlite3'
db = SQLite3::Database.new 'stock_light.db'
sql = "select * from '1301' order by date desc limit 3;"
p db.execute sql
