//
//  Card.swift
//  Set
//
//  Created by Vladislav Tarasevich on 30/03/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

struct Card {
    
    // MARK: - Internal properties
    
    let numberOfSymbols: Int
    let symbol: Symbol

}

extension Card: Equatable, Hashable {
    
    // MARK: - Methods
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return  lhs.numberOfSymbols == rhs.numberOfSymbols &&
                lhs.symbol == rhs.symbol
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(numberOfSymbols)
        hasher.combine(symbol)
    }
        
}
