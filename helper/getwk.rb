get '/wk/:code' do
  str = ""; wk = {}
    begin
    @db.execute( "select * from '#{params[:code]}' order by date desc;" ) do |e|
      d =  Date.parse(e.first)

      wk.store(d.year, {}) if not wk.has_key?(d.year)
      wk[d.year].store(d.cweek, []) if not wk[d.year].has_key?(d.cweek)
      wk[d.year][d.cweek] << e
    end
    ar = wk_candle(wk).take(40)
    ar.each{|row|
      row[0] = row[0].sub("-", "年").sub("-", "月").sub(/$/, "日")
      row[5] = row[5].to_s.sub(/$/, "株")
      # puts row[0]
      # puts row.size
      str += row.join(",\t") + "\r"
    }
    rescue => err 
      puts err
      str = "no table"
    end
  str
end
