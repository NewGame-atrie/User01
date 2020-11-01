## UITableViewにセルを作る

```
	//1つのセクションあたりのセルの数を決める
	//userListの配列データをカウントしてセルの数を決める
	
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
	
	
	//セルを作る
	//セルに返す値を表示
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //cellにUserDataCellの型をつけて、dequeueReusableCellでどのデータを返すかを指定
        //cellのユーザーにカスタムセルのデータを返す
        let cell : UserDataCell = tableView.dequeueReusableCell(withIdentifier: "UserDataCell", for: indexPath) as! UserDataCell
        cell.user = self.userList[indexPath.row]
        
        return cell
    }
}
```

**参考URL**

- https://qiita.com/nsy_python/items/df11d2eedea1379cd386

**参考文献**

『詳細! Swift iPhoneアプリ開発入門ノート iOS12 + Xcode 10対応』

- https://www.amazon.co.jp/Swift-iPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E5%85%A5%E9%96%80%E3%83%8E%E3%83%BC%E3%83%88-iOS12-Xcode-10%E5%AF%BE%E5%BF%9C/dp/4800712238


## セルを選択した時の動作の処理

```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        	処理内容
}
```

**参考URL**

- https://qiita.com/nsy_python/items/df11d2eedea1379cd386

**参考文献**

『詳細! Swift iPhoneアプリ開発入門ノート iOS12 + Xcode 10対応』

- https://www.amazon.co.jp/Swift-iPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E5%85%A5%E9%96%80%E3%83%8E%E3%83%BC%E3%83%88-iOS12-Xcode-10%E5%AF%BE%E5%BF%9C/dp/4800712238


## 行を選択したら、画面遷移

```

//セルがタップされたときに勝手に呼ばれるメソッド

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //ユーザーデータを取り出す
        //userDataの変数にUserDataの型のユーザデータを取り出す
        
        let userData : UserData = self.userList[indexPath.row]

        //UserDetailViewのインスタンスを作る
        //次の画面のインスタンス
        let detail = UserDetailViewController()
        
        //deteilのuserDataラベルの変数にユーザーデータを入れる
        detail.userData = userData
        
        //画面遷移
        //次に遷移する画面をインスタンス生成
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
```
**参考URL**

- https://qiita.com/nsy_python/items/df11d2eedea1379cd386

**参考文献**

『詳細! Swift iPhoneアプリ開発入門ノート iOS12 + Xcode 10対応』

- https://www.amazon.co.jp/Swift-iPhone%E3%82%A2%E3%83%97%E3%83%AA%E9%96%8B%E7%99%BA%E5%85%A5%E9%96%80%E3%83%8E%E3%83%BC%E3%83%88-iOS12-Xcode-10%E5%AF%BE%E5%BF%9C/dp/4800712238


## WebViewで詳細画面を表示

```
import WebKit

class UserDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    //表示するデータを定義
    var userData : UserData? = nil
    var webView : WKWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = self.userData?.name
        
        let conf = WKWebViewConfiguration()
        
        self.webView = WKWebView(frame: self.view.bounds, configuration: conf)
        
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
        
        self.view.addSubview(self.webView)
        
        if let safeUrlString = self.userData?.url, let urlObj = URL(string: safeUrlString) {
            let req : URLRequest = URLRequest(url: urlObj)
            self.webView.load(req)
        }
    }
}
```

**参考URL**

- https://rc-code.info/ios/post-241/

## カスタムセル

TableViewCellではなく、カスタムセルでセルを表現する

JSONデータから画像やユーザー名のキーとなるラベルを使うので
```
UITableViewCell
```
のクラスを使う

