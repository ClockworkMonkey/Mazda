//
//  AppIntent.swift
//  CarWidget
//
//  Created by GG on 2024/2/3.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "设置"
    static var description = IntentDescription("描述")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
}
