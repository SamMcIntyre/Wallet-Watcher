//
//  ExpenseListItemView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI

struct ExpenseListItemView: View {
	let expense:Expense
	
    var body: some View {
		NavigationLink(
			destination: ExpenseDetailView(expense: expense)){
				HStack{
					Text("-$" + expense.formattedTotal).monospaced()
					Spacer()
					Text(expense.purpose).font(.caption)
				}
			}
    }
}

#Preview {
	ExpenseListItemView(expense: Expense(price: 69.69))
}
