//
//  ContentView.swift
//  Wallet Watchman AKA Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	@Query private var wallets: [Wallet]
	@Query(sort: \Expense.timestamp, order: .reverse)
	private var expenses: [Expense]
	
	let defaults = UserDefaults.standard
	
	@State var showingNewExpensePopover = false

	@State var budget = 200.00 //set to default later in defaulter

    var body: some View {
        NavigationStack {
			ScrollView{
				VStack{
					//title
					Text("Wallet Watchman").font(.title).padding(.leastNonzeroMagnitude)
					
					//Display wallet gauge
					ForEach(wallets) { wallet in
						WalletGaugeView(wallet: wallet)
					}
					
					//Add expense button
					Button(action: {showingNewExpensePopover = true}) {
						Label("Add New Expense", systemImage: "plus");
					}
					.buttonStyle(.borderedProminent)
					.popover(isPresented: $showingNewExpensePopover, content: {
						NewExpenseView()
					})
					
					//display Quick Expense shortlist
					ShortQuickListView()
					
					//display past Expense shortlist
					ShortExpenseListView()
					
					Spacer()
				}
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						NavigationLink(destination: SettingsView()) {
							Image(systemName: "gearshape")
						}
					}
					ToolbarItem(placement: .navigationBarLeading) {
						EditButton()
					}
				}
				.onAppear(){
					defaulter()
				}
			}
        }
	}
	
	//acces user defaults and apply them to the view
	private func defaulter(){
		budget = defaults.double(forKey: "budget")
		
		if(wallets.count == 0){
			//initialize a wallet
			let newWallet = Wallet(spent: 0.00, budget: budget)
			modelContext.insert(newWallet)
			do {
				try modelContext.save()
			} catch {
				print(error.localizedDescription)
			}
			dismiss()
		}
	}
	
	//delete an expense
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(expenses[index])
			}
		}
	}
}

#Preview {
    ContentView()
		.modelContainer(for: [Expense.self, QuickExpense.self, Wallet.self], inMemory: true)
}
