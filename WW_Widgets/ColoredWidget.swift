//
//  WW_Widgets.swift
//  WW_Widgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import SwiftUI

struct ColoredTimeline: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> ColoredEntry {
		ColoredEntry(date: Date(), widgetColor: WidgetColor.allColors[0])
    }

    func snapshot(for configuration: SelectColorIntent, in context: Context) async -> ColoredEntry {
		ColoredEntry(date: Date(), widgetColor: configuration.accentColor)
    }
    
    func timeline(for configuration: SelectColorIntent, in context: Context) async -> Timeline<ColoredEntry> {
        Timeline(entries: [
			ColoredEntry(date: Date(), widgetColor: configuration.accentColor)],
						 policy: .never
				 )
    }
}

struct ColoredEntry: TimelineEntry {
    let date: Date
    let widgetColor: WidgetColor
}

struct ColoredWidgetView : View {
    var entry: ColoredTimeline.Entry

    var body: some View {
		entry.widgetColor.color
    }
}

struct ColoredWidget: Widget {
    let kind: String = "ColoredWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectColorIntent.self, provider: ColoredTimeline()) { entry in
            ColoredWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
		.configurationDisplayName("Colored Widget")
		.description("Displays a configurable color")
		.supportedFamilies([.systemSmall])
		.contentMarginsDisabled()
    }
}

/*
extension SelectColorIntent {
    fileprivate static var smiley: SelectColorIntent {
        let intent = SelectColorIntent()
        return intent
    }
    
    fileprivate static var starEyes: SelectColorIntent {
        let intent = SelectColorIntent()
        return intent
    }
	
	
}
*/


#Preview(as: .systemSmall) {
    ColoredWidget()
} timeline: {
	ColoredEntry(date: .now, widgetColor: WidgetColor(id: "green", color: .green))
	ColoredEntry(date: .now, widgetColor: WidgetColor(id: "red", color: .red))
}
