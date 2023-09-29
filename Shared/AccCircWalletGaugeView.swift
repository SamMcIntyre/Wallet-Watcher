//
//  SmallWalletGaugeView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/28/23.
//

import SwiftUI

struct AccCircWalletGaugeView: View {
	let wallet :Wallet
	
	let defaults = UserDefaults.standard
	
	var body: some View {
		HStack{
			Spacer()
			
			VStack{
				Gauge(value: wallet.spent, in: 0...wallet.budget) {
					//Image("WalletWatcher_logo")
					//	.resizable(resizingMode: .stretch)
					//	.aspectRatio(contentMode: .fill)
					//	.frame(width: 50, height: 50
					//	)
				} currentValueLabel: {
					Text("$" + String(format:"%.2f", wallet.spent))
						.font(.caption.monospacedDigit())
				}
				.gaugeStyle(.accessoryCircular)
			}
			
			Spacer()
		}
	}
}

#Preview {
	AccCircWalletGaugeView(wallet: Wallet(spent: 25.24, budget: 200.00))
}
