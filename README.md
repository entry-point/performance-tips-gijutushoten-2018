# セットアップ手順

以下のソフトウェアをインストールする必要がある。

- [node](https://nodejs.org)
  - 6.10以降
- [ruby](https://www.ruby-lang.org/)
  - 2.4以降
- [docker](https://www.docker.com/)
- [docker-compose](https://docs.docker.com/compose/)
- [yarn](https://yarnpkg.com/lang/en/)
- [mysql-client](https://dev.mysql.com/doc/refman/5.6/ja/programs-client.html)

インストールの仕方は、各サイトを参考。
mysqlについては、Railsアプリにてmysql2 gemを利用するため、
mysqlをビルドできる環境が必要。mysql向けのヘッダファイル、gccコマンドなど。

# アプリケーションの動かし方

このリポジトリをgit clone後、
必要なgem packageをインストールするために、
bundle installを実行する必要がある。

```
> bundle install --path vendor/bundle
```

# 4つのプロセスの実行

ターミナルを3つひらくか、tmuxを利用して
rails, ruby, webpack-dev-server, docker-composeプロセス合わせて4つ実行する

## railsの起動

以下のコマンドを実行

```
> bundle ex rails s
```

## webpack-dev-serverの起動

以下のコマンドを実行

```
> ./bin/webpack-dev-server
```

## sidekiqの起動

以下のコマンドを実行

```
> bundle ex sidekiq
```

## docker-compose

以下のコマンドを実行

```
> docker-compose up
```

# DBの作成、テストデータのインポート

以下のコマンドを実行

```
> mysql -h 127.0.0.1 -u root --password=webapptips < initializedb.sql
> bundle ex rake db:migrate
> bundle ex rake db:seed
```

# License

Apache License 2.0とします
