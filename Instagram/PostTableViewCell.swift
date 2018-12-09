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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    }
    
    
    @IBAction func addComentButton(_ sender: Any) {
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
        
        //キーボードに投稿ボタンを作成
        
        //完了ボタンの生成
//        let myButton = UIButton(frame: CGRect(300, 5, 70, 30))
//        myButton.backgroundColor = UIColor.darkGray
//        myButton.setTitle("投稿", for: .normal)
//        myButton.layer.cornerRadius = 2.0
//        myButton.addTarget(self, action: Selector(("onClickMyButton:")), for: .touchUpInside)
//
//        //Viewに完了ボタンを追加する。
//        myKeyboard.addSubview(myButton)
//
//    }
//
//    //ボタンを押すとキーボードが下がるメソッド
//    func onClickMyButton (sender: UIButton) {
//        self.endEditing(true)
//    }
//    //改行押すとキーボードが下がるメソッド
//    func textFieldReturn(textField: UITextField) -> Bool {
//        self.endEditing(true)
//        return false
//    }
    
    }
    
    //【コメントした人の名前をラベルに追加】
    //【コメントをラベルに追加】
    
    
    
    
    
    
    
    
    
}
