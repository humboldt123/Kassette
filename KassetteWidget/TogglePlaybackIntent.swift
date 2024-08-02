//
//  TogglePlaybackIntent.swift
//  KassetteWidgetExtension
//
//  Created by Vish on 8/1/24.
//

import AppIntents
import WidgetKit

struct TogglePlaybackIntent: AppIntent {
    static var title: LocalizedStringResource = "Toggle Playback"
    
    func perform() async throws -> some IntentResult {
        print("togle plaerback")
        
        NotificationCenter.default.post(name: Notification.Name("TogglePlayback"), object: nil)
        
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}
