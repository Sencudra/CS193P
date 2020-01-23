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

        case landscape
        case portrait

        static var isLandscape: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isLandscape
                : UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
        }

        static var isPortrait: Bool {
            return UIDevice.current.orientation.isValidInterfaceOrientation
                ? UIDevice.current.orientation.isPortrait
                : UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? false
        }

    }

}
