//
//  WWWidgetsBundle.swift
//  WWWidgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import SwiftUI
import SwiftData

@main
struct WWWidgetsBundle: WidgetBundle {
	
    var body: some Widget {
        WalletStatusWidget()
		QuickExpenseWidget()
        WWWidgetsLiveActivity()
    }
}
