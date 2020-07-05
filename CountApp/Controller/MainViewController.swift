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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        targetTextLabel.text = (UserDefaults.standard.object(forKey: "target") as! String)
        countTextLabel.text = (UserDefaults.standard.object(forKey: "count") as! String)
        
//        // Screen Size の取得
//        let screenWidth = self.view.bounds.width
//        let screenHeight = self.view.bounds.height
//
//        print(screenWidth)
//        print(screenHeight)
//
//        let draw = DrawView(frame: CGRect(x: 0, y: 0,
//                       width: screenWidth , height: screenWidth))
//        self.view.addSubview(draw)
        
        let shapeLayer = CAShapeLayer.init();
        
        //円の大きさ
        let circleSize:CGFloat = 250
        
        /* --- xの位置 -> (ビューの幅 -  円の大きさ) / 2 = 円の左端の位置（画面の中央に描画できる）--- */
        let shapeFrame = CGRect.init(x: (self.view.bounds.width - circleSize) / 2, y: (self.view.bounds.height - circleSize) / 2, width: circleSize, height: circleSize)
        print(self.view.bounds.height)
        print((self.view.bounds.height - circleSize) / 2)
        shapeLayer.frame = shapeFrame
        
        /* --- 円弧を描画 --- */
        // 輪郭の色
        shapeLayer.strokeColor = UIColor.red.cgColor
        // 円の中の色
        shapeLayer.fillColor = UIColor.lightGray.cgColor
        // 輪郭の太さ
        shapeLayer.lineWidth = 15.0

        // スタートとエンドの位置を計算
//        let startAngle: CGFloat = CGFloat(Double.pi * 2.0 * 180.0 / 360.0)
//        let endAngle: CGFloat = CGFloat(Double.pi * 2.0 * 0.0 / 360.0)
        let startAngle: CGFloat = CGFloat(0)
        let endAngle: CGFloat = CGFloat(Double.pi * 2)
        
//        startAngleとendAngleの求め方ですが、
//        3時の方向が0度になるので、
//        直径×円周率×描画したい角度/360度で求めることができます

        // 円弧を描画
        shapeLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0),
                                            radius: shapeFrame.size.width / 2.0,
                                            startAngle: startAngle,
                                            endAngle: endAngle,
                                            clockwise: true).cgPath

        self.view.layer.addSublayer(shapeLayer)


        
    }
    
    
    //画面遷移操作用※あとで消すやつ
    func save() {
        UserDefaults.standard.set("保存", forKey: "saveContent")
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
