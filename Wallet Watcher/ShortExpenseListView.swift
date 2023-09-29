//
//  ShortListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData
import WidgetKit

//defines a short list of the most recent Expenses for the dashboard.
struct ShortExpenseListView: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query private var wallets: [Wallet]
	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
    var body: some View {
		NavigationStack{
					GroupBox(label: Text("Recent Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
						List{
							ForEach(expenses) { expense in
								ExpenseListItemView(expense: expense)
							}
							.onDelete(perform: deleteExpense)
						}
						.listStyle(.plain)
						.scrollDisabled(true)
						.frame(height: 175)
						.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
						NavigationLink(destination: FullExpenseListView()){
							Text("View all").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						}
					}
				}
    }
	
	//delete an expense
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				wallets[0].spent -= expenses[index].total
				modelContext.delete(expenses[index])
				
				//update widgets
				WidgetCenter.shared.reloadAllTimelines()
			}
		}
	}
}

#Preview {
	ShortExpenseListView()
}
