//
//  ViewController.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/12.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

import Firebase
import FirebaseAuth
import UIKit
import ESTabBarController
//ESTabBarControllerはタブの一つをボタンとして扱い、タップした時に画面遷移以外にも任意の処理を行うことができる。


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTab(){
        //画像のファイル名を指定してESTabBarControllerを作成する
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
        // 背景色、選択時の色を設定する
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        tabBarController.selectionIndicatorHeight = 3
        
        //作成したESTabControllerを親のViewController(=self)に追加する
        /*
         addChildViewController(_:)メソッドとdidMove(toParentViewController:)メソッドはセットで使います。
         親のViewController(ViewController.swift)のaddChildViewController(_:)メソッドで追加するViewControllerを指定して、子のViewControllerのdidMove(toParentViewController:)メソッドで追加の完了を伝えます。
         addChildViewController(_:)メソッドとdidMove(toParentViewController:)メソッドの間に追加するときに行う処理を記述します。
         */
        addChildViewController(tabBarController)
        let tabBarView = tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        /*
         addSubview(_:)メソッドで子のViewControllerのViewを追加し、親のViewのSafe Area全体に子のViewを表示するよう制約を設定しています。これにより、iPhoneXの画面上部のノッチや四隅の角丸で表示が切れる部分を避けた範囲で画面いっぱいに表示できるようになります。
         */
        
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),])
        tabBarController.didMove(toParentViewController: self)
        
        //タブをタップした時に表示するViewControllerを決める
        //移動したのがわかりやすくなる。
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        let settingViewController = storyboard?.instantiateViewController(withIdentifier: "Setting")
        
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)
        
        //真ん中のタブはボタンとして使う
        /*
         highlightButton(at:)メソッドで真ん中のタブはボタンとして扱う設定をし、setAction(_:at:)メソッドでタップされたときの処理を記述する
         */
        
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            //ボタンが押されたらImageViewControllerをモーダルで表示する
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //完全に遷移が行われ、スクリーン上に表示された時に呼ばれる。
        //ログインしているかを確認
        super.viewDidAppear(animated)
        
        //currentuserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            //ログインしていない時の処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            
            self.present(loginViewController!,animated: true, completion: nil)
            //presentメソッドでモーダルで表示させる。
            
        }
        
    }
    
    
}//endClass

