//
//  TanView.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

import SwiftUI

struct TanView : View {
    
    @EnvironmentObject var settings: MetalSettings
    
    let screensize = UIScreen.main.bounds
    @State private var dragging : CGPoint
    @State private var progress : Double = 0.3
    @State private var circleSize : CGFloat = 600
    @State private var intensity : CGFloat = 0.0
    
    init() {
        _dragging = .init(initialValue: CGPoint(x: screensize.width/2, y: screensize.height/2))
    }
    

    var body: some View {
        ZStack{
            BaseView()
            .frame(width:UIScreen.main.bounds.width)
            .layerEffect(ShaderLibrary.particletan(.float2(settings.circleSize,settings.circleSize),.float2(dragging),.float(intensity),.float(progress)), maxSampleOffset: CGSize(width: 200, height: 200))
            .onTapGesture { location in
                dragging = location
                circleSize = settings.circleSize
                intensity = settings.rippleIntensity
                progress = settings.rippleParameter
                if settings.isHapticOn {
                    Haptic.triggerHapticFeedback(style: .light)
                }
                withAnimation(.linear(duration:settings.rippleSpeed)) {
                    circleSize = settings.circleSize
                    intensity = 0.0
                    progress = 0.0
                }
                
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        circleSize = settings.circleSize
                        dragging = value.location
                        intensity = settings.rippleIntensity
                        progress = settings.rippleParameter
                        if settings.isHapticOn {
                            Haptic.triggerHapticFeedback(style: .light)
                        }
                    }
                    .onEnded { _ in
                        withAnimation(.linear(duration: settings.rippleSpeed)){
                            dragging = CGPoint(x:UIScreen.main.bounds.width/2,y:UIScreen.main.bounds.height/2)
                            circleSize = settings.circleSize * 4
                            intensity = 0.0
                            progress = 0.0
                        }
                        
                        if settings.isHapticOn {
                            Haptic.triggerHapticFeedback(style: .medium)
                        }
                    }
            )
        }
        .ignoresSafeArea()
    }
}
