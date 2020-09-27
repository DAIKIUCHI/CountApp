//
//  MainViewController.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    /* --  進捗状況表示用のテキストラベル  -- */
    @IBOutlet weak var progress: UILabel!
    @IBOutlet weak var slash: UILabel!
    @IBOutlet weak var setValue: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    /* --  カウントアップボタン  -- */
    @IBOutlet weak var count1plus: UIButton!
    @IBOutlet weak var count10plus: UIButton!
    @IBOutlet weak var count100plus: UIButton!
    @IBOutlet weak var count1000plus: UIButton!
    
    /* --  countCircle()のインクリメント用  -- */
    var i:Double = 1.0
    /* --  円の終わりの位置指定のための計算用変数  -- */
    var circleEnd:Double =  0.0
    
    /* --  進捗カウントのインクリメント用  -- */
    var j = Int()
    
    /* --  ログログイメージカラー  -- */
    let rgba = UIColor(red: 255/255.0, green: 126/255.0, blue: 121/255.0, alpha: 1.0)
    /* --   基本背景色  -- */
    let backGroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    /* --  日付取得に使用する定数  -- */
    let dt = Date()
    let dateFormatter = DateFormatter()
    
    // ②・・・作成したTodoModel型の変数を用意。<TodoModel>という書き方はいわゆるジェネリック
    //Realmから受け取るデータを突っ込む変数を準備
    var items: Results<TableItem>!
    
//    var LV = LogTableViewController()
    
    /*--  viewDidLoad --*/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ③・・・Realmをインスタンス化
        // Realmのインスタンスを取得
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // ④・・・Realmのfunctionでデータを取得。functionを更に追加することで、フィルターもかけられる
        // Realmデータベースに登録されているデータを全て取得
        // try!はエラーが発生しなかった場合は通常の値が返されるが、エラーの場合はクラッシュ
        self.items = realm.objects(TableItem.self)
        
        //Userdefaults取得
        targetTextLabel.text = (UserDefaults.standard.object(forKey: "target") as! String)
        setValue.text = UserDefaults.standard.string(forKey: "count")
        unitLabel.text = UserDefaults.standard.string(forKey: "unit")
        progress.text = UserDefaults.standard.string(forKey: "j")
        
        //UserDefaults初期化
        UserDefaults.standard.register(defaults: ["dateArray" : []])
        UserDefaults.standard.register(defaults: ["progressArray" : []])
        UserDefaults.standard.register(defaults: ["targetArray" : []])
        
        //背景色設定
        self.view.backgroundColor = backGroundColor
        
        //リセットボタンの見た目
        resetButton.layer.borderColor = rgba.cgColor
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
    
//    /* -- 画面遷移操作用※あとで消すやつ -- */
//    func save() {
//        UserDefaults.standard.set("保存", forKey: "saveContent")
//    }
    
    
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
                    })
        
        // actionを追加
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)

        // UIAlertControllerの起動
        present(alertController, animated: true, completion: nil)

    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        
        // モデルクラスをインスタンス化
         let tableItem:TableItem = TableItem()
        
        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))

         // テキストフィールドの名前を突っ込む
        tableItem.date = dateFormatter.string(from: dt)
        tableItem.progress = progress.text!
        tableItem.target = setValue.text! + " " + unitLabel.text!

         // Realmデータベースを取得
         // try!はエラーが発生しなかった場合は通常の値が返されるが、エラーの場合はクラッシュ
         let realm = try! Realm()

         // ⑤・・・Realmインスタンスからaddを叩くと、データベースにレコードが追加される
         // テキストフィールドの情報をデータベースに追加
         try! realm.write {
            realm.add(tableItem)
         }
        
        print(items)
        
//        print(items)

//         // テーブルリストを再読み込み
//         self.テーブル.reloadData()

//
//        guard var dateArray = UserDefaults.standard.array(forKey: "dateArray"),
//              var progressArray = UserDefaults.standard.array(forKey: "progressArray"),
//              var targetArray = UserDefaults.standard.array(forKey: "targetArray") else {
//            return
//        }
//
//        // DateFormatter を使用して書式とロケールを指定する
//        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
//
//        //配列に追加
//        dateArray.append(dateFormatter.string(from: dt))
//        progressArray.append(progress.text!)
//        targetArray.append(setValue.text!)
//
//        //それぞれのUserDefaultsにセット
//        UserDefaults.standard.set(dateArray, forKey: "dateArray")
//        UserDefaults.standard.set(progressArray,forKey: "progressArray")
//        UserDefaults.standard.set(targetArray,forKey: "targetArray")
        
        
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
        resetButton.layer.cornerRadius = 5.0
        resetButton.layer.backgroundColor = rgba.cgColor
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.frame = CGRect(x: view.frame.size.width / 5.71428571, y: view.frame.size.height / 1.25, width: view.frame.size.width / 4, height: view.frame.size.height / 17)
        
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
