//
//  Card.swift
//  Concentration
//
//  Created by profile on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    private(set) var identifier: Int
    
    private static var identifierGlobalCounter = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierGlobalCounter += 1
        return identifierGlobalCounter
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
