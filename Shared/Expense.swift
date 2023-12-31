//
//  Expense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import Foundation
import SwiftData

//Defines an expense, which is the most basic piece of data in the system. Objects of this type build up the app.
@Model
class Expense{
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
	
	init(price: Double) {
		//for a quick init for testing purposes
		let tax = 0.0
		let grat = 0.18
		let totalPrice = price + (price*grat) + (price*tax)
		
		self.price = price
		self.tax = tax
		self.gratuity = grat
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", price)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = "default purpose."
		self.location = "default location."
	}
}
