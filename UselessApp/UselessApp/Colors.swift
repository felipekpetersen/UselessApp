//
//  File.swift
//  UselessApp
//
//  Created by Felipe Petersen on 17/04/20.
//  Copyright © 2020 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

class Colors {
    
    private let colors = [UIColor(rgb: 0x651E3E), UIColor(rgb: 0x051E3E), UIColor(rgb: 0x3DA4AB), UIColor(rgb: 0x4B86B4), UIColor(rgb: 0xfEB2A8), UIColor(rgb: 0x83D0C9)]

    private var lastColor: CGColor?
    
    func getRandomPairOfColor() -> [CGColor] {
        var color = colors.randomElement()?.cgColor
        while lastColor == color {
            color = colors.randomElement()?.cgColor
        }
        lastColor = color
        return [color!, (UIColor(red: (color?.components?[0] ?? 0) + 0.2, green: (color?.components?[1] ?? 0) + 0.2, blue: (color?.components?[2] ?? 0) + 0.2, alpha: 1)).cgColor]
    }
    
    func incrementColor(rgb: String) -> String{
        let len = rgb.lengthOfBytes(using: String.Encoding.utf8)
        let num2 = Int(rgb, radix: 16)! + 1
        let newStr = NSString(format: "%0\(len)X" as NSString, num2) as String
        return newStr
    }
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
    func getColors(red: Int, green: Int, blue: Int) {
    }
}
