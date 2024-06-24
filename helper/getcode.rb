get '/code/?' do
  str = ""
  sql1 = "select name from sqlite_master where type='table' " + 
    "order by name desc limit 1;"
  codeTbl = @cdb.execute(sql1).first.first
  sql2 = "select * from '#{codeTbl}' " + 
  # sql2 = "select code, company from '#{codeTbl}' " + 
    "order by code asc;"
  # 日付を取得
  codeAr = @cdb.execute(sql2); str = codeTbl.delete("code").gsub("_", "-") + "\n"
  begin # str初期値は日付文字列
  codeAr.each {|e|
      str += e.join(",\t") + "\n"
  }
  rescue => err 
    puts err
    str = "err in code"
  end
  'Hello World'
  str
end

get '/codetable/?' do
  content_type :html
  slim :codetable
end
# 2023年  7月 10日 月曜日 15:49:10 JST
get '/jsonCode/?' do
  content_type :json

  begin
    sql1 = "select name from sqlite_master where type='table' " + 
      "order by name desc limit 1;"
    codeTbl = @cdb.execute(sql1).first.first
    sql2 = "select * from '#{codeTbl}' order by code asc;"
    codeAr = @cdb.execute(sql2)
    # 日付を取得
    str = codeTbl.delete("code").gsub("_", "-")
    codeAr.insert(0, [str])
  rescue => err
    redirect "/codetable", 303
    puts err
    rec = "no codes json"
  end
  'Hello World'
  codeAr.to_json
end

# 2024年  3月 29日 金曜日 22:23:13 JST
get '/jsonCode2/?' do
  content_type :json
  @codeAr.to_json
end
