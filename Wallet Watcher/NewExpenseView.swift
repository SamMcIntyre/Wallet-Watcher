//
//  NewExpenseView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import Combine

struct NewExpenseView: View {
	@State private var value = ""
	@State private var grat = "18"
	@State private var tax = "0"
	
	let gratTaxLimit = 2
	
	private let numberFormatter: NumberFormatter
	init() {
		  numberFormatter = NumberFormatter()
		  numberFormatter.numberStyle = .currency
		  numberFormatter.maximumFractionDigits = 2
	}
	
    var body: some View {
		VStack{
			Text("New Expense").font(.title)
			HStack{
				Spacer()
				TextField("$0.00", text: $value)
					.keyboardType(.decimalPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(width: 200)
					.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.monospaced())
					.onSubmit() {
						enterExpense(amountStr:value, gratStr: grat, taxStr: tax)
					}
				Spacer()
			}
			HStack{
				Button("Enter", action: {enterExpense(amountStr:value, gratStr: grat, taxStr: tax)})
					.font(.title)
					.buttonStyle(BorderedProminentButtonStyle())
					.keyboardType(.numberPad)
			}
			HStack{
				Spacer()
				VStack{
					HStack{
						Spacer()
						TextField("00", text: $grat)
							.onReceive(Just(grat), perform: { _ in
								limitText(gratTaxLimit)
							})
							.frame(minWidth: 20, idealWidth: 50, maxWidth: 50)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.keyboardType(.numberPad)
						Text("%")
						Spacer()
					}
					Text("Gratuity")
				}
				Spacer()
				VStack{
					HStack{
						Spacer()
						TextField("00", text: $tax)
							.onReceive(Just(grat), perform: { _ in
								limitText(gratTaxLimit)
							})
							.frame(minWidth: 20, idealWidth: 50, maxWidth: 50)
							.textFieldStyle(RoundedBorderTextFieldStyle())
						Text("%")
						Spacer()
					}
					Text("Tax")
				}
				Spacer()
			}
			Spacer()
		}
    }
	
	private func enterExpense(amountStr: String, gratStr: String, taxStr: String) {
		print(amountStr)
		guard let amount = Double(amountStr) else { return }
		let cleanStr = String(format: "%.2f", amount)
		let cleanAmount = Double(cleanStr)
		print(cleanAmount!)
	}
	//Function to keep text length in limits
	private func limitText(_ upper: Int) {
		if grat.count > upper {
			grat = String(grat.prefix(upper))
		}
		if tax.count > upper {
			tax = String(tax.prefix(upper))
		}
	}
}

#Preview {
    NewExpenseView()
}
