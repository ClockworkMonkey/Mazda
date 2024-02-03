//
//  CarWidgetLiveActivity.swift
//  CarWidget
//
//  Created by GG on 2024/2/3.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct CarWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CarWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CarWidgetAttributes.self) { context in
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

extension CarWidgetAttributes {
    fileprivate static var preview: CarWidgetAttributes {
        CarWidgetAttributes(name: "World")
    }
}

extension CarWidgetAttributes.ContentState {
    fileprivate static var smiley: CarWidgetAttributes.ContentState {
        CarWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: CarWidgetAttributes.ContentState {
         CarWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: CarWidgetAttributes.preview) {
   CarWidgetLiveActivity()
} contentStates: {
    CarWidgetAttributes.ContentState.smiley
    CarWidgetAttributes.ContentState.starEyes
}
