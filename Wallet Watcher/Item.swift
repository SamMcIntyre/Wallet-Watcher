//
//  Item.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
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
