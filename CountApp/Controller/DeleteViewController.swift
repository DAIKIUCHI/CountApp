//
//  DeleteViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/15.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class DeleteViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
