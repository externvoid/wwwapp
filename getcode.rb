get '/code/?' do
  str = ""
  sql1 = "select name from sqlite_master where type='table' " + 
    "order by name desc limit 1;"
  codeTbl = @cdb.execute(sql1).first.first
  sql2 = "select code, company from '#{codeTbl}' " + 
    "order by code asc;"
  # 日付を取得
  codeAr = @cdb.execute(sql2); str = codeTbl.delete("code").gsub("_", "-") + "\n"
  begin
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
  str = ""
  sql1 = "select name from sqlite_master where type='table' " + 
    "order by name desc limit 1;"
  codeTbl = @cdb.execute(sql1).first.first
  sql2 = "select code, company from '#{codeTbl}' " + 
    "order by code asc;"
  # 日付を取得
  @codeAr = @cdb.execute(sql2); 
  slim :codetable
end
