//
//  ShortQuickList.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData

struct ShortQuickListView: View {
	@Environment(\.modelContext) private var modelContext
	
	@Query(sort: \QuickExpense.timestamp, order: .reverse)
	private var quickExpenses: [QuickExpense]
	
    var body: some View {
		NavigationStack{
					GroupBox(label: Text("Quick Expenses").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)) {
						List{
							ForEach(quickExpenses) { quickExpense in
								//if(expense.)
								QuickListItemView(quickExpense: quickExpense)
							}
							.onDelete(perform: deleteQuickExpense)
						}
						.listStyle(.plain)
						.scrollDisabled(true)
						.frame(height: 190)
						NavigationLink(destination: FullQuickListView()){
							Text("View all").frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						}
					}
				}
    }
	
	private func deleteQuickExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(quickExpenses[index])
			}
		}
	}
}

#Preview {
    ShortQuickListView()
		
}
