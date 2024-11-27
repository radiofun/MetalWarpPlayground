//
//  SettingsView.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

import SwiftUI

struct SettingsView : View {
    
    @EnvironmentObject var settings: MetalSettings
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Ripple Size")){
                    HStack{
                        Slider(value: $settings.circleSize, in:0...800.0)
                            .tint(.orange)
                        Text("\(settings.circleSize, specifier: "%.0f")")
                    }
                }
                Section(header: Text("Ripple Intensity")){
                    HStack{
                        Slider(value: $settings.rippleIntensity, in:0...10.0)
                            .tint(.orange)
                        Text("\(settings.rippleIntensity, specifier: "%.2f")")
                    }
                }
                Section(header: Text("Ripple Damper")){
                    HStack{
                        Slider(value: $settings.rippleParameter, in:0...1.0)
                            .tint(.orange)
                        Text("\(settings.rippleParameter, specifier: "%.2f")")
                    }
                }
                Section(header: Text("Ripple Speed")){
                    HStack{
                        Slider(value: $settings.rippleSpeed, in:0...3.0)
                            .tint(.orange)
                        Text("\(settings.rippleSpeed, specifier: "%.2f")")
                    }
                }
                Section(header: Text("CA Multiplier")){
                    HStack{
                        Stepper {
                            Text("\(settings.rippleIterations, specifier: "%.0f")")
                        } onIncrement: {
                            settings.rippleIterations += 1
                        } onDecrement: {
                            settings.rippleIterations -= 1
                        }
                    }
                }

                Section(header: Text("Haptic Feedback")){
                    Toggle("Haptic Feedback", isOn: $settings.isHapticOn)
                        .tint(.orange)
                }
                Section {
                    Text("Reset to Default")
                        .onTapGesture {
                            settings.isHapticOn = false
                            settings.circleSize = 600
                            settings.rippleIntensity = 1.6
                            settings.rippleParameter = 0.3
                            settings.rippleSpeed = 1.0
                        }
                }

            }
            .navigationTitle("Settings")
            .colorScheme(.dark)
            .background(Color.black)

        }
    }
}
