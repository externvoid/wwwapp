helpers do
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
        cr << vv.reverse.last[4]
        cr << vol
        br << cr
      }
    }
    br
  end
end
