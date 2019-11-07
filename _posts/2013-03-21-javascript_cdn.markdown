---
layout: single
title: JavaScriptを配布しているCDNまとめ
date: 2013-03-21 23:23:14.000000000 +09:00
type: post
tags:
- JavaScript
permalink: "/2013/03/javascript_cdn/"
---
プロフサイトである[stoic.jp](http://stoic.jp/)を[Twitter Bootstrap](http://twitter.github.com/bootstrap/)で書き直してみた。<br />
ヘッダーがあって、そのしたに何個かのカラムがあるようなサイトを作るときなんかさっくり作れる。

基本的にCSSのフレームワークだけど、[jQuery](http://jquery.com/)を使って拡張ができて、ダイアログを表示したり、タブを簡単に実装できる。<br />
エンジニアがツールを作ったりするとCSSがうまくかけずに素っ気ないページができあがるけど、これを使えばちょっとかっこいい物ができそう。

あと、レスポンシブレイアウトにすぐに対応できるのもいい。PCとスマートフォンで同じページを（それなりに）見せられるのは魅力的。

Twitter Bootstrapを使うには、配布サイトからzipを落としてきて自分でファイルを置かないといけないけど、世の中にはJavaScriptをホスティングしてくれてるサービスがいくつかあったのでまとめてみた。<br />
基本的に海外のサイトだけど、[CDN](http://e-words.jp/w/CDN.html)を使ってそこそこ速そうだったのでpingを打って確かめてみた。

### [Google Hosted Libraries](https://developers.google.com/speed/libraries/)
Googleのホスティングサービス。jQueryを使うときなんかよく紹介される。<br />
収録されているライブラリはそんなに多くない。

```
C:\Users\mura>ping ajax.googleapis.com

googleapis.l.google.com [74.125.31.95]に ping を送信しています 32 バイトのデータ:
74.125.31.95 からの応答: バイト数 =32 時間 =46ms TTL=48
74.125.31.95 からの応答: バイト数 =32 時間 =48ms TTL=48
74.125.31.95 からの応答: バイト数 =32 時間 =39ms TTL=48
74.125.31.95 からの応答: バイト数 =32 時間 =45ms TTL=48

74.125.31.95 の ping 統計:
    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
ラウンド トリップの概算時間 (ミリ秒):
    最小 = 39ms、最大 = 48ms、平均 = 44ms
```

### [Microsoft Ajax Content Delivery Network](http://www.asp.net/ajaxlibrary/cdn.ashx)
Microsoftのホスティング。jQueryとASP.NETのJSライブラリを提供している。<br />
今回調べた中で一番応答速度がよかった。

```
C:\Users\mura>ping ajax.aspnetcdn.com

mscomajax.vo.msecnd.net [65.54.91.182]に ping を送信しています 32 バイトのデータ:
65.54.91.182 からの応答: バイト数 =32 時間 =8ms TTL=56
65.54.91.182 からの応答: バイト数 =32 時間 =8ms TTL=56
65.54.91.182 からの応答: バイト数 =32 時間 =8ms TTL=56
65.54.91.182 からの応答: バイト数 =32 時間 =10ms TTL=56

65.54.91.182 の ping 統計:
    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
ラウンド トリップの概算時間 (ミリ秒):
    最小 = 8ms、最大 = 10ms、平均 = 8ms
```

### [jsDelivr](http://www.jsdelivr.com/)
490個のプロジェクトをホスティング。<br />
調べた中最多。サイト内の検索システムをつかってライブラリを探す。

```
C:\Users\mura>ping cdn.jsdelivr.net

jsdelivr.dak.netdna-cdn.com [108.161.188.69]に ping を送信しています 32 バイトのデータ:
108.161.188.69 からの応答: バイト数 =32 時間 =124ms TTL=53
108.161.188.69 からの応答: バイト数 =32 時間 =126ms TTL=53
108.161.188.69 からの応答: バイト数 =32 時間 =127ms TTL=53
108.161.188.69 からの応答: バイト数 =32 時間 =125ms TTL=53

108.161.188.69 の ping 統計:
    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
ラウンド トリップの概算時間 (ミリ秒):
    最小 = 124ms、最大 = 127ms、平均 = 125ms
```

### [cdnjs](http://cdnjs.com/)
320個のライブラリをホスティング。Microsoftに次いで応答速度が速い。<br />
GitHubでライブラリが管理されていて、pull requestを送ることで新しいライブラリを追加することが出来る模様。

```
C:\Users\mura>ping cdnjs.cloudflare.com

cdnjs.cloudflare.com.cdn.cloudflare.net [190.93.240.8]に ping を送信しています 32 バイトのデータ:
190.93.240.8 からの応答: バイト数 =32 時間 =16ms TTL=52
190.93.240.8 からの応答: バイト数 =32 時間 =13ms TTL=52
190.93.240.8 からの応答: バイト数 =32 時間 =9ms TTL=52
190.93.240.8 からの応答: バイト数 =32 時間 =10ms TTL=52

190.93.240.8 の ping 統計:
    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
ラウンド トリップの概算時間 (ミリ秒):
    最小 = 9ms、最大 = 16ms、平均 = 12ms
```

### [BootstrapCDN](http://www.bootstrapcdn.com/)
おまけ。Twitter Bootstrapのみをホスティングしている。NetDNAというCDN会社が運営しているっぽい。

```
C:\Users\mura>ping netdna.bootstrapcdn.com

bootstrapcdn.jdorfman.netdna-cdn.com [108.161.189.56]に ping を送信しています 32 バイトのデータ:
108.161.189.56 からの応答: バイト数 =32 時間 =117ms TTL=53
108.161.189.56 からの応答: バイト数 =32 時間 =118ms TTL=53
108.161.189.56 からの応答: バイト数 =32 時間 =118ms TTL=53
108.161.189.56 からの応答: バイト数 =32 時間 =117ms TTL=53

108.161.189.56 の ping 統計:
    パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
ラウンド トリップの概算時間 (ミリ秒):
    最小 = 117ms、最大 = 118ms、平均 = 117ms
```
