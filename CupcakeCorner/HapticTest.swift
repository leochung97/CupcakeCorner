//
//  HapticTest.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI
import CoreHaptics

// Apple's Taptic Engine allows the phone to vibrate in various ways
// Haptic effects only work on physical iPhones
// .increase is one of the built-in haptic feedback variants
// There are other variants such as .success, .warning, .error, .start, .stop, and more
// There is also more control through .impact() which has two variants:
// 1. You can specify how flexible your object is and how strong the effect should be
// 2. You can specify a weight and intensity

// For more advanced haptics, Apple provides us with a framework called Core Haptics
// Core Haptics let you create hugely customizable haptics by combining taps, continuous vibrations, parameter curves, and more

struct HapticTest: View {
    @State private var counter = 0
    // This is the actual object that's responsible for creating vibrations - you want you create it upfront before you add haptic effects
    @State private var engine: CHHapticEngine?
    
    // When creating the engine, you can attach handlers to help resume activity if it gets stopped (such as when the app is moved to the background)
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()

        // create one intense, sharp tap
        // .hapticIntensity controls intensity of the haptic effect
        // .hapcticSharpness controls the "sharpness" of the haptic effect
        // let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        // let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        // let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // events.append(event)

        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
    var body: some View {
        Button("Tap Me", action: complexSuccess)
            .onAppear(perform: prepareHaptics)
        
        // Button("Tap Count: \(counter)") {
        //     counter += 1
        // }
        // .sensoryFeedback(.increase, trigger: counter)
        // .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
        // .sensoryFeedback(.impact(weight: .heavy, intensity: 1), trigger: counter)
    }
}

#Preview {
    HapticTest()
}
