//
//  CalculatorCommands.swift
//  calculator
//
//  Created by Aaron on 27/07/2026.
//

import SwiftUI

struct CalculatorCommands: Commands {
    var body: some Commands {
        CommandMenu("Math") {
            
            Button {
                NotificationCenter.default.post(
                    name: .openCalculator,
                    object: "quadratic"
                )
            } label: {
                Label(String(localized: "Quadratic"), systemImage: "function")
            }
        }
    }
}

extension Notification.Name {
    static let openCalculator = Notification.Name("openCalculator")
}
