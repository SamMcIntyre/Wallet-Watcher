//
//  WWWidgets.swift
//  WWWidgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import SwiftUI
import SwiftData

struct StatusProvider: TimelineProvider {
	
	//make the model contatainer to pull down the current wallet
	private let modelContainer: ModelContainer
	init() {
		do {
			modelContainer = try ModelContainer(for: Wallet.self)
		} catch {
			fatalError("Failed to create the model container: \(error)")
		}
	}
	
    func placeholder(in context: Context) -> StatusEntry {
		StatusEntry(wallet: Wallet(spent: 30.00, budget: 200.00))
    }

	@MainActor
	func getSnapshot(in context: Context, completion: @escaping (StatusEntry) -> ()) {
		
		//modelContainer.mainContext.fetch(fetchDescriptor)
		let wallets = try? modelContainer.mainContext.fetch(FetchDescriptor<Wallet>())
		
		let entry = StatusEntry(wallet: wallets?[0] ?? Wallet(spent: 30.00, budget: 200.00))
        completion(entry)
    }

	@MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [StatusEntry] = []
		
		let wallets = try? modelContainer.mainContext.fetch(FetchDescriptor<Wallet>())

		let entry = StatusEntry(wallet: wallets?[0] ?? Wallet(spent: 30.00, budget: 200.00))
		entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct StatusEntry: TimelineEntry {
	var date = Date()
	let wallet: Wallet
}

struct StatusEntryView : View {
	//@Environment(\.modelContext) private var modelContext
	//@Query private var wallets: [Wallet]
	
    var entry: StatusProvider.Entry

    var body: some View {
        VStack {
			Text(String(entry.wallet.spent))
        }
    }
}

struct WalletStatusWidget: Widget {
    let kind: String = "Wallet Status"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StatusProvider()) { entry in
            if #available(iOS 17.0, *) {
                StatusEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                StatusEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Wallet Status")
        .description("Displays your current wallet status.")
    }
}

#Preview(as: .systemSmall) {
    WalletStatusWidget()
} timeline: {
    StatusEntry(wallet: Wallet(spent: 30.00, budget: 200.00))
    StatusEntry(wallet: Wallet(spent: 150.00, budget: 200.00))
}
