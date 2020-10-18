#Carthageの導入について
***
ユーザーAPIを使うのでAlamofireでAPIデータを取得するため
Carthageでライブラリ管理を行う

- メリット
ライブラリを事前にビルドし、
フレームワークを作成してくれるので、コンパイル時間を短くしてくれる。

- デメリット
使用したいライブラリがCarthageに対応していなければならない


手順
============
## ターミナル で下記手順を実行

1. Carthageのインストール
***
[Homebrewの公式ページ](https://brew.sh/)からコマンドをコピー

` $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" `

コピーしたコマンドをターミナルに貼り付けて読み込みが終わったら、

`$ brew install carthage`

でインストール完了

1. ライブラリのインストール
***
Carthageは、Cartfileに記載されたライブラリをインストールする仕様

`$ touch Cartfile`
でファイルを作成

`$ vim Cartfile`
でファイルを編集状態にする

※ Vim の基本操作
`i`キーで入力モードにして、ライブラリの情報を記述
記述ができたら`esc`を押して入力モードを解除、
その状態で`:wq`を入力しエンターを押して保存し、終了

`$ github "Alamofire/Alamofire"`

https://github.com/Alamofire/Alamofire
今回、Alamofireを使用するのでGithubにあるコマンドをコピーして
Cartfileに入力し、編集が完了したら、終了

`$ carthage update --platform ios # os指定したい場合はコレ`
Cartfileの作業が完了したら、Carthageのupdateを実行

※`--platform ios`をつけないとwatch OSやOSXもビルドしてしまう

##Xcodeで下記手順を実行
1. Xcodeのプロジェクトにビルドしたライブラリを追加
***
2つ設定する必要がある。

- Frameworks, Libraries, and Embedded Content  にライブラリ追加
- Build Phasesに追加

__Frameworks, Libraries, and Embedded Content  にライブラリ追加__
プロジェクトファイルの"Gereral"タブ　>　Frameworks, Libraries, and Embedded Content  に
ライブラリのfireworkを追加

以下、ディレクトリにfireworkが入ってる
`/Carthage/Build/iOS/Alamofire.framework`

__Build Phasesに追加__
プロジェクトファイル > Build Phases
New Run Script Phaseを選択し、新しいRun Scriptを追加

「Shell」の下に以下コマンドを追記
`/usr/local/bin/carthage copy-frameworks`

次に、「input Files」に以下のframeworkの情報を記述
`$(SRCROOT)/Carthage/Build/iOS/Alamofire.framework`

※アプリケーションを申請する際に、
iTunesConnectの不具合を回避するために必須

`import Alamofire`
をコードで書いてエラーが発生しなかったら完成

参考URL
https://qiita.com/tsuzuki817/items/8f6e2e0c2b3f9d197097
https://qiita.com/fuwamaki/items/5e6e9c18e5a0b1d7199e
https://qiita.com/ashdik/items/689f7659050aba300fce
https://qiita.com/0126/items/5d401acc219ac4f172d6	

#Alomofireの利用法について

- Alamofireの導入
APIのデータを取得する機能

- AlomofireImageの導入

画像を取得する機能

- https://github.com/Alamofire/AlamofireImage

参考URL

- https://qiita.com/uhooi/items/c0e083f916dc516175bd
- https://qiita.com/hcrane/items/422811dfc18ae919f8a4

※Xcodeのバージョンを12.0にしたことでシミュレーションが立ち上がらない
エラーが発生した時の対応方法

手順
============
## ターミナルで下記手順を実行

```
export XCODE_XCCONFIG_FILE=$(pwd)/Config.xcconfig
carthage update --platform iOS --no-use-binaries --cache-builds
```

https://qiita.com/pinoerumo/items/0a340078ea2e0f8d01b0


#カスタムセルの作り方

参考URL
https://qiita.com/orimomo/items/e12a0e468f083bcb7a50
https://xyk.hatenablog.com/entry/2017/01/15/202620
