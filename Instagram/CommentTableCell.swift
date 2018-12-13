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
        
        
        

    
    }
    
}
