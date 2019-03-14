//
//  Concentration.swift
//  Concentration
//
//  Created by profile on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation

enum GameRules {
    
    static var penalty: Int {
        return 1
    }
    
    static var reward: Int {
        return -5
    }
    
}

class Concentration {

    // MARK: - Public types
    
    var score = Int.zero
    
    var flips = Int.zero
    
    // MARK: - Semipublic types
    
    private(set) var cards = [Card]()
    
    // MARK: - Private types
    
    private var penalty = GameRules.penalty
    
    private var reward = GameRules.reward
    
    private var timerToMeasureTimeElapsed: Date = Date()
    
    private var indexOfOnlyOneSelectedCard: Int? {
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
    
    // MARK: - Init
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    // MARK: - Public methods
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        
        if !cards[index].isMatched, !cards[index].isFaceUp {
            
            // One card selected
            if let selectedCardIndex = indexOfOnlyOneSelectedCard {
                
                // Matching cards found
                if cards[selectedCardIndex].identifier == cards[index].identifier {
                    cards[selectedCardIndex].isMatched = true
                    cards[index].isMatched = true
                
                    score = score + reward - Int(timerToMeasureTimeElapsed.timeIntervalSinceNow)

                    timerToMeasureTimeElapsed = Date()
                } else {
                    score += penalty
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
