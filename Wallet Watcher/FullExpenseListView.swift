//
//  FullExpenseListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import SwiftData

struct FullExpenseListView: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query private var wallets: [Wallet]
	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
	var body: some View {
		NavigationStack{
			GroupBox(label: Text("All Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
				List{
					ForEach(expenses) { expense in
						ExpenseListItemView(expense: expense)
					}.onDelete(perform: deleteExpense)
				}.listStyle(.plain)
			}.toolbar{
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
			}
		}
	}
	
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(expenses[index])
				wallets[0].spent -= expenses[index].total
			}
		}
	}
}

#Preview {
    FullExpenseListView()
		.modelContainer(for: Expense.self, inMemory: true)
}
