//
//  SpotifyManager.swift
//  Kassette
//
//  Created by Vish on 8/1/24.
//

import Foundation
import WidgetKit

struct TrackInfo: Codable {
    let trackName: String
    let artistName: String
    let trackImageData: Data?
    let isPlaying: Bool
}

class SpotifyManager {
    static let shared = SpotifyManager()
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults(suiteName: "group.info.vivime.Kassette")!
    }
    
    func saveTrackInfo(_ trackInfo: TrackInfo) {
        do {
            let data = try JSONEncoder().encode(trackInfo)
            userDefaults.set(data, forKey: "currentTrack")
            WidgetCenter.shared.reloadAllTimelines()
        } catch {
            print("Error saving track info: \(error)")
        }
    }
    
    func getTrackInfo() -> TrackInfo? {
        guard let data = userDefaults.data(forKey: "currentTrack") else { return nil }
        do {
            return try JSONDecoder().decode(TrackInfo.self, from: data)
        } catch {
            print("Error loading track info: \(error)")
            return nil
        }
    }

}
