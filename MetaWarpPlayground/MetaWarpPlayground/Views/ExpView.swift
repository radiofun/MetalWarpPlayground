//
//  ExpView.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

import SwiftUI

struct ExpView : View {
    
    @EnvironmentObject var settings : MetalSettings
    
    @State private var touchpoint = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    @State private var isMetalOn = false
    @State private var power = 0.05
    @State private var rippleIntensity : CGFloat = 1
    @State private var rippleParameter : CGFloat = 0.8
    @State private var iteration : CGFloat = 1
        
    var body: some View {
        BaseView()
            .layerEffect(ShaderLibrary.particlerand(.float2(settings.circleSize,settings.circleSize),.float2(touchpoint),.float(rippleIntensity),.float(rippleParameter),.float(iteration)), maxSampleOffset:CGSize(width: 200, height: 200))
        .onTapGesture { location in
            touchpoint = location

            rippleIntensity = settings.rippleIntensity
            rippleParameter = settings.rippleParameter
            withAnimation(.linear(duration: settings.rippleSpeed)){
                rippleIntensity = 0.1
                rippleParameter = 0.8
            }
        }
        .onAppear {
            rippleIntensity = 0.1
            rippleParameter = 0.8
            iteration = settings.rippleIterations
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    touchpoint = value.location
                    rippleIntensity = settings.rippleIntensity
                    rippleParameter = settings.rippleParameter

                }
                .onEnded { value in
                    withAnimation(.spring){
                        rippleIntensity = 0.1
                        rippleParameter = 0.8


                    }
                }
            )

    }
}
