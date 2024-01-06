//
//  WalletGaugeView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI

struct WalletGaugeView: View {
	let wallet :Wallet
	
	let defaults = UserDefaults.standard
	
    var body: some View {
		HStack{
			Spacer()
			
			Gauge(value: wallet.spent > wallet.budget ? wallet.budget : wallet.spent, in: 0...wallet.budget) {
				Image("WalletWatcher_logo")
					.resizable(resizingMode: .stretch)
					.aspectRatio(contentMode: .fill)
					.frame(width: 50, height: 50
					)
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
			.tint(.wwDarkGreen)
			
			Spacer()
		}
    }
}

#Preview {
	WalletGaugeView(wallet: Wallet(spent: 23.00, budget: 250.0))
		.modelContainer(for: [Expense.self, QuickExpense.self, Wallet.self], inMemory: true)
}
