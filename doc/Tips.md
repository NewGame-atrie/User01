Tips
===============

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

##カスタムセル

 cell.textLabel?.text = userData.name　//
        cell.detailTextLabel?.text = userData.type　//詳細テキスト
        cell.imageView?.image = UIImage(userData.icon)
        cell.imageView?.clipsToBounds = true　//UIImageView内で画像を表示
        cell.imageView?.contentMode = .scaleAspectFit　//
        cell.imageView?.frame.size = CGSize(width: 64, height: 64)
