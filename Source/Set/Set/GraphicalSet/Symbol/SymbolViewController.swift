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

    private(set) var symbolView: SymbolView?

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
            return.rhombus
        case 1:
            return .roundedRectangle
        case 2:
            return .wave
        default:
            fatalError("SymbolViewController: getSymbol() - incorrect data has been passed - \(symbol.type)!")
        }

    }

    private func getFilling(for symbol: Symbol) -> SymbolView.Filling {
        switch symbol.filling {
        case 0:
            return .full
        case 1:
            return .partly
        case 2:
            return .none
        default:
            fatalError("SymbolViewController: getFilling() - incorrect data has been passed - \(symbol.filling)!")
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
            fatalError("SymbolViewController: getColor() - incorrect data has been passed - \(symbol.color)!")
        }

    }

}
