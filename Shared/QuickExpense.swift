//
//  QuickExpense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation
import SwiftData

//defines a quick expense, which allows users to re-add an Expense very quickly
@Model
final class QuickExpense{
	var price: Double
	var formattedPrice: String
	var tax: Double
	var gratuity: Double
	var total: Double
	var formattedTotal: String
	var timestamp: Date
	var purpose: String
	var location: String
	
	init(price: Double, grat: Double, tax: Double, purpose: String, location: String){
		self.price = price
		self.tax = tax
		self.gratuity = grat
		let totalPrice = price + (price*grat) + (price*tax)
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", price)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = purpose
		self.location = location
	}
	
	//function to return its saved expense as a brand new Expense object
	func returnNewExpense() -> Expense{
		let newExpense = Expense(price: price, grat: gratuity, tax: tax, purpose: purpose, location: location)
		return newExpense
	}
}
