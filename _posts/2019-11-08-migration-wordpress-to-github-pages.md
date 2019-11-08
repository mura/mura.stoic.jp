---
layout: single
title: WordPressからGitHub Pagesに移行してみた
date: 2019-11-08 00:00:00 +0900
type: post
tags:
- Jekyll
permalink: "/2019/11/migration-wordpress-to-github-pages/"
---
長らく放置していた本ブログだが、WordPressの運用にも飽きてきたのと、ホスティングしているペパボがCGI版のPHP7しかまともに動く環境がなくなってきたことで、思い切ってGitHub Pagesに移してみた。

GitHub PagesはCGI的なものは動かないが、[Jekyll](http://jekyllrb-ja.github.io/)というページジェネレーターのプロジェクトを置いておくとビルドしてデプロイまでしてくれるので、ブログ的な運用ができる。<br>
→ [GitHub PagesとJekyllについて](https://help.github.com/ja/github/working-with-github-pages/about-github-pages-and-jekyll)

インターネットを検索すればGitHub PagesとJekyllを使ったブログ構築方法はいくらでも見つかるので細かい解説は割愛するが、いくつかはまったポイントを書いておこうと思う。

## ページネーションが表示されない
[Pagination](http://jekyllrb-ja.github.io/docs/pagination/)のページに思いっきり書いてあるが、インデックスページが`index.html`以外だと機能しない。

`jekyll new`でひな形を作ると`index.md`が作られるので、これを`index.html`に変更することで解決。

## ページのジェネレートは成功しているように見えるが、HTMLが0バイトになっている
結論から言うと、テーマの指定方法が間違っていた。

Jekyllの解説サイトに載っている`_config.yml`の`theme:`で設定できるテーマはGitHub Pagesでは[サポートされているテーマ](https://pages.github.com/themes/)以外指定できない。

現時点では[Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/)というテーマを使っていて、これはサポートされているテーマに入ってないので`remote_theme:`の指定をすることで解決。

## jekyll-archives が動かない
またまた結論から言うと、互換性がない。

元も子もないが、[バージョンの依存関係](https://pages.github.com/versions/)に載っているライブラリしか動かないので、ここにない jekyll-archives プラグインは動かない。

仕方ないので Liquid (デフォルト) 一択で。