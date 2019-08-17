//
//  ViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 28/03/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private properties
    
    private var model: SetGame = SetGame()
    private var timer: Timer = Timer()

    //private var uiButtonSlotsToCards: [UIButton:Card] = [UIButton:Card]()
    
    // MARK: - Overrides
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
//        let symbol = Symbol(type: 1, color: 1, filling: 1)
//        let card = Card(numberOfSymbols: 2, symbol: symbol)
        
        let model = SetGame()
        let board = Board(cards: model.table)
        let boardViewController = BoardViewController(model: board)
        
        view.addSubview(boardViewController.view)
        addChild(boardViewController)
        boardViewController.didMove(toParent: self)
        
//        view.addSubview(cardView)
//        let grid = Grid(layout: .fixedCellSize(CGSize(width: 100, height: 200)),
//                        frame: view.bounds)
        
//        for index in 0...grid.cellCount {
//            let subview = CardView(numberOfSymbols: 3)
//
//            if UIDevice.current.orientation.isLandscape {
//                subview.setOrientation(as: .Horizontal)
//            } else {
//                subview.setOrientation(as: .Vertical)
//            }
//
//            if let frame = grid[index] {
//                subview.frame = frame
//            }
//            subview.backgroundColor = UIColor.red
//            view.addSubview(subview)
//            views.append(subview)
//        }

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
        
    }
 
    // MARK: - Private methods
    
//    private func sheduledTimerWithTimeInterval() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimeLabel), userInfo: nil, repeats: true)
//    }

//    @IBAction private func touchCard(_ sender: UIButton) {
//        if let card = uiButtonSlotsToCards[sender] {
//            let match = model.touch(card: card)
//            color = Color.selection(if: match)
//            updateMapping()
//        } else {
//            print("ViewController.touchCard() - Card not found in cardButtons!")
//        }
//
//    }
    
//    @IBAction private func touchDealMoreCards(_ sender: Any) {
//        if uiButtonEmptySlots.count > 0 {
//            model.dealMoreCards()
//            updateMapping()
//        } else {
//            print("ViewController.touchDealMoreCards() - No space for more cards")
//        }
//
//    }
    
//    @IBAction private func touchNewGameButton(_ sender: Any) {
//        model = SetGame()
//        sheduledTimerWithTimeInterval()
//        initCards()
//    }
//
//    @IBAction private func touchHelpButton(_ sender: Any) {
//        model.getHelp()
//        updateView()
//    }
//
//    private func initCards() {
//        uiButtonSlotsToCards = [UIButton:Card]()
//        uiButtonEmptySlots = cardButtons.shuffled()
//        for card in model.table {
//            uiButtonSlotsToCards[uiButtonEmptySlots.removeFirst()] = card
//        }
//        updateMapping()
//    }
    
//    private func updateMapping() {
//        let cards = model.table
//        for button in uiButtonSlotsToCards.keys {
//            if let card = uiButtonSlotsToCards[button], !model.table.contains(card) {
//                uiButtonEmptySlots += [button]
//                uiButtonSlotsToCards.removeValue(forKey: button)
//            }
//
//        }
//
//        // add new ones
//        for card in cards {
//            if uiButtonSlotsToCards.key(for: card) == nil, uiButtonEmptySlots.count > 0 {
//                uiButtonSlotsToCards[uiButtonEmptySlots.removeFirst()] = card
//            }
//
//        }
//        updateView()
//    }
//
//    private func updateView() {
//        updateSetsFoundLabel()
//        updateTimeLabel()
//        updateDealButton()
//
//        for button in cardButtons {
//
//            // Checking if button have card binding
//            if let card = uiButtonSlotsToCards[button] {
//
//                let highlighted = model.set.contains(card)
//                let selected = model.selected.contains(card)
//
//                // Maintain card selection
//                if selected || highlighted {
//                    button.layer.borderWidth = 3.0
//                } else {
//                    button.layer.borderWidth = 0.0
//                }
//
//                button.layer.cornerRadius = 4.0
//                button.layer.borderColor = selected ? color : Color.yellow
//
//                // Getting nsatributed string
//                if let attributedString = CardPresenter.getContent(for: card) {
//                    button.setAttributedTitle(attributedString, for: .normal)
//                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//
//                } else {
//                    assertionFailure("ViewController.updateView() - There is no card here!")
//                    return
//                }
//            } else {
//                button.setTitle(Text.empty, for: .normal)
//                button.setAttributedTitle(NSAttributedString(string: Text.empty), for: .normal)
//                button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.6666666667, blue: 0.3333333333, alpha: 1)
//                button.layer.borderWidth = 0.0
//            }
//
//        }
//
//    }
//
//    private func updateSetsFoundLabel() {
//        let count = model.setsFound
//        setsFoundLabel.text = "\(Text.setsFoundLabel)\(count)"
//    }
//
//    @objc private func updateTimeLabel() {
//        let count = -Int(model.time.timeIntervalSinceNow)
//
//        let minutes = count / 60
//        let seconds = count % 60
//
//        let minutesString = (minutes > 9 ? "" : "0") + "\(minutes)"
//        let secondsString = (seconds > 9 ? "" : "0") + "\(seconds)"
//
//        timeLabel.text = "\(Text.timeLabel)" + minutesString + ":" + secondsString
//    }
//
//    private func updateDealButton() {
//        dealButton.isEnabled = model.dealingAvailable
//        dealButton.setTitleColor( Color.button(if:dealButton.isEnabled), for: .normal)
//    }

}
