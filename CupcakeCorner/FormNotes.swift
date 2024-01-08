//
//  FormNotes.swift
//  CupcakeCorner
//
//  Created by Leo Chung on 1/8/24.
//

import SwiftUI

// Form view lets us store user input in a fast and convenient way but you need to check that input to make sure it's valid before you proceed
// disabled() modifier will take a condition to check and then disable anything if the condition is met

struct FormNotes: View {
    @State private var username = ""
    @State private var email = ""
    
    // You can even spin out your conditions into a separate computed property as such
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account...")
                }
            }
            // .disabled(username.isEmpty || email.isEmpty)
            .disabled(disableForm)
        }
    }
}

#Preview {
    FormNotes()
}
