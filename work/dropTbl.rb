require 'sqlite3'
require 'date'

db = SQLite3::Database.new( "shareprice-dup.db")
# db = SQLite3::Database.open( "shareprice-dup.db", :readonly => true )
sqlD = "delete from '1301' where date = '2017年6月13日'"
db.execute(sqlD)
db.close
# 戦略
# 1. 一旦全データをarに格納
# 2. 格納データから日付文字列のみを格納したarを作成
# 3. arをsortしてdelete候補を格納したarを作成
# 4. ar.eachしてdelete fromを実行！

@str = "OK"
str = "NG"
def foo
  puts @str
  yield
#  puts str
end
foo{ puts str}
define_method :bar do |e|
  puts str
  puts e
end
bar 1301
