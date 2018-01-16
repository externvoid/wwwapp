# Tue, 26 Dec 2017 15:52:40 +0900
これで止まる
>sudo systemctl stop apache2.service 

# Mon, 20 Nov 2017 09:17:38 +0900

- wling.db // kabuojiからdownloadしたCSVより作成したall candle sticks2017-10-18
- crowling2.db // Yahoo2017-11-01データを使ってアップデート
- crowlingW.db // 日々更新している、Working Data。

- crowling{3-5}.db // crowling2.dbのコピー、debug用

# Wed, 15 Nov 2017 09:55:01 +0900
- crowling.db
  kabuoji3から得たCSV(9.5hr必要, Oct 18までのデータ)をtableへ放り込んだ。

- shareprice.db
  crowling.dbへのリンク(~/kabuoji/asset/crowling.db)

- shareprice.db~
  yahoo financeから得た20日分データ(Jun 09取得)
  May 17 - Jun 09の20日分

  file sizeでかい！code毎にtable作成するとファイルサイズが9倍？
  20日分のデータをone tableに放り込むとファイルサイズが小さくなる。
