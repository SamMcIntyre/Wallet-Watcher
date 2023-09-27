//
//  TutorialView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI

struct TutorialView: View {
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		NavigationView{
			Form{
				VStack{
					Text("How to use this app...")
						.frame(maxWidth: .infinity, alignment: .center)
						.font(.title2)
					Divider()
					Text("From Settings you can:")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.headline)
					Text(" - Change your Budget.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Update the default values of new Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Clear all Expenses")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text("     - (not the Quick Expenses.)")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Access this tutoral (Hello!)")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Divider()
					Text("From the Dashboard you can:")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.headline)
					Text(" - Add new Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - View and Use Quick Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - View past Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text("     - Click on them to view their details.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Access the full list of both Expenses and Quick Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Delete items from both Expenses and Quick Expenses.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text("     - Click the Edit button in the top right to do this more easily.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Divider()
					Text("From 'Add Expenses' you can:")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.headline)
					Text(" - Change the details of the new Expense.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Choose to save the Expense as a new Quick Expense.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Divider()
					Text("How to utilize Quick Expenses")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.headline)
					Text(" - Toggle the Quick Expense switch to 'On' within the 'New Expense' menu.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text("     - With the switch on, when you create the new Expense, a new Quick Expense will also be created.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text(" - Now when you click on the corresponding Quick Expense, a duplicate Expense will quickly be created without any further input.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					Text("     - This is useful for when you will buy duplicate things, for instance buying many of the same drinks at a bar throughout the day.")
						.frame(maxWidth: .infinity, alignment: .leading)
						.font(.footnote)
					
					Spacer()
				}
			}
			//.frame(maxHeight: .infinity)
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Close") {
						dismiss()
					}
				}
			}
		}
    }
}

#Preview {
    TutorialView()
}
