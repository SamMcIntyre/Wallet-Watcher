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
	
	@Query private var expenses: [Expense]
	
	@State var showingNewExpensePopover = false
	
    var body: some View {
		NavigationStack{
			GroupBox(label: Text("Recent Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
				List{
					ForEach(expenses) { expense in
						NavigationLink(
							destination: ExpenseDetailView(expense: expense)){
								HStack{
									Text("-$" + expense.formattedTotal).monospaced()
									Spacer()
									Text(expense.purpose).font(.caption)
								}
							}
					}
					.onDelete(perform: deleteExpense)
					NavigationLink(destination: FullExpenseListView()){
						Text("View more").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
					}.tint(.gray)
				}.listStyle(.plain)
			}
		}
    }
	
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
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
