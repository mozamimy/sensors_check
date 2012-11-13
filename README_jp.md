sensors_check.rb README
=======================

## イントロダクション

sensors_check.rbは、cronとsensorsコマンドを組み合わせることにより、CPUの温度監視を可能にするRubyスクリプトである。CPUの温度が危険な域に達すると、メールおよびsyslogによってユーザに知らせる。

## 動作環境

Linux(openSUSE 12.2)およびRuby 1.9.3で動作することを確認している。また、syslogによる通知は、KDEで動作を確認している。

## 構成

- sensors_check.rb: スクリプト本体。
- sensors_check.sh: cronから呼び出すシェルスクリプト。これを使って、間接的にsensors_check.rbを起動する。

## 導入

### スクリプトの書き換え

適当なエディタでsensors_check.rbおよびsensors_check.shを開き、必要な書き換えを行う。

#### sensors_check.rbの書き換え

まず、警告メールを送信するメールアドレスなどの設定を行う。send_alert_mailメソッド中の17-18行目に、あなたのメールアドレスを入力する。次に、mail_delivery_methodメソッドの引数に与えているハッシュの中のSMTPサーバの情報を書き換える。

認証付きのSMTPサーバのユーザIDとパスワードをハードコーディングすることはおすすめしない。認証なしで使えるSMTPサーバがない場合、ローカルマシンにlocalhostからのリクエストのみ受け付けるSMTPサーバを立てるのが良いだろう。

#### sensors_check.shの書き換え

6行目のcdコマンドの引数のパスを、適宜書き換える。cdの引数には、sensors_check.rbおよびsensors_check.shが置かれているディレクトリのフルパスを与える。

### cronにスクリプトを登録する

ここでは、設定の一例を示す。cronの詳細な使い方は、インターネットなどで調べてほしい。

まず、以下のコマンドを使ってcronの設定ファイルを修正する。このコマンドを使うと、$EDITORに設定されているエディタでcronの設定ファイルが開かれる。

`$ crontab -e`

次に、以下の1行を追加する。スクリプトが/home/icecube/binに存在すると仮定している。

`*/5 * * * * /home/icecube/bin/sensors_check.sh > /dev/null 2>&1`

この設定例では、5分ごとにスクリプトを走らせるようになっている。

以上で導入は完了である。have fun!

## 作者について

Moza USANE
http://blog.quellencode.org/
mozamimy@quellencode.org