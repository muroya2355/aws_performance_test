# ツアー予約システム

## 機能一覧
* ユーザ登録機能
* ユーザログイン／ログアウト機能
* ツアー検索機能
* ツアー詳細表示機能
* ツアー予約機能
* ツアー予約照会/キャンセル機能

## データテーブル

|テーブル|固定データ|説明|
|-|-|-|
|出発地テーブル|○|北海道～沖縄 までの47都道府県|
|目的地テーブル|○|北海道～沖縄 までの47都道府県|
|宿泊施設テーブル|-|宿泊施設情報|
|年令区分テーブル|○|大人, 小人|
|社員テーブル|-|サイト管理者|
|顧客テーブル|-|エンドユーザ|
|ツアーテーブル|-|ツアー情報|
|ツアー担当者テーブル|-|各ツアーの担当者情報|
|予約テーブル|-|顧客の予約ツアー|

## データの用意

|テーブル|データ件数|SQLファイル|
|-|-|-|
|宿泊施設テーブル|5000件|00220_insert_accommodation.sql|
|顧客テーブル|10万件|00250_insert_customer.sql|
|ツアーテーブル|約150万件|00260_insert_tourinfo.sql|
|ツアー担当者テーブル|約180万件|00270_insert_tourcon.sql|

```sh:構成管理サーバ
$ cd ~
$ psql -h local.db.tourreserve.com -U postgres -d tourreserve
Password for user postgres: P0stgres
tourreserve=> \i ~/aws_performance_test/03_JMeter/00220_insert_accommodation.sql
tourreserve=> select count(*) from accommodation;
 count
-------
  5000
(1 row)
tourreserve=> \i ~/aws_performance_test/03_JMeter/00250_insert_customer.sql
tourreserve=> select count(*) from customer;
 count
--------
 100000
(1 row)
tourreserve=> \i ~/aws_performance_test/03_JMeter/00260_insert_tourinfo.sql
tourreserve=> select count(*) from tourinfo;
  count
---------
 1537464
(1 row)
tourreserve=> \i ~/aws_performance_test/03_JMeter/00270_insert_tourcon.sql
tourreserve=> select count(*) from tourcon;
  count
---------
 1805355
(1 row)
```

# JMeter動作確認

## トップページ表示

## ログイン/ログアウト
https://blackbird-blog.com/jmeter-02
https://blackbird-blog.com/jmeter-login-case01
https://blackbird-blog.com/jmeter-login-case02

## ツアー検索/詳細表示

## ユーザログイン