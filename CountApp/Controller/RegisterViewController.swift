//
//  RegisterViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var stopSnackingButton: UIButton!
    
    var rgba = UIColor(red: 93/255.0, green: 195/255.0, blue: 223/255.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //外枠の色
        stopSnackingButton.layer.borderColor = rgba.cgColor
        //外枠の太さ
        stopSnackingButton.layer.borderWidth = 2.0
        //角丸
        stopSnackingButton.layer.cornerRadius = 3.0

        
    }
    
    
    @IBAction func stopSnackingAction(_ sender: Any) {
        
        targetTextField.text = "間食を制限する"
        
    }
    
    
    //CountViewControllerへ画面遷移
    @IBAction func nextAction(_ sender: Any) {
        performSegue(withIdentifier: "count", sender: nil)
    }
    
    //値を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "count" {
            let countVC: CountViewController = segue.destination as! CountViewController
            countVC.targetStirng = targetTextField.text!
        }
    }
    
//    // Segue 準備
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//       if (segue.identifier == "count") {
//            let countVC: CountViewController = segue.destination as! CountViewController
//
//            //UIImage型の画像を入れる
//            subVC.passImage = saveImage
//
//
//        }
//    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
