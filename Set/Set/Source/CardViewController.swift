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
        
        if let cardView = cardView {
            cardView.setOrientation(as: getOrientation(), with: CGSize(width: view.bounds.width, height: view.bounds.height))
        }
        print("View did load!")
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("to \(size)")
        print("cardview from \(cardView?.bounds)")
        print("view from \(view.bounds)")
        
        super.viewWillTransition(to: size, with: coordinator)
        
        cardView?.setOrientation(as: getOrientation(), with: size)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        

        
    }

    // MARK: - Private methods
    
    private func getOrientation() -> UIDevice.Orientation {
        if UIDevice.Orientation.isPortrait {
            return .Portrait
        } else if UIDevice.Orientation.isLandscape {
            return .Landscape
        } else {
            fatalError("Unknown orientation!")
        }
        
    }

    private func getSymbolViewControllers(for model: Card) -> [SymbolViewController] {
        
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
