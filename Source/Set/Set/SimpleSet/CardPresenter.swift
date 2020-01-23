//
//  CardPresenter.swift
//  Set
//
//  Created by Vlad Tarasevich on 30/03/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

enum CardPresenter {

    // MARK: - Private types

    /// Defines alpha channel constants
    private enum ColorAlpha {

        static var zeroFilled: CGFloat {
            return 0.0
        }

        static var partlyFilled: CGFloat {
            return 0.30
        }

        static var fullFilled: CGFloat {
            return 1.0
        }

    }

    // MARK: - Private static properties

    private static var strokeWidth: Int {
        return 7
    }

    private static var fontSize: CGFloat {
        return CGFloat(integerLiteral: 28)
    }

    // MARK: - Public static methods

    /// Proved card's atribited string
    /// - Parameter card: Card struct
    public static func getContent(for card: Card) -> NSAttributedString? {

        guard let color = getColor(for: card) else {
            assertionFailure("CardPresenter.getColor(color: \(card.symbol.color))")
            return nil
        }

        guard let string = getFigure(for: card) else {
            assertionFailure("""
                CardPresenter.getFigure(symbol: \(card.symbol.type),\
                numberOfSymbols: \(card.numberOfSymbols) line_length
            """)
            return nil
        }

        guard let filling = getFiling(for: card) else {
            assertionFailure("CardPresenter.getFilling(filling: \(card.symbol.filling))")
            return nil
        }

        let range = NSRange(location: 0, length: string.count)
        let figure = NSMutableAttributedString(string: string)
        let font = UIFont.systemFont(ofSize: CardPresenter.fontSize)

        figure.addAttribute(.font, value: font, range: range)
        figure.addAttribute(.kern, value: 2, range: range)
        figure.addAttribute(.strokeColor, value: color, range: range)
        figure.addAttribute(.foregroundColor, value: color.withAlphaComponent(filling.0), range: range)
        figure.addAttribute(.strokeWidth, value: filling.1, range: range)

        return figure
    }

    // MARK: - Private static methods

    private static func getColor(for card: Card) -> UIColor? {

        switch card.symbol.color {
        case 0:
            return #colorLiteral(red: 1, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        case 1:
            return #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 1, alpha: 1)
        case 2:
            return #colorLiteral(red: 0.3333333333, green: 0.6666666667, blue: 0.3333333333, alpha: 1)
        default:
            return nil
        }

    }

    private static func getFigure(for card: Card) -> String? {

        let cardSymbol: String
        switch card.symbol.type {
        case 0:
            cardSymbol = "●"
        case 1:
            cardSymbol = "■"
        case 2:
            cardSymbol = "▲"
        default:
            return nil
        }
        return String(repeating: cardSymbol, count: card.numberOfSymbols + 1)

    }

    private static func getFiling(for card: Card) -> (CGFloat, Int)? {

        switch card.symbol.filling {
        case 0:
            // No fill
            return (ColorAlpha.zeroFilled, CardPresenter.strokeWidth)
        case 1:
            // Partly filled
            return (ColorAlpha.partlyFilled, 0)
        case 2:
            // Fullfilled
            return (ColorAlpha.fullFilled, -CardPresenter.strokeWidth)
        default:
            return nil
        }

    }

}
