//
//  SymbolViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import UIKit

class SymbolViewController: UIViewController {
    
    // MARK: - Private properties
    
    private(set) var symbolView: SymbolView? = nil
    
    // MARK: - Init
    
    init(frame: CGRect, model: Symbol) {
        super.init(nibName: nil, bundle: nil)
        
        let symbol = getSymbol(for: model)
        let filling = getFilling(for: model)
        let color = getColor(for: model)
        
        symbolView = SymbolView(frame: frame,
                               symbol: symbol,
                               filling: filling,
                               color: color)
        
        if let subview = symbolView {
            view.addSubview(subview)
        }
        
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("SymbolViewController: required init?(coder aDecoder: NSCoder) not implemented!")
    }
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews \(view.bounds)")
        
        if let symbolView = symbolView {
            symbolView.setOrientation(as: getOrientation())
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
    
    private func getSymbol(for symbol: Symbol) -> SymbolView.Symbol {
        switch symbol.type {
        case 0:
            return.Rhombus
        case 1:
            return .RoundedRectangle
        case 2:
            return .Wave
        default:
            fatalError("SymbolViewController: private func getSymbol(for symbol: Symbol) -> SymbolView.Symbol - incorrect data has been passed - \(symbol.type)!")
        }
        
    }
    
    private func getFilling(for symbol: Symbol) -> SymbolView.Filling {
        switch symbol.filling {
        case 0:
            return .Full
        case 1:
            return .Partly
        case 2:
            return .None
        default:
            fatalError("SymbolViewController: private func getFilling(for symbol: Symbol) -> SymbolView.Filling - incorrect data has been passed - \(symbol.filling)!")
        }
        
    }
    
    private func getColor(for symbol: Symbol) -> UIColor {
        switch symbol.color {
        case 0:
            return UIColor.SymbolColor.green
        case 1:
            return UIColor.SymbolColor.pink
        case 2:
            return UIColor.SymbolColor.purple
        default:
            fatalError("SymbolViewController: private func getColor(for symbol: Symbol) -> UIColor - incorrect data has been passed - \(symbol.color)!")
        }
        
    }
    
}
