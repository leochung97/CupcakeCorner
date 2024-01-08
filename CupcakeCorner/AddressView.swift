//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

struct AddressView: View {
    // Bindable property wrapper creates missing bindings -> it produces two-way bindings that are able to work with the @Observable macro without having to use @State to create local data
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                 TextField("Name", text: $order.name)
                 TextField("Street Address", text: $order.streetAddress)
                 TextField("City", text: $order.city)
                 TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
