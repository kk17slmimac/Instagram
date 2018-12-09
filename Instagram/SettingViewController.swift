//
//  SettingViewController.swift
//  Instagram
//
//  Created by 久保田慧 on 2018/11/13.
//  Copyright © 2018年 KeiKubota. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD
class SettingViewController: UIViewController {
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text{
            //表示名が入力されていない時はHUDを出して何もしない
            if displayName.isEmpty{
                SVProgressHUD.showError(withStatus: "表示名を入力してください")
                return
            }
            
            //表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user{
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges{ error in
                    if let error = error {
                        SVProgressHUD.showError(withStatus: "表示名の変更に失敗しました")
                        print("DEBUG_PRINT:" + error.localizedDescription)
                        return
                    }
                    
                    print("DEBUG_PRINT:[displayName = \(user.displayName!)の設定に成功しました]")
                    
                    //HUDで完了を知らせる
                    SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                }
            }
            
        }
        //キーボードを閉じる
        self.view.endEditing(true)
    }
    
    
    //ログアウトボタンを押した時に呼ばれるメソッド
    @IBAction func handleLogoutButton(_ sender: Any) {
        //ログアウトする
        try!Auth.auth().signOut()
        
        //ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)
        
        //ログイン画面から戻ってきた時のためにホーム画面(index = 0) を選択している状態にしておく
        let tabBarController = parent as! ESTabBarController
        tabBarController.setSelectedIndex(0, animated: false)
        }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user{
            displayNameTextField.text = user.displayName
        }
    }//end viewwillAppear
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
