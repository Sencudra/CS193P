//
//  CardViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - Private properties

    private(set) var cardView: CardView?
    private(set) var model: Card?

    private var symbolViewControllers: [SymbolViewController]?

    // MARK: - Init

    init(model: Card) {
        self.cardView = nil
        self.model = model
        self.symbolViewControllers = nil
        super.init(nibName: nil, bundle: nil)

        let symbolViewControllers = getSymbolViewControllers(for: model)
        let symbolViews = getSymbolViews(for: symbolViewControllers)
        let cardView = CardView(symbolViews: symbolViews)

        self.cardView = cardView
        self.symbolViewControllers = symbolViewControllers
    }

    required init?(coder: NSCoder) {
        preconditionFailure("CardViewController: required init?(coder: NSCoder) not implemented!")
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let cardView = self.cardView, let controllers = symbolViewControllers else {
            return
        }

        view.addSubview(cardView)

        controllers.forEach { controller in
            cardView.addSubview(controller.view)
            addChild(controller)
            controller.didMove(toParent: self)
        }

        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        cardView.widthAnchor.constraint(equalTo: cardView.heightAnchor,
                                        multiplier: view.bounds.width / view.bounds.height).isActive = true

    }

    // MARK: - Private methods

    private func getSymbolViewControllers(for model: Card) -> [SymbolViewController] {
        assert(model.numberOfSymbols > 0,
               "CardViewController: getSymbolViewControllers(for model: Card) - model's numberOfSymbols less than 1")

        var symbolViewControllers = [SymbolViewController]()

        for _ in 0..<model.numberOfSymbols {
            let symbolViewController = SymbolViewController(
                frame: .zero,
                model: model.symbol)
            symbolViewControllers.append(symbolViewController)
        }
        return symbolViewControllers
    }

    private func getSymbolViews(for controllers: [SymbolViewController]) -> [SymbolView] {
        var symbolViews = [SymbolView]()

        controllers.forEach { controller in

            if let symbolView = controller.symbolView {
                symbolViews.append(symbolView)
            }

        }
        return symbolViews
    }

}
