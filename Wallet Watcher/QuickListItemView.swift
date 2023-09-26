//
//  QuickListItemView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

struct QuickListItemView: View {
	let quickExpense: QuickExpense
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	@Query private var wallet: [Wallet]
	@Query private var expenses: [Expense]
	
    var body: some View {
		Button(action: {quickEnterExpense(newExpense: quickExpense.returnNewExpense())}) {
			HStack{
				//price
				Text("$" + quickExpense.formattedPrice).monospaced()
				Spacer()
				VStack{
					//grat and tax
					Text("Grat: " + String(Int(quickExpense.gratuity * 100)) + "%").font(.caption)
					Text(" Tax: " + String(Int(quickExpense.tax * 100)) + "%").font(.caption)
				}
				Spacer()
				VStack{
					//purpose and location
					Text(quickExpense.purpose).font(.caption)
					Text("at " + quickExpense.location).font(.caption)
				}
			}
		}
		.buttonStyle(.automatic)

	}
	
	private func quickEnterExpense(newExpense: Expense){
		//enter new expense
		modelContext.insert(newExpense)
		
		//update wallet
		wallet[0].spent += newExpense.total
		do {
			try modelContext.save()
		} catch {
			print(error.localizedDescription)
		}
		dismiss()
	}
    
}

#Preview {
	QuickListItemView(quickExpense: QuickExpense(price: 20.0, grat: 0.18, tax: 0.0, purpose: "default purp", location: "default loc"))
		.modelContainer(for: [Expense.self, QuickExpense.self, Wallet.self], inMemory: true)
}
