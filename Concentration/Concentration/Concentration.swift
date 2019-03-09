//
//  Concentration.swift
//  Concentration
//
//  Created by profile on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation


class Concentration {
    
    var cards = [Card]()
    
    var indexOfOnlyOneSelectedCard : Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched, !cards[index].isFaceUp {
            
            if let selectedCardIndex = indexOfOnlyOneSelectedCard {
                
                if cards[selectedCardIndex].identifier == cards[index].identifier {
                    cards[selectedCardIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                    // penalty
                }
                cards[index].isFaceUp = true
                indexOfOnlyOneSelectedCard = nil
            }
            else {
                
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyOneSelectedCard = index
            }
        }
    }
}
