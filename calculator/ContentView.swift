//
//  ContentView.swift
//  calculator
//
//  Created by Aaron on 09/07/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text("Math")
                    .font(.title3)
                
                NavigationLink("Find unknown on Simple / Compound Interest") {
                    InterestView()
                }

                NavigationLink("Solve Quadratic Equation") {
                    QuadraticView()
                }

                NavigationLink("Find nth term in Sequence") {
                    SequenceView()
                }

                Text("Computer Science")
                    .font(.title3)

                NavigationLink("Conversion of Binary to Denary") {
                    BinaryDenaryView()
                }

                Spacer()

                NavigationLink("About Build 9") {
                    ChangelogView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()

            .navigationTitle("Calculator")
        }
        
        VStack {
            Text("Version 1.0, Build 9")
            Text("Created by Aaron")
        }
    }
}

#Preview {
    ContentView()
}
