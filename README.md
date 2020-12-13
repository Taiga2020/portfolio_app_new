# 好きなアニメを共有するサービス「Anime Searcher」
Anime Searcherとは同じアニメが好きなユーザー同士をつなぐサービスです。</br>
また、つながったユーザーを介して新しいアニメを開拓できます。</br>
<br/>

# 本番環境
AWS上で運用・公開しています。【URL: https://www.animesearcher.com 】
<br/><br/>

# 開発構成図

![develpment-diagram-test (2)](https://user-images.githubusercontent.com/63719647/102009574-adbc4280-3d7b-11eb-96e6-47eba4c0a467.png)

# 使用技術一覧

* 開発言語等

  * Ruby on Rails
  * jQuery
  * Docker

* バージョン管理

  * Git (Linux環境・CUI)
  * GitHub

* テスト

  * RSpec

* AWS

  * EC2
  * RDS (MySQL)
  * Route53
  * その他(VPC, IAM)

* Nginx

* Editor

  * vim
<br/><br/>

# クラウドアーキテクチャ
AWSでインフラ構築をする際には次の２つのポイントを意識しています。

* 堅牢性
外部からの侵入を防ぐために
・IAMユーザー・ロール権限を最小化（１ユーザー１ポリシーをなるべく守る）
を行っています。

* 保守性
保守コストが低くなるように設計をしています。
具体的には、
・開発環境、テスト環境、本番環境で一貫してDockerコンテナを使用することにより環境差異を最小化
・Route53、ELBを挟むことでWEB, APサーバとHTTPリクエスト処理の疎結合を保ち、実行コンテナとHTTPリクエストの結合を考える必要を無くす
などの設計をしています。
<br/><br/>

# Railsアプリケーション機能一覧

* Ruby version

* ...
