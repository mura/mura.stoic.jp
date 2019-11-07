---
layout: single
title: NVIDIA Shield TVのパフォーマンスはいかほど？
date: 2016-02-21 23:24:15.000000000 +09:00
type: post
tags:
- Android
- Android TV
permalink: "/2016/02/nvidia-shield-tv-performance/"
---
最強のCPU「Tegra X1」を積んでいるNVIDIA Shield TV（タブレットとややこしいのでTVつけた）のパフォーマンスはいかほどか。

手元にあるAndroid端末と比較しながら検証してみたいと思う。

まずAndroid TVでパフォーマンスを測定する方法はそんなに多くなくて、アプリだと[3DMark](https://play.google.com/store/apps/details?id=com.futuremark.dmandroid.application&amp;hl=ja)ぐらいしかなかった。3DMarkはPCでは有名な3D処理のパフォーマンスを測定するベンチマークソフトで、Androidでも3Dを中心に測定してくれる。今回はこのアプリの「Sling Shot」ベンチマークを使って比べてみた。

### 使用した端末

端末 | CPU | GPU | 解像度
---|---|---|---
NVIDIA Shield TV | NVIDIA Tegra X1 | NVIDIA Maxwell 256コア | 最大3840×2160
Sony Xperia Z2 Tablet | Qualcomm Snapdragon 801 (2.3GHz) | Adreno 330 | 1920×1200
Sony Xperia Z4 SO-03G | Qualcomm Snapdragon 810 (2.0GHz + 1.5GHz) | Adreno 430 | 1920×1080

### ベンチマーク結果
<div id="target"></div>
<script>
(function() {
  'use strict';
  // パッケージのロード
  google.charts.load('current', {packages: ['corechart', 'bar']});
  // コールバックの登録
  google.charts.setOnLoadCallback(function(){
    // データの準備
    var data　= new google.visualization.arrayToDataTable([
      ['端末', 'ES 3.1', 'ES 3.0'],
      ['NVIDIA Shield (4K)', 3632, 4273],
      ['NVIDIA Shield (FHD)', 3943, 4779],
      ['Sony Xperia Z2 Tablet', 0, 1158],
      ['Sony Xperia Z4', 790, 1178]
    ]);
    // オプションの準備
    var options = {
        title: '3DMark Sling Shot ベンチマーク',
        height: 400
    };
    // 描画用インスタンスの生成および描画メソッドの呼び出し
    var chart = new google.visualization.BarChart(document.getElementById('target'));
    chart.draw(data, options);
  });
})();
</script>

### 総評
Xperia Z4のおよそ5倍ということで、スマホと比べられないパフォーマンスとなった。Xperiaでベンチマーク中の画面を見ると10fpsも出てないが、Shieldなら25fpsは出ていたので、そのすごさがわかる。

また、[Xbox 360のほぼ2倍](http://pc.watch.impress.co.jp/docs/column/kaigai/20150306_691561.html)の性能があるそうなので、もうゲーム機は必要ないのかもしれないが、アプリはまだまだ少ないのでみんな買ってシェア率を上げよう！ｗ
