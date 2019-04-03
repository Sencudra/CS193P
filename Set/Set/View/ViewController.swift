//
//  ViewController.swift
//  Set
//
//  Created by Vlad Tarasevich on 28/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private types
    
    private enum staticTexts {
        
        static var scoreLabel: String {
            return "Sets found: "
        }
        
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak private var setsFoundLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var dealButton: 		UIButton!
    
    // MARK: - Private properties
    
    private var game = SetGame()
    
    private var buttonToCard = [UIButton:Card]()
    private lazy var buttonsEmpty: [UIButton] = cardButtons.shuffled()
    
    private var color = UIColor.blue.cgColor
    
    // MARK: - Private methods
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let card = buttonToCard[sender] {
            let match = game.touch(card: card)
            color = getSelectionColor(if: match)
            updateMapping()
            
            // TODO remove this crap
            print("Card: number - \(card.numberOfSymbols+1), color - \(card.color), symbol - \(card.symbol), filling - \(card.filling)")
            
        } else {
            print("ViewController.touchCard() - Card not found in cardButtons!")
        }
        
    }
    
    @IBAction private func touchDealMoreCards(_ sender: Any) {
        if buttonsEmpty.count > 0 {
            game.dealMoreCards()
            updateMapping()
        } else {
            print("ViewController.touchDealMoreCards() - No space for more cards")
        }
    }
    
    @IBAction private func touchNewGameButton(_ sender: Any) {
        game = SetGame()
        initCards()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCards()
    }
    
    private func initCards() {
        
        buttonToCard = [UIButton:Card]()
        buttonsEmpty = cardButtons.shuffled()
        
        for card in game.table {
            buttonToCard[buttonsEmpty.removeFirst()] = card
        }
        updateView()
        
    }
    
    private func updateMapping() {
        
        let cards = game.table
        
        for button in buttonToCard.keys {
            if let card = buttonToCard[button], !game.table.contains(card) {
                buttonsEmpty += [button]
                buttonToCard.removeValue(forKey: button)
            }
            
        }
            
        // add new one
        for card in cards {
            if buttonToCard.key(for: card) == nil, buttonsEmpty.count > 0 {
                buttonToCard[buttonsEmpty.removeFirst()] = card
            }
            
        }
        
        updateView()
    }
    
    private func updateView() {
        
        updateSetsFoundLabel()
        updateDealButton()
        
        for button in cardButtons {
            
            // Checking if button have card binding
            if let card = buttonToCard[button] {
                
                // Maintain card selection
                if game.selected.contains(card) {
                    button.layer.borderWidth = 3.0
                } else {
                    button.layer.borderWidth = 0.0
                }
                
                button.layer.cornerRadius = 4.0
                button.layer.borderColor = color
                
                // Getting nsatributed string
                if let attributedString = CardPresenter.getContent(for: card) {
                    button.setAttributedTitle(attributedString, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                    
                } else {
                    assertionFailure("ViewController.updateView() - There is no card here!")
                    return
                }
            } else {
                button.setTitle("", for: .normal)
                button.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.6666666667, blue: 0.3333333333, alpha: 1)
                button.layer.borderWidth = 0.0
            }
        
        }
    
    }
    
    private func updateSetsFoundLabel() {
        let count = game.setsFound
        setsFoundLabel.text = "\(staticTexts.scoreLabel)\(count)"
    }
    
    private func updateDealButton() {
        dealButton.isEnabled = game.dealingAvailable
        dealButton.setTitleColor(getDisabledColor(if: dealButton.isEnabled), for: .normal)
    }
    
    private func getDisabledColor(if enabled: Bool) -> UIColor {
        switch enabled {
        case true:
            return UIColor.white
        case false:
            return UIColor.lightText
        }
    }
    
    private func getSelectionColor(if match: Bool?) -> CGColor {
        switch match {
        case true:
            return UIColor.green.cgColor
        case false:
            return UIColor.red.cgColor
        default:
            return UIColor.blue.cgColor
        }
        
    }

}
