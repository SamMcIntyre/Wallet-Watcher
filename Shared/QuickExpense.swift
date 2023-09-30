//
//  QuickExpense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import Foundation
import SwiftData

//defines a quick expense, which allows users to re-add an Expense very quickly
//complies to Sendable but for some reason the compiler still throws a warning if not marked unchecked
@Model
final class QuickExpense: @unchecked Sendable{
	let price: Double
	let formattedPrice: String
	let tax: Double
	let gratuity: Double
	let total: Double
	let formattedTotal: String
	let timestamp: Date
	let purpose: String
	let location: String
	
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
	
	// EZ default initializer for debug purposes
	init(price:Double){
		self.price = price
		self.tax = 0.03
		self.gratuity = 0.18
		let totalPrice = price + (price*0.18) + (price*0.03)
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", price)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = "Basic Purpose"
		self.location = "Basic Location"
	}
	
	//function to return its saved expense as a brand new Expense object
	func returnNewExpense() -> Expense{
		let newExpense = Expense(price: price, grat: gratuity, tax: tax, purpose: purpose, location: location)
		return newExpense
	}
}
