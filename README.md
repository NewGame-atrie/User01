# プロジェクトの説明

## MVP+CleanArchitectureで検索サンプルアプリケーション

- User01

アプリケーションの本体

- モジュール
	- View　ViewControllerを設置
	- DataStore 　APIとの通信を行うデータ層
	- Domain　UseCaseがあるドメイン層
	- Model　Viewで表示する変換したデータ

## 各モジュールについて

今回、CleanArchitectureの「UseCase」と「Repository」のみを使用

理由は、

- MVPの「View」と「Presenter」にて
CleanArchtectureの「Presentation」レイヤーを担ってるため、【UserSeachViewController.swift】に集約

- 「Repository」は、ドメイン層とデータ層との仲介役だが、データ層として置いても問題ないということを知り、DetaStoreとして設定

- 「UseCase」は、「Repository」のデータ層とMVPの仲介役として設定


### View
-  UserSeachViewController.swift　

	検索実行処理と検索結果を表示

-  UserDetailViewController.swift

	画面遷移先のユーザー情報表示
	
-  UserDataCell.swift

	カスタムセル

### DataStore
- UserSearchRepository.swift

	GithubのJSONデータの呼び出しとAPI通信を行い、
	検索機能だけを持つRepository

### Domain
- UserSearchUseCase.swift　
	
	UserSeachViewController.swiftの検索で入力された情報の受け取りとModelのユーザーデータから呼び出し、Viewへ出力する。
	入力と出力を担うUseCase


### Model
- UserData.swift

	Repositoryで呼び出したJSONデータを受け取り、Dictionary型にユーザーデータを変換


***参考URL***

https://github.com/sergdort/CleanArchitectureRxSwift

https://qiita.com/knagauchi/items/8c9fb93520b56fd3a564

https://qiita.com/shinkuFencer/items/f2651073fb71416b6cd7

https://qiita.com/koutalou/items/07a4f9cf51a2d13e4cdc

https://qiita.com/fr0g_fr0g/items/2a71d055af4824e94bff

https://gist.github.com/mpppk/609d592f25cab9312654b39f1b357c60

https://blog.tai2.net/the_clean_architecture.html


# 環境

- Xcode12.0.1

- Swift5+ 

# 利用したツールとライブラリ

選定理由を下部【その他】のリンク先に記載をしております。

## API

- [Github](https://developer.github.com/v3/search/#search-users)

## ツール

- [Carthage](https://github.com/Carthage/Carthage)

## ライブラリ

- [Alamofire](https://github.com/Alamofire/Alamofire)

- [AlamofireImage](https://github.com/Alamofire/AlamofireImage)

# 利用しなかったツールとライブラリ

- [XcodeGen](https://github.com/yonaskolb/XcodeGen)


Xcodeプロジェクトファイル（` .xcodeproj` ）を定義ファイル（ `project.yml` ）から生成する、Swift製のコマンドラインツール
 
 `project.yml`の設定を書くことでプロジェクトファイルが自動で生成される。
 
 しかし、ymlファイルの書き方まで理解が及ばず、今回は対応なし

***参考URL***

https://qiita.com/uhooi/items/16a870eaae24b46103fb

- [SwiftLint](https://github.com/realm/SwiftLint)

Swiftの1行あたりの文字数やコロンの両側のスペースの有無などの文法をチェックするツール

XcodeGenと同じようにymlファイルの作成が必要なので今回は対応なし

***参考URL***

https://qiita.com/uhooi/items/bf888b53b4b8210108aa

https://qiita.com/OSR108/items/4b23b13bd23feada1921

- [LicensePlist](https://github.com/mono0926/LicensePlist)

Carthageで管理しているライブラリのライセンス表示を自動的に生成するツール

Carthageのコードを確認とビルドを行わないとエラーが発生するので
今回は対応なし

***参考URL***

https://qiita.com/uhooi/items/c9f91637430c10b8555a

- [Generamba](https://github.com/strongself/Generamba)

Xcodeのために作られたコード生成ツール

プロジェクトを立てるのと同時に導入をするので
今回のプロジェクトとは合わないので今回は対応なし

***参考URL***

https://qiita.com/uhooi/items/c216b83fe462c863ff92

https://qiita.com/YKEI_mrn/items/d1f79ceddf6e009fdcd0



- [Mint](https://github.com/yonaskolb/Mint)

LicensePlist /SwiftLint /XcodeGenなどのコマンドラインツールのインストールと実行、管理をするツール

しかし、各ライブラリの導入を不要にしたので今回は対応なし

***参考URL***

https://qiita.com/uhooi/items/6a41a623b13f6ef4ddf0

# その他

- [Carthageの導入について](https://github.com/NewGame-atrie/User01/blob/master/doc/%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6.md#carthage%E3%81%AE%E5%B0%8E%E5%85%A5%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

- [Alamofireの利用法について](https://github.com/NewGame-atrie/User01/blob/master/doc/%E3%83%A9%E3%82%A4%E3%83%96%E3%83%A9%E3%83%AA%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6.md#alomofire%E3%81%AE%E5%88%A9%E7%94%A8%E6%B3%95%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)

- [Tips](https://github.com/NewGame-atrie/User01/blob/master/doc/Tips.md)

- [用語集](https://github.com/NewGame-atrie/User01/blob/master/doc/%E7%94%A8%E8%AA%9E%E9%9B%86.md)
 
 
- [CleanArchitecture](https://github.com/NewGame-atrie/User01/blob/master/doc/%E8%A8%AD%E8%A8%88%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6.md)