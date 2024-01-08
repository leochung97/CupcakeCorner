//
//  AsyncImage.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

// If you want to load a remote image from the internet, you need to use AsyncImage instead of Image

struct ImageTest: View {
    let url = URL(string: "https://hws.dev/img/logo.png")
    
    // If you want to add modifiers to an image, you need to first wrap the image and then apply the modifiers to the wrapper
    // If you want complete control over your remote image, you will need to add a phase wrapper as well -> this will let you know if a download as failed as well
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    ImageTest()
}
