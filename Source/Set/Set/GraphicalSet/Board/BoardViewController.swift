//
//  BoardViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 11/08/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {

    // MARK: - Private properties

    private(set) var boardView: BoardView?
    private(set) var model: Board?

    private var cardViewControllers: [CardViewController]?

    // MARK: - Init

    init(model: Board) {
        self.boardView = nil
        self.cardViewControllers = nil
        self.model = model
        super.init(nibName: nil, bundle: nil)

        let cardViewControllers = getCardViewControllers(for: model)
        let cardViews = getCardViews(for: cardViewControllers)
        let boardView = BoardView(cardViews: cardViews)

        self.boardView = boardView
        self.cardViewControllers = cardViewControllers

    }

    // No need to use this init, as view is created completely programmatically
    required init?(coder: NSCoder) {
        preconditionFailure("BoardViewController: required init?(coder aDecoder: NSCoder) not implemented!")
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let boardView = boardView,
              let controllers = cardViewControllers else {
            print("Board not init")
            return
        }

        view.addSubview(boardView)

        controllers.forEach { controller in
            boardView.addSubview(controller.view)
            addChild(controller)
            controller.didMove(toParent: self)
        }

        boardView.translatesAutoresizingMaskIntoConstraints = false
        boardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        boardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        boardView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        boardView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true

        boardView.setNeedsLayout()

    }

    // MARK: - Private methods

    private func getCardViewControllers(for model: Board) -> [CardViewController] {
        var cardViewControllers = [CardViewController]()

        for card in model.cards {
            cardViewControllers.append(CardViewController(model: card))
        }
        return cardViewControllers
    }

    private func getCardViews(for controllers: [CardViewController]) -> [CardView] {
        var cardViews = [CardView]()

        controllers.forEach { controller in

            if let cardView = controller.cardView {
                cardViews.append(cardView)
            }

        }
        return cardViews
    }

}
