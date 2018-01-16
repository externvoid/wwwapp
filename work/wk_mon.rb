# Mon, 25 Dec 2017 20:00:17 +0900
# 週足、月足生成
require 'sqlite3'
require 'date'
str = "6501"
db = SQLite3::Database.new( "shareprice.db" )

sql = "select * from '#{str}' order by date desc limit 80;"
rec = db.execute(sql)

wk = {}; mn = {}
rec.each {|e|
  d =  Date.parse(e.first)

  wk.store(d.year, {}) if not wk.has_key?(d.year)
  wk[d.year].store(d.cweek, []) if not wk[d.year].has_key?(d.cweek)
  wk[d.year][d.cweek] << e
  # p d.cweek, d.year
  mn.store(d.year, {}) if not mn.has_key?(d.year)
  mn[d.year].store(d.month, []) if not mn[d.year].has_key?(d.month)
  mn[d.year][d.month] << e
}
#p wk
# {2017=>
# {42=>[["2017-10-18", 850.0, 855.2, 846.4, 854.1, 21955000.0, 854.1], ["2017-10-17", 855.0, 855.1, 841.4, 846.3, 20089000.0, 846.3], ["2017-10-16", 840.0, 852.3, 839.9, 847.1, 27881000.0, 847.1]], 
# 41=>[["2017-10-13", 824.0, 833.0, 822.3, 832.4, 29342000.0, 832.4], ["2017-10-12", 820.0, 826.0, 814.3, 818.4, 17819000.0, 818.4], ["2017-10-10", 811.6, 819.2, 810.6, 819.2, 14616000.0, 819.2]], 

def wk_candle(h)
  br = []
  h.each_pair{|k, v|
    # p k, v # k = 2017, 2016, ...
    v.each_value{|vv| # v = 42, 41, ...
      cr = []
      cr << vv.reverse.first[0]
      cr << vv.reverse.first[1]
      tr = []; vol = 0.0
      vv.each{|e|
        tr = tr + e[1..4]
        vol += e[5]
      }
      cr << tr.max
      cr << tr.min
      cr << vv.reverse.first[4]
      cr << vol
      br << cr
    }
    #p cr
    # br << cr
  }
  br
end
br = wk_candle(wk)
p br
br = wk_candle(mn)
p br
# [
# ["2017-10-16", 840.0, 855.2, 839.9, 847.1], 
# ["2017-10-10", 811.6, 833.0, 810.6, 819.2], 
# ["2017-10-02", 793.5, 817.2, 793.1, 803.2], 
# ["2017-09-25", 795.4, 799.1, 775.8, 791.0], 
