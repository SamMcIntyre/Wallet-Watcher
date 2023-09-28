//
//  WWWidgetsLiveActivity.swift
//  WWWidgets
//
//  Created by Sam McIntyre on 9/28/23.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WWWidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WWWidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WWWidgetsAttributes.self) { context in
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

extension WWWidgetsAttributes {
    fileprivate static var preview: WWWidgetsAttributes {
        WWWidgetsAttributes(name: "World")
    }
}

extension WWWidgetsAttributes.ContentState {
    fileprivate static var smiley: WWWidgetsAttributes.ContentState {
        WWWidgetsAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WWWidgetsAttributes.ContentState {
         WWWidgetsAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WWWidgetsAttributes.preview) {
   WWWidgetsLiveActivity()
} contentStates: {
    WWWidgetsAttributes.ContentState.smiley
    WWWidgetsAttributes.ContentState.starEyes
}
