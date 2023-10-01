//
//  SmallWalletGaugeView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/28/23.
//

import SwiftUI

struct SmallWalletGaugeView: View {
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
				.tint(.wwLightGreen)
				.scaleEffect(CGSize(width: 2.0, height: 2.0))
				.padding(.top)

				Text("$" + String(format:"%.2f", wallet.budget))
					.font(.caption2.monospaced())
			}
			.frame(width: 200, height: 200)
			
			Spacer()
		}
	}
}

#Preview {
	SmallWalletGaugeView(wallet: Wallet(spent: 25.24, budget: 200.00))
}
