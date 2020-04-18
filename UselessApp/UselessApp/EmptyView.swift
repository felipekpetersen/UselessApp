//
//  EmptyView.swift
//  UselessApp
//
//  Created by Felipe Petersen on 17/04/20.
//  Copyright © 2020 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class EmptyView: UIView {
    
    var path = UIBezierPath()
    let shape = CAShapeLayer()
    let shape2 = CAShapeLayer()
    let shape3 = CAShapeLayer()

    var delayTime:Double = 0
    
    func createLabel(rect: CGRect){
        let label = UILabel()
        label.text = "Tap to start"
        label.frame = CGRect(x: -40, y: -80, width: 200, height: 20)
        label.textColor = UIColor(rgb: 0x4D648D)
        self.addSubview(label)
    }
    
    func createRadialForm(rect: CGRect) {
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 5, height: 5))
        
        shape.path = path.cgPath

        shape.fillColor = UIColor(rgb: 0xD0E1F9).cgColor
        self.layer.addSublayer(shape)
        
        shape2.path = path.cgPath

        shape2.fillColor = UIColor(rgb: 0xD0E1F9).cgColor
        self.layer.addSublayer(shape2)
        
        shape3.path = path.cgPath

        shape3.fillColor = UIColor(rgb: 0xD0E1F9).cgColor
        self.layer.addSublayer(shape3)
        
        animateRadial(shapeToAnimate: shape)
        animateRadial(shapeToAnimate: shape2)
        animateRadial(shapeToAnimate: shape3)
    }
    
    override func draw(_ rect: CGRect) {
        createRadialForm(rect: rect)
        createLabel(rect: rect)
    }
    
    func animateRadial(shapeToAnimate: CAShapeLayer) {
        let radialEffect = CABasicAnimation(keyPath: "transform.scale")
        radialEffect.toValue = 20
        radialEffect.repeatCount = .infinity
        radialEffect.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let positionAnimation = CABasicAnimation(keyPath: "position")
        positionAnimation.toValue = CGPoint(x: -50, y: -50)
        positionAnimation.repeatCount = .infinity
        positionAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.toValue = 0
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = 6
        //        groupAnimation.autoreverses = true
        groupAnimation.beginTime = CACurrentMediaTime() + delayTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.animations = [radialEffect, positionAnimation, opacityAnimation]
        shapeToAnimate.add(groupAnimation, forKey: "dasod")
        
        delayTime += 2
    }
    
}


