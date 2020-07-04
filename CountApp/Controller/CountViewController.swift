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
    
    
    
    var targetStirng = String()
    
    let dataList = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate設定
        countPickerView.delegate = self
        countPickerView.dataSource = self
        countTextField.delegate = self
        
        receivedTargetTextLabel.text = targetStirng
        
        countTextField.text = dataList[0]

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func targetDecisionAction(_ sender: Any) {
        UserDefaults.standard.set(receivedTargetTextLabel.text, forKey: "target")
        UserDefaults.standard.set(countTextField.text, forKey: "count")
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
        countTextField.text = dataList[row]
    }
    
        
    //入力制限（数字のみ）
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //For mobile numer validation
        if textField == countTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
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
