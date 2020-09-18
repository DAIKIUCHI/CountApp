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
    @IBOutlet weak var resetButton: UIButton!
//    @IBOutlet weak var countTapButton: UIButton!
    
    /* --  カウント表示用のテキストラベル  -- */
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var slash: UILabel!
    @IBOutlet weak var setValue: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
//    @IBOutlet weak var tap: UILabel!
    
    
    @IBOutlet weak var count1plus: UIButton!
    @IBOutlet weak var count10plus: UIButton!
    @IBOutlet weak var count100plus: UIButton!
    @IBOutlet weak var count1000plus: UIButton!
    
    //countCircle()のインクリメント用
    var i:Double = 1.0
    //円の終わりの位置指定のための計算用変数
    var circleEnd:Double =  0.0
    
    //進捗カウントのインクリメント用
    var j = Int()
    
    var rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    
    /*--  viewDidLoad --*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTextLabel.text = (UserDefaults.standard.object(forKey: "target") as! String)
        setValue.text = UserDefaults.standard.string(forKey: "count")
        unitLabel.text = UserDefaults.standard.string(forKey: "unit")
        progress.text = UserDefaults.standard.string(forKey: "j")
        
        //カラー定数宣言
        let backGroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let buttonRGBA = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
        
        //背景色設定
        self.view.backgroundColor = backGroundColor
        
//        //日付が変更されていたら数値リセット
//        judgeDate()
        
        //リセットボタンの見た目
        resetButton.layer.borderColor = buttonRGBA.cgColor
        resetButton.layer.borderWidth = 1
        resetButton.layer.backgroundColor = .none
        resetButton.layer.cornerRadius = 5.0
        
        // ボタンやラベルのレイアウト
        labelDecoration()
        
        // 円を描画
        circle()
        countCircle()
        
        // ナビゲージョンアイテムの文字色
        self.navigationController!.navigationBar.tintColor = .white
        // ナビゲーションバーのタイトルの文字色
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        // ナビゲーションバーの背景色
        self.navigationController!.navigationBar.barTintColor = rgba

        // progressラベルがnilのときは"0"を表示させる
        if progress.text == nil {
            progress.text = "0"
        }
        
        j = UserDefaults.standard.integer(forKey: "j")

    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        // ナビゲージョンアイテムの文字色
//        self.navigationController!.navigationBar.tintColor = .white
//        // ナビゲーションバーのタイトルの文字色
//        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        // ナビゲーションバーの背景色
//        self.navigationController!.navigationBar.barTintColor = rgba
//    }
    
    /* -- 画面遷移操作用※あとで消すやつ -- */
    func save() {
        UserDefaults.standard.set("保存", forKey: "saveContent")
    }
    
    
    @IBAction func count1Button(_ sender: Any) {
        j += 1
        progress.text = String(j)
        UserDefaults.standard.set(j, forKey: "j")
        countCircle()
    }
    
    @IBAction func count10Button(_ sender: Any) {
        j += 10
        progress.text = String(j)
        UserDefaults.standard.set(j, forKey: "j")
        countCircle()
    }
    
    @IBAction func count100Button(_ sender: Any) {
        j += 100
        progress.text = String(j)
        UserDefaults.standard.set(j, forKey: "j")
        countCircle()
    }
    
    @IBAction func count1000Button(_ sender: Any) {
        j += 1000
        progress.text = String(j)
        UserDefaults.standard.set(j, forKey: "j")
        countCircle()
    }
    
    /*-- 回数リセットボタンの処理 --*/
    @IBAction func resetAction(_ sender: Any) {
        
        /*-- アラート表示設定 --*/
        let alertController:UIAlertController =
            UIAlertController(title:"リセットしますか？",
                              message: nil,
                              preferredStyle: .alert)

        // Default のaction
        let defaultAction:UIAlertAction =
                    UIAlertAction(title: "リセットする！",
                                  style: .default,
                          handler:{
                            (action:UIAlertAction!) -> Void in
                            
                            self.j = 0
                            self.progress.text = String(self.j)
                            self.circle()
                            //アプリ内データの更新
                            UserDefaults.standard.set(self.j, forKey: "j")
                })
        
        // Cancel のaction
        let cancelAction:UIAlertAction =
                    UIAlertAction(title: "やっぱりしない！",
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
    
    // ボタンやラベルのデザインをまとめている
    func labelDecoration() {
        
        slash.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2.6)
        progress.center = CGPoint(x: view.frame.size.width / 2.4, y: view.frame.size.height / 2.6)
        setValue.center = CGPoint(x: view.frame.size.width / 1.7, y: view.frame.size.height / 2.6)
        unitLabel.center = CGPoint(x: view.frame.size.width / 1.4, y: view.frame.size.height / 2.6)
        
        /*-- 目標のラベル デザイン --*/
        targetTextLabel.frame = CGRect(x: view.frame.size.width / 10, y: view.frame.size.height / 8, width: view.frame.size.width / 1.25, height: view.frame.size.height / 13)
        
        /*-- +1 ボタンデザイン --*/
        //外枠の色
        count1plus.layer.borderColor = rgba.cgColor
        //外枠の太さ
        count1plus.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        count1plus.layer.cornerRadius = 5.0
        //枠のサイズ
        count1plus.frame = CGRect(x: view.frame.size.width / 5.71428571, y: view.frame.size.height / 1.63, width: view.frame.size.width / 1.53846154, height: view.frame.size.height / 17)
        
        /*-- +10 ボタンデザイン --*/
        //外枠の色
        count10plus.layer.borderColor = rgba.cgColor
        //外枠の太さ
        count10plus.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        count10plus.layer.cornerRadius = 5.0
        //枠のサイズ
        count10plus.frame = CGRect(x: view.frame.size.width / 5.71428571, y: view.frame.size.height / 1.44, width: view.frame.size.width / 5, height: view.frame.size.height / 17)
        
        /*-- +100 ボタンデザイン --*/
        //外枠の色
        count100plus.layer.borderColor = rgba.cgColor
        //外枠の太さ
        count100plus.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        count100plus.layer.cornerRadius = 5.0
        //枠のサイズ
        count100plus.frame = CGRect(x: view.frame.size.width / 2.5, y: view.frame.size.height / 1.44, width: view.frame.size.width / 5, height: view.frame.size.height / 17)
        
        
        /*-- +1000 ボタンデザイン --*/
        //外枠の色
        count1000plus.layer.borderColor = rgba.cgColor
        //外枠の太さ
        count1000plus.layer.borderWidth = 2.0
        //テンプレ挿入ボタン角丸
        count1000plus.layer.cornerRadius = 5.0
        //枠のサイズ
        count1000plus.frame = CGRect(x: view.frame.size.width / 1.6, y: view.frame.size.height / 1.44, width: view.frame.size.width / 5, height: view.frame.size.height / 17)
        
        /*-- リセット ボタンデザイン --*/
        resetButton.frame = CGRect(x: view.frame.size.width / 5.71428571, y: view.frame.size.height / 1.25, width: view.frame.size.width / 1.53846154, height: view.frame.size.height / 17)
        
    }
    
    /*-- 円を描画 --*/
    func circle() {
        //初期化
        let shapeLayer = CAShapeLayer.init();
        //円の大きさ
        let circleSize:CGFloat = view.bounds.width / 1.7
        /* --- xの位置 -> (ビューの幅 -  円の大きさ) / 2 = 円の左端の位置（画面の中央に描画できる）--- */
        let shapeFrame = CGRect.init(x: (self.view.bounds.width - circleSize) / 2, y: (self.view.bounds.height - circleSize) / 3, width: circleSize, height: circleSize)
        shapeLayer.frame = shapeFrame
        
        /* --- 円を描画 --- */
        // 輪郭の色
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1.0).cgColor
        // 円の中の色
        shapeLayer.fillColor = UIColor.white.cgColor
        // 輪郭の太さ
        shapeLayer.lineWidth = 15.0
        //円
        let startAngle: CGFloat = CGFloat(0)
        let endAngle: CGFloat = CGFloat(Double.pi * 2)
        // 円弧を描画
        shapeLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0),
                                            radius: shapeFrame.size.width / 2.0,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: true).cgPath
        self.view.layer.addSublayer(shapeLayer)
        textAddsubView()
    }
    
    /*-- カウント回数を表す円 --*/
    func countCircle() {
        //初期化
        let shapeLayer = CAShapeLayer.init();
        //円の大きさ
        let circleSize:CGFloat = view.bounds.width / 1.7
        /* --- xの位置 -> (ビューの幅 -  円の大きさ) / 2 = 円の左端の位置（画面の中央に描画できる）--- */
        let shapeFrame = CGRect.init(x: (self.view.bounds.width - circleSize) / 2, y: (self.view.bounds.height - circleSize) / 3, width: circleSize, height: circleSize)
        shapeLayer.frame = shapeFrame

        /* --- 円を描画 --- */
        // 輪郭の色
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 102/255, blue: 51/255, alpha: 1.0).cgColor
        // 円の中の色
        shapeLayer.fillColor = UIColor.clear.cgColor
        // 輪郭の太さ
        shapeLayer.lineWidth = 15.0

        /* -- スタートとエンドの位置を計算 -- */
        // startAngleとendAngleの求め方ですが、
        // 3時の方向が0度になるので、直径×円周率×描画したい角度/360度で求めることができます
        let startAngle: CGFloat = CGFloat(Double.pi * 2.0 * 270.0 / 360.0)

        //円の終わりの位置指定のための計算用変数(360°/"count")
        circleEnd = UserDefaults.standard.double(forKey: "count")
        j = UserDefaults.standard.integer(forKey: "j")
        
        //Double.piの0°が3時。よって270°は12時。12時から開始したいので270を足した後にcountを割る
        let endAngle: CGFloat = CGFloat(Double.pi * 2.0 * (270 + (360 / circleEnd) * Double(j)) / 360.0)

        // 円弧を描画
        shapeLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0),
                                           radius: shapeFrame.size.width / 2.0,
                                           startAngle: startAngle,
                                           endAngle: endAngle,
                                           clockwise: true).cgPath
        self.view.layer.addSublayer(shapeLayer)
        textAddsubView()
    }
    
    //テキストフィールドを円より前面に表示
    func textAddsubView() {
        self.view.addSubview(progress)
        self.view.addSubview(slash)
        self.view.addSubview(setValue)
//        self.view.addSubview(tap)
        self.view.addSubview(unitLabel)
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
