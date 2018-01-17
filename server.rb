require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'slim'
require 'sass'
require 'date'
require './req'
$stdout.sync = true
#$stderr.sync = true
before do
  content_type :txt
  @db = SQLite3::Database.open( "shareprice.db", :readonly => true )
  @cdb = SQLite3::Database.new( "codeTbl.db" )
end
set :bind, '0.0.0.0'
set :port, 8080 # rackupには効果ない

get '/json?' do
  content_type :json
  data = { foo: [1,2,3]}
  data.to_json
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
    ar = wk_candle(mn).take(40)
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

get %r!/(\d+)! do |c|
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
    puts err
    str = "no code table"
  end
  'Hello World'
  str
end
