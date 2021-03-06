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
<br/>

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
<br/>

# Railsアプリケーション機能一覧
※以下「記事」は、アニメ紹介ページを示す。

* __単体/統合テスト機能 (自動)__
  * RSpec
  * FactoryBot
  
* 記事一覧表示機能
* 記事詳細表示機能
* 記事追加機能 (管理ユーザーのみ・管理画面)
* ログイン機能 （セッション管理）
* 管理ユーザーログイン機能
* DBテーブルのリレーション機能
* ページネーション機能 (will_paginate)
<br/>

# 開発に際して気をつけたポイント

### __「表示の高速化」__
  * __HerokuからEC2へ移行__  
    Heroku環境が遅いという話は聞いていたので  
    勉強も兼ねてAWS EC2へ移行しました。  
    
現状でも高速とは言えないとは思いますが上記対策の結果、
表示速度は1.5倍以上になりました。  

 ### __「基礎的な環境構築を経験する」__

  このアプリケーションの構成はDocker + AWS (EC2, RDS)  
  というコンテナ技術、クラウドサービスを利用していますが  
  基礎的な知識を身に着けるために他の環境も利用しました。  
  
  具体的には  
  * LAMP環境での開発 (フレームワークを使用せずPHP + MySQLで開発)  
  などに取り組みました。  
  <br/>

# 今後の課題

### __・コードの可読性、保守性向上__  
エンジニアとしての業務経験が浅いため、基礎的な  
「コーディングの作法」という部分が欠落していると自覚しています。  
RubyではGemレポジトリを見てプロがどのようなコードを書いているか  
参考にするなどしています。  

### __・セキュリティ__  
RailsにはSQLインジェションやCSRF対策が施されているので  
基本的なセキュリティは問題ないと思いますが  
今回AWSを初めて使用しましたのでインフラやDBのやりとりに  
関して不安を覚えています。(IAMユーザー・ロールの設定など)  
ですので今後はインフラ構築面について詳しく勉強する予定です  

### __・React/TypeScriptでの開発__  
現在、Ruby on Rails単体でアプリケーションを構成することは少なく  
フロントにはReactやVueJSを使用することが多い、と認識しています。  
したがって現在Reactでの開発に取り組んでいます。  
