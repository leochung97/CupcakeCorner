//
//  iTunesAPI.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct iTunesAPI: View {
    @State private var results = [Result]()
    
    // Async functions exist in SwiftUI -> similar to JS / TS
    // SwiftUI uses task() modifier to cal,ll functions that might be async
    // You must mark the async functions with await in the task modifier
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        // data(from:) method takes a URl and returns the Data object at that URL -> method belongs to the URLSession class, which you can create and configure manually
        // The return value from data(from:) is a tuple containing the data from the URL and some metadata describing how the request went -> we do want the URL's data but don't care about the metadata, which is why we toss it away with an underscore
        // When using both try and await, you must write try await
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
}

#Preview {
    iTunesAPI()
}
