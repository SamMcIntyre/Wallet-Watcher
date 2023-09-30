//
//  QuickExpenseWidget.swift
//  WWWidgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct QuickExpenseProvider: AppIntentTimelineProvider {
	
	//make the model contatainer to pull down the current wallet
	private let modelContainer: ModelContainer
	init() {
		do {
			modelContainer = try ModelContainer(for: Expense.self, QuickExpense.self, Wallet.self)
		} catch {
			fatalError("Failed to create the model container: \(error)")
		}
	}
	
	
    func placeholder(in context: Context) -> QuickExpenseEntry {
        QuickExpenseEntry(date: Date(), configuration: QuickExpenseIntent())
    }

	@MainActor
    func snapshot(for configuration: QuickExpenseIntent, in context: Context) async -> QuickExpenseEntry {
		
		let quickExpenses = try? modelContainer.mainContext.fetch(FetchDescriptor<QuickExpense>())
		
		return QuickExpenseEntry(date: Date(), configuration: configuration)
    }
    
	@MainActor
    func timeline(for configuration: QuickExpenseIntent, in context: Context) async -> Timeline<QuickExpenseEntry> {
        var entries: [QuickExpenseEntry] = []
		
		let quickExpenses = try? modelContainer.mainContext.fetch(FetchDescriptor<QuickExpense>())
		
		//return QuickEntry(date: Date(), configuration: configuration, quickExpense: quickExpenses?[0] ?? QuickExpense(price: -1.00))

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
			let entry = QuickExpenseEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }
        return Timeline(entries: entries, policy: .never)
    }
}

struct QuickExpenseEntry: TimelineEntry {
    let date: Date
    let configuration: QuickExpenseIntent
	//let quickExpense: QuickExpense
}

struct QuickExpenseEntryView : View {
    var entry: QuickExpenseProvider.Entry
	
    var body: some View {
		let quickEpense = try? entry.configuration.widgetQuickExpense.quickExpense ?? QuickExpense(price: -1.00)
        VStack {
			//Text(String(entry.quickExpense.price))
			
            Text("This is the quickExpense stuff")
            //Text(entry.date, style: .time)

            Text("Favorite Emoji:")
            //Text(entry.configuration.favoriteEmoji)
        }
    }
}

struct QuickExpenseWidget: Widget {
    let kind: String = "Quick Expense"

    var body: some WidgetConfiguration {
		AppIntentConfiguration(kind: kind, intent: QuickExpenseIntent.self, provider: QuickExpenseProvider()) { entry in
            QuickExpenseEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
		.configurationDisplayName("Quick Expense")
		.description("Quickly add expenses from your home screen.")
		.supportedFamilies([.systemSmall])
    }
}
/*
extension QuickExpenseIntent {
    fileprivate static var smiley: QuickExpenseIntent {
        let intent = QuickExpenseIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: QuickExpenseIntent {
        let intent = QuickExpenseIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
	
	fileprivate static var thing: QuickExpenseIntent{
		let intent = QuickExpenseIntent()
		intent.favoriteEmoji = "🙋‍♂️"
		return intent
	}
}
 */

#Preview(as: .systemSmall) {
    QuickExpenseWidget()
} timeline: {
	QuickExpenseEntry(date: .now, configuration: QuickExpenseIntent())
	QuickExpenseEntry(date: .now, configuration: QuickExpenseIntent())
}
