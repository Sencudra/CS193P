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
    
    var symbol: Symbol = .Rhombus { didSet { setNeedsLayout(); setNeedsDisplay() } }
    var color: UIColor = UIColor.SymbolColor.purple { didSet { setNeedsLayout(); setNeedsDisplay() } }
    var filling: Filling = .Partly { didSet { setNeedsLayout(); setNeedsDisplay() } }
    
    // MARK: - Overrides
    
    override func draw(_ rect: CGRect) {
        createPath()
    }
    
    // MARK: - Private methods
    
    private func createPath() {
        color.setFill()
        color.setStroke()
        
        let path = symbol.createPath()
        
        // Adjust path scale
        var scale: CGFloat
        var diff_x: CGFloat { return bounds.size.width - path.bounds.size.width }
        var diff_y: CGFloat { return bounds.size.height - path.bounds.size.height }
        if diff_x < diff_y {
            scale = Ratio.pathBoundsToBoundSize * bounds.size.width / path.bounds.size.width
        } else {
            scale = Ratio.pathBoundsToBoundSize * bounds.size.height / path.bounds.size.height
        }
        path.apply(CGAffineTransform(scaleX: scale, y: scale))
        
        // Adjust position
        let offset_x = diff_x / 2
        let offset_y = diff_y / 2
        path.apply(CGAffineTransform(translationX: offset_x, y: offset_y))
        
        path.lineWidth = lineWidth
        path.stroke()
        
        setFilling(for: path)
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

// MARK: - Extension SymbolVIew

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
        
        // MARK: - Methods
        
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
        
        // MARK: - Private functions
        
        private func createRoundedRectanglePath() -> UIBezierPath {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 210.0, y: 5.0))
            path.addLine(to: CGPoint(x: 63.0, y: 5.0))
            path.addArc(withCenter: CGPoint(x: 63.0, y: 68.0), radius: CGFloat(63.0), startAngle: 3*CGFloat.pi/2, endAngle: CGFloat.pi/2, clockwise: false)
            path.addLine(to: CGPoint(x: 210.0, y: 131.0))
            path.addArc(withCenter: CGPoint(x: 210.0, y: 68.0), radius: CGFloat(63.0), startAngle: CGFloat.pi/2, endAngle: 3*CGFloat.pi/2, clockwise: false)
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
