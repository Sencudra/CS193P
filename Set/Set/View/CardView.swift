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
    
    // MARK: - Properties
    
    var numberOfSymbols: Int = 3 { didSet { setNeedsLayout(); setNeedsDisplay() } }
    
    var isHorizontal = false
    
    private lazy var symbolViews = isHorizontal ? createSymbolViewsHorizontal() : createSymbolViewsVertical()
    
    // MARK: - Overrides
    
    override func draw(_ rect: CGRect) {
        prepareCard()
        
        for _ in symbolViews {
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        symbolViews = isHorizontal ? createSymbolViewsHorizontal() : createSymbolViewsVertical()
    }
    
    // MARK: - Private methods
    
    private func clearAllSubviews() {
        for subView in self.subviews as [UIView] {
            subView.removeFromSuperview()
        }
    }
    
    private func update() {
        setNeedsLayout(); setNeedsDisplay()
    }
    
    private func createSymbolViewsVertical() -> [SymbolView] {
        print(bounds.size.width, bounds.size.height)
        clearAllSubviews()
        
        let width = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.width
        let height = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.height / CGFloat(numberOfSymbols)
        let offsetX = (bounds.size.width - width) / 2
        let offsetY = (bounds.size.height - height * CGFloat(numberOfSymbols)) / 2
        
        let symbolViews = Array(0..<numberOfSymbols).map { index -> SymbolView in
            let x = offsetX
            let y = offsetY + (CGFloat(index) * height)
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let view = SymbolView(frame: frame)
            view.backgroundColor = UIColor.clear
            addSubview(view)
            return view
        }
        return symbolViews
    }
    
    private func createSymbolViewsHorizontal() -> [SymbolView] {

        clearAllSubviews()
        
        let width = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.width / CGFloat(numberOfSymbols)
        let height = (1 - SizeRatio.imageOffsetToBounds) * bounds.size.height
        
        let offsetX = (bounds.size.width - width * CGFloat(numberOfSymbols)) / 2
        let offsetY = (bounds.size.height - height) / 2
        
        let symbolViews = Array(0..<numberOfSymbols).map { index -> SymbolView in
            let x = offsetX + (CGFloat(index) * width)
            let y = offsetY
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let view = SymbolView(frame: frame)
            view.backgroundColor = UIColor.clear
            addSubview(view)
            return view
        }
        return symbolViews
    }
    
    private func prepareCard() {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 10)
        roundedRect.addClip()
        UIColor.white.setFill()
        roundedRect.fill()
    }
    
}

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

extension CGRect {
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
    
}
