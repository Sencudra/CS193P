//
//  SymbolVIew.swift
//  Set
//
//  Created by Vlad Tarasevich on 07/07/2019.
//  Copyright © 2019 Vlad Tarasevich. All rights reserved.
//

import Foundation
import UIKit

class SymbolView: UIView {
    
    // MARK: - Private properties
    
    private let symbol: Symbol
    private let filling: Filling
    private let color: UIColor
    
    private var orientation: CardView.Orientation {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Initializers
    
    init(frame: CGRect, symbol: Symbol, filling: Filling, color: UIColor) {
        self.symbol = symbol
        self.color = color
        self.filling = filling
        self.orientation = .Horizontal
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
    }
    
    // No need to use this init, as view is created completely programmatically
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("SymbolView: required init?(coder aDecoder: NSCoder) not implemented!")
    }
    
    // MARK: - Overrides
    
    override func draw(_ rect: CGRect) {
        color.setFill()
        color.setStroke()
        createPath()
    }
    
    // MARK: - Public methods
    
    public func setOrientation(as orientation: CardView.Orientation) {
        self.orientation = orientation
    }
    
    // MARK: - Private methods
    
    private func createPath() {
        let path = symbol.createPath()
    
        adjustOrientation(of: path)
        adjustScale(of: path)
        adjustPosition(of: path)
        
        path.lineWidth = lineWidth
        path.stroke()
        
        setFilling(for: path)
    }
    
    private func getBoundsDifferenceToView(of path: UIBezierPath) -> (diffX: CGFloat, diffY: CGFloat) {
        return (bounds.size.width - path.bounds.size.width, bounds.size.height - path.bounds.size.height)
    }
    
    private func adjustScale(of path: UIBezierPath) {
        var scale: CGFloat
        let (diffX, diffY) = getBoundsDifferenceToView(of: path)
        if diffX < diffY {
            scale = Ratio.pathBoundsToBoundSize * bounds.size.width / path.bounds.size.width
        } else {
            scale = Ratio.pathBoundsToBoundSize * bounds.size.height / path.bounds.size.height
        }
        path.apply(CGAffineTransform(scaleX: scale, y: scale))
    }
    
    private func adjustPosition(of path: UIBezierPath) {
        let (diffX, diffY) = getBoundsDifferenceToView(of: path)
        path.apply(CGAffineTransform(translationX: path.bounds.minX, y: path.bounds.minY).inverted())
        path.apply(CGAffineTransform(translationX: diffX / 2, y: diffY / 2))
    }
    
    private func adjustOrientation(of path: UIBezierPath) {
    
        if orientation == .Vertical {
            let pathCenter = CGPoint(x: path.bounds.midX, y: path.bounds.midY)
            path.apply(CGAffineTransform(translationX: pathCenter.x, y: pathCenter.y).inverted())
            path.apply(CGAffineTransform(rotationAngle: CGFloat.pi/2))
            path.apply(CGAffineTransform(translationX: pathCenter.x, y: pathCenter.y))
        }

    }
    
    private func setFilling(for path: UIBezierPath) {
        switch filling {
        case .Full:
            color.setFill()
            path.fill()
        case .Partly:
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            path.addClip()
            stripe()
            context?.restoreGState()
        case .None:
            break
        }
    }
    
    private  func stripe() {
        let stripe = UIBezierPath()
        let dashes: [CGFloat] = [2, 6]
        stripe.setLineDash(dashes, count: dashes.count, phase: 0.0)
        
        stripe.lineWidth = bounds.size.height
        stripe.lineCapStyle = .butt
        stripe.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
        stripe.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        stripe.stroke()
    }
    
}

// MARK: - Extension SymbolView

extension SymbolView {
    
    enum Filling {
        case Full
        case Partly
        case None
    }
    
    enum Symbol: Int {
        
        case Rhombus
        case RoundedRectangle
        case Wave
        
        // MARK: - Symbol functions
        
        func createPath() -> UIBezierPath{
            
            switch self {
            case .Rhombus:
                return createRhombusPath()
            case .RoundedRectangle:
                return createRoundedRectanglePath()
            case .Wave:
                return createWavePath()
            }

        }
        
        // MARK: - Symbol private functions
        
        private func createRoundedRectanglePath() -> UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 210.0, y: 0.0))
            path.addLine(to: CGPoint(x: 63.0, y: 0.0))
            path.addArc(withCenter: CGPoint(x: 63.0, y: 63.0), radius: CGFloat(63.0), startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
            path.addLine(to: CGPoint(x: 210.0, y: 126.0))
            path.addArc(withCenter: CGPoint(x: 210.0, y: 63.0), radius: CGFloat(63.0), startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
            path.close()
            return path
        }
        
        private func createWavePath() -> UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 24.0, y: 130.0))
            path.addCurve(to: CGPoint(x: 0.0, y: 80.0), controlPoint1: CGPoint(x: 24.0, y: 130.0), controlPoint2: CGPoint(x: 0.0, y: 131.0))
            path.addCurve(to: CGPoint(x: 66.0, y: 7.0), controlPoint1: CGPoint(x: 0.0, y: 29.0), controlPoint2: CGPoint(x: 38.0, y: 7.0))
            path.addCurve(to: CGPoint(x: 159.0, y: 30.0), controlPoint1: CGPoint(x: 98.0, y: 7.0), controlPoint2: CGPoint(x: 133.5, y: 30.0))
            path.addCurve(to: CGPoint(x: 234.0, y: 0.0), controlPoint1: CGPoint(x: 199.0, y: 30.0), controlPoint2: CGPoint(x: 219.0, y: 0.0))
            path.addCurve(to: CGPoint(x: 257.0, y: 35.0), controlPoint1: CGPoint(x: 249.0, y: 0.0), controlPoint2: CGPoint(x: 257.0, y: 17.0))
            path.addCurve(to: CGPoint(x: 169.0, y: 119.0), controlPoint1: CGPoint(x: 257.0, y: 53.0), controlPoint2: CGPoint(x: 247.0, y: 119.0))
            path.addCurve(to: CGPoint(x: 96.0, y: 101.0), controlPoint1: CGPoint(x: 136.0, y: 119.0), controlPoint2: CGPoint(x: 127.0, y: 101.0))
            path.addCurve(to: CGPoint(x: 24.0, y: 130.0), controlPoint1: CGPoint(x: 53.0, y: 101.0), controlPoint2: CGPoint(x: 45.0, y: 130.0))
            path.close()
            return path
        }
        
        private func createRhombusPath() -> UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 275, y: 68.0))
            path.addLine(to: CGPoint(x: 137.5, y: 135.71))
            path.addLine(to: CGPoint(x: 0.0, y: 68.0))
            path.addLine(to: CGPoint(x: 137.5, y: 0.0))
            path.addLine(to: CGPoint(x: 275.0, y: 68.0))
            path.close()
            return path
        }
        
    }
    
    // MARK: - Ratio
    
    private struct Ratio {
    
        static var lineWidthToBoundsSize: CGFloat {
            return 0.015
        }
        
        static var pathBoundsToBoundSize: CGFloat {
            return 0.9
        }
        
    }
    
    private var lineWidth: CGFloat {
        return Ratio.lineWidthToBoundsSize * min(bounds.size.width, bounds.size.height)
    }

}
