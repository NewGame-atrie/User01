## 画面遷移
```
self.navigationController?.pushViewController(
	次の画面のインスタンス,
	animated: true
)
```

```
let detail = UserDetailViewController()
self.navigationController?.pushViewController(
	detail,
	animated: true
)
```

## カスタムセル

```
class UserDataCell: UITableViewCell {
    
    var user : UserData? {
        didSet {
            self.configure()
        }
    }
    init(){
        super.init(style: .subtitle, reuseIdentifier: "UserDataCell")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* */
    
    private func setup(){
        
        self.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        self.detailTextLabel?.textColor = UIColor.gray
        
        //UIImage	View内で画像を表示
        self.imageView?.clipsToBounds = true
        
        //回転しても画像が崩さない
        self.imageView?.contentMode = .scaleAspectFit
        
        //サイズの指定
        self.imageView?.frame.size = CGSize(width: 64, height: 64)
        
        self.setNeedsLayout()
    }
    
    private func configure(){
        
        guard let user : UserData = self.user else {
            return
        }
        
        //title
        self.textLabel?.text = user.name
        
        //type
        self.detailTextLabel?.text = user.type
        
        //image
        self.imageView?.image = UIImage(named: "loading")
        if let icon = user.icon, let imageUrl = URL(string: icon) {
            self.imageView?.af.setImage(withURL: imageUrl)
        }
        
        
    }
}
```

## セルを選択した時の動作の処理

```
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        	処理内容
}
```


## 行を選択したら、画面遷移

```
extension UserSearchViewController: UITableViewDelegate {
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
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
}
```


## セルをTable Viewに表示

```
extension UserSearchViewController: UITableViewDataSource {
	
	//セクションに表示するセルの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }

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


## WebViewで詳細画面を表示

```
import UIKit
import WebKit

class UserDetailViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    //
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
