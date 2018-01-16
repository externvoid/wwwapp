# shareprice.db格納のレコードを2017-6-1以降のモノに限定する。
# vacuum;してもファイル容量が小さく成らない？
# Mon, 15 Jan 2018 16:07:01 +0900
# 超強力、時間が掛かる！6hr位
# ちょいとの変更でdateフィールドが2017年06月01日、って感じでもOK!
require 'sqlite3'
require 'date'

db = SQLite3::Database.new( "shareprice-dup.db")
strDate = "2017-6-1" # 6月分のみを抽出する
# db = SQLite3::Database.open( "shareprice-dup.db", :readonly => true )
# 戦略
# 0. code nameを格納したar作成
# 1. 一旦全データをarに格納
# 2. 格納データから日付文字列のみを格納したarを作成
# 3. arをsortしてdelete候補を格納したarを作成
# 4. ar.eachしてdelete fromを実行！

# step 0
sqlCode = "select name from sqlite_master where type = 'table' order by name asc;"
ar = db.execute(sqlCode).flatten
ar.select!{|x| x =~ /\d{4}/} # codeTblテーブルとかあるし！
# step 1
ar.each_with_index{|e, i|
  sqlS = "select date from '#{e}';"
  br = db.execute(sqlS).flatten
  br.sort_by!{|x| -Date.parse(x).to_time.to_i}
  # step 3
  br.reject!{|x| Date.parse(x) >= Date.parse(strDate)}
  # puts br.take(3)
  # puts br # delete 日付
  br.each_with_index{|f, j|
    sqlD = "delete from '#{e}'where date = '#{f}';"
    # step 4
    db.execute(sqlD)
  }
  puts i if i % 100 == 0
}

db.close
__END__


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
