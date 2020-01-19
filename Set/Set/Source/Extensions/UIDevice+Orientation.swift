//
//  UIDevice+Orientation.swift
//  Set
//
//  Created by Vladislav Tarasevich on 25/07/2019.
//  Copyright © 2019 Vladislav Tarasevich. All rights reserved.
//

import UIKit

extension UIDevice {
    
    enum Orientation {
        
        case Landscape
        case Portrait
        
        static var isLandscape: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.statusBarOrientation.isLandscape
        }
        
        static var isPortrait: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.statusBarOrientation.isPortrait
        }
        
    }
    
}
