//
//  Themes.swift
//  Concentration
//
//  Created by Vlad Tarasevich on 13/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

struct Theme {

    // MARK: - Public properties

    var emojiSet: [String]
    var backgroundColor: UIColor
    var cardColor: UIColor

    // MARK: - Private properties

    private static var themes: [Theme] {

        return [
            Theme(emojiSet: ["🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "⚽️", "🏓", "🏸"],
                  backgroundColor: #colorLiteral(red: 0.4549019608, green: 0.9019607843, blue: 0, alpha: 1),
                  cardColor: #colorLiteral(red: 0.8745098039, green: 0, blue: 0.3098039216, alpha: 1)),

            Theme(emojiSet: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😇"],
                  backgroundColor: #colorLiteral(red: 1, green: 0.2862745098, blue: 0, alpha: 1),
                  cardColor: #colorLiteral(red: 0, green: 0.6862745098, blue: 0.3921568627, alpha: 1)),

            Theme(emojiSet: ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"],
                  backgroundColor: #colorLiteral(red: 1, green: 0.9098039216, blue: 0, alpha: 1),
                  cardColor: #colorLiteral(red: 0.3254901961, green: 0.05882352941, blue: 0.6784313725, alpha: 1)),

            Theme(emojiSet: ["🍏", "🍎", "🍒", "🍆", "🍑", "🍌", "🍉", "🌶", "🥦", "🍇"],
                  backgroundColor: UIColor.purple,
                  cardColor: UIColor.yellow),

            Theme(emojiSet: ["🍗", "🍣", "🍜", "🍝", "🍕", "🍔", "🍤", "🥟", "🌮", "🍟"],
                  backgroundColor: UIColor.green,
                  cardColor: UIColor.red),

            Theme(emojiSet: ["🎤", "🎧", "🎼", "🎹", "🥁", "🎮", "🎷", "🎺", "🎸", "🥁"],
                  backgroundColor: UIColor.magenta,
                  cardColor: UIColor.white),

            Theme(emojiSet: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐"],
                  backgroundColor: UIColor.black,
                  cardColor: UIColor.magenta)
        ]

    }

    // MARK: - Public methods

    static func randomTheme() -> Theme {

        let count = themes.count
        return themes[Int.random(in: 0..<count)]

    }

}
