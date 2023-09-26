//
//  Setting.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import Foundation
import SwiftData

@Model
final class Setting{
	var defaultGrat: Double
	var defaultTax: Double
	var budget: Double
	
	init(){
		self.defaultGrat = 0.18
		self.defaultTax = 0.00
		self.budget = 200.00
	}
	init(defaultGrat: Double, defaultTax: Double, budget: Double) {
		self.defaultGrat = defaultGrat
		self.defaultTax = defaultTax
		self.budget = budget
	}
}
