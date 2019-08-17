//
//  SetGame.swift
//  Set
//
//  Created by Vladislav Tarasevich on 28/03/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import Foundation

class SetGame {
    
    // MARK: - Semiprivate properties
    
    private(set) var time: Date = Date()
    private(set) var score: Int = 0
    private(set) var setsFound: Int = 0
    
    private(set) var set: [Card] = [Card]()
    private(set) var table: [Card] = [Card]()
    private(set) var selected: [Card] = [Card]()
    
    private(set) var dealingAvailable: Bool = true
    
    
    // MARK: - Private properties
    
    private var deck = [Card]()
    private var deckSize: Int {
        return deck.count
    }
    
    // MARK: - Public methods
    
    init() {
        initializeDeck()
        deal(numberOf: GameRules.cardsDealingOnStart)
    }
    
    public func touch(card: Card) -> Bool? {
        assert(table.contains(card), "SetGame.touchCard() : Card not found at the table!")
        
        if selected.count == GameRules.cardsToSelect {
            
            // Delete cards from table if it's a match
            if checkSet(selected[0], selected[1], selected[2]) {
                for card in selected {
                    for index in 0..<table.count {
                        if card == table[index] {
                            table.remove(at: index)
                            break
                        }
                    }
                }
                
                // add new cards
                dealMoreCards()
            }
            
            // remove selection anyway
            selected.removeAll()
        }
        select(card: card)
        
        // Check three selected cards
        if selected.count == GameRules.cardsToSelect {
            
            let matched = checkSet(selected[0], selected[1], selected[2])
                        score(if: matched, evalFunc: { _ -> Int in
                if matched {
                    setsFound += 1
                    set = []
                    return 3
                } else {
                    return -5
                }
            })
            return matched
        } else {
            return nil
        }
        
    }
    
    public func dealMoreCards(){
        deal(numberOf: GameRules.cardsDealingDuringGame)
        score += GameRules.onDealingMoreCards
    }
    
    public func getHelp(){
        score += GameRules.onGettingHelp
        table.shuffle()
        
        for cardOne in table {
            for cardTwo in table {
                for cardThree in table {
                    
                    if cardOne != cardTwo && cardTwo != cardThree && checkSet(cardOne, cardTwo, cardThree){
                        if set != [cardOne, cardTwo, cardThree] || set == [] {
                            set = [cardOne, cardTwo, cardThree]
                            return 
                        }
                        
                    }
                    
                }
                
            }
            
        }
        set = []
    }
    
    // MARK: - Private methods
    
    private func resetGameVariables() {
        time = Date()
        score = 0
        setsFound = 0
        
        set = [Card]()
        table = [Card]()
        selected = [Card]()
        
        dealingAvailable = true
    }
    
    private func select(card: Card) {
        
        if table.contains(card) {
        
            // Unselect card
            for index in 0..<selected.count {
                
                if selected[index] == card {
                    selected.remove(at: index)
                    return
                }
                
            }
            
            // Select card
            if (0..<GameRules.cardsToSelect).contains(selected.count) {
                selected += [card]
                score -= 1
            } else {
                assertionFailure("SetGame.selectCard(at \(String(describing: index))) : Number of selected cards exceeded possible value")
            }
            
        }
        
    }
    
    private func initializeDeck() {
        let range = 0...2
        
        for number in range {
            for color in range {
                for symbol in range {
                    for filling in range {
                        
                        let card = Card(numberOfSymbols: number + 1,
                                        symbol: Symbol(type: symbol, color: color, filling: filling))
                        deck += [card]
                        
                    }
                    
                }
                
            }
            
        }
        deck.shuffle()
        
        assert({12...}().contains(deckSize) && deckSize % 3 == 0, "Invalid number of cards in a deck! Must be in 12... and divisible by 3")
    }
    
    private func deal(numberOf: Int) {
        
        if deck.count >= numberOf {
            for _ in 0..<numberOf {
                let card = deck.removeFirst()
                table += [card]
            }
            
            if table.count == GameRules.tableMaxSize {
                dealingAvailable = false
            }
            
        } else {
            dealingAvailable = false
        }
        
    }
    
    private func checkSet(_ first: Card,_ second: Card,_ third: Card) -> Bool {
        
        let ruleNumber = Set([first.numberOfSymbols, second.numberOfSymbols, third.numberOfSymbols]).count
        let ruleSymbol = Set([first.symbol.type, second.symbol.type, third.symbol.type]).count
        let ruleColor = Set([first.symbol.color, second.symbol.color, third.symbol.color]).count
        let ruleFilling = Set([first.symbol.filling, second.symbol.filling, third.symbol.filling]).count
        
        let checkRule = { $0 == 1 || $0 == GameRules.cardsToSelect }
        
        return checkRule(ruleNumber) && checkRule(ruleSymbol) && checkRule(ruleColor) && checkRule(ruleFilling)
    }
    
    private func score(if matched: Bool, evalFunc: (_:Bool) -> Int) {
        score = score + evalFunc(matched)
    }
   
}

extension Dictionary where Value: Equatable {
    
    func key(for value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }
    
}


