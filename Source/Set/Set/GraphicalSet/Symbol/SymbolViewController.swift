//
//  SymbolViewController.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class SymbolViewController: UIViewController {
    
    // MARK: - Private(set) properties
    
    private(set) var symbolView: SymbolView? = nil
    
    // MARK: - Init
    
    init(frame: CGRect, model: Symbol) {
        super.init(nibName: nil, bundle: nil)
 
        symbolView = SymbolView(frame: frame,
                               symbol: getSymbol(for: model),
                               filling: getFilling(for: model),
                               color: getColor(for: model))
        
        if let subView = symbolView {
            view.addSubview(subView)
        }

    }
    
    required init?(coder: NSCoder) {
        preconditionFailure("SymbolViewController: required init?(coder aDecoder: NSCoder) not implemented!")
    }
    
    // MARK: - Private methods
    
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
