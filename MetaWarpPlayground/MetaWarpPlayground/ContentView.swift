//
//  ContentView.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//
import SwiftUI
import UIKit

struct ContentView: View {
    
    @StateObject var settings = MetalSettings()
    
    init() {
        customizeTabBarAppearance()
    }

    var body: some View {
        ZStack{
            TabView {
                ExpView()
                    .environmentObject(settings)
                    .tabItem {
                        Label("Exp", systemImage: "angle")
                    }
                SinView()
                    .environmentObject(settings)
                    .tabItem {
                        Label("Sin", systemImage: "waveform")
                    }
                CosView()
                    .environmentObject(settings)
                    .tabItem {
                        Label("Cos", systemImage:"wave.3.forward")
                    }
                TanView()
                    .environmentObject(settings)
                    .tabItem {
                        Label("Tan", systemImage: "triangle")
                    }
                SettingsView()
                    .environmentObject(settings)
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
            .tint(.white)
            .colorScheme(.dark)

        }
    }
    
    func customizeTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black // Tab bar background color
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.orange
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.orange]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray]

        UITabBar.appearance().standardAppearance = appearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

}

#Preview {
    ContentView()
}
