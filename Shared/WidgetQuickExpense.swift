//
//  WidgetQuickExpense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/28/23.
//

import Foundation
import SwiftData
import WidgetKit

// defines a widget quick expense, which allows user to select a button for a widget
@Model
final class WidgetQuickExpense{ // needs to conform to _IntentValue
	var spent: Double
	var budget: Double
	
	init(spent: Double, budget: Double) {
		self.spent = spent
		self.budget = budget
	}
}
