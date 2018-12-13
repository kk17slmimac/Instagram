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
    var comment: [String] = []
    var commentUserName: [String] = []
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
        
        
        
        
        
        
        
        
        
        
        
    }
}
