//
//  AboutViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/09/13.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text3: UILabel!
    @IBOutlet weak var text4: UITextView!
    @IBOutlet weak var text5: UILabel!
    @IBOutlet weak var text6: UITextView!
    @IBOutlet weak var text7: UILabel!
    @IBOutlet weak var text8: UILabel!
    @IBOutlet weak var twitterLinkLabel: UIButton!
    
    
    var rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLayout()

        // Do any additional setup after loading the view.
    }
    
    func textLayout() {
        //テキストラベルの位置、サイズ
        titleLabel.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 9, width: 200, height: 50)
        
//        titleLabel.layer.borderWidth = 2.0
//        titleLabel.layer.borderColor = rgba.cgColor
        
        //テキストラベルの位置、サイズ
        text1.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 6.7, width: 300, height: 50)
        
//        text1.layer.borderWidth = 2.0
//        text1.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text2.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 4.5, width: 300, height: 83)
        
//        text2.layer.borderWidth = 2.0
//        text2.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text3.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 2.8, width: 170, height: view.frame.size.height / 30)
        
//        text3.layer.borderWidth = 2.0
//        text3.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text4.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 2.6, width: 330, height: 150)
        
//        text4.layer.borderWidth = 2.0
//        text4.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text5.frame = CGRect(x: view.frame.size.width / 13, y: view.frame.size.height / 1.65, width: 300, height: 30)
        
//        text5.layer.borderWidth = 2.0
//        text5.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text6.frame = CGRect(x: view.frame.size.width / 12, y: view.frame.size.height / 1.55, width: 340, height: 50)
        
//        text6.layer.borderWidth = 2.0
//        text6.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text7.frame = CGRect(x: view.frame.size.width / 13, y: view.frame.size.height / 1.4, width: 300, height: 30)
        
//        text7.layer.borderWidth = 2.0
//        text7.layer.borderColor = rgba.cgColor

        //テキストラベルの位置、サイズ
        text8.frame = CGRect(x: view.frame.size.width / 11, y: view.frame.size.height / 1.3, width: 300, height: 20)

        //テキストラベルの位置、サイズ
        twitterLinkLabel.frame = CGRect(x: view.frame.size.width / 1.6, y: view.frame.size.height / 1.2, width: 100, height: 30)
    }
    
    
    @IBAction func twitterLinkAction(_ sender: Any) {
        let url = NSURL(string: "https://twitter.com/uchi_dev")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
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
