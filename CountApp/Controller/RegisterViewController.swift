//
//  RegisterViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var stopSnackingButton: UIButton!
    @IBOutlet weak var moneyLimit: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    var rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    var penetrateRGBA = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 0.3)
    var backgroundRGBA = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    /*-- viewDidLoad --*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTextField.delegate = self
        
        //背景色設定
        self.view.backgroundColor = backgroundRGBA
        
        /*-- ボタンデザイン --*/
        //外枠の色
        stopSnackingButton.layer.borderColor = rgba.cgColor
        //外枠の太さ
        stopSnackingButton.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        stopSnackingButton.layer.cornerRadius = 5.0
        
        moneyLimit.layer.borderColor = rgba.cgColor
        //外枠の太さ
        moneyLimit.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        moneyLimit.layer.cornerRadius = 5.0
        
        
        //次へボタン角丸
        nextButton.layer.cornerRadius = 5.0
        //テキストフィールドに文字が入るまでは透過(ボタン無効化の見た目)させておく
        nextButton.layer.backgroundColor = penetrateRGBA.cgColor
        //ボタンのテキストカラー
        nextButton.setTitleColor(.white, for: .normal)
        //次へボタンを無効化
        nextButton.isEnabled = false

    }
    
    
    
    /*-- 間食制限テンプレ挿入ボタン --*/
    @IBAction func stopSnackingAction(_ sender: Any) {
        targetTextField.text = "間食を制限する"
        //次へボタンを有効化
        nextButton.isEnabled = true
        nextButton.backgroundColor = rgba
    }
    
    
    @IBAction func moneyLimitAction(_ sender: Any) {
        targetTextField.text = "使えるお金を制限する"
        //次へボタンを有効化
        nextButton.isEnabled = true
        nextButton.backgroundColor = rgba
        
    }
    
    
    /*-- CountViewControllerへ画面遷移 --*/
    @IBAction func nextAction(_ sender: Any) {
            performSegue(withIdentifier: "count", sender: nil)
    }
    
    /*-- 値をCountView Controllerへ渡す --*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "count" {
            let countVC: CountViewController = segue.destination as! CountViewController
            countVC.targetStirng = targetTextField.text!
        }
    }
    
    /*-- キーボード閉じた後に呼ばれる --*/
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch targetTextField.text {
        case nil:
            nextButton.isEnabled = false
            nextButton.backgroundColor = penetrateRGBA
        case "":
            nextButton.isEnabled = false
            nextButton.backgroundColor = penetrateRGBA
        default:
            nextButton.isEnabled = true
            nextButton.backgroundColor = rgba
        }
    }
    
    /*-- リターンキーを押されたら呼ばれる --*/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボード閉じる
        targetTextField.resignFirstResponder()
        return true
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
