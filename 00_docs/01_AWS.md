# [実践] JMeterを使ってAWS環境Webアプリケーションを性能検証する② 環境構築(1) AWS編

導入編からの続きです。CloudFormation を用いて AWS のサーバ・ネットワーク構築を行います。

まずは Web サイトと JMeter の動作確認が出来れば良いので、インスタンスタイプはすべて t3.micro、シングル構成で構築します。

# AWS構成

## AWS構成図

<img width=80% alt="システム概要図" src="./.figure/01_AWS/1000.png">

## 内部 ALB を使う理由

通常、一般公開する Web サイトではインターネット向け ALB を採用しますが（下図）、本システムでは採用せず、内部 ALB を使用します。

インターネット向け ALB を使用した場合、作業用PC の JMeter から大量のアクセスをする場合、 作業用PC側のネットワーク回線がボトルネックとなる可能性があります。

<img width=80% alt="システム概要図" src="./.figure/01_AWS/1001.png">

しかし、実際にシステムが使われる場合、複数の端末からアクセスされるため、ネットワーク回線がボトルネックになることはありません。


<img width=80% alt="システム概要図" src="./.figure/01_AWS/1002.png">

性能試験では、AWS環境内に JMeterサーバを導入し、かつ内部 ALB を使用することにより回線のボトルネックが起きないようにしています。

# 構築方法
AWSコンソールで Administrator アカウントを使用して構築していきます。

## 鍵作成
EC2 コンソールからキーペアを作成していきます。

https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/ec2-key-pairs.html

形式は pem で、名前は「key-performance-test」で作成してください。
<img width=100% alt="システム概要図" src="./.figure/01_AWS/1003.png">

## CloudFormation のスタック作成

github リポジトリに CloudFormation のコードを公開しています。まずはこちらを clone か、zipダウンロードしてください。

https://github.com/muroya2355/aws_performance_test

01_AWS_Cfn フォルダ中に yaml ファイルが入っています。構成は以下の通り。各 yaml ファイルのコード詳細は後述します。

|ファイル名|スタック名|リソース|
|-|-|-|
|01_cloudformation-network.yaml	|performance-test-VPC		|VPC/サブネット/GW/ルートテーブル|
|02_cloudformation-IAMRole.yaml	|performance-test-IAMRole	|EC2用IAMロール|
|03_cloudformation-TestEC2.yaml	|performance-test-TestEC2	|構成管理サーバ/JMterクライアント/JMeterサーバ|
|04_cloudformation-WebAPEC2.yaml|performance-test-WebAP		|WebAPサーバ起動設定/ASG/内部ELB|
|05_cloudformation-RDS.yaml		|performance-test-RDS		|RDSインスタンス|
|06_cloudformation-DNS.yaml		|performance-test-DNS		|WebAP用Aレコード/DB用CNAMEレコード|

AWSコンソールの CloudFormation サービスで順番にスタックを作成していきましょう。手順は以下を参考にしてください。

https://qiita.com/mshinoda88/items/c5b238212c2de850efdd#5-cloudformation%E5%AE%9F%E8%A1%8C

ただし、スタック「performance-test-TestEC2」を作成する際、パラメータ「FromIPSegment」が未定になっています。これは作業PCのグローバルIPアドレス（ルータ、プロキシサーバ等のアドレス）を指定してください。家庭用ルータを使用している場合は、IPアドレスがこまめに変更されるので、こまめにスタックを更新してください。

<img width=100% alt="システム概要図" src="./.figure/01_AWS/1004.png">

## 動作確認

# CloudFormation 詳細

## VPC 関連

<img width=80% alt="システム概要図" src="./.figure/01_AWS/1005.png">

```01_cloudformation-network.yaml
puts 'The best way to log and share programmers knowledge.'
```