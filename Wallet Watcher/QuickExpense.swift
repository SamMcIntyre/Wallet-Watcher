//
//  QuickExpense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation
import SwiftData

@Model
final class QuickExpense{
	var expense:Expense
	
	init(expense: Expense){
		self.expense = expense
	}
	
	init(){
		self.expense = Expense(price: 0.00)
	}
}
