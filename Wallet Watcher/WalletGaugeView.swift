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
	
	//@Query private var wallet: [Wallet]
	let wallet :Wallet

	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
	//@State var budget = 150.00 //set to default later in defaulter
	//@State var spent = 0.00
	
	let defaults = UserDefaults.standard
	/*
	private func defaulter(){
		budget = defaults.double(forKey: "budget")
	}
	*/
	
    var body: some View {
		
		Gauge(value: wallet.spent, in: 0...wallet.budget) {
			Text("Wallet")
		} currentValueLabel: {
			Text("Spent: $" + String(format:"%.2f", wallet.spent))
				.font(.title2.monospacedDigit())
		} minimumValueLabel: {
			Text("0")
				.font(.caption2.monospaced())
		} maximumValueLabel: {
			Text("$" + String(format:"%.2f", wallet.budget))
				.font(.caption2.monospaced())
		}
		.gaugeStyle(DefaultGaugeStyle())
		.tint(.green)
		.onAppear(){
		}
    }
}

#Preview {
	WalletGaugeView(wallet: Wallet(spent: 23.00, budget: 250.0))
		.modelContainer(for: [Expense.self, QuickExpense.self, Wallet.self], inMemory: true)
}
