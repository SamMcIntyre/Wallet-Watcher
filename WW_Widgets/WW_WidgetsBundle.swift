//
//  WW_WidgetsBundle.swift
//  WW_Widgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import WidgetKit
import SwiftUI

@main
struct WW_WidgetsBundle: WidgetBundle {
    var body: some Widget {
        ColoredWidget()
        WW_WidgetsLiveActivity()
    }
}
