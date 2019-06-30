//
//  Concentration.swift
//  Concentration
//
//  Created by Vlad Tarasevich on 09/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation


class Concentration {

    // MARK: - Public types
    
    var score: Int
    var flips: Int
    
    // MARK: - Semipublic types
    
    private(set) var cards: [Card]
    
    // MARK: - Private types
    
    private var timerToMeasureTimeElapsed: Date
    
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
        score = Int.zero
        flips = Int.zero
        
        cards = [Card]()
        timerToMeasureTimeElapsed = Date()
        
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
                matchCards(at: selectedCardIndex, at: index)
                cards[index].isFaceUp = true
                
            // Two or none cards selected
            } else {
                indexOfOnlyOneSelectedCard = index
            }
            flips += 1
        }
        
    }
    
    // MARK: - Private methods
    
    private func matchCards(at firstIndex: Int, at secondIndex: Int) {
        
        if cards[firstIndex].identifier == cards[secondIndex].identifier {
            cards[firstIndex].isMatched = true
            cards[secondIndex].isMatched = true
            addReward()
        } else {
            addPenalty()
        }
        
    }
    
    private func addReward() {
        addScore(of: GameRules.reward)
    }
    
    private func addPenalty() {
        addScore(of: GameRules.penalty)
    }
    
    private func addScore(of value: Int) {
        score = score + value + Int(timerToMeasureTimeElapsed.timeIntervalSinceNow)
        timerToMeasureTimeElapsed = Date()
    }
    
}
