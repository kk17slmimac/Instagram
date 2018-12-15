/*
 HomeViewControllerの流れ
 1.Firebaseから追加、変更された投稿データが送られてくる。
 2.送られてきた投稿データを元に投稿データ用のクラスを作成して配列に追加
 3.UITableViewを更新
 
 投稿データ用のクラスPostDataクラスを作成し、プロパティとそれらを初期化するメソッドを持たせる。
 */



import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray: [PostData] = []
    
    // DatabaseのobserveEventの登録状態を表す
    var observing = false
    
    
    //コメント入力用
    let textField: UITextField = UITextField()
    var commentFlag = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // テーブルセルのタップを無効にする
        tableView.allowsSelection = false
        
        //「PostTableViewCell.xib」ファイルに作成したセルの定義内容をUINib(nibName:bundle)で取得します。これをOutletで接続しているTableViewにregisterNib(_:forCellReuseIdentifier:)メソッドで登録します。この時、Identifierは"Cell"としておきます。
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        // テーブル行の高さをAutoLayoutで自動調整する
        tableView.rowHeight = UITableViewAutomaticDimension
        // テーブル行の高さの概算値を設定しておく
        // 高さ概算値 = 「縦横比1:1のUIImageViewの高さ(=画面幅)」+「いいねボタン、キャプションラベル、その他余白の高さの合計概算(=100pt)」
        tableView.estimatedRowHeight = UIScreen.main.bounds.width + 100
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if Auth.auth().currentUser != nil {
            if self.observing == false {
                // 要素が追加されたらpostArrayに追加してTableViewを再表示する
                let postsRef = Database.database().reference().child(Const.PostPath)
                postsRef.observe(.childAdded, with: { snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                    // PostDataクラスを生成して受け取ったデータを設定する
                    if let uid = Auth.auth().currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, at: 0)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                // 要素が変更されたら該当のデータをpostArrayから一度削除した後に新しいデータを追加してTableViewを再表示する
                postsRef.observe(.childChanged, with: { snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    
                    if let uid = Auth.auth().currentUser?.uid {
                        // PostDataクラスを生成して受け取ったデータを設定する
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        
                        // 保持している配列からidが同じものを探す
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.index(of: post)!
                                break
                            }
                        }
                        
                        // 差し替えるため一度削除する
                        self.postArray.remove(at: index)
                        
                        // 削除したところに更新済みのデータを追加する
                        self.postArray.insert(postData, at: index)
                        
                        // TableViewを再表示する
                        self.tableView.reloadData()
                    }
                })
                
                // DatabaseのobserveEventが上記コードにより登録されたため
                // trueとする
                observing = true
            }
        } else {
            if observing == true {
                // ログアウトを検出したら、一旦テーブルをクリアしてオブザーバーを削除する。
                // テーブルをクリアする
                postArray = []
                tableView.reloadData()
                // オブザーバーを削除する
                Database.database().reference().removeAllObservers()
                
                // DatabaseのobserveEventが上記コードにより解除されたため
                // falseとする
                observing = false
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeueReusableCellメソッドでセルを取得してPostDataデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        //PostData オブジェクト (インスタンス) の内容をセル内に配置したイメージやキャプションラベルに反映させる
        cell.setPostData(postArray[indexPath.row])
        // セル内のボタンのアクションをソースコードで設定する
        cell.likeButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        cell.postButton.addTarget(self, action:#selector(commentButton(_:forEvent:)), for: .touchUpInside)
        cell.addComentButton.addTarget(self, action:#selector(addCommentButton(_:forEvent:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    // セル内のボタン(likeボタン)がタップされた時に呼ばれるメソッド
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: likeボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        
        // Firebaseに保存するデータの準備
        if let uid = Auth.auth().currentUser?.uid {
            if postData.isLiked {
                // すでにいいねをしていた場合はいいねを解除するためIDを取り除く
                var index = -1
                for likeId in postData.likes {
                    if likeId == uid {
                        // 削除するためにインデックスを保持しておく
                        index = postData.likes.index(of: likeId)!
                        break
                    }
                }
                postData.likes.remove(at: index)
            } else {
                postData.likes.append(uid)
            }
            // 増えたlikesをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            let likes = ["likes": postData.likes]
            postRef.updateChildValues(likes)
        }
        
        
    }
    
    
    
    // セル内のボタンが押された時に呼ばれるメソッド(投稿ボタンが押された時に呼ばれるメソッド)
    @objc func commentButton(_ sender: UIButton, forEvent event: UIEvent) {
        /*
         このメソッドで実装したいこと
         ①TextFieldにあるコメントを取得
         ②現在のログインユーザーを取得
         ③Firebaseにカンマ区切りで保存する
         */
        
        print("DEBUG_PRINT: commetButtonがタップされました。")
        
        //タップされたセルのインデックスを求める
        //UIEventクラスからタッチされた情報を取得
        let touch = event.allTouches?.first
        //UITouchクラスのlocation(in:)メソッドで座標を割り出す。
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        
        //PostTableViewCellを定義している。こうやって定義しないといけない。
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath!) as! PostTableViewCell
        
        // 現在選択されているセルを取得する
        cell = tableView.cellForRow(at: indexPath!) as! PostTableViewCell
        
        
        //①TextFieldにあるコメントを取得
        //選択したセルからコメントのデータを取得する
        let commentString = self.textField.text
        print("コメント蘭のコメント:" + commentString!)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        
        // Firebaseに保存するデータの準備
        if (Auth.auth().currentUser?.uid) != nil {
            
            
            var submitcomment = commentString
            
            // コメントとユーザ名をカンマ区切りにしておく
            let user = Auth.auth().currentUser
            if let user = user {
                //②現在のログインユーザーを取得、③Firebaseにカンマ区切りで保存する
                //                submitcomment = user.displayName! + "," + commentString!
                submitcomment = "\(user.displayName!): \(commentString!)"
                print("コメントの登録:" + submitcomment!)
            }
            
            // 追加する
            postData.commentData.append(submitcomment!)
            print("投稿したコメント"+submitcomment!)
            
            // 増えたcomentDataをFirebaseに保存する
            let postRef = Database.database().reference().child(Const.PostPath).child(postData.id!)
            let commentData = ["commentData": postData.commentData]
            postRef.updateChildValues(commentData)
            
            print("投稿保存")
            
            if self.commentFlag == true {
                
                self.textField.isHidden = true
                
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "コメントしました")
                
                //commentFlagがtrueの時のみ投稿ボタンが出現する
                self.commentFlag = false
                
            }else{
                cell.postButton.isHidden = true
            }
            
        }
        
        // TableViewを再表示する
        self.tableView.reloadData()
        
    }
    
    
    //+ボタン(コメント)
    @objc func addCommentButton(_ sender: UIButton, forEvent event: UIEvent) {
        
        print("DEBUG_PRINT: addCommetButtonがタップされました。")
        
        //タップされたセルのインデックスを求める
        //UIEventクラスからタッチされた情報を取得
        let touch = event.allTouches?.first
        //UITouchクラスのlocation(in:)メソッドで座標を割り出す。
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        //PostTableViewCellを定義している。こうやって定義しないといけない。
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath!) as! PostTableViewCell
        
        // 現在選択されているセルを取得する
        cell = tableView.cellForRow(at: indexPath!) as! PostTableViewCell
        
        //textViewの作成
        //UITextViewのインスタンスを生成
        //        let textField: UITextField = UITextField()
        //        let textView: UITextView = UITextView()
        self.textField.isHidden = false
        //textViewの位置とサイズを設定
        self.textField.frame = CGRect(x:10, y:350, width:cell.frame.width - 20, height:50)
        //テキストを設定
        self.textField.text = "コメントを入力してください"
        //フォントの大きさを設定
        self.textField.font = UIFont.systemFont(ofSize: 20.0)
        //textViewの枠線の太さを設定
        self.textField.layer.borderWidth = 1
        //枠線の色をグレーに設定
        self.textField.layer.borderColor = UIColor.lightGray.cgColor
        self.textField.backgroundColor = UIColor.white
        //テキストを編集できるように設定
        //        textField.isEditing = true
        //Viewに追加
        cell.addSubview(self.textField)
        
        //投稿ボタンを押せるようにする。
        self.commentFlag = true
        cell.postButton.isHidden = false
        
        
    }
    
    
    
    
    
}
