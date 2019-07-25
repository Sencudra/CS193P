//
//  CardViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: - Private types

    // MARK: - Private properties

    //private let view: CardView
    
    private(set) var cardView: CardView? = nil

    // MARK: - Init

    init(frame: CGRect, model: Card) {
        super.init(nibName: nil, bundle: nil)

        let symbolViewControllers = getSymbolViewControllers(for: model)
        var symbolViews = [SymbolView]()
        
        symbolViewControllers.forEach { controller in
            
            if let symbolView = controller.symbolView {
                symbolViews.append(symbolView)
            }
            
        }
        
        cardView = CardView(frame: frame, symbolViews: symbolViews)
        
        if let subview = cardView {
            view.addSubview(subview)
            
            symbolViewControllers.forEach { controller in
                subview.addSubview(controller.view)
                addChild(controller)
                controller.didMove(toParent: self)
            }
        }
    }

    required init?(coder: NSCoder) {
        preconditionFailure("CardViewController: required init?(coder: NSCoder) not implemented!")
    }

    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        print("View did load!")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews \(view.bounds)")
        
        if let cardView = cardView {
            cardView.setOrientation(as: getOrientation())
        }
        
    }

    // MARK: - Private methods
    
    private func getOrientation() -> UIDevice.Orientation {
        if UIDevice.current.orientation.isLandscape {
            return .Landscape
        } else {
            return .Portrait
        }
        
    }

    private func getSymbolViewControllers(for model: Card) -> [SymbolViewController] {
        
        print("getSymbolViewControllers")
        
        assert(model.numberOfSymbols > 0, "CardViewController: private func getSymbolViewControllers(for model: Card) - model's numberOfSymbols less than 1")
        
        var symbolViewControllers = [SymbolViewController]()
        
        for _ in 0..<model.numberOfSymbols {
            let symbolViewController = SymbolViewController(
                frame: .zero,
                model: model.symbol)
            symbolViewControllers.append(symbolViewController)
        }
        return symbolViewControllers
    }

}
