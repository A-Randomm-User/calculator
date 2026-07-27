//
//  ChangelogView.swift
//  calculator
//
//  Created by Aaron on 23/07/2026.
//

import SwiftUI

struct ChangelogView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Version 1.0, Build 9")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.24")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Finding unknown from Simple or Compound interest
                     2. New Icon
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 8")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.23")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Binary to Denary and inversely conversion
                     2. Adaptation to iOS 26 Liquid Glass
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 7")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.23")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Binary to Denary and inversely conversion
                     2. Adaptation to iOS 26 Liquid Glass

                     Known Issues:
                     1. Conversion does not convert negative numbers
                     2. Decimal point can be entered in Conversion and will return a wrong value
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    ChangelogView()
}
