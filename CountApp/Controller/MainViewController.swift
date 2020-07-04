//
//  MainViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    

    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var countTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTextLabel.text = (UserDefaults.standard.object(forKey: "target") as! String)
        countTextLabel.text = (UserDefaults.standard.object(forKey: "count") as! String)

        // Do any additional setup after loading the view.
    }
    
    
    //画面遷移操作用※あとで消すやつ
    func save() {
        UserDefaults.standard.set("保存", forKey: "saveContent")
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
