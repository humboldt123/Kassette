//
//  ContentView.swift
//  Kassette
//
//  Created by Vish on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var spotifyController = SpotifyController.shared
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            if spotifyController.isAuthorized {
                if let currentTrack = spotifyController.currentTrack {
                    Text("Now Playing: \(currentTrack)")
                } else {
                    Text("No track playing")
                }
                Button("Refresh") {
                    spotifyController.getCurrentTrack()
                }
            } else {
                Button("Login to Spotify") {
                    spotifyController.authorize()
                }
            }
        }
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .onOpenURL { url in
            spotifyController.handleCallback(url: url)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            if spotifyController.isAuthorized {
                spotifyController.getCurrentTrack()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
#Preview {
    ContentView()
}
