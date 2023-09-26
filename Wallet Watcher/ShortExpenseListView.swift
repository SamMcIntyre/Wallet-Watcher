//
//  ShortListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

struct ShortExpenseListView: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
    var body: some View {
		NavigationStack{
					GroupBox(label: Text("Recent Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
						List{
							ForEach(expenses) { expense in
								//if(expense.)
								ExpenseListItemView(expense: expense)
							}
							.onDelete(perform: deleteExpense)
						}
						.listStyle(.plain)
						.scrollDisabled(true)
						.frame(height: 175)
						NavigationLink(destination: FullExpenseListView()){
							Text("View more").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						}
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
	ShortExpenseListView()
}
