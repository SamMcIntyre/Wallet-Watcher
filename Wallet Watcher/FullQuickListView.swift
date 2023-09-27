//
//  FullQuickListView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

// defines the comprehensive list of Quick Expenses
struct FullQuickListView: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query(sort: \QuickExpense.timestamp, order: .reverse)
	private var quickExpenses: [QuickExpense]
	
    var body: some View {
		NavigationStack{
				GroupBox(label: Text("Quick Expenses").frame(maxWidth: .infinity, alignment: .center)) {
					List{
						ForEach(quickExpenses) { quickExpense in
							//if(expense.)
							QuickListItemView(quickExpense: quickExpense)
						}
						.onDelete(perform: deleteQuickExpense)
					}
					.listStyle(.plain)
				}
				.toolbar{
					ToolbarItem(placement: .navigationBarTrailing) {
						EditButton()
					}
				}
			}
    }
	
	//delete a quick expense from the list
	private func deleteQuickExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(quickExpenses[index])
			}
		}
	}
}

#Preview {
    FullQuickListView()
}
