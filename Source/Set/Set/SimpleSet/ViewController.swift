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

    private typealias Text = String.StaticTexts
    private typealias Color = UIColor.Color

    // MARK: - Outlets

    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var setsFoundLabel: UILabel!

    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private var dealButton: UIButton!
    @IBOutlet private var helpButton: UIButton!

    // MARK: - Private properties

    private var model = SetGame()
    private var timer = Timer()
    private var uiButtonSlotsToCards: [UIButton: Card] = [UIButton: Card]()

    private lazy var uiButtonEmptySlots: [UIButton] = cardButtons.shuffled()
    private lazy var color = Color.blue

    // MARK: - Overrides

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        sheduledTimerWithTimeInterval()
        initCards()
    }

    private func sheduledTimerWithTimeInterval() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(self.updateTimeLabel),
                                     userInfo: nil,
                                     repeats: true)
    }

    // MARK: - Private methods

    @IBAction private func touchCard(_ sender: UIButton) {
        if let card = uiButtonSlotsToCards[sender] {
            let match = model.touch(card: card)
            color = Color.selection(if: match)
            updateMapping()
        } else {
            print("ViewController.touchCard() - Card not found in cardButtons!")
        }

    }

    @IBAction private func touchDealMoreCards(_ sender: Any) {
        if !uiButtonEmptySlots.isEmpty {
            model.dealMoreCards()
            updateMapping()
        } else {
            print("ViewController.touchDealMoreCards() - No space for more cards")
        }

    }

    @IBAction private func touchNewGameButton(_ sender: Any) {
        model = SetGame()
        sheduledTimerWithTimeInterval()
        initCards()
    }

    @IBAction private func touchHelpButton(_ sender: Any) {
        model.getHelp()
        updateView()
    }

    private func initCards() {
        uiButtonSlotsToCards = [UIButton: Card]()
        uiButtonEmptySlots = cardButtons.shuffled()
        for card in model.table {
            uiButtonSlotsToCards[uiButtonEmptySlots.removeFirst()] = card
        }
        updateMapping()
    }

    private func updateMapping() {
        let cards = model.table
        for button in uiButtonSlotsToCards.keys {
            if let card = uiButtonSlotsToCards[button], !model.table.contains(card) {
                uiButtonEmptySlots += [button]
                uiButtonSlotsToCards.removeValue(forKey: button)
            }

        }

        // Add new ones
        for card in cards {
            if uiButtonSlotsToCards.key(for: card) == nil, !uiButtonEmptySlots.isEmpty {
                uiButtonSlotsToCards[uiButtonEmptySlots.removeFirst()] = card
            }

        }
        updateView()
    }

    private func updateView() {
        updateSetsFoundLabel()
        updateTimeLabel()
        updateDealButton()

        for button in cardButtons {

            // Checking if button have card binding
            if let card = uiButtonSlotsToCards[button] {

                let highlighted = model.set.contains(card)
                let selected = model.selected.contains(card)

                // Maintain card selection
                if selected || highlighted {
                    button.layer.borderWidth = 3.0
                } else {
                    button.layer.borderWidth = 0.0
                }

                button.layer.cornerRadius = 4.0
                button.layer.borderColor = selected ? color : Color.yellow

                // Getting nsatributed string
                if let attributedString = CardPresenter.getContent(for: card) {
                    button.setAttributedTitle(attributedString, for: .normal)
                    button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

                } else {
                    assertionFailure("ViewController.updateView() - There is no card here!")
                    return
                }
            } else {
                button.setTitle(Text.empty, for: .normal)
                button.setAttributedTitle(NSAttributedString(string: Text.empty), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.6666666667, blue: 0.3333333333, alpha: 1)
                button.layer.borderWidth = 0.0
            }

        }

    }

    private func updateSetsFoundLabel() {
        let count = model.setsFound
        setsFoundLabel.text = "\(Text.setsFoundLabel)\(count)"
    }

    @objc
    private func updateTimeLabel() {
        let count = -Int(model.time.timeIntervalSinceNow)

        let minutes = count / 60
        let seconds = count % 60

        let minutesString = (minutes > 9 ? "" : "0") + "\(minutes)"
        let secondsString = (seconds > 9 ? "" : "0") + "\(seconds)"

        timeLabel.text = "\(Text.timeLabel)" + minutesString + ":" + secondsString
    }

    private func updateDealButton() {
        dealButton.isEnabled = model.dealingAvailable
        dealButton.setTitleColor( Color.button(if: dealButton.isEnabled), for: .normal)
    }

}
