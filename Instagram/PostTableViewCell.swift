//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/24.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

//実装


import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    
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
        
        self.commentLabel.text = "\(postData.commentUserName):\(postData.comment)"
        
        
    }
    
    
    @IBAction func addComentButton(_ sender: Any) {
        //textViewの作成
        //UITextViewのインスタンスを生成
        let textField: UITextField = UITextField()
//        let textView: UITextView = UITextView()
        //textViewの位置とサイズを設定
        textField.frame = CGRect(x:10, y:350, width:self.frame.width - 20, height:50)
        //テキストを設定
        textField.text = "コメントを入力してください"
        //フォントの大きさを設定
        textField.font = UIFont.systemFont(ofSize: 20.0)
        //textViewの枠線の太さを設定
        textField.layer.borderWidth = 1
        //枠線の色をグレーに設定
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.white
        //テキストを編集できるように設定
//        textField.isEditing = true
        //Viewに追加
        self.addSubview(textField)
    }
    
    
    
    
    
    //投稿ボタンを押した際のアクション
    @IBAction func postCommentButton(_ sender: Any) {
        //①ユーザー名を取得
        //②入力されたコメントを取得
        //③カンマ区切りの文字列で保存する。
        
        
        
        
    }
    
    
    
    
    
}
