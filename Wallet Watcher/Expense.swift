//
//  Expense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import Foundation
import SwiftData

@Model
final class Expense{
	var price: Double
	var formattedPrice: String
	var tax: Double
	var gratuity: Double
	var total: Double
	var formattedTotal: String
	var timestamp: Date
	var purpose: String
	var location: String
	
	init(price: Double) {
		let tax = 0.0
		let gratuity = 0.18
		let taxedPrice = price + (price*tax)
		let totalPrice = taxedPrice + (taxedPrice*gratuity)
		
		self.price = price
		self.tax = tax
		self.gratuity = gratuity
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", price)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = "default purpose."
		self.location = "default location."
	}
	
	init(price: Double, purpose: String) {
		let tax = 0.0
		let gratuity = 0.18
		let taxedPrice = price + (price*tax)
		let totalPrice = taxedPrice + (taxedPrice*gratuity)
		
		self.price = price
		self.tax = tax
		self.gratuity = gratuity
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", totalPrice)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = purpose
		self.location = "default location."
	}
	
	init(price: Double, purpose: String, location: String) {
		let tax = 0.0
		let gratuity = 0.18
		let taxedPrice = price + (price*tax)
		let totalPrice = taxedPrice + (taxedPrice*gratuity)
		
		self.price = price
		self.tax = tax
		self.gratuity = gratuity
		self.total = totalPrice
		self.formattedPrice = String(format: "%.2f", totalPrice)
		self.formattedTotal = String(format: "%.2f", totalPrice)
		self.timestamp = Date()
		self.purpose = purpose
		self.location = location
	}
}
