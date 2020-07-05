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
    
    //countCircle()のインクリメント用
    var i:Double = 1.0
    //円の終わりの位置指定のための計算用変数
    var circleEnd:Double =  0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTextLabel.text = (UserDefaults.standard.object(forKey: "target") as! String)
        countTextLabel.text = (UserDefaults.standard.object(forKey: "count") as! String)
        
        //背景色設定
        self.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        //初期化
        let shapeLayer = CAShapeLayer.init();
        //円の大きさ
        let circleSize:CGFloat = view.bounds.width / 2
        /* --- xの位置 -> (ビューの幅 -  円の大きさ) / 2 = 円の左端の位置（画面の中央に描画できる）--- */
        let shapeFrame = CGRect.init(x: (self.view.bounds.width - circleSize) / 2, y: (self.view.bounds.height - circleSize) / 2, width: circleSize, height: circleSize)
        print(self.view.bounds.height)
        print((self.view.bounds.height - circleSize) / 2)
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
    }
    
    
    /* -- 画面遷移操作用※あとで消すやつ -- */
    func save() {
        UserDefaults.standard.set("保存", forKey: "saveContent")
    }
    /* -- ------------------------ -- */

    //カウントボタンの処理
    @IBAction func countTapAction(_ sender: Any) {
        countCircle()
    }
    
    //カウント回数を表す円
    func countCircle() {
        //初期化
        let shapeLayer = CAShapeLayer.init();
        //円の大きさ
        let circleSize:CGFloat = view.bounds.width / 2
        /* --- xの位置 -> (ビューの幅 -  円の大きさ) / 2 = 円の左端の位置（画面の中央に描画できる）--- */
        let shapeFrame = CGRect.init(x: (self.view.bounds.width - circleSize) / 2, y: (self.view.bounds.height - circleSize) / 2, width: circleSize, height: circleSize)
        shapeLayer.frame = shapeFrame

        /* --- 円を描画 --- */
        // 輪郭の色
        shapeLayer.strokeColor = UIColor(red: 255/255, green: 102/255, blue: 51/255, alpha: 1.0).cgColor
        // 円の中の色
        shapeLayer.fillColor = UIColor.white.cgColor
        // 輪郭の太さ
        shapeLayer.lineWidth = 15.0

        /* -- スタートとエンドの位置を計算 -- */
        // startAngleとendAngleの求め方ですが、
        // 3時の方向が0度になるので、直径×円周率×描画したい角度/360度で求めることができます
        let startAngle: CGFloat = CGFloat(Double.pi * 2.0 * 270.0 / 360.0)

        //円の終わりの位置指定のための計算用変数(360°/"count")
        circleEnd = UserDefaults.standard.double(forKey: "count")
        print(circleEnd)
        //Double.piの0°が3時。よって270°は12時。12時から開始したいので270を足した後にcountを割る
        let endAngle: CGFloat = CGFloat(Double.pi * 2.0 * (270 + (360 / circleEnd) * i) / 360.0)

        i += 1.0
        print(i)

        // 円弧を描画
        shapeLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0),
                                           radius: shapeFrame.size.width / 2.0,
                                           startAngle: startAngle,
                                           endAngle: endAngle,
                                           clockwise: true).cgPath
        self.view.layer.addSublayer(shapeLayer)

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
