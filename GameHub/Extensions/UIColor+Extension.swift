//
//  UIColor+Extension.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 13/9/23.
//

import UIKit.UIColor

extension UIColor {
    var complementaryColor: UIColor {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
    }
}
