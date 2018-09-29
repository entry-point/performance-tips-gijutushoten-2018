# 立ち上げについて

Docker image化しているので、アプリケーションの挙動を確かめたい場合は、以下のコマンドを利用すれば良い。Docker Composeをインストールしていない人、Dockerを利用していない人はインストールしよう。

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

```
> docker-compose up
```

このコマンドを実行すれば、後は `http://localhost:3000/` にアクセスすれば確認できる。

# docker image buildの方法

以下のコマンドを実行することで、docker imageを作成することができる

```
> docker build -f docker/performance_tips_rails_2018/Dockerfile -t futoase/performance_tips_rails_2018:latest .
```

# マニュアルでアプリを操作する場合

以下のソフトウェアが必要である。

- [node](https://nodejs.org)
  - 8.12以降
- [ruby](https://www.ruby-lang.org/)
  - 2.5以降
- [yarn](https://yarnpkg.com/lang/en/)
- [mysql-client](https://dev.mysql.com/doc/refman/5.6/ja/programs-client.html)

インストールの仕方は、各サイトを参考。
mysqlについては、Railsアプリにてmysql2 gemを利用するため、
mysql-client及びMySQLのヘッダファイルが必要となる。

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
