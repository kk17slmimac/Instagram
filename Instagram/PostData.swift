//
//  PostData.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/24.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//
/*
 HomeViewControllerの流れ
 1.Firebaseから追加、変更された投稿データが送られてくる
 2.送られて来た投稿データをもとに投稿データ用のクラスを作成して配列に追加⇦今ここ！
 3.UITableViewを更新
 */

/*
 Firebaseはデータの更新があるとDataSnapShotクラスのデータが渡されてきます。
 keyプロパティがこの要素自身のID(投稿データではユニークなIDとして生成されたもの)となります。
 そしてvalueプロパティにデータが入っています。
 */


import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject{
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    //【コメント関連を追加】
//    var comment: [String] = []
//    var commentUserName: [String] = []
    //コメントと投稿したユーザー名を保存する領域
    //コメントは複数件登録される可能性があるので、配列で持たないと最新の一件しか保存されないので配列にする。
    var commentData:[String] = []
    
    //プロパティを初期化するメソッド
    init(snapshot: DataSnapshot, myId: String) {
        //keyプロパティがこの要素自信のID(ユニークなIDとして作成されたもの)
        self.id = snapshot.key
        
        //valueプロパティにデータが入っておりキーと値の組み合わせで辞書型となっている。
        let valueDictionary = snapshot.value as! [String: Any]
        //imageを取り出している。
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
        
        self.name = valueDictionary["name"] as? String
        self.caption = valueDictionary["caption"] as? String
        
        let time = valueDictionary["time"] as? String
        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
//        self.commentData = (valueDictionary["commentData"] as? [String])!
        
        if let comment = valueDictionary["commentData"] as? [String]{
            self.commentData = comment
        }
        
        if let likes = valueDictionary["likes"] as? [String]{
            self.likes = likes
        }
        
        
        
        //isLikedプロパティだけはDataSnapShotクラスから取り出すのではなく、
        //likesというキーで取り出したString型の配列の中にユーザー自身のIDが入っているかで値をtrueかfalseのどちらかで設定。
        for likeId in self.likes {
            if likeId == myId{
                self.isLiked = true
                break
            }
        }
        
        //コメントは別クラスの方が良いのでは？
        
        /*
         PostDataはFirebaseに保存するためのデータ整形、
         Firebaseからデータを取り出す以前のこういう形でデータを保存する、
         という部分を行っているため必要になります。
         
         コメントについてもひとつの投稿に紐づくデータになりますのでPostData内にいれるのが望ましいです
         */
        
        
        
        
        
        
        
        
        
        
        
    }
}
