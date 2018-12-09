//
//  commentData.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/12/09.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

import UIKit

class commentData: NSObject {
    var userName: String?
    var comment: String?
    
    
//    init(snapshot: DataSnapshot, myId: String) {
//        self.id = snapshot.key
//
//        let valueDictionary = snapshot.value as! [String: Any]
//        imageString = valueDictionary["image"] as? String
//        image = UIImage(data: Data(base64Encoded: imageString!, options: .ignoreUnknownCharacters)!)
//
//        self.name = valueDictionary["name"] as? String
//        self.caption = valueDictionary["caption"] as? String
//
//        let time = valueDictionary["time"] as? String
//        self.date = Date(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
//
//        if let likes = valueDictionary["likes"] as? [String]{
//            self.likes = likes
//        }
//
//        for likeId in self.likes {
//            if likeId == myId{
//                self.isLiked = true
//                break
//            }
//        }
//
//
//
//
//    }

}
