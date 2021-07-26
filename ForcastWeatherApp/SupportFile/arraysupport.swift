//
//  arraysupport.swift
//  WeatherApp
//
//  Created by Hamed Amiry on 17.12.2020.
//

import Foundation
extension Array {
    public func object(at index: Int) -> Element? {
        guard index < self.count, index >= 0 else { return nil }
        return self[index]
    }
}

