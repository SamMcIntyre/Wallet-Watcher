//
//  AppIntent.swift
//  WW_Widgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import SwiftUI
import WidgetKit
import AppIntents

struct WidgetColor: AppEntity{
	var id: String
	var color: Color
	
	static var typeDisplayRepresentation: TypeDisplayRepresentation = "Widget Color"
	static var defaultQuery = WidgetColorQuery()
	
	var displayRepresentation: DisplayRepresentation{
		DisplayRepresentation(title: "\(id)")
	}
	
	//Mock Data
	static let allColors: [WidgetColor] = [
		WidgetColor(id: "Red", color: .red),
		WidgetColor(id: "Blue", color: .blue),
		WidgetColor(id: "Orange", color: .orange)
	]
}

struct WidgetColorQuery: EntityQuery{
	func entities(for identifiers: [WidgetColor.ID]) async throws -> [WidgetColor] {
		WidgetColor.allColors.filter{
			identifiers.contains($0.id)
		}
	}
	
	//show all the options
	func suggestedEntities() async throws -> [WidgetColor] {
		WidgetColor.allColors
	}
	
	func defaultResult() async -> WidgetColor? {
		WidgetColor.allColors.first
	}
}


struct SelectColorIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Sel Color"
    static var description = IntentDescription("Select coloe for display.")

    // An example configurable parameter.
    @Parameter(title: "Accent Color")
    var accentColor: WidgetColor
}
