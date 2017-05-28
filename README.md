## このアプリについて

RailsでGCPのpub/subをactive jobとして動かすサンプルです。
詳細は[こちら](http://tech.itandi.co.jp/2017/05/rails-active-job-gcp-pubsub/)のブログに記載しています。

## 実行方法

### 前準備
- ブログに書いている前準備を済ませてGCPの環境を作って下さい。
- docker for macの環境を作ってください

### コマンド

build

```
docker-compose build
```

起動

```
docker-compose up
```

サンプルjobの発行

```
docker-compose run worker bundle exec rake issue_job
```