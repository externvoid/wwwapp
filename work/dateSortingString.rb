# sorting Date String
require 'date'
ar = ['1月', '2月', '11月']
br = ['2017年1月1日', '2017年12月1日', '2017年11月1日']
cr = ['2017-1-1', '2017-12-1', '2017-11-1']
p ar.sort_by{|x| x.to_i}
p br.sort_by{|x| x.to_i}
p cr.sort_by{|x| x.to_i}
# Dateクラスを使わないと、sort orderがプギャー
puts "====="
p cr.sort_by{|x| -Date.parse(x).to_time.to_i} # 降順はマイナスで！
br.sort_by!{|x| -Date.parse(x.sub('年', '-').sub('月', '-')).to_time.to_i}
p br
dr = ['2017-1-1', '2017-12-1', '2017-11-1', '2016-12-31']
p dr.reject{|x| x < '2017-1-1'}

p dr.select{|x| x =~ /\d{4}/}
