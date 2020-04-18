//
//  CurveView.swift
//  UselessApp
//
//  Created by Felipe Petersen on 15/04/20.
//  Copyright © 2020 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

protocol BezierViewDataSource: class {
    func bezierViewDataPoints(bezierView: CurveView) -> [CGPoint]
}

@IBDesignable
class CurveView: UIView {
    
    private let colors = Colors()
    private let kStrokeAnimationKey = "StrokeAnimationKey"
    private let kBackgroundColorKey = "BackgroundColorKey"
    private let emptyView = EmptyView()
    
//    weak var dataSource: BezierViewDataSource?
//    private var dataPoints: [CGPoint]? {
//        return self.dataSource?.bezierViewDataPoints(bezierView: self)
//    }
    lazy var referencePoint: CGFloat = 0
    lazy var initialPoint = CGPoint(x: 0, y: self.frame.size.height)
    lazy var finalPoint = CGPoint(x: self.frame.size.width, y: self.frame.size.height)
    lazy var frameWidth = frame.size.width
    
    var lineLayer = CAShapeLayer()
    var gradientLayer = CAGradientLayer()

    
    override func draw(_ rect: CGRect) {
        if self.layer.sublayers?.count == 1 {
            emptyView.frame = CGRect(x: self.frame.midX , y: self.frame.height - 150, width: 10, height: 10)
            self.addSubview(emptyView)
        } else {
            self.emptyView.removeFromSuperview()
        }
//        animateLine()
//        drawMountains(in: rect, in: context, with: colorSpace)
    }
    
    private func drawSmoothLines() {
        let cubicCurveAlgorithm = CubicCurveAlgorithm()
        
        let randomSub1 = CGFloat.random(in: -25...25)
        let randomSub2 = CGFloat.random(in: -60...60)

        let dataPoints: [CGPoint]? = [initialPoint, CGPoint(x: -40, y: referencePoint), CGPoint(x: 100 + randomSub2, y: referencePoint + randomSub1), CGPoint(x: 150 + randomSub2, y: referencePoint + randomSub2), CGPoint(x: 250 + randomSub2, y: referencePoint + randomSub1),  CGPoint(x: 350 + randomSub2, y: referencePoint + randomSub1),  CGPoint(x: frameWidth + 40, y: referencePoint), finalPoint]
        
        guard let points = dataPoints else {
            return
        }
        
        let controlPoints = cubicCurveAlgorithm.controlPointsFromPoints(dataPoints: points)
        
        
        let linePath = UIBezierPath()
        
        for i in 0..<points.count {
            let point = points[i];
            
            if i==0 {
                linePath.move(to: point)
            }  else {
                let segment = controlPoints[i-1]
                linePath.addCurve(to: point, controlPoint1: segment.controlPoint1, controlPoint2: segment.controlPoint2)
                if i == points.count - 1 {
                    linePath.close()
                }
            }
        }

        lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 4.0
        
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: referencePoint / 1000)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: referencePoint / 1000 + 0.3)
//        gradientLayer.locations = [0, 1]
        // make sure to use .cgColor
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.cgColor]
        gradientLayer.frame = self.frame
        
        gradientLayer.mask = lineLayer
        
        guard let layers = self.layer.sublayers else {
            lineLayer.strokeEnd = 0
//            self.emptyView.removeFromSuperview()
            animateLine()
            self.setNeedsLayout()
            return self.layer.addSublayer(gradientLayer)
        }
        self.layer.sublayers?.insert(gradientLayer, at: 0)
        
        lineLayer.strokeEnd = 0
        
        animateLine()
        self.setNeedsLayout()
        self.setNeedsDisplay()
        
    }
    
    func animateLine() {
        
        let growAnimation = CABasicAnimation(keyPath: "strokeEnd")
        growAnimation.toValue = 1
        growAnimation.beginTime = CACurrentMediaTime() - 1
        growAnimation.duration = 4
        growAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        growAnimation.fillMode = CAMediaTimingFillMode.forwards
        growAnimation.isRemovedOnCompletion = false
        lineLayer.add(growAnimation, forKey: kStrokeAnimationKey)
        
        let backgroundColorAnimation = CABasicAnimation(keyPath: "colors")
        backgroundColorAnimation.fromValue = gradientLayer.colors
        backgroundColorAnimation.toValue = colors.getRandomPairOfColor()
        backgroundColorAnimation.beginTime = CACurrentMediaTime()
        backgroundColorAnimation.duration = 4
        backgroundColorAnimation.fillMode = .forwards
        backgroundColorAnimation.isRemovedOnCompletion = false
        gradientLayer.add(backgroundColorAnimation, forKey: kBackgroundColorKey)
        
        
        let fillColorAnimation = CABasicAnimation(keyPath: "fillColor")
        fillColorAnimation.toValue = UIColor.white.cgColor
        fillColorAnimation.beginTime = CACurrentMediaTime()
        fillColorAnimation.duration = 3
        fillColorAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        fillColorAnimation.fillMode = CAMediaTimingFillMode.forwards
        fillColorAnimation.isRemovedOnCompletion = false
        lineLayer.add(fillColorAnimation, forKey: "fillColor")
        
        //        let backgroundColorAnimation = CABasicAnimation(keyPath: "locations")
        //        backgroundColorAnimation.fromValue = [0, 0.4]
        //        backgroundColorAnimation.toValue = [0, 0.9]
        //        backgroundColorAnimation.duration = 3
        //        backgroundColorAnimation.autoreverses = true
        //        backgroundColorAnimation.repeatCount = .infinity
        //        backgroundColorAnimation.isRemovedOnCompletion = false
        //        backgroundColorAnimation.fillMode = .forwards
        //        gradientLayer.add(backgroundColorAnimation, forKey: kBackgroundColorKey)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            self.referencePoint = location.y
            drawSmoothLines()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        }
    }
}
