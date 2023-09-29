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
	
	//basic placeholder
    func placeholder(in context: Context) -> StatusEntry {
		StatusEntry(wallet: Wallet(spent: 30.00, budget: 200.00))
    }

	//for a quick snapshot
	@MainActor
	func getSnapshot(in context: Context, completion: @escaping (StatusEntry) -> ()) {
		
		//modelContainer.mainContext.fetch(fetchDescriptor)
		let wallets = try? modelContainer.mainContext.fetch(FetchDescriptor<Wallet>())
		
		let entry = StatusEntry(wallet: wallets?[0] ?? Wallet(spent: -1.00, budget: 200.00))
        completion(entry)
    }

	//for a timeline (basically a snapshot in this instance)
	@MainActor
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [StatusEntry] = []
		
		let wallets = try? modelContainer.mainContext.fetch(FetchDescriptor<Wallet>())

		let entry = StatusEntry(wallet: wallets?[0] ?? Wallet(spent: -1.00, budget: 200.00))
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
    var entry: StatusProvider.Entry

	@Environment(\.widgetFamily) var family
	
    var body: some View {
        VStack {
			let spent = entry.wallet.spent
			//let budget = entry.wallet.budget
			
			//quick error check
			if(spent == -1.00){
				//error pulling the data
				Text("There was a problem pulling your data from the app.")
					.frame(maxWidth: .infinity, alignment: .center)
					.font(.footnote)
			}else{
				//successfully pulled down the data
				
				//display either large or small version of the gauge
				switch family {
				case .systemSmall:
					SmallWalletGaugeView(wallet: entry.wallet)
				case .systemMedium:
					WalletGaugeView(wallet: entry.wallet)
						.frame(width: 340, height: 175)
				default:
					SmallWalletGaugeView(wallet: entry.wallet)
				}
			}
        }
    }
}

struct WalletStatusWidget: Widget {
    let kind: String = "Wallet Status"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: StatusProvider()) { entry in
            if #available(iOS 17.0, *) {
                StatusEntryView(entry: entry)
					.frame(maxWidth: .infinity, maxHeight:.infinity)
                    .containerBackground(.fill.tertiary, for: .widget)
					.background(Color.accentColor.gradient)
					.clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
            } else {
                StatusEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Wallet Status")
        .description("Displays your current wallet status.")
		.supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    WalletStatusWidget()
} timeline: {
    StatusEntry(wallet: Wallet(spent: 30.00, budget: 200.00))
    StatusEntry(wallet: Wallet(spent: 150.00, budget: 200.00))
}
