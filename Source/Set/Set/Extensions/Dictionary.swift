//
//  Dictionary.swift
//  Graphical Set
//
//  Created by Vladislav Tarasevich on 26.01.2020.
//  Copyright © 2020 Vladislav Tarasevich. All rights reserved.
//

extension Dictionary where Value: Equatable {

    func key(for value: Value) -> Key? {
        return first { $0.1 == value }?.0
    }

}
