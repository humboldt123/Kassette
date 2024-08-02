//
//  KassetteApp.swift
//  Kassette
//
//  Created by Vish on 8/1/24.
//

import SwiftUI

@main
struct KassetteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UISceneDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        handleURL(url)
        return true
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleURL(url)
    }
    
    private func handleURL(_ url: URL) {
        print("Received URL: \(url)")
        let spotifyController = SpotifyController.shared
        spotifyController.handleCallback(url: url)
    }
}
