//
//  UIColorExtension.swift
//  Avito-tech Test
//
//  Created by Vyacheslav Pronin on 11.11.2022.
//

import Foundation
import UIKit

extension UIColor {
    
    static let text = UIColor(hex: 0x18191F)
    static let shadow = UIColor(hex: 0x334155)
    static let backgroundCell = UIColor(hex: 0xFFD465)
    static let backgroundController = UIColor(hex: 0x10B981)
    
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}
