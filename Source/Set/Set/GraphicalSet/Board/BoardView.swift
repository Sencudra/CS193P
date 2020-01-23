//
//  BoardView.swift
//  Set
//
//  Created by Vladislav Tarasevich on 24/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class BoardView: UIView {

    // MARK: - Private properties

    private(set) var cardViews: [CardView]?

    // MARK: - Init

    init(cardViews: [CardView]) {
        self.cardViews = cardViews
        super.init(frame: .zero)
    }

    // No need to use this init, as view is created completely programmatically
    required init?(coder: NSCoder) {
        preconditionFailure("BoardView: required init?(coder: NSCoder) not implemented!")
    }

    // MARK: - Overrides

    override func layoutSubviews() {
        super.layoutSubviews()

        guard let cardViews = cardViews else {
            return
        }

        let count = Int(ceil(sqrt(Float(cardViews.count))))
        let grid = BoardGrid(layout: .dimensions(rowCount: count,
                                                 columnCount: count),
                             frame: self.bounds)

        for (index, view) in cardViews.enumerated() {

            if let rect = grid[index] {
                view.superview?.frame = rect
            }

        }

    }

}
