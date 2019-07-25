//
//  UIColor+Color.swift
//  Set
//
//  Created by Vlad Tarasevich on 06/04/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

extension UIColor {
    
    enum SymbolColor {
        
        static var green: UIColor {
            return #colorLiteral(red: 0.2117647059, green: 0.8039215686, blue: 0.2588235294, alpha: 1)
        }
        
        static var purple: UIColor {
            return #colorLiteral(red: 0.4274509804, green: 0.4196078431, blue: 0.7960784314, alpha: 1)
        }
        
        static var pink: UIColor {
            return #colorLiteral(red: 1, green: 0, blue: 0.4588235294, alpha: 1)
        }
        
    }

    enum Color {
        
        static var blue: CGColor {
            return UIColor.blue.cgColor
        }
        
        static var red: CGColor {
            return UIColor.red.cgColor
        }
        
        static var green: CGColor {
            return UIColor.green.cgColor
        }
        
        static var white: CGColor {
            return UIColor.white.cgColor
        }
        
        static var lightGray: CGColor {
            return UIColor.lightGray.cgColor
        }
        
        static var yellow: CGColor {
            return UIColor.yellow.cgColor
        }
        
        static public func selection(if match: Bool?) -> CGColor {
            switch match {
            case true:
                return Color.green
            case false:
                return Color.red
            default:
                return Color.blue
            }
            
        }
        
        static public func button(if enabled: Bool) -> UIColor {
            switch enabled {
            case true:
                return UIColor(cgColor: Color.white)
            case false:
                return UIColor(cgColor: Color.lightGray)
            }
        }
        
    }

}
