//
//  DrawView.swift
//  CountApp
//
//  Created by Daiki Uchiyama on 2020/07/04.
//  Copyright © 2020 Daiki Uchiyama. All rights reserved.
//

import UIKit

class DrawView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.backgroundColor = UIColor.clear;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        // ここにUIBezierPathを記述する
        // 円弧
//        let circle = UIBezierPath(arcCenter: CGPoint(x: 200, y: 200), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi)*2/4, clockwise: true)
//        print(Double.pi)
//        // 線の色
//        UIColor(red: 1, green: 0, blue: 1, alpha: 1.0).setStroke()
//        // 線の太さ
//        circle.lineWidth = 5.0
//        // 線を塗りつぶす
//        circle.stroke()
        
//---------------------------------------------------------------
//---------------------------------------------------------------
        
//        // 円形の中が透明になっているのがわかり易いように背景をグレーに設定
//        self.view.backgroundColor = UIColor.gray
//
//        let shapeLayer = CAShapeLayer.init();
//        let shapeFrame = CGRect.init(x: 50, y: 50, width: 100, height: 100)
//        shapeLayer.frame = shapeFrame
//
//        /* --- 円弧を描画 --- */
//        // 輪郭の色
//        shapeLayer.strokeColor = UIColor.blue.cgColor
//        // 円の中の色
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        // 輪郭の太さ
//        shapeLayer.lineWidth = 2.5
//
//        // スタートとエンドの位置を計算
//        let startAngle: CGFloat = CGFloat(Double.pi * 2.0 * 180.0 / 360.0)
//        let endAngle: CGFloat = CGFloat(Double.pi * 2.0 * 0.0 / 360.0)
//
//        // 円弧を描画
//        shapeLayer.path = UIBezierPath.init(arcCenter: CGPoint.init(x: shapeFrame.size.width / 2.0, y: shapeFrame.size.height / 2.0),
//                                            radius: shapeFrame.size.width / 2.0,
//                                            startAngle: startAngle,
//                                            endAngle: endAngle,
//                                            clockwise: true).cgPath
//
//        self.view.layer.addSublayer(shapeLayer)
        
    }

}
