//
//  calculatorApp.swift
//  calculator
//
//  Created by Aaron on 09/07/2026.
//

import SwiftUI

@main
struct calculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CalculatorCommands()
        }
    }
}
