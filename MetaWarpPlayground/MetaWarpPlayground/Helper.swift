//
//  Helper.swift
//  MetaWarpPlayground
//
//  Created by Minsang Choi on 11/27/24.
//

import SwiftUI


class MetalSettings : ObservableObject {
    @Published var isHapticOn : Bool = false
    @Published var circleSize : CGFloat = 600
    @Published var rippleIntensity : CGFloat = 1.6
    @Published var rippleParameter : CGFloat = 0.3
    @Published var rippleSpeed : CGFloat = 1.0
    @Published var rippleIterations : CGFloat = 2.0
}
class Haptic {
    static func triggerHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
        }
    }
}
