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
                Text("Version 1.0, Build 15")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.08.02")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. More conversion
                     2. Added animations
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 14")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.30")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Animations on Quadratic
                     2. Sidebar on iPad and Mac
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 13")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.30")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Conversion of Number systems
                     2. Better use on Liquid Glass
                     3. More localization
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 12")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.29")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. More units to length conversion
                     2. More localization
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 11")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.27")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. New Icon
                     2. Localization
                     
                     Fixed:
                     1. No Button for Simultaneous
                     2. Length should include displacement
                     3. TextField length unification for iOS 17 & 18 on Simultaneous
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
                Text("Version 1.0, Build 10")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Released in: 2026.07.26")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("""
                     This update added:
                     1. Finding 2 unknowns of Linear Simultaneous Equation
                     2. Length Conversion
                     3. Rounding up values on other modes
                     4. Distinguish modes in main menu
                     5. Improved entering values in in Sequence as keyboard users now can return to go to next TextField
                     """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer(minLength: 50)
                
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
