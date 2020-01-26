//
//  Card.swift
//  Concentration
//
//  Created by Vlad Tarasevich on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation

struct Card {

    // MARK: - Internal types

    var isFaceUp = false
    var isMatched = false

    // MARK: - SemiInternal types

    private(set) var identifier: Int

    // MARK: - Private types

    private static var identifierGlobalCounter = 0

    // MARK: - Internal init

    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    // MARK: - Private methods

    private static func getUniqueIdentifier() -> Int {
        identifierGlobalCounter += 1
        return identifierGlobalCounter
    }

}
