//
//  gameRules.swift
//  Set
//
//  Created by Vlad Tarasevich on 30/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

extension SetGame {
    
    enum gameRules {
        
        static var cardsDealingOnStart: Int {
            return 12
        }
        
        static var cardsDealingDuringGame: Int {
            return 3
        }
        
        static var cardsToSelect: Int {
            return 3
        }
        
        static var tableMaxSize: Int {
            return 24
        }
        
    }
    
}
