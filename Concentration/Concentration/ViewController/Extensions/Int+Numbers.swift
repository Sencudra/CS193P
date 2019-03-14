//
//  Int+Numbers.swift
//  Concentration
//
//  Created by profile on 14/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation

extension Int {
    
    static var zero: Int {
        return 0
    }
    
    var arc4random: Int {
        if self > 0 {
            return Int.random(in: 0..<self)
        } else if self < 0 {
            return -Int.random(in: 0..<abs(self))
        } else {
            return 0
        }
        
    }
    
}
