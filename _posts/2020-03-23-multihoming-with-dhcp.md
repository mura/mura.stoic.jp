---
layout: single
title: DHCP環境でマルチホーミングやってみた
date: 2020-03-23 00:00:00 +0900
type: post
tags:
- Linux
- Raspberry Pi
permalink: "/2020/03/multihoming-with-dhcp/"
---
## 我が家のインターネット環境
今の自宅には、アパート付きのネット回線(フレッツ光、無料)と、自分で引いた回線(ソフトバンク光)の2つがある。
なぜアパートに無料の回線があるのにさらに回線を引いたのかは、涙なしには語れないのだが今回は割愛するとして、せっかく2回線あるので遊ばない手はないということで、「[マルチホーミング](http://e-words.jp/w/%E3%83%9E%E3%83%AB%E3%83%81%E3%83%9B%E3%83%BC%E3%83%9F%E3%83%B3%E3%82%B0.html)」に挑戦してみた。

マルチホーミング自体の詳細はリンク先にお任せするとして、通常インターネットの出口は1つしか使えないが、複数使えるようにしてしまえということである。

<a href="{{ site.baseurl }}/assets/images/2020/03/HomeNetwork.png"><img src="{{ site.baseurl }}/assets/images/2020/03/HomeNetwork-232x300.png"></a>

ざっくり今の自宅のLAN構成を書いてみた。

それぞれの回線は光回線用のルーターに接続されている。アパート付きの回線はMDFの中にルーターがあるので自由に触れず、ソフトバンク光はIPoEで繋ぐために光BBユニットに繋がっている。

## どうやってマルチホーミングしよう？
残念なことにどちらのルーターもDHCPをOFFに出来ない。それぞれのルーター以下のネットワークを同一のスイッチ以下に収めるのは基本無理だ。
それぞれのルーター用にスイッチやNICを買うのはコスパが悪いので、[VLAN](http://e-words.jp/w/VLAN.html)を使うことにした。

そこでNETGEARの[GS308E](https://amzn.to/2U78I2B)を導入した。設定はちょっと難しいが、Webのインタフェースがついていて操作はしやすい方かなと思う。

VLANには2種類あって、LANポートごとに割り当てる「ポートVLAN」と目印(タグ)をつけたフレームを使う「タグVLAN」がある。
それぞれの特徴をまとめると

ー | ポートVLAN | タグVLAN
:---:|:---:|:---:
物理ポート当たりの設定数 | 1つ | 複数
クライアント側の対応 | 不要 | 必要
スイッチをまたいだVLANの設定 | できない | できる

さらにこれらを組み合わせる事も可能で、各ルーターをポートVLANで接続して、クライアントとなるRaspberry PiはタグVLANで設定している。物理2ポートを物理1ポートに集約できるので1つのスイッチで結構遊ぶことが出来る。

## まずはVLANの設定
うちで使っているRaspberry Piには[Ubuntu Server for ARM](https://ubuntu.com/download/server/arm)を入れているので、普通のUbuntuも同じような設定できるはず。

Ubuntu 19.10を使っているとnetplanがインストールされてると思うので、その設定ファイルに追加する。自分の環境では `/etc/netplan/50-cloud-init.yaml` があったのでそこに追記した。

```yaml
network:
    version: 2
    ethernets:
        eth0:
            addresses: ['192.168.0.210/24']
            optional: true
    vlans:
        vlan101:
            id: 101
            link: eth0
            dhcp4: true
            dhcp4-overrides:
                route-metric: 10
        vlan102:
            id: 102
            link: eth0
            dhcp4: true
            dhcp4-overrides:
                route-metric: 20
```

`network/vlans`直下の名前は任意だが、`ifconfig`や`ip`コマンドで使うのでわかりやすいものに。`id`でスイッチで設定したVLAN ID、`link`には物理NICのデバイス名を入れる。

ここでstatic ipを振れれば簡単なのだが、今回はDHCP環境下なので、`dhcp4: true`を書いておく。`route-metric`はネットワークの優先度(小さい方が高)を指定している。がっつりルーティングの設定をする場合はなくても良いが、手っ取り早くデフォルトの出口を決めておきたい場合はそちらに小さい数字を振っておくと良い。

ここまで設定出来て、`sudo netplan apply`を打てばIPアドレスが振ってくるはず。`ip a`や`ip r`でIPやルーティングが設定されることを確認してみよう。

## ルーティングルールの追加
上記の設定が終わればとりあえずインターネットに繋がったと思う。しかしメトリックの設定でVLAN101からしかインターネットに出て行かない。
また`curl --interface vlan102`などインターフェースが指定できるオプションをつけてもVLAN102からレスポンスを受け取ることができない。（ルーティングに詳しいわけではないが、デフォルトゲートウエイがあれやこれやしてる模様）

まず、`/etc/iproute2/rt_tables`にVLAN102用のテーブル番号を抑えておく

```
#
# reserved values
#
255     local
254     main
253     default
0       unspec
#
# local
#
#1      inr.ruhep
100     vlan102 # ← 追加
```
数字とその横の名前はかぶっていなければなんでもかまわない。

その後、`ip rule`でルーティングのルールを追加する。VLAN102に払い出されたIPが`192.168.0.100`とすると

```
$ sudo ip rule add from 192.168.0.100 table 100 prio 200
```
と入れると
```
$ ip rule
0:	from all lookup local
200:	from 192.168.0.100 lookup vlan102
32766:	from all lookup main
32767:	from all lookup default
```
と設定される。`table 100`で指定したのが`rt_tables`に追加した番号、`prio 200`で指定したのが、このルーティングルールの優先度。1以上、32766以下であれば何番でも良いので不都合がない番号を指定する。

これで、`192.168.0.100`で発信されるパケットは`vlan102`のルーティングテーブルのルールが適応される。

ルーティングテーブルを表示するには以下のコマンドを使う
```
$ ip route show table 100
```
しかし、まだなにも設定していないのでエラーが表示される。

インターネットの出口として使うにはデフォルトゲートウエイを追加する。ゲートウェイのIPアドレスが`192.168.0.1`とすると
```
$ sudo ip route add 0.0.0.0/0 dev vlan102 via 192.168.0.1 table 100
$ sudo ip route add 192.168.0.0/24 dev vlan102 table 100
```
1行目がデフォルトゲートウエイの設定。`dev vlan102`は通信するデバイス名なのでVLANの`vlan102`を指定してる。2行目はネットワークマスクの設定。正直無くて通信はできる。

ここまで設定出来たら、curlなどで通信できるようになるはずだ。
```
$ curl --interface vlan102 https://www.example.com/
```

しかし、残念なことにDHCPのIPアドレスの更新があるとこの設定が吹っ飛んでしまう。

## networkd-dispacherに設定してもらう
[networkd-dispatcher](https://gitlab.com/craftyguy/networkd-dispatcher)はネットワークの状態変化が起こったときにスクリプトを起動してくれるプログラム。これを使ってIPアドレスが変わったらスクリプトを起動することでルーティングの設定を自動化することにした。

起動させたいスクリプトは`/etc/networkd-dispatcher/routable.d`以下に置くことで、疎通可能になったときに読んでくれる。ただし、実行可能かつrootユーザーのファイルでないと起動してくれない。

今回はサブネットマスクを汎用的に作りたかったのでPerlで作成した。設定するインターフェースの情報は環境変数で渡されるので、具体的な値は[README.md](https://gitlab.com/craftyguy/networkd-dispatcher/-/blob/master/README.md)あたりを見るとなんとなくわかると思う。

```perl
#!/usr/bin/perl

use 5.028;
use IO::Interface::Simple;
use Net::Netmask;
use JSON qw/decode_json/;

my $IFACE = $ENV{IFACE};
my $AdministrativeState = $ENV{AdministrativeState};
my $json = decode_json($ENV{json});

if ($IFACE eq 'vlan102' and $AdministrativeState eq 'configured') {
  my $if = IO::Interface::Simple->new($IFACE);
  my $block = Net::Netmask->new($if->address, $if->netmask);
  my $gateway = $$json{Gateway}->[0];
  system "ip rule del table 100 prio 200";
  system "ip route add 0.0.0.0/0 dev $IFACE via $gateway table 100";
  system "ip route add ".$block->desc." dev $IFACE table 100";
  system "ip rule add from ".$if->address." table 100 prio 200";
}
```

エラー処理もなにもないスクリプトだが、起動後でもIPアドレス更新後でもちゃんとルーティングテーブルを更新してくれている。