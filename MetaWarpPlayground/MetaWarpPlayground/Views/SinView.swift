//
//  SinView.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

import SwiftUI

struct SinView: View {
    
    @EnvironmentObject var settings: MetalSettings
    
    @State private var dragging : CGPoint = .zero
    @State private var progress : Double = 0.3
    @State private var circleSize : CGFloat = 1000
    @State private var intensity : CGFloat = 0.0
    
    var body: some View {
        BaseView()
            .layerEffect(ShaderLibrary.particlesin(.float2(circleSize,circleSize),.float2(dragging),.float(intensity),.float(progress)), maxSampleOffset: CGSize(width: 200, height: 200))
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
                            circleSize = settings.circleSize * 6
                            intensity = 0.0
                            progress = 0.3
                        }
                    }
            )
    }
}
