//
//  ViewController.swift
//  Concentration
//
//  Created by Vlad Tarasevich on 08/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Private types

    private typealias Text = String.StaticTexts

    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    private var theme = Theme.randomTheme() {
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
    private lazy var emoji = [Int: String]()
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
            flipCountLabel.text = Text.flipsLabelText + "\(flipCount)"
        }

    }

    private(set) var gameScore = 0 {
        didSet {
            scoreLabel.text = Text.scoreLabelText + "\(gameScore)"
        }

    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
    }

    // MARK: - Private action methods

    @IBAction private func touch(_ sender: UIButton) {

        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }

    }

    @IBAction private func startNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = Theme.randomTheme()
        emoji = [Int: String]()

        updateViewFromModel()
    }

    // MARK: - Private methods

    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiSet.isEmpty {
            let randomIndex = Int.random(in: 0..<emojiSet.count)
            emoji[card.identifier] = emojiSet.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

    private func updateViewFromModel() {

        var hasCardsNotMathed = false

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

            if !card.isMatched {
                hasCardsNotMathed = true
            }
        }
        flipCount = game.flips
        gameScore = game.score

        if !hasCardsNotMathed {
            launchEndGameAlert()
        }
    }

    private func launchEndGameAlert() {
        let alert = UIAlertController(title: Text.endGameTitle,
                                      message: Text.scoreLabelText + "\(gameScore)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Text.startNewGameText, style: .default, handler: { _ in
            self.launchNewGame()
        }))
        self.present(alert, animated: true)
    }

    private func launchNewGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        theme = Theme.randomTheme()
        emoji = [Int: String]()

        updateViewFromModel()
    }

}
