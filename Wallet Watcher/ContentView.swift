//
//  ContentView.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    //@Query private var items: [Item]
	@Query private var expenses: [Expense]
	//@Query private var settings: [Setting]
	
	let defaults = UserDefaults.standard
	
	@State var showingNewExpensePopover = false
	//@State private var path = NavigationPath()
	@State var budget = 150.00 //set to default later in defaulter
	
	let tempBudget = 200.00
	let tempSpent = 50.00
	
	private func defaulter(){
		budget = defaults.double(forKey: "budget")
	}

    var body: some View {
        NavigationStack {
			VStack{
				Gauge(value: tempSpent, in: 0...budget) {
					Text("Wallet")
				} currentValueLabel: {
					Text("Spent: $" + String(format:"%.2f", tempSpent))
						.font(.title2.monospacedDigit())
				} minimumValueLabel: {
					Text("0")
						.font(.caption2.monospaced())
				} maximumValueLabel: {
					Text("$" + String(format:"%.2f", budget))
						.font(.caption2.monospaced())
				}
				.gaugeStyle(DefaultGaugeStyle())
				.tint(.green)
				
				Button(action: {showingNewExpensePopover = true}) {
					Label("Add Expense", systemImage: "plus");
				}
				.buttonStyle(.borderedProminent)
				.popover(isPresented: $showingNewExpensePopover, content: {
					NewExpenseView()
				})
				
				ExpenseListView()
				/*List {
					//Button("Add Expense", action: addItem)
					Button(action: {showingNewExpensePopover = true}) {
						Label("Add Expense", systemImage: "plus");
					}
					.popover(isPresented: $showingNewExpensePopover, content: {
						NewExpenseView()
					})
					
					/*ForEach(items) { item in
						NavigationLink {
							Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
						} label: {
							Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
						}
					}
					.onDelete(perform: deleteItems)
					 */
					
					/*ForEach(expenses) { expense in
					NavigationLink {
					Text("\(expense.price)")
					}
					label: {
					Text(expense.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
					
					}
					}
					.onDelete(perform: deleteExpense)
					 */
					
					
				}
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button(action: openSettings) {
							Label("Open Settings", systemImage: "gearshape")
						}
					}
					/*
					 ToolbarItem(placement: .navigationBarTrailing) {
					 EditButton()
					 }
					 ToolbarItem {
					 Button(action: addItem) {
					 Label("Add Item", systemImage: "plus")
					 }
					 }
					 */
				}*/
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
				//if settings.isEmpty{
					//let newSetting = Setting()
					//modelContext.insert(newSetting)
				//}
			}
        }
	}

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }
	
	private func addExpense() {
		let price = 69.69
		let newExpense = Expense(price: price)
		modelContext.insert(newExpense)
	}
	
	private func clearExpenses(){
		modelContext.delete(expenses[0])
	}
	
	private func deleteExpense(offsets: IndexSet) {
		withAnimation {
			for index in offsets {
				modelContext.delete(expenses[index])
			}
		}
	}

    /*private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                //modelContext.delete(items[index])
            }
        }
    }*/
	
	private func openSettings(){
		//path.append(SettingsView())
	}
}

#Preview {
    ContentView()
        //.modelContainer(for: Item.self, inMemory: true)
		.modelContainer(for: Expense.self, inMemory: true)
		//.modelContainer(for: Setting.self, inMemory: true)
}
