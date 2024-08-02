//
//  KassetteWidget.swift
//  KassetteWidget
//
//  Created by Vish on 8/1/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    let emptyTrack = TrackInfo(
        trackName: "Not Playing",
        artistName: "",
        trackImageData: nil,
        isPlaying: false
    )
    func placeholder(in context: Context) -> TrackEntry {
        TrackEntry(date: Date(), trackInfo: emptyTrack)
    }
    func getSnapshot(in context: Context, completion: @escaping (TrackEntry) -> ()) {
        let entry = TrackEntry(date: Date(), trackInfo: SpotifyManager.shared.getTrackInfo() ?? emptyTrack)
            
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 5, to: currentDate)!
        
        let entry = TrackEntry(date: currentDate, trackInfo: SpotifyManager.shared.getTrackInfo() ?? emptyTrack)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

struct TrackEntry: TimelineEntry {
    let date: Date
    let trackInfo: TrackInfo
}

struct KassetteWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.trackInfo.trackName)
                .font(.headline)
            Text(entry.trackInfo.artistName)
                .font(.subheadline)
            Button(intent: TogglePlaybackIntent()) {
                Image(systemName: entry.trackInfo.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 30))
            }
        }
    }
}

struct KassetteWidget: Widget {
    let kind: String = "KassetteWidget"
    

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                KassetteWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                KassetteWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Kassette")
        .description("Media display widget for Spotify!")
    }
}

func fetchImageData(from url: URL?) -> Data? {
    guard let url = url else { return nil }
    guard let data = try? Data(contentsOf: url) else { return nil }
    return data
}

#Preview(as: .systemMedium) {
    KassetteWidget()
} timeline: {
    TrackEntry(date: .now, trackInfo: 
                TrackInfo(
                    trackName: "Like You Do",
                    artistName: "Joji",
                    trackImageData: fetchImageData(from: URL(string: "https://i.scdn.co/image/ab67616d00001e028da6404284573219a9b1e2f4")),
                    isPlaying: true
                )
    )
}
