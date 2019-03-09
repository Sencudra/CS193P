//
//  ViewController.swift
//  Concentration
//
//  Created by profile on 08/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    enum StaticTexts {
        static var flipsLabelText: String {
            return "Flips: "
        }
        static var blankLabelText: String {
            return ""
        }
    }
    
    enum Colors {
        static var grey: UIColor {
            return #colorLiteral(red: 0.9450716972, green: 0.9450716972, blue: 0.9450716972, alpha: 1)
        }
        
        static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        static var orange: UIColor {
            return #colorLiteral(red: 1, green: 0.5433388929, blue: 0, alpha: 1)
        }
        
        static var black: UIColor {
            return #colorLiteral(red: 0.0404754281, green: 0.007496107835, blue: 0.1335391104, alpha: 1)
        }
    }
    
    let emojiChoices = ["🏀","🏈","⚾️","🎾","🏐","🏉","🎱","⚽️","🏓","🏸"]
    lazy var emojiChoicesList = emojiChoices
    var emoji = [Int:String]()
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count / 2 )
    
    var flipCount = 0 { didSet {flipCountLabel.text = StaticTexts.flipsLabelText + "\(flipCount)"} }
    
    @IBAction func touch(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction func startNewGame() {
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: cardButtons.count / 2 )
        emojiChoicesList = emojiChoices
        emoji = [Int:String]()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = Colors.white
            } else {
                button.setTitle(StaticTexts.blankLabelText, for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? Colors.grey : Colors.orange
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoicesList.count - 1)))
            emoji[card.identifier] = emojiChoicesList.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
