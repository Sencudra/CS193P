//
//  CardView.swift
//  Set
//
//  Created by Vlad Tarasevich on 06/07/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation
import UIKit

class CardView: UIView {

    // MARK: - Private Properties
    
    private let numberOfSymbols: Int
    
    private var symbolViews: [SymbolView]

    private var orientation: Orientation

    // MARK: - Initializers
    
    init(numberOfSymbols: Int) {
        symbolViews = [SymbolView]()
        orientation = .Horizontal
        self.numberOfSymbols = numberOfSymbols
        super.init(frame: .zero)
        createSymbolViews()
        
        backgroundColor = UIColor.clear
    }
    
    // No need to use this init, as view is created completely programmatically
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("CardView: required init?(coder aDecoder: NSCoder) not implemented!")
    }
    
    // MARK: - Overrides
    
    override func draw(_ rect: CGRect) {
        prepareCard()
        
        // TODO remove carefully
        for _ in symbolViews {  }

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if orientation == .Horizontal {
            layoutSymbolViewsHorizontally()
        } else {
            layoutSymbolViewsVertically()
        }

    }
    
    // MARK: - Internal methods
    
    func setOrientation(as orientation: CardView.Orientation) {
        self.orientation = orientation
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    // MARK: - Private methods
    
    private func prepareCard() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
    private func createSymbolViews() {
        let symbol = SymbolView.Symbol.Wave
        let filling = SymbolView.Filling.Partly
        let color = UIColor.SymbolColor.purple
        
        for _ in 0..<numberOfSymbols {
            let view = SymbolView(frame: .zero,
                                  symbol: symbol,
                                  filling: filling,
                                  color: color)
            addSubview(view)
            symbolViews.append(view)
        }

    }
    
    private func layoutSymbolViewsVertically() {
        let width = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.width
        let height = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.height / CGFloat(numberOfSymbols)
        let offsetX = (bounds.size.width - width) / 2
        let offsetY = (bounds.size.height - height * CGFloat(numberOfSymbols)) / 2
        
        for (index, symbolView) in symbolViews.enumerated() {
            let x = offsetX
            let y = offsetY + (CGFloat(index) * height)
            symbolView.frame = CGRect(x: x, y: y, width: width, height: height)
            symbolView.setOrientation(as: .Horizontal)
        }

    }
    
    private func layoutSymbolViewsHorizontally() {
        let width = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.width / CGFloat(numberOfSymbols)
        let height = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.height
        let offsetX = (bounds.size.width - width * CGFloat(numberOfSymbols)) / 2
        let offsetY = (bounds.size.height - height) / 2
        
        for (index, symbolView) in symbolViews.enumerated() {
            let x = offsetX + (CGFloat(index) * width)
            let y = offsetY
            symbolView.frame = CGRect(x: x, y: y, width: width, height: height)
            symbolView.setOrientation(as: .Vertical)
        }

    }

}

// MARK: - Extension CardView

extension CardView {
    
    enum Orientation {
        case Horizontal
        case Vertical
    }
    
    private struct SizeRatio {
        
        static var cornerRadiusToBoundsHeight: CGFloat {
            return 0.06
        }
        
        static var imageOffsetToBounds: CGFloat {
            return 0.25
        }
        
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
}
