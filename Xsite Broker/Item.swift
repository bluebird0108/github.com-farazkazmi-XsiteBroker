//
//  Item.swift
//  Xsite Broker
//
//  Created by Faraz on 18/10/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
