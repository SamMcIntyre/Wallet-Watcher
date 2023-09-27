//
//  Wallet.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation
import SwiftData

// Defines a wallet, which keeps track of the budget and how much has been spent
@Model
final class Wallet{
	var spent: Double
	var budget: Double
	
	init(spent: Double, budget: Double) {
		self.spent = spent
		self.budget = budget
	}
}
