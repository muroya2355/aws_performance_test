# [実践] JMeterを使ってAWS環境Webアプリケーションを性能検証する③ 環境構築(2) Ansible編

環境構築(1) AWS編からの続きです。Ansible を用いて各サーバをプロビジョニングしていきます。

今回も、構築方法を先に、その後で各 Ansible コードの解説を行います。

# ソフトウェア構成

## ソフトウェア構成図

<img width=100% alt="ソフトウェア概要図" src="./.figure/ソフトウェア構成.png">

黒細字のソフトウェアはインストール済です。黒太字のソフトウェアをインストールしていきます。

また、構成管理サーバでアプリケーションをビルドし、WebAPサーバにデプロイします。

## Ansible 構成

Ansible のファイル構成は以下になります。

<img width=80% alt="ソフトウェア概要図" src="./.figure/Ansible.png">

# 構築方法

## Ansible インストール

EC2 ユーザデータで実施済ですが、Ansibleのインストールコマンドは以下です。

```sh:構成管理サーバ
# python3.8のインストール
$ sudo amazon-linux-extras install -y python3.8
# python3.8と同時にpip3.8もインストールされるが、バージョンが古いためアップグレードする
$ sudo pip3.8 install --upgrade pip
# pip3.8でansibleをインストール
$ /usr/local/bin/pip3.8 install ansible
# 本システムで必要となるパッケージのインストール
$ /usr/local/bin/pip3.8 install boto3 botocore
$ /usr/local/bin/pip3.8 install pywinrm
```

## WinRMの実行許可設定

こちらも EC2 ユーザデータで実施済ですが、Ansible から Windows の JMeter クライアントを操作するために、Powershell で以下のコマンドを実行します。

```powershell:JMeterクライアント
> $url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
> $file = "$env:temp\ConfigureRemotingForAnsible.ps1"
> (New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)
> powershell.exe -ExecutionPolicy ByPass -File $file
```

https://goodbyegangster.hatenablog.com/entry/2019/04/09/073408

## Ansible 動作確認

まずは git でリポジトリをクローンしてください。

```sh:構成管理サーバ
$ cd ~
$ git clone https://github.com/muroya2355/aws_performance_test.git
$ cd aws_performance_test/02_Ansible/
$ ls
inventory_aws_ec2.yaml  roles              test-jmeter-client.yaml  webap.yaml
playbook.yaml           test-ansible.yaml  test-jmeter-server.yaml
```

インベントリファイルのチェックし、ホスト一覧を取得します。以下のようにホスト一覧が表示されればOKです。

```sh:構成管理サーバ
$ ansible-inventory -i inventory_aws_ec2.yaml --graph
@all:
  |--@aws_ec2:
  |  |--test-ansible
  |  |--test-jmeter
  |  |--test-win
  |  |--webap
  |--@tag_ansible:
  |  |--test-ansible
  |--@tag_jmeter_server:
  |  |--test-jmeter
  |--@tag_tour_reservation:
  |  |--webap
  |--@tag_windows:
  |  |--test-win
  |--@ungrouped:
```



## Playbook 実行




## アプリケーション動作確認