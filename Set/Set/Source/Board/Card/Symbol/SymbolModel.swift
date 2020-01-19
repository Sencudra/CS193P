//
//  SymbolModel.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

struct Symbol {
    
    // MARK: - Properties
    
    let type: Int
    let color: Int
    let filling: Int

}

extension Symbol: Equatable, Hashable {
    
    // MARK: - Methods
    
    static func == (lhs: Symbol, rhs: Symbol) -> Bool {
        return lhs.type == rhs.type &&
               lhs.color == rhs.color &&
               lhs.filling == rhs.filling
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(type)
        hasher.combine(color)
        hasher.combine(filling)
    }

}
