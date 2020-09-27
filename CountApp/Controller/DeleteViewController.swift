//
//  DeleteViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/15.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit
import RealmSwift

class DeleteViewController: UIViewController {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var message2Label: UILabel!
        
    /* --  ログログイメージカラー  -- */
    let rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    /* --   基本背景色  -- */
    let backGroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色設定
        self.view.backgroundColor = backGroundColor
        
        /*-- ラベルデザイン --*/
        //最初からやり直したいとき
        messageLabel.frame = CGRect(x: view.frame.size.width / 10, y: view.frame.size.height / 5    , width: view.frame.size.width / 1.25, height: view.frame.size.height / 17)
        //削除後はもとに戻せません
        message2Label.frame = CGRect(x: view.frame.size.width / 5, y: view.frame.size.height / 4.0    , width: view.frame.size.width / 1.67, height: view.frame.size.height / 17)
        
        /*-- データ削除 ボタンデザイン --*/
        deleteButton.layer.backgroundColor = rgba.cgColor
        deleteButton.layer.cornerRadius = 5.0
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.frame = CGRect(x: view.frame.size.width / 5, y: view.frame.size.height / 2.2    , width: view.frame.size.width / 1.67, height: view.frame.size.height / 15)


        // Do any additional setup after loading the view.
    }
    
    @IBAction func deleteAction(_ sender: Any) {

            /*-- アラート表示設定 --*/
            let alertController:UIAlertController =
                UIAlertController(title:"本当に消しますか？",
                                  message: nil,
                                  preferredStyle: .alert)

            // Default のaction
            let defaultAction:UIAlertAction =
                        UIAlertAction(title: "消すよ！",
                                      style: .default,
                              handler:{
                                (action:UIAlertAction!) -> Void in
                                
                                UserDefaults.standard.removeObject(forKey: "target")
                                UserDefaults.standard.removeObject(forKey: "count")
                                UserDefaults.standard.removeObject(forKey: "j")
                                UserDefaults.standard.removeObject(forKey: "i")
//                                UserDefaults.standard.removeObject(forKey: "dateArray")
//                                UserDefaults.standard.removeObject(forKey: "progressArray")
//                                UserDefaults.standard.removeObject(forKey: "targetArray")
                                let realm = try! Realm()
                                // ファイルは残すが、中身を空っぽに
                                try! realm.write {
                                  realm.deleteAll()
                                }

                                //画面遷移
                                self.performSegue(withIdentifier: "delete", sender: nil)
                    })
            
            // Cancel のaction
            let cancelAction:UIAlertAction =
                        UIAlertAction(title: "やっぱり消さない！",
                              style: .cancel,
                              handler:{
                                (action:UIAlertAction!) -> Void in
                                print("元の画面のまま")
                        })
            
            // actionを追加
            alertController.addAction(cancelAction)
            alertController.addAction(defaultAction)

            // UIAlertControllerの起動
            present(alertController, animated: true, completion: nil)
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
