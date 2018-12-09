//
//  CommentTableCell.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/12/09.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

import UIKit

class CommentTableCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setCommentData(_ commentData: PostData) {
        
        self.userName.text = "test"
        self.comment.text = "testComment"
        
//        self.captionLabel.text = "\(postData.name!):\(postData.caption!)"
//        let likeNumber = postData.likes.count
//        likeLabel.text = "\(likeNumber)"
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm"
//        let dateString = formatter.string(from: postData.date!)
//        self.dateLabel.text = dateString
//
//        if postData.isLiked{
//            let buttonImage = UIImage(named: "like_exist")
//            self.likeButton.setImage(buttonImage, for: .normal)
//        }else{
//            let buttonImage = UIImage(named: "like_none")
//            self.likeButton.setImage(buttonImage, for: .normal)
//        }
//    }
    
    }
    
}
