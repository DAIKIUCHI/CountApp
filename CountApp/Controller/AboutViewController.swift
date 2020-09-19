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
//    @IBOutlet weak var text2: UITextView!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
//    @IBOutlet weak var text4: UITextView!
    @IBOutlet weak var text4: UILabel!
    @IBOutlet weak var text4_2: UILabel!
    @IBOutlet weak var text5: UILabel!
//    @IBOutlet weak var text6: UITextView!
    @IBOutlet weak var text6: UILabel!
    @IBOutlet weak var text7: UILabel!
    @IBOutlet weak var text8: UILabel!
    @IBOutlet weak var twitterLinkLabel: UIButton!
    
    
    var rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
