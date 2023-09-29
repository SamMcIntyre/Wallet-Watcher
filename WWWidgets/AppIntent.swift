//
//  AppIntent.swift
//  WWWidgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("This is an example widget.")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
	
	//@Parameter(title: "Quick Expense", default: "😃")
	//var quickExpense: WidgetQuickExpense
}
