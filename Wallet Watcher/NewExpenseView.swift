//
//  NewExpenseView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import Combine
import SwiftData

//Defines the New Expense View, which allows you to make a new expense
struct NewExpenseView: View {
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	let defaults = UserDefaults.standard
	
	@State private var value = ""
	@State private var grat = "18" //set to default later (using defaulter() onAppear())
	@State private var tax = "0" //set to default later
	@State private var purpose = "" //set to default later
	@State private var location = "" // set to default later
	@State private var makeQuickExpense = false
	
	@Query private var wallet: [Wallet]
	@Query private var expenses: [Expense]
	
	let gratTaxLimit = 2 //digit limit for gratuity and text box
	
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
							.font(.title.monospaced())
							.onSubmit() {
								enterExpense(amountStr:value, gratStr: grat, taxStr: tax, purpose: purpose, location: location)
							}
						Spacer()
					}
					HStack{
						//Submit Button
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
									.keyboardType(.numberPad)
								Text("%")
								Spacer()
							}
							Text("Tax")
						}
						Spacer()
					}
					HStack{
						VStack{
							//Purpose and Location
							GroupBox{
								//Purpose
								Text("Purpose:").frame(maxWidth: .infinity, alignment: .leading).font(.caption)
								TextField("drink, food, etc.", text: $purpose).textFieldStyle(RoundedBorderTextFieldStyle())
									.frame(maxWidth: .infinity, alignment: .leading)
									.font(.caption)
							}
							GroupBox{
								//Location
								Text("Location:").frame(maxWidth: .infinity, alignment: .leading).font(.caption)
								TextField("bar, buffet, etc.", text: $location).textFieldStyle(RoundedBorderTextFieldStyle())
									.frame(maxWidth: .infinity, alignment: .leading)
									.font(.caption)
							}
							Spacer()
						}.frame(width:180)
						Spacer()
						VStack{
							//Quick Expense toggle
							GroupBox{
								HStack {
									Toggle(isOn: $makeQuickExpense) {Text("Make Quick Expense")}.labelsHidden().frame(maxWidth: .infinity, alignment: .center)
								}
								Text("Make Quick Expense").frame(maxWidth: .infinity, alignment: .trailing).font(.caption2)
							}
							Spacer()
						}.frame(width: 120)
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
			.onAppear(perform: {
				defaulter()
			})
		}
    }
	
	//set some default values
	private func defaulter(){
		grat = String(Int(defaults.double(forKey: "gratuity")*100))
		tax = String(Int(defaults.double(forKey: "tax")*100))
		purpose = defaults.string(forKey: "purpose") ?? ""
		location = defaults.string(forKey: "location") ?? ""
	}
	
	//enter a new expense into the SwiftData model. Also clean the data while doing that
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
			var dirtyGrStr:String
			if(gratStr.count == 1){ //check if need to add the tenths place
				dirtyGrStr = ("0.0" + gratStr) // add tenths place, build a proper float percent
			}else{
				dirtyGrStr = ("0." + gratStr) // build a proper float percent
			}
			guard let grat = Double(dirtyGrStr) else { return }
			let cleanGrStr = String(format: "%.2f", grat)
			cleanGrat = Double(cleanGrStr) ?? 0.0
		}else{
			cleanGrat = 0.0
		}
		//tax
		if (taxStr != ""){
			var dirtyTaStr:String
			if(taxStr.count == 1){ //check if need to add the tenths place
				dirtyTaStr = ("0.0" + taxStr) // add tenths place, build a proper float percent
			}else{
				dirtyTaStr = ("0." + taxStr) // build a proper float percent
			}
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
		
		//make new expense
		let newExpense = Expense(price: cleanAmount, grat: cleanGrat, tax: cleanTax, purpose: cleanPurpose, location: cleanLocation)
		
		//make new quick expense
		if(makeQuickExpense){
			let newQuickExpense = QuickExpense(price: cleanAmount, grat: cleanGrat, tax: cleanTax, purpose: cleanPurpose, location: cleanLocation)
			
			//insert into models
			modelContext.insert(newQuickExpense)
		}
		modelContext.insert(newExpense)
		
		//update wallet
		wallet[0].spent += newExpense.total
		
		//save to model
		do {
			try modelContext.save()
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
		.modelContainer(for: [Expense.self, QuickExpense.self], inMemory: true)
}
