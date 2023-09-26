//
//  NewExpenseView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import Combine
import SwiftData

struct NewExpenseView: View {
	
	@State private var value = ""
	@State private var grat = "18" //set to default later
	@State private var tax = "0" //set to default later
	@State private var purpose = ""
	@State private var location = ""
	
	@Environment(\.modelContext) private var context
	@Environment(\.dismiss) private var dismiss
	
	@Query private var expenses: [Expense]
	
	let gratTaxLimit = 2 //digit limit for gratuity and text box
	
	private let numberFormatter: NumberFormatter
	init() {
		  numberFormatter = NumberFormatter()
		  numberFormatter.numberStyle = .currency
		  numberFormatter.maximumFractionDigits = 2
	}
	
	var body: some View {
		NavigationView{
			Form{
				VStack{
					//Text("New Expense").font(.title)
					HStack{
						//expense amount text field
						Spacer()
						TextField("$0.00", text: $value)
							.keyboardType(.decimalPad)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.frame(width: 200)
							.font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.monospaced())
							.onSubmit() {
								enterExpense(amountStr:value, gratStr: grat, taxStr: tax, purpose: purpose, location: location)
							}
						Spacer()
					}
					HStack{
						Button("Enter", action: {enterExpense(amountStr:value, gratStr: grat, taxStr: tax, purpose: purpose, location: location)})
							.font(.title)
							.buttonStyle(BorderedProminentButtonStyle())
							.keyboardType(.numberPad)
					}
					HStack{
						Spacer()
						VStack{
							//Gratuity modifier
							HStack{
								Spacer()
								TextField("00", text: $grat)
									.onReceive(Just(grat), perform: { _ in
										limitText(gratTaxLimit)
									})
									.frame(minWidth: 20, idealWidth: 50, maxWidth: 50)
									.textFieldStyle(RoundedBorderTextFieldStyle())
									.keyboardType(.numberPad)
								Text("%")
								Spacer()
							}
							Text("Gratuity")
						}
						Spacer()
						VStack{
							//Tax modifier
							HStack{
								Spacer()
								TextField("00", text: $tax)
									.onReceive(Just(grat), perform: { _ in
										limitText(gratTaxLimit)
									})
									.frame(minWidth: 20, idealWidth: 50, maxWidth: 50)
									.textFieldStyle(RoundedBorderTextFieldStyle())
								Text("%")
								Spacer()
							}
							Text("Tax")
						}
						Spacer()
					}
				}
			}
			.navigationTitle("New Expense")
			.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button("Cancel") {
						dismiss()
					}
				}
			}
		}
    }
	
	private func enterExpense(amountStr: String, gratStr: String, taxStr: String, purpose: String, location: String) {
		// clean and format incoming inputs:
		var cleanAmount = 0.0
		var cleanGrat = 0.0
		var cleanTax = 0.0
		var cleanPurpose = ""
		var cleanLocation = ""
		//expense amount
		if(amountStr != ""){
			guard let amount = Double(amountStr) else { return }
			let cleanAmStr = String(format: "%.2f", amount)
			cleanAmount = Double(cleanAmStr) ?? 0.0
		}else{
			cleanAmount = 0.0
		}
		//gratuity
		if (gratStr != ""){
			let dirtyGrStr = ("0." + gratStr) // build a proper float percent
			guard let grat = Double(dirtyGrStr) else { return }
			let cleanGrStr = String(format: "%.2f", grat)
			cleanGrat = Double(cleanGrStr) ?? 0.0
		}else{
			cleanGrat = 0.0
		}
		//tax
		if (taxStr != ""){
			let dirtyTaStr = ("0." + taxStr) // build a proper float percent
			guard let tax = Double(dirtyTaStr) else { return }
			let cleanTaStr = String(format: "%.2f", tax)
			cleanTax = Double(cleanTaStr) ?? 0.0
		}else{
			cleanTax = 0.0
		}
		
		//check for purpose and location data
		if(purpose == ""){
			cleanPurpose = "Unknown" // make default
		}else{
			cleanPurpose = purpose
		}
		if(location == ""){
			cleanLocation = "Unknown" // make default
		}else{
			cleanLocation = location
		}
		
		let newExpense = Expense(price: cleanAmount, grat: cleanGrat, tax: cleanTax, purpose: cleanPurpose, location: cleanLocation)
		context.insert(newExpense)
		do {
			try context.save()
		} catch {
			print(error.localizedDescription)
		}
		dismiss()
	}
	
	//Function to keep text length in limits
	private func limitText(_ upper: Int) {
		if grat.count > upper {
			grat = String(grat.prefix(upper))
		}
		if tax.count > upper {
			tax = String(tax.prefix(upper))
		}
	}
}

#Preview {
    NewExpenseView()
	.modelContainer(for: Expense.self, inMemory: true)
}
