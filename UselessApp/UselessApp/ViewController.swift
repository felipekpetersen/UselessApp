//
//  ViewController.swift
//  UselessApp
//
//  Created by Felipe Petersen on 15/04/20.
//  Copyright © 2020 Felipe Petersen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var curveView: CurveView!
    
    let dataPoints = [152, 120, 101, 60, 101, 120, 152]
    
    var xAxisPoints : [Double] {
        var points = [Double]()
        for i in 0..<dataPoints.count {
            let val = (Double(i)/6.0) * Double(self.curveView.bounds.size.width)
            points.append(val)
        }
        
        return points
    }
    
    var yAxisPoints: [Double] {
        var points = [Double]()
        for i in dataPoints {
            let val = (Double(i)/152) * Double(self.curveView.bounds.size.height / 10)
            points.append(val)
        }
        
        return points
    }
    
    var graphPoints : [CGPoint] {
        var points = [CGPoint]()
        for i in 0..<dataPoints.count {
            let val = CGPoint(x: self.xAxisPoints[i], y: self.yAxisPoints[i])
            points.append(val)
        }
        
        return points
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        curveView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.curveView.layoutSubviews()
    }
    
}

extension ViewController: BezierViewDataSource {
    
    func bezierViewDataPoints(bezierView: CurveView) -> [CGPoint] {
        
        return graphPoints
    }
}
