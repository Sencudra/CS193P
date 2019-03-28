//
//  Themes.swift
//  Concentration
//
//  Created by Vlad Tarasevich on 13/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    // MARK: - Public types
    
    var emojiSet: [String]
    
    var backgroundColor: UIColor
    
    var cardColor: UIColor
    
    // MARK: - Private types
    
    private static var themes: [Theme] {
        return [
            Theme(emojiSet: ["🏀","🏈","⚾️","🎾","🏐","🏉","🎱","⚽️","🏓","🏸"], backgroundColor: UIColor.grey, cardColor: UIColor.orange),
            Theme(emojiSet: ["😀","😃","😄","😁","😆","😅","😂","🤣","☺️","😇"], backgroundColor: UIColor.black, cardColor:UIColor.white),
            Theme(emojiSet: ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯"], backgroundColor: UIColor.blue, cardColor:UIColor.lightGray),
            Theme(emojiSet: ["🍏","🍎","🍒","🍆","🍑","🍌","🍉","🌶","🥦","🍇"], backgroundColor: UIColor.purple, cardColor:UIColor.yellow),
            Theme(emojiSet: ["🍗","🍣","🍜","🍝","🍕","🍔","🍤","🥟","🌮","🍟"], backgroundColor: UIColor.green, cardColor:UIColor.red),
            Theme(emojiSet: ["🎤","🎧","🎼","🎹","🥁","🎮","🎷","🎺","🎸","🥁"], backgroundColor: UIColor.magenta, cardColor:UIColor.white),
            Theme(emojiSet: ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐"], backgroundColor: UIColor.black, cardColor:UIColor.magenta)
        ]
    }
    
    // MARK: - Public methods
    
    static func randomTheme() -> Theme {
        let count = themes.count
        return themes[Int.random(in: 0..<count)]
    }
    
}
