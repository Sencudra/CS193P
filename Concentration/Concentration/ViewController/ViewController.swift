//
//  ViewController.swift
//  Concentration
//
//  Created by profile on 08/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private types
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var theme: Theme = Theme.randomTheme() {
        
        didSet {
            emojiSet = theme.emojiSet
            self.view.backgroundColor = theme.backgroundColor
            
            flipCountLabel.textColor = theme.cardColor
            scoreLabel.textColor = theme.cardColor
            newGameButton.setTitleColor(theme.cardColor, for: UIControl.State.normal)
            
            for button in cardButtons {
                button.backgroundColor = theme.cardColor
            }
            
        }
        
    }
    
    private lazy var emojiSet: [String] = theme.emojiSet

    private lazy var emoji = [Int:String]()
    
    private var numberOfPairsOfCards: Int {
        return cardButtons.count / 2
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var newGameButton: UIButton!
    
    // MARK: - Semiprivate types
    
    private(set) var flipCount = 0 {
        
        didSet {
            flipCountLabel.text = String.StaticTexts.flipsLabelText + "\(flipCount)"
        }
        
    }
    
    private(set) var gameScore = 0 {
        
        didSet {
            scoreLabel.text = String.StaticTexts.scoreLabelText + "\(gameScore)"
        }
        
    }
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiSet.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiSet.count)
            emoji[card.identifier] = emojiSet.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    // MARK: - Private methods

    @IBAction private func touch(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction private func startNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = Theme.randomTheme()
        emoji = [Int:String]()
        
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle(String.StaticTexts.blankLabelText, for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? theme.backgroundColor : theme.cardColor
            }
        }
        flipCount = game.flips
        gameScore = game.score
    }

}
