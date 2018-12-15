//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/24.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

//このクラスの役割は？


import UIKit
import  SVProgressHUD

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var addComentButton: UIButton!
    
//    let textField: UITextField = UITextField()
//    
//    var commentFlag = false
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    //コメントを表示する処理を追加しラベルに表示させる。
    func setPostData(_ postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!):\(postData.caption!)"
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: postData.date!)
        self.dateLabel.text = dateString
        
        if postData.isLiked{
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        }else{
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
        
        
        //コメントラベルに表示するもの
       if !postData.commentData.isEmpty {
       
        var text = ""
        for comment in postData.commentData {
            text += "\(comment)\n"
//            var commentDataStr = comment.components(separatedBy: ",")
//            text += "\(commentDataStr[0]):\(commentDataStr[1])"
        }
        self.commentLabel.text = text
        }
        
        
    }
    
    
    @IBAction func addComentButton(_ sender: Any) {
//        //textViewの作成
//        //UITextViewのインスタンスを生成
////        let textField: UITextField = UITextField()
////        let textView: UITextView = UITextView()
//        self.textField.isHidden = false
//        //textViewの位置とサイズを設定
//        self.textField.frame = CGRect(x:10, y:350, width:self.frame.width - 20, height:50)
//        //テキストを設定
//        self.textField.text = "コメントを入力してください"
//        //フォントの大きさを設定
//        self.textField.font = UIFont.systemFont(ofSize: 20.0)
//        //textViewの枠線の太さを設定
//        self.textField.layer.borderWidth = 1
//        //枠線の色をグレーに設定
//        self.textField.layer.borderColor = UIColor.lightGray.cgColor
//        self.textField.backgroundColor = UIColor.white
//        //テキストを編集できるように設定
////        textField.isEditing = true
//        //Viewに追加
//        self.addSubview(self.textField)
//        
//        //投稿ボタンを押せるようにする。
//        self.commentFlag = true
//        self.postButton.isHidden = false
    }
    
    
    
    
    
    //投稿ボタンを押した際のアクション
    @IBAction func postCommentButton(_ sender: Any) {
        
//        print("投稿ボタン押下")
//        
//        if self.commentFlag == true {
//        
//        self.textField.isHidden = true
//     
//        // HUDで投稿完了を表示する
//        SVProgressHUD.showSuccess(withStatus: "コメントしました")
//        
//        //commentFlagがtrueの時のみ投稿ボタンが出現する
//        self.commentFlag = false
//            
//        }else{
//            self.postButton.isHidden = true
//        }
        
        
    }
    
    
    
    
    
}
