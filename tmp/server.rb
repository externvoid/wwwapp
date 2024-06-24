# 2023年  7月  2日 日曜日 01:11:23 JST
# headersメソッドの引数を変更@/json/:code
# Fri, 09 Feb 2018 20:46:05 +0900
# adjを使ってohlcを補正。補正は単純にrate = adj/close, open=open * rate, ...
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'slim'
# require 'sass-embedded'
require 'date'
require './req'
$stdout.sync = true
#$stderr.sync = true
before do
  content_type :txt
  @db = SQLite3::Database.new( "shareprice.db" )
  @cdb = SQLite3::Database.new( "codeTbl.db" )
end
set :bind, '0.0.0.0'
set :port, 8080 # rackupには効果ない

get '/json2?' do
  content_type :json
  data = { foo: [1,2,3]}
  data = [{label: "apple", value: 100}, {label: "orange", value: 200}]
  data.to_json
end

get '/chart/:code' do
  content_type :html
  @code = params[:code]
  @test2 =  {'foo': 3, 'bar': 4}
  @test = getjson

  slim :candle
end   

get '/jsonS/:code' do # loch
  # headers 'Access-Control-Allow-Origin' => '*',
  #   'Access-Control-Allow-Headers' =>
  #   'Origin, X-Requested-With, Content-Type, Accept'
            
  content_type :json
  rec = nil
  begin
    rec = @db.execute( "select date, open, high, low, close, volume, adj from '#{params[:code]}' order by date desc limit 60;" ).reverse
    # 要素７の配列の配列から要素6の配列の配列へfor Swift App
    rec.map!{|e| e[0].gsub!('-','/'); r = e[6]/e[4];[e[0], e[1]*r,
                                          e[2]*r, e[3]*r, e[4]*r, e[5]]}
                                          # e[2]*r, e[3]*r, e[4]*r, e[5]]}
  rescue => err
    redirect "/codetable", 303
    puts err
    rec = "no code table"
  end
  'Hello World'
  rec.to_json
end

# del OK
get '/jsonBAK/:code' do # loch
  headers 'Access-Control-Allow-Origin' => '*',
    'Access-Control-Allow-Headers' =>
    'Origin, X-Requested-With, Content-Type, Accept'
            
  content_type :json
  getjson
end

# new route
get '/json/:code' do # loch
  headers 'Access-Control-Allow-Origin' => '*',
    'Access-Control-Allow-Headers' =>
    'Origin, X-Requested-With, Content-Type, Accept'
            
  content_type :json
  rec = nil
  begin
    rec = @db.execute( "select date, open, high, low, close, volume, adj from '#{params[:code]}' order by date desc limit 60;" ).reverse
    # 要素７の配列の配列から要素5の配列の配列へ
    rec.map!{|e| e[0].gsub!('-','/'); r = e[6]/e[4];[e[0], e[3]*r,
                                          e[1]*r, e[4]*r, e[2]*r]}
                                          # e[2]*r, e[3]*r, e[4]*r, e[5]]}
                                          # volumeデータがあればGoogle Chart, NG
                                          # date, l, o, c, h for Google Chart
  rescue => err
    redirect "/codetable", 303
    puts err
    rec = "no code table"
  end
  'Hello World'
  rec.to_json
end

get '/dy/:code' do
  content_type :html
  str = ""; wk = {}
    begin
    @rec = @db.execute( "select * from '#{params[:code]}' order by date desc;" )
    @rec = @rec.take(40)
    rescue => err 
      puts err
      "no table"
    end
  slim :dy
end

get '/mn/:code' do
  str = ""; mn = {}
    begin
    @db.execute( "select * from '#{params[:code]}' order by date desc;" ) do |e|
      d =  Date.parse(e.first)

      mn.store(d.year, {}) if not mn.has_key?(d.year)
      mn[d.year].store(d.month, []) if not mn[d.year].has_key?(d.month)
      mn[d.year][d.month] << e
    end
    ar = wk_candle(mn).take(120)
    ar.each{|row|
      row[0] = row[0].sub("-", "年").sub("-", "月").sub(/$/, "日")
      row[5] = row[5].to_s.sub(/$/, "株")
      str += row.join(",\t") + "\r"
    }
    rescue => err 
      puts err
      str = "mn no table"
    end
  str
end

get '/all/:code' do
  str = ""
  begin
    @db.execute( "select * from '#{params[:code]}' order by date desc;" ) do |row|
      # db.execute( "select * from '1301';" ) do |row|
      #  puts row.join(',')
      row[0] = row[0].sub("-", "年").sub("-", "月").sub(/$/, "日")
      row[5] = row[5].to_s.sub(/$/, "株")
      # puts row[0]
      # puts row.size
      str += row.join(",\t") + "\r"
    end
  rescue => err
    redirect "/codetable", 303
    puts err
    str = "no code table"
  end
  'Hello World'
  str
end

get '/' do
  # redirect "/codetable", 303
  redirect "/index.html"
end

get '/face' do
  # redirect "/codetable", 303
  redirect "/face.html"
end

get %r!/(\d\w\d\w)! do |c|
#get %r!/(\d{4})! do |c|
#get %r!/([\d]{4})! do |c|
str = ""
begin
#@db.execute( "select * from '#{params[:code]}' order by date desc limit 40;" ) do |row|
  @db.execute( "select * from '#{c}' order by date desc limit 40;" ) do |row|
    # db.execute( "select * from '1301';" ) do |row|
    #  puts row.join(',')
    row[0] = row[0].sub("-", "年").sub("-", "月").sub(/$/, "日")
    row[5] = row[5].to_s.sub(/$/, "株")
    # puts row[0]
    # puts row.size
    str += row.join(",\t") + "\r"
  end
  rescue => err
    redirect "/codetable", 303
    puts err
    str = "no code table"
  end
  'Hello World'
  str
end

after do
  @db.close
  @cdb.close
end
