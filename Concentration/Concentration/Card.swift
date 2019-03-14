//
//  Card.swift
//  Concentration
//
//  Created by profile on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation

struct Card {
    
    // MARK: - Public types
    
    var isFaceUp = false
    
    var isMatched = false
    
    // MARK: - Semipublic types
    
    private(set) var identifier: Int
    
    // MARK: - Private types
    
    private static var identifierGlobalCounter = 0
    
    // MARK: - Init
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    // MARK: - Private methods
    
    private static func getUniqueIdentifier() -> Int {
        identifierGlobalCounter += 1
        return identifierGlobalCounter
    }
    
}
