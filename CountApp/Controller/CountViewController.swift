//
//  CountViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class CountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var countPickerView: UIPickerView!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var receivedTargetTextLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var unit:String = "kcal"
    
    var alertController: UIAlertController!
    
    @IBOutlet var tap: UITapGestureRecognizer!
    
    var targetStirng = String()
    let dataList = ["kcal", "円", "回", "個"]
    
    /* --  ログログイメージカラー  -- */
    let rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    /* --   基本背景色  -- */
    let backGroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    /* -- ボタン透過用カラー  -- */
    let penetrateRGBA = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 0.3)

    /*-- viewDidLoad --*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate設定
        countPickerView.delegate = self
        countPickerView.dataSource = self
        countTextField.delegate = self
        
        //背景色設定
        self.view.backgroundColor = backGroundColor
        
        // タップを定義
        let tap = UITapGestureRecognizer(target: self, action: #selector(CountViewController.tapAction(_:)))
        
        // viewにタップを登録
        self.view.addGestureRecognizer(tap)
        
        //数字だけのキーボードを表示
        self.countTextField.keyboardType = UIKeyboardType.numberPad
        
        //目標画面から目標(targetString)をもってきて代入
        receivedTargetTextLabel.text = targetStirng
    
        /*-- ボタンデザイン --*/
        //角丸
        doneButton.layer.cornerRadius = 5.0
        //countTextFieldに値が入るまでは透過(ボタン無効化の見た目)させておく
        doneButton.layer.backgroundColor = penetrateRGBA.cgColor
        //ボタンのテキストカラー
        doneButton.setTitleColor(.white, for: .normal)
        //次へボタンを無効化
        doneButton.isEnabled = false
    }
    
    
    @IBAction func targetDecisionAction(_ sender: Any) {

        /*-- アラート表示設定 --*/
        let alertController:UIAlertController =
            UIAlertController(title:"\(receivedTargetTextLabel.text!)\n\(countTextField.text!)\(unit)まで！",
                              message: nil,
                              preferredStyle: .alert)

        // Default のaction
        let defaultAction:UIAlertAction =
                    UIAlertAction(title: "これでいく！",
                                  style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            //アプリ内にデータ保存
                            UserDefaults.standard.set(self.receivedTargetTextLabel.text, forKey: "target")
                            UserDefaults.standard.set(self.countTextField.text, forKey: "count")
                            UserDefaults.standard.set(self.unit, forKey: "unit")
                            //画面遷移
                            self.performSegue(withIdentifier: "done", sender: nil)
                })
        
        // Cancel のaction
        let cancelAction:UIAlertAction =
                    UIAlertAction(title: "やっぱりやめとく",
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
    
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewに表示する配列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
                unit = dataList[row]
                //キーボード閉じる
                countTextField.resignFirstResponder()
    }
    
        
    //入力制限（数字のみ）
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //For mobile numer validation
        if textField == countTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    //キーボード閉じたあと,ボタン有効/無効の処理
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch countTextField.text {
        case nil:
            doneButton.isEnabled = false
            doneButton.backgroundColor = penetrateRGBA
        case "":
            doneButton.isEnabled = false
            doneButton.backgroundColor = penetrateRGBA
        default:
            doneButton.isEnabled = true
            doneButton.backgroundColor = rgba
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボード閉じる
        countTextField.resignFirstResponder()
        return true
    }
    
    

    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        //キーボード閉じる
        countTextField.resignFirstResponder()
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
