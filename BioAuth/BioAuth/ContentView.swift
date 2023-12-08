//
//  ContentView.swift
//  BioAuth
//
//  Created by Natascha Baumgartner on 08.12.23.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {
    @State private var unlocked = false
    @State private var text = "LOCKED"
    
    var body: some View {
        VStack {
            Text(text)
                .bold()
            .padding()
            
            Button("Authenticate") {
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "This is a security check reason.") { success, authenticationError in
                
                if success {
                    text = "UNLOCKED"
                } else {
                    text = "There was a problem!"
                }
            }
        } else {
            text = "Phone does not have biometrics"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
