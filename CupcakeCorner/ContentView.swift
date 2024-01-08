//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var counter = 0
    
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
    }
}

#Preview {
    ContentView()
}
