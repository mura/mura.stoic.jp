---
layout: single
title: プロバイダをIIJmioひかりに乗り換えた
date: 2020-12-13 00:00:00 +0900
type: post
tags:
- Internet
permalink: "/2020/12/swithed-internet-provider-to-iijmio-hikari/"
---
今年の12月がいままで使っていたインターネットプロバイダの更新月だった。
いろいろ考えて、解約料が安いプロバイダに乗り換えることにした。

[IIJmioひかり](https://www.iijmio.jp/imh/)に乗り換えたのは、24ヶ月以内の解約料が5,000円で、今使っている携帯回線がIIJmioで多少安くなるということから選んだ。

## 事業者変更承諾番号の取得
今回はソフトバンク光からIIJmioひかりへの「光コラボ」同士の切り替えになるので、まずはソフトバンク光から「事業者変更承諾番号」を取得する必要がある。<br>
→ [コラボ光の事業者変更お手続き（情報開示許諾のお手続き）｜NTT西日本公式│フレッツ光](https://flets-w.com/collabo/change/entry/)

「事業者変更承諾番号」の取得方法はプロバイダによって違い、ソフトバンク光の場合は電話で申し込む必要がある。<br>
→ [［SoftBank 光］「転用」または「事業者変更」をする場合の手続き方法を教えてください。](https://www.softbank.jp/support/faq/view/19129)

窓口に電話すると、とくに引き留めもなく番号の発行自体もすんなりできて、注意点についてもいろいろ教えてもらえた
- 「事業者変更承諾番号」自体は翌日SMSで携帯に届く
- 「事業者変更承諾番号」は発行から15日間有効
  - 乗り換え先の開通も含めて15日間に行わないと有効期限が切れる
  - 有効期限が切れたら再取得しなければならない
- 「事業者変更承諾番号」の発行に税別3,000円の事務手数料がかかる
  - 乗り換え先の方でも事務手数料 税別3,000円がかかる（合計税別6,000円）
  - 乗り換えを取りやめた場合は事務手数料はかからない
- NTTの回線はそのまま使える、機材の入れ替えもなし
- 貸し出されている光BBユニットは14日以内に元払いで返送する
- [Yahoo! BB「プレミアム」](https://bbpromo.yahoo.co.jp/premium/)に入っている場合、月末までプレミアム会員が維持される
  - 解約翌月1日 16時以降に再度Yahoo!プレミアムに加入することができる
- 解約月のインターネット料金は日割りで計算される

## IIJmioひかりの申し込み
「事業者変更承諾番号」が届いて、IIJmioひかりに申し込んだ。すでにIIJmioを使っているので住所などはそのまま引き継いでくれるのは楽だった。

IIJmioひかりの場合、申込時に開通日を決める電話を受ける日を予約し、後日「プロビジョニングセンター」という所から電話がかかってきて開通日を決定する。自分の場合は12/5に申し込み、7日に開通日を決めて、10日に開通と言う流れだった。

7日に電話を受けた翌日`[IIJmio] ready to start`という開通日をお知らせするメールが届いた。

この間もちろんソフトバンク光は問題なく使えている。

## IIJmioひかり開通～波乱
「プロビジョニングセンター」の方の話では、10日なればいつ切り替え作業してもらっても良く、切り替え作業をすると自動的にソフトバンク光が解約されるとのことだった。

ソフトバンク光では[IPv6高速ハイブリッド IPv6 IPoE + IPv4](https://www.softbank.jp/ybb/hikari/ipv6/)を使っていたので「切り替え作業」とは？と思っていたが、単にIPv4 PPPoEで接続することだった。

IPv6の方はまだソフトバンク光のままで
- IPv6: ソフトバンク光(IPoE)
- IPv4: IIJmio光(PPPoE)

という形で開通した。

光BBユニットは使えなくなるので、昔使っていた[YAMAHA NVR500](https://network.yamaha.com/products/routers/nvr500/index)を引っ張り出して設定してる。

### 11日お昼
10日はそれで問題なく使えていたが11日になって突然インターネットが使えなくなった。
よくよく調べてみると、IPoEの方が不通になっておりどうやらソフトバンク光の解約が行われた模様でIPv6が突然消えたのが原因らしかった。

IIJmioひかりにはIPv6 PPPoEが標準で使えるようなので、そっちを設定することにした。
- IPv6: IIJmio光(PPPoE)
- IPv4: IIJmio光(PPPoE)

夜には`[IIJmio] IIJmioひかり回線開通のお知らせ`というメールがきて、開通日がちゃんと契約ページに載るようになった。

### 12日朝
朝7時に突然NVR500からアラーム音が鳴り響いた。NVR500はPPPoEなど接続時と切断時にBEEP音を鳴らす仕様があり設定を切り替えたりすると鳴るのだが、繰り返しずっと鳴っているのは明らかにおかしい。

寝ぼけつつNVR500の管理画面を開いてみるとIPv6 PPPoEの方が切断されていて、ログにはIPv6 PPPoEの認証エラーがずらーっと出ていた。
```
2020/12/12 07:00:07: PPPOE[01] Disconnected, cause [No error.]
2020/12/12 07:00:07: PPPOE[01] Connecting to PPPoE server
2020/12/12 07:00:07: PPPOE[01] PPPoE Connect
2020/12/12 07:00:07: PPPOE[02] Disconnected, cause [No error.]
2020/12/12 07:00:08: PPPOE[02] Connecting to PPPoE server
2020/12/12 07:00:08: PPPOE[02] PPPoE Connect
2020/12/12 07:00:08: PP[02] CHAP Response Error
2020/12/12 07:00:08: PPPOE[02] Disconnected, cause [PPP: Authentication failed]
2020/12/12 07:00:09: PPPOE[02] Connecting to PPPoE server
2020/12/12 07:00:09: PPPOE[02] PPPoE Connect
2020/12/12 07:00:10: PP[02] CHAP Response Error
2020/12/12 07:00:10: PPPOE[02] Disconnected, cause [PPP: Authentication failed]
～中略～
2020/12/12 07:09:34: PPPOE[02] Connecting to PPPoE server
2020/12/12 07:09:34: PPPOE[02] PPPoE Connect
2020/12/12 07:09:34: PP[02] CHAP Response Error
2020/12/12 07:09:34: PPPOE[02] Disconnected, cause [PPP: Authentication failed]
2020/12/12 07:09:34: PP[02]: clear account
2020/12/12 07:09:34: PP[02]: last account: 47 calling, 0 called, 0 yen.
```
(`PPPOE[01]`がIPv4、`PPPOE[02]`がIPv6)

どうしようもないのでIPv6 PPPoEの設定を消すことにした
- IPv6: なし
- IPv4: IIJmio光(PPPoE)

あとでメールを確認すると、ちょうどエラーが出始めた7:00に`[IIJmio] IPoE オプションご利用開始日確定のお知らせ`というメールが届いていて、IPoEは13日から使えると言うことだった。

## IPoEの開通
そして今日13日である。NVR500にIPv6 IPoEを設定してみると問題なく接続することができた。

IIJmioひかりはDS-Liteという方式でIPv4 over IPv6に対応していて、インターネットマルチフィード社の[transix](https://www.mfeed.ad.jp/transix/dslite/dslite.html)で接続することができる。しかも[YAMAHAルーター向けの設定](https://www.mfeed.ad.jp/transix/dslite/yamaha.html)まで公開してくれているので、とても助かった。

最終的には以下の状態で落ち着いた
- IPv6: IIJmio光/mfeed(IPoE)
- IPv4: transix(DS-Lite)
- IPv4: IIJmio光(PPPoE)

IPoEで接続すると、IPアドレスの払い出しはインターネットマルチフィード社のようで、transixまで設定するとIIJmioどこ行った状態になる。<br>
<a href="{{ site.baseurl }}/assets/images/2020/12/test-ipv6.png"><img src="{{ site.baseurl }}/assets/images/2020/12/test-ipv6-300x167.png"></a><br>
([test-ipv6](https://test-ipv6.com)の結果)

## さいごに
ソフトバンク光からIIJmioひかりに乗り換えてみたが、速度低下も見られず満足している。

IPv4の接続状況にPPPoEが残っているがこれは誤植ではなく、DS-Liteにはいろいろ制約があるのでPPPoEとマルチホーミングをしてみようとしている（というかすでに設定はしてある）。

また時間が出来たらDS-LiteとPPPoEの設定とかも書いていこうと思う。