//
//  WidgetQuickExpense.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/28/23.
//

import Foundation
import SwiftData
import WidgetKit
import AppIntents
import SwiftUI

// defines a widget quick expense, which allows user to select a button for a widget
struct WidgetQuickExpense: AppEntity{
	var id: UUID
	var quickExpense: QuickExpense
	
	static var typeDisplayRepresentation: TypeDisplayRepresentation = "Quick Expense"
	static var defaultQuery = WidgetQuickExpenseQuery()
	
	var displayRepresentation: DisplayRepresentation{
		DisplayRepresentation(title: "\(quickExpense.formattedPrice) for \(quickExpense.purpose)")
	}
	
	//Mock Data
	static let someExpenses: [WidgetQuickExpense] = [
		WidgetQuickExpense(id: UUID(), quickExpense: QuickExpense(price: 3.50)),
		WidgetQuickExpense(id: UUID(), quickExpense: QuickExpense(price: 4.20)),
		WidgetQuickExpense(id: UUID(), quickExpense: QuickExpense(price: 18.69))
	]
}

struct WidgetQuickExpenseQuery: EntityQuery{
	//make the model contatainer to pull down the current wallet
	private let modelContainer: ModelContainer
	init() {
		do {
			modelContainer = try ModelContainer(for: Expense.self, QuickExpense.self, Wallet.self)
		} catch {
			fatalError("Failed to create the model container: \(error)")
		}
	}
	
	//filtered show
	func entities(for identifiers: [WidgetQuickExpense.ID]) async throws -> [WidgetQuickExpense] {
		let filtered = await getAllQuickExpenses().filter{
			identifiers.contains($0.id)
		}
		return filtered
	}
	
	//show all the options
	func suggestedEntities() async throws -> [WidgetQuickExpense] {
		return await getAllQuickExpenses()
	}
	
	//default
	func defaultResult() async -> WidgetQuickExpense? {
		try? await suggestedEntities().first
	}
	
	@MainActor
	private func getAllQuickExpenses() -> [WidgetQuickExpense]{
		let allQuickExpenses = (try? modelContainer.mainContext.fetch(FetchDescriptor<QuickExpense>())) ?? [QuickExpense(price: -1.00)]
		var allWidgetQEs: [WidgetQuickExpense] = []
		
		for quickExpense in allQuickExpenses{
			let newID = UUID()
			let newWidgetQuickExpense = WidgetQuickExpense(id: newID, quickExpense: quickExpense)
			allWidgetQEs.append(newWidgetQuickExpense)
		}
		return allWidgetQEs
	}
}

struct QuickExpenseIntent: WidgetConfigurationIntent {
	static var title: LocalizedStringResource = "Select Quick Expense"
	static var description = IntentDescription("Select quick expense for display.")

	//configurable parameter.
	@Parameter(title: "Quick Expense")
	var quickExpense: WidgetQuickExpense
	
	
}