```
class UserDataCell: UITableViewCell {
    
    var user : UserData? {
        didSet {
            self.configure()
        }
    }
    
    
   
    	//initメソッドを使い、引数を自動で生成
    	
    init(){
        super.init(style: .subtitle, reuseIdentifier: "UserDataCell")
    }
    
     
	 //initメソッド内で配列の初期化
    //セルのスタイルを指定
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    //initメソッドを使用したら絶対に記載
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* */
    
    private func setup(){
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.detailTextLabel?.textColor = UIColor.gray
        
        //UIImage	View内で画像を表示
        self.imageView?.clipsToBounds = true
        
        //回転しても画像を崩さない
        self.imageView?.contentMode = .scaleAspectFit
        
        //サイズの指定
        self.imageView?.frame.size = CGSize(width: 64, height: 64)
        
        self.setNeedsLayout()
    }
    
    private func configure(){
        
        guard let user : UserData = self.user else {
            return
        }
        
        //セルスタイのテキスト
        self.textLabel?.text = user.name
        
        //セルスタイルの詳細タイトル
        self.detailTextLabel?.text = user.type
        
        //セルスタイルの画像
        //画像が読み込まれる前にロード画面を表示
          self.imageView?.image = UIImage(named: "loading")
       if let icon = user.icon, let imageUrl = URL(string: icon) {
            self.imageView?.af.setImage(withURL: imageUrl)
        }
        
        
    }
}
```

**参考URL**

- https://qiita.com/naochi___/items/dcbf58acb925fc716af5
- https://xyk.hatenablog.com/entry/2017/01/15/202620
- https://yuu.1000quu.com/use_a_custom_cell_in_swift
- https://weblabo.oscasierra.net/swift-uitableview-2/
- https://qiita.com/coe/items/9723381ec0046fd8d8ad
- https://qiita.com/sunstripe2011/items/a5cbecfd8df7e060577d
- https://qiita.com/kinopontas/items/1603bb1dcbf115ccc345


## GithubのデータをDictionary型に変換

```
class UserData {
    var name : String?
    var url : String?
    var type : String?
    var icon : String?
    
    //Githubのデータを変換する
    //
    static func convert(_ data : [String:Any]) -> UserData {
        let userData = UserData()
        
        userData.name = data["login"] as? String
        userData.url = data["html_url"] as? String
        userData.type = data["type"] as? String
        userData.icon = data["avatar_url"] as? String

        
        return userData
    }
    
}
```

**参考URL**

- https://rc-code.info/ios/post-241/
- https://qiita.com/YutoMizutani/items/040d8af5bfc38d9f1fac
- https://qiita.com/shimesaba/items/dc976b3974cfb41bec0c
- https://qiita.com/Mt-Hodaka/items/d14447a429948a3fb28c

## GitHubユーザー検索APIの呼び出し

```
 func search(_ query : String){
        
        //GithubのAPI
        
        let url = "https://api.github.com/search/users?q=\(query)"
        
        //Alamofireでデータを取得
        
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            
            .responseJSON { response in
                
                switch response.result{
                    case.success:
                        if let data = response.value {
                            self.onSuccess(data)
                        }
                        break
                    
                    case let .failure(error):
                        self.onError(error)
                        break
                }
}
```

**参考URL**

- https://rc-code.info/ios/post-241/


## エラー時にアラートを表示

```
  func showAlert(_ message : String){
        let alert: UIAlertController = UIAlertController(title: "エラー", message: message, preferredStyle:  UIAlertController.Style.alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler:{
            // キャンセルボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            
        })
        
        //UIAlertControllerにキャンセルボタンを追加
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)

    }
```

**参考URL**

- https://qiita.com/kaneko77/items/010c3836a1a063ad015e
- https://qiita.com/hitcracker317/items/d93436d9a3fcd5109a2f

## 検索結果が0件の表示

```
 guard let items = data["items"] as? [[String:Any]] else {
            return
        }
        
        var result : [UserData] = []
        
        for i in items {
            let user = UserData.convert(i)
            result.append(user)
        }
        
        self.userList = result
        
        //reload tableview
        self.tableView.reloadData()
        
        // userList内の個数が０件の時にアラートを出す
        if self.userList.count < 1 {
            self.showAlert("検索結果は、0件です")
}
```

**参考URL**

- https://www.paveway.info/entry/2019/01/13/swift_search
- https://qiita.com/netetahito/items/20e3a1a57fb82525a1f7
-  https://qiita.com/eKushida/items/5ed6e895f80bb0096ead
- https://qiita.com/rd0501/items/5aca559df3423335fe40
