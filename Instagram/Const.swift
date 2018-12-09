//
//  Const.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/24.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//


/*
 アプリ全体にわたって使用する定数は一つのファイルにまとめて持っておいた方が
 後ほど変更があった時などに対応しやすい。
 Swiftでこのように管理する時は構造体を用いて管理する。
 */

import Foundation

struct Const {
    //staticをつけることで、この構造体を生成することなく
    //Const.PostPathのような記述で値を得ることができるようになります。
    static let PostPath = "posts"
}
