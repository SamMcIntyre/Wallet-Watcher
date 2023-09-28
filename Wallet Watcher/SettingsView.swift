//
//  SettingsView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/26/23.
//

import SwiftUI
import SwiftData
import Combine

//defines the Settings menu, which provides plenty of backend options.
struct SettingsView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	@Query private var wallets: [Wallet]
	@Query private var expenses: [Expense]
	@Query private var quickExpenses: [QuickExpense]
	
	@State private var value = ""
	@State private var grat = "18"
	@State private var tax = "00"
	@State private var purpose = ""
	@State private var location = ""
	
	@State private var isShowingDialog = false
	@State private var isShowingTutorialPopover = false
	
	let defaults = UserDefaults.standard
	
	let gratTaxLimit = 2 //digit limit for gratuity and text box
	
    var body: some View {
		ScrollView{
			VStack{
				Text("Settings").font(.largeTitle)
				//Text("Will not take effect unless saved.").font(.footnote)
				
				// BUDGET
				Text("Update Budget").padding(.top).font(.headline)
				HStack{
					//budget entry field
					TextField("$0.00", text: $value)
						.keyboardType(.decimalPad)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.frame(width: 200)
						.font(.title.monospaced())
						.onSubmit() {
							updateBudget(newBudget: Double(value) ?? -1.0)
						}
					//Submit Button
					Button("Update", action: {updateBudget(newBudget: Double(value) ?? -1.0)})
						.font(.title2)
						.buttonStyle(BorderedProminentButtonStyle())
				}
				
				Spacer()
				Divider()
				
				// DEFAULTS
				GroupBox{
					Text("Update Defaults").font(.headline)
					Divider()
					HStack{
						//Gratuity and Tax
						Spacer()
						VStack{
							//gratuity
							Text("Gratuity:").font(.subheadline)
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
						}
						Spacer()
						VStack{
							//tax
							Text("Tax:").font(.subheadline)
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
						}
						Spacer()
					}
					Divider()
					HStack{
						//Purpose and Location
						Spacer()
						VStack{
							//Purpose
							Text("Purpose:").frame(maxWidth: .infinity, alignment: .center).font(.subheadline)
							TextField("drink, food, etc.", text: $purpose).textFieldStyle(RoundedBorderTextFieldStyle())
								.frame(maxWidth: .infinity, alignment: .leading)
								.font(.caption)
						}
						VStack{
							//Location
							Text("Location:").frame(maxWidth: .infinity, alignment: .center).font(.subheadline)
							TextField("bar, buffet, etc.", text: $location).textFieldStyle(RoundedBorderTextFieldStyle())
								.frame(maxWidth: .infinity, alignment: .leading)
								.font(.caption)
						}
					}
					Divider()
					//Submit Button
					Button("Submit Defaults", action: {updateDefaults(newGratStr: grat, newTaxStr: tax, newPur: purpose, newLoc: location)})
						.font(.headline)
						.buttonStyle(.bordered)
						.keyboardType(.numberPad)
				}.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
				
				Spacer()
				Divider()
				
				//CLEAR AND TUTORIAL
				HStack{
					Spacer()
					
					//Clear
					Button("Clear Expenses", action: {isShowingDialog = true})
						.font(.headline)
						.buttonStyle(.borderedProminent)
						.tint(.red)
						.confirmationDialog("Are you sure you want to clear all expenses?", isPresented: $isShowingDialog) {
							Button("Clear All", role: .destructive) {
								clearExpenses()
							}
						} message: {
							Text("You cannot undo this action.")
						}
					
					Spacer()
					
					//Tutorial
					Button(action: {isShowingTutorialPopover = true}) {
						Text("How to Use");
					}
					.tint(Color.green)
					.buttonStyle(.borderedProminent)
					.popover(isPresented: $isShowingTutorialPopover, content: {
						TutorialView()
					})
					
					Spacer()
				}.padding(.top)
			}
		}
		.onAppear(){
			defaulter()
		}
    }
	
	//function to update the user budget
	private func updateBudget(newBudget: Double){
		if(newBudget == -1.0){
			print("invalid budget")
		}else{
			defaults.setValue(newBudget, forKey: "budget")
			wallets[0].budget = newBudget
			value = ""
		}
	}
	
	//function to update the user defaults
	private func updateDefaults(newGratStr: String, newTaxStr: String, newPur: String, newLoc:String){
		var cleanGrat = 0.0
		var cleanTax = 0.0
		
		//gratuity
		if (newGratStr != ""){
			var dirtyGrStr:String
			if(newGratStr.count == 1){ //check if need to add the tenths place
				dirtyGrStr = ("0.0" + newGratStr) // add tenths place, build a proper float percent
			}else{
				dirtyGrStr = ("0." + newGratStr) // build a proper float percent
			}
			let dirtyGrat = Double(dirtyGrStr) ?? -1.0
			let cleanGrStr = String(format: "%.2f", dirtyGrat)
			cleanGrat = Double(cleanGrStr) ?? -1.0
		}else{
			cleanGrat = 0.0
		}
		if(cleanGrat != -1.0){
			defaults.setValue(cleanGrat, forKey: "gratuity")
		}
		
		//tax
		if (newTaxStr != ""){
			var dirtyTaStr:String
			if(newTaxStr.count == 1){ //check if need to add the tenths place
				dirtyTaStr = ("0.0" + newTaxStr) // add tenths place, build a proper float percent
			}else{
				dirtyTaStr = ("0." + newTaxStr) // build a proper float percent
			}
			let dirtyTax = Double(dirtyTaStr) ?? -1.0
			let cleanTaStr = String(format: "%.2f", dirtyTax)
			cleanTax = Double(cleanTaStr) ?? -1.0
		}else{
			cleanTax = 0.0
		}
		if(cleanTax != -1.0){
			defaults.setValue(cleanTax, forKey: "tax")
		}
		
		//purpose and location
		defaults.setValue(newPur, forKey: "purpose")
		defaults.setValue(newLoc, forKey: "location")
	}
	
	//function to clear expenses
	private func clearExpenses(){
		//clear expenses
		modelContext.deleteAll(model: Expense.self)
		
		//clear wallet
		wallets[0].spent = 0.0
	}
	
	//function to pull the user defaults
	private func defaulter(){
		grat = String(Int(defaults.double(forKey: "gratuity")*100))
		tax = String(Int(defaults.double(forKey: "tax")*100))
		purpose = defaults.string(forKey: "purpose") ?? ""
		location = defaults.string(forKey: "location") ?? ""
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

//an extension which allows me to delete all of a certain item in the model.
extension ModelContext {
	func deleteAll<T>(model: T.Type) where T : PersistentModel {
		do {
			let p = #Predicate<T> { _ in true }
			try self.delete(model: T.self, where: p, includeSubclasses: false)
			print("All of \(model.self) cleared !")
		} catch {
			print("error: \(error)")
		}
	}
}

#Preview {
    SettingsView()
		.modelContainer(for: [Expense.self, QuickExpense.self, Wallet.self], inMemory: true)
}
