//
//  WalletGaugeView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

struct WalletGaugeView: View {
	@Environment(\.modelContext) private var modelContext

	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
	@State var budget = 150.00 //set to default later in defaulter
	@State var spent = 0.00
	
	let defaults = UserDefaults.standard
	
	private func defaulter(){
		budget = defaults.double(forKey: "budget")
	}
	
	func refreshSpent(){
		spent = 0
		for expense in expenses {
			spent += expense.price
		}
	}
	
	
    var body: some View {
		
		Gauge(value: spent, in: 0...budget) {
			Text("Wallet")
		} currentValueLabel: {
			Text("Spent: $" + String(format:"%.2f", spent))
				.font(.title2.monospacedDigit())
		} minimumValueLabel: {
			Text("0")
				.font(.caption2.monospaced())
		} maximumValueLabel: {
			Text("$" + String(format:"%.2f", budget))
				.font(.caption2.monospaced())
		}
		.gaugeStyle(DefaultGaugeStyle())
		.tint(.green)
		.onAppear(){
			defaulter()
			refreshSpent()
		}
    }
}

#Preview {
    WalletGaugeView()
}
