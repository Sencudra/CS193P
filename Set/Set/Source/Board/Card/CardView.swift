//
//  CardView.swift
//  Set
//
//  Created by Vladislav Tarasevich on 06/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

class CardView: UIView {

    // MARK: - Private Properties

    private let symbolViews: [SymbolView]

    // MARK: - Initializers

    init(symbolViews: [SymbolView]) {
        self.symbolViews = symbolViews
        super.init(frame: .zero)
        
        backgroundColor = UIColor.clear
    }

    // No need to use this init, as view is created completely programmatically
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("CardView: required init?(coder aDecoder: NSCoder) not implemented!")
    }

    // MARK: - Overrides

    override func draw(_ rect: CGRect) {
        UIColor.white.setFill()
        setRoundedClip()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutSymbolViews()
    }

    // MARK: - Private methods
    
    private func setRoundedClip() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        roundedRect.fill()
    }

    private func layoutSymbolViews() {
        let width = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.width
        let height = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.height / CGFloat(symbolViews.count)
        let offsetX = (bounds.size.width - width) / 2
        let offsetY = (bounds.size.height - height * CGFloat(symbolViews.count)) / 2

        for (index, symbolView) in symbolViews.enumerated() {
            let x = offsetX
            let y = offsetY + (CGFloat(index) * height)
            symbolView.frame = CGRect(x: x, y: y, width: width, height: height)
        }

    }

}

// MARK: - Extension CardView

extension CardView {

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
