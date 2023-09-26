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
	
	@Query private var expenses: [Expense]
	
	var body: some View {
		NavigationStack{
			GroupBox(label: Text("All Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
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
				}.listStyle(.plain)
			}
		}
	}
}

#Preview {
    FullExpenseListView()
		.modelContainer(for: Expense.self, inMemory: true)
}