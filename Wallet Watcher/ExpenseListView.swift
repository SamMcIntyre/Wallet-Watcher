//
//  ExpenseListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI

struct ExpenseListView: View {
	let expenses:[Expense]
	
    var body: some View {
		NavigationStack{
			List{
				ForEach(expenses) { expense in
					NavigationLink(
						destination: ExpenseDetailView(expense: expense)){
						HStack{
							Text("-$" + expense.formattedTotal)
							Text("   " + expense.purpose)
						}
					}
				}
			}
		}
    }
}

#Preview {
	ExpenseListView(expenses: [Expense(price: 6.90, purpose: "Drink"), Expense(price: 69.25)])
}
