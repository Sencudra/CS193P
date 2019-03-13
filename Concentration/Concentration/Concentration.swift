//
//  Concentration.swift
//  Concentration
//
//  Created by profile on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation


class Concentration {
    
    private(set) var cards = [Card]()
    var score = 0
    var flips = 0
    
    private var penalty = 1
    private var reward = 2
    
    private var indexOfOnlyOneSelectedCard : Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp  {
                    guard foundIndex == nil else { return nil }
                    foundIndex = index
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched, !cards[index].isFaceUp {
            
            // One card selected
            if let selectedCardIndex = indexOfOnlyOneSelectedCard {
                
                // Matching cards found
                if cards[selectedCardIndex].identifier == cards[index].identifier {
                    cards[selectedCardIndex].isMatched = true
                    cards[index].isMatched = true
                    score += penalty
                } else {
                    score -= penalty
                }
                cards[index].isFaceUp = true
                
            // Two or none cards selected
            } else {
                indexOfOnlyOneSelectedCard = index
            }
            flips += 1
        }
    }
}
