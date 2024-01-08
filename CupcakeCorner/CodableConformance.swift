//
//  CodableConformance.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

// Observable macro is quietly rewriting our class so that it can be monitored by SwiftUI -> this rewriting is leaking if we don't write strict methods to encode and decode data
@Observable
class User: Codable {
    // the enum is CodingKeys and the protocol is CodingKey -> this matters in order!
    // Inside the enum, you need to write one case for each property that you want to save along with a raw value containing the name you want to give it
    // Note: This coding key mapping works both ways: when Codable sees name in some JSON, it will automatically be saved in the _name property
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    
    var name = "Taylor"
}

struct CodableConformance: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
}

#Preview {
    CodableConformance()
}
