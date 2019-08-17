//
//  MyGrid.swift
//  Set
//
//  Created by CS193p Instructor.
//  Modified by Vladislav Tarasevich on 24/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import Foundation
import UIKit

struct BoardGrid {
    
    // MARK: - Types
    
    enum Layout {
        case fixedCellSize(CGSize)
        case dimensions(rowCount: Int, columnCount: Int)
        case aspectRatio(CGFloat)
    }
    
    // MARK: - Properties
    
    var layout: Layout { didSet { recalculate() } }
    
    var frame: CGRect { didSet { recalculate() } }
    
    // MARK: - Computed properties
    
    var cellSize: CGSize {
        get { return cellFrames.first?.size ?? CGSize.zero }
        set { layout = .fixedCellSize(newValue) }
    }
    
    var dimensions: (rowCount: Int, columnCount: Int) {
        get { return calculatedDimensions }
        set { layout = .dimensions(rowCount: newValue.rowCount, columnCount: newValue.columnCount) }
    }
    
    var aspectRatio: CGFloat {
        get {
            switch layout {
            case .aspectRatio(let aspectRatio):
                return aspectRatio
            case .fixedCellSize(let size):
                return size.height > 0 ? size.width / size.height : 0.0
            case .dimensions(let rowCount, let columnCount):
                if rowCount > 0 && columnCount > 0 && frame.size.width > 0 {
                    return (frame.size.width / CGFloat(columnCount)) / (frame.size.width / CGFloat(rowCount))
                } else {
                    return 0.0
                }
            }
        }
        set { layout = .aspectRatio(newValue) }
    }
    
    var cellCount: Int {
        get {
            switch layout {
            case .aspectRatio: return cellCountForAspectRatioLayout
            case .fixedCellSize, .dimensions: return calculatedDimensions.rowCount * calculatedDimensions.columnCount
            }
        }
        set { cellCountForAspectRatioLayout = newValue }
    }

    
    // MARK: - Init
    
    init(layout: Layout, frame: CGRect = CGRect.zero) {
        self.frame = frame
        self.layout = layout
        recalculate()
    }
    
    // MARK: - Subscripts
    
    subscript(row: Int, column: Int) -> CGRect? {
        return self[row * dimensions.columnCount + column]
    }
    
    subscript(index: Int) -> CGRect? {
        return index < cellFrames.count ? cellFrames[index] : nil
    }
    
    // MARK: - Private properties
    
    private var cellFrames = [CGRect]()
    
    private var cellCountForAspectRatioLayout = 0 { didSet { recalculate() } }
    
    private var calculatedDimensions: (rowCount: Int, columnCount: Int) = (0, 0)
    
    private mutating func recalculate() {
        switch layout {
        case .fixedCellSize(let cellSize):
            if cellSize.width > 0 && cellSize.height > 0 {
                calculatedDimensions.rowCount = Int(frame.size.height / cellSize.height)
                calculatedDimensions.columnCount = Int(frame.size.width / cellSize.width)
                updateCellFrames(to: cellSize)
            } else {
                assert(false, "Grid: for fixedCellSize layout, cellSize height and width must be positive numbers")
                calculatedDimensions = (0, 0)
                cellFrames.removeAll()
            }
        case .dimensions(let rowCount, let columnCount):
            if columnCount > 0 && rowCount > 0 {
                calculatedDimensions.rowCount = rowCount
                calculatedDimensions.columnCount = columnCount
                let cellSize = CGSize(width: frame.size.width/CGFloat(columnCount), height: frame.size.height/CGFloat(rowCount))
                updateCellFrames(to: cellSize)
            } else {
                assert(false, "Grid: for dimensions layout, rowCount and columnCount must be positive numbers")
                calculatedDimensions = (0, 0)
                cellFrames.removeAll()
            }
        case .aspectRatio:
            assert(aspectRatio > 0, "Grid: for aspectRatio layout, aspectRatio must be a positive number")
            let cellSize = largestCellSizeThatFitsAspectRatio()
            if cellSize.area > 0 {
                calculatedDimensions.columnCount = Int(frame.size.width / cellSize.width)
                calculatedDimensions.rowCount = (cellCount + calculatedDimensions.columnCount - 1) / calculatedDimensions.columnCount
            } else {
                calculatedDimensions = (0, 0)
            }
            updateCellFrames(to: cellSize)
            break
        }
    }
    
    private mutating func updateCellFrames(to cellSize: CGSize) {
        cellFrames.removeAll()
        
        let cellsBounds = CGSize(width: CGFloat(dimensions.columnCount) * cellSize.width,
                                 height: CGFloat(dimensions.rowCount) * cellSize.height
        )
        
        let offset = (
            dx: (frame.size.width - cellsBounds.width) / 2,
            dy: (frame.size.height - cellsBounds.height) / 2
        )
        
        var origin = CGPoint(x: frame.origin.x + offset.dx,
                             y: frame.origin.y + offset.dy)
        
        if cellCount > 0 {
            
            for _ in 0..<cellCount {
                cellFrames.append(CGRect(origin: origin, size: cellSize))
                origin.x += cellSize.width
                
                if round(origin.x) > round(frame.maxX - cellSize.width) {
                    origin.x = frame.origin.x + offset.dx
                    origin.y += cellSize.height
                }
                
            }

        }
        
    }
    
    private func largestCellSizeThatFitsAspectRatio() -> CGSize {
        var size = CGSize.zero
        
        if cellCount > 0 && aspectRatio > 0 {
            for rowCount in 1...cellCount {
                size = cellSizeAssuming(rowCount: rowCount, minimumAllowedSize: size)
            }
            for columnCount in 1...cellCount {
                size = cellSizeAssuming(columnCount: columnCount, minimumAllowedSize: size)
            }
            
        }
        return size
    }
    
    
    private func cellSizeAssuming(rowCount: Int? = nil,
                                  columnCount: Int? = nil,
                                  minimumAllowedSize: CGSize = CGSize.zero) -> CGSize {
        var size = CGSize.zero
        if let rowCount = rowCount {
            size.height = frame.size.height / CGFloat(rowCount)
            size.width = frame.size.width * aspectRatio
        } else if let columnCount = columnCount {
            size.width = frame.size.width / CGFloat(columnCount)
            size.height = size.width / aspectRatio
        }
        
        if size.area > minimumAllowedSize.area {

            if Int(frame.size.height / size.height) * Int(frame.size.width / size.width) >= cellCount {
                return size
            }

        }
        return minimumAllowedSize
    }

}

private extension CGSize {
    
    var area: CGFloat {
        return width * height
    }
    
}
