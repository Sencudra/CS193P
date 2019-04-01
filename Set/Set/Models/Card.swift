//
//  Card.swift
//  Set
//
//  Created by Vlad Tarasevich on 30/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

struct Card: Equatable, Hashable {
    
    // MARK: - Internal properties
    
    let numberOfSymbols: Int
    let symbol: Int
    let color: Int
    let filling: Int
    
}

extension Card {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return  lhs.numberOfSymbols == rhs.numberOfSymbols &&
                lhs.symbol == rhs.symbol &&
                lhs.color == rhs.color &&
                lhs.filling == rhs.filling
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(numberOfSymbols)
        hasher.combine(symbol)
        hasher.combine(color)
        hasher.combine(filling)
    }
    
}
