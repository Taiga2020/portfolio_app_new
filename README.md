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

# クラウドアーキテクチャ
AWSでインフラ構築をする際には次の２つのポイントを意識しています。

* __堅牢性__  
外部からの侵入を防ぐために  
・IAMユーザー・ロール権限を最小化（１ユーザー１ポリシーをなるべく守る）  
を行っています。  

* __保守性__  
保守コストが低くなるように設計をしています。  
具体的には、  
・開発環境、テスト環境、本番環境で一貫してDockerコンテナを使用することにより環境差異を最小化  
・Route53、ELBを挟むことでWEB, APサーバとHTTPリクエスト処理の疎結合を保ち、実行コンテナとHTTPリクエストの結合を考える必要を無くす  
などの設計をしています。  

# Railsアプリケーション機能一覧
※以下「ページ」は、アニメ紹介ページを示す。

* __単体/統合テスト機能 (自動)__
  * RSpec
  * FactoryBot
  
* ページ一覧表示機能
* ページ詳細表示機能
* ページ追加機能 (管理ユーザーのみ・管理画面)
* 管理ユーザーログイン機能
* DBテーブルのリレーション機能
* ページネーション機能 (will_paginate)

