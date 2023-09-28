//
//  WW_WidgetsLiveActivity.swift
//  WW_Widgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WW_WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WW_WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WW_WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension WW_WidgetsAttributes {
    fileprivate static var preview: WW_WidgetsAttributes {
        WW_WidgetsAttributes(name: "World")
    }
}

extension WW_WidgetsAttributes.ContentState {
    fileprivate static var smiley: WW_WidgetsAttributes.ContentState {
        WW_WidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WW_WidgetsAttributes.ContentState {
         WW_WidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WW_WidgetsAttributes.preview) {
   WW_WidgetsLiveActivity()
} contentStates: {
    WW_WidgetsAttributes.ContentState.smiley
    WW_WidgetsAttributes.ContentState.starEyes
}
