//
//  AccRectWalletGaugeView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/28/23.
//

import SwiftUI

struct AccRectWalletGaugeView: View {
	let wallet :Wallet
	
	let defaults = UserDefaults.standard
	
	var body: some View {
		HStack{
			Spacer()
			
			VStack{
				Gauge(value: wallet.spent, in: 0...wallet.budget) {
				} currentValueLabel: {
					Text("$" + String(format:"%.2f", wallet.spent))
						.font(.caption.monospacedDigit())
				} minimumValueLabel: {
					Text("")
					 .font(.caption2.monospaced())
				 } maximumValueLabel: {
					 Text("$" + String(format:"%.2f", wallet.budget))
						 .font(.caption2.monospaced())
				 }
				.gaugeStyle(.accessoryLinear)
				.tint(.wwDarkGreen)
				Text("$" + String(format:"%.2f", wallet.spent))
					.font(.subheadline.monospacedDigit())
			}
			
			Spacer()
		}
	}
}

#Preview {
	AccRectWalletGaugeView(wallet: Wallet(spent: 25.24, budget: 200.00))
}
