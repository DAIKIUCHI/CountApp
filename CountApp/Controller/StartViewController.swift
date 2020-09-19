//
//  StartViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/19.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var startButton: UIButton!
    
    var rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    var penetrateRGBA = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 0.3)
    var backgroundRGBA = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景色設定
        self.view.backgroundColor = backgroundRGBA
        
        /*-- 次へボタン --*/
        //角丸
        startButton.layer.cornerRadius = 5.0
        //ボタンの背景色
        startButton.layer.backgroundColor = rgba.cgColor
        //ボタンのテキストカラー
        startButton.setTitleColor(.white, for: .normal)
        
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
