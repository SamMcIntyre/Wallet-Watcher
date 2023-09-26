//
//  ExpenseDetailView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI

struct ExpenseDetailView: View {
	let expense: Expense
	
	var body: some View {
		NavigationView{
			VStack{
				HStack{
					Text("-$" + expense.formattedTotal).font(.title)
				}
				HStack{
					Text("Original Price: ")
					Text("$" + expense.formattedPrice)
				}
				HStack{
					Text("Gratuity: ")
					Text(String(Int(expense.gratuity * 100)) + "%")
				}
				HStack{
					Text("Tax: ")
					Text(String(Int(expense.tax * 100)) + "%")
				}
				HStack{
					Text("Date: ")
					Text(expense.timestamp, format: Date.FormatStyle(date: .abbreviated))
				}
				HStack{
					Text("Time: ")
					Text(expense.timestamp, format: Date.FormatStyle(time: .complete))
				}
				HStack{
					Text("For: ")
					Text(expense.purpose)
				}
				HStack{
					Text("Location: ")
					Text(expense.location)
				}
				Spacer()
			}
		}
    }
}

#Preview {
	ExpenseDetailView(expense: Expense(price: 69.23))
}
