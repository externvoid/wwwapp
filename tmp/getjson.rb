def getjson
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
    puts err
    redirect "/codetable", 303
    rec = "no code table"
  end
  rec.to_json
end
