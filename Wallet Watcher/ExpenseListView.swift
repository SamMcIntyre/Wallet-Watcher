//
//  ExpenseListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
	@Environment(\.modelContext) private var modelContext
	
	//@Query(filter: #Predicate<Expense> {$0.hasChanges})
	@Query private var wallets: [Wallet]
	@Query private var expenses: [Expense]
	
	@State var showingNewExpensePopover = false
	
    var body: some View {
		ShortExpenseListView()
    }
	
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				wallets[0].spent -= expenses[index].total
				modelContext.delete(expenses[index])
			}
		}
	}
}

#Preview {
	//ExpenseListView(expenses: [Expense(price: 6.90, purpose: "Drink"), Expense(price: 69.25)])
	ExpenseListView()
		.modelContainer(for: Expense.self, inMemory: true)
}
