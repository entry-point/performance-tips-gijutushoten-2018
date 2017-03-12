# 同期処理と非同期処理のやり方を見てみる

例としてアプリケーションを用意した。
同期処理、非同期処理を別のController, actionに実装、
非同期処理についてはActiveJobを利用している。

# 環境構築

アプリを起動するためには以下の環境が必要。

- ruby
- sqlite3
- docker
- docker-compose

インストール方法については割愛する。
macOSであれば、homebrew, rbenv, docker for Macを利用すれば環境は整えられる。

必要なgemについてはbundlerを利用してインストールする。

```
> bundle install --path vendor/bundle -j10
```

# docker container, アプリ、workerを起動

- docker containerを起動

redisについてdocker containerを利用して立ち上げる。
同梱しているdocker-compose.ymlを利用する。

```
> docker-compose up
```

- Railsアプリケーションは以下のコマンドでプロセスを実行

```
> bundle exec rails s
```

- workerは以下のコマンドでプロセスを実行

```
> bundle exec sidekiq
```

# 同期処理を見る
