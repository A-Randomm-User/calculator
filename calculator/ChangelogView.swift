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
                Group {
                    Text("Version 1.0, Build 17")
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Text("Released in: 2026.08.07")
                    
                    Text("""
                         This update added:
                         1. More shapes available
                         2. Pie Chart
                         3. Renamed Interest to Model
                         4. Added more modes to Interest
                         5. Removed "?" and replace action with leaving empty
                         6. Volume Conversions
                         7. More units for Area and Length
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 16")
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Text("Released in: 2026.08.03")
                    
                    Text("""
                         This update added:
                         1. Area calculations
                         2. Optimize code
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 15")
                        .font(.title3)
                        .fontWeight(.bold)
                        
                    Text("Released in: 2026.08.02")
                    
                    Text("""
                         This update added:
                         1. More conversion
                         2. Added animations
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 14")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.30")
                    
                    Text("""
                         This update added:
                         1. Animations on Quadratic
                         2. Sidebar on iPad and Mac
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 13")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.30")
                    
                    Text("""
                         This update added:
                         1. Conversion of Number systems
                         2. Better use on Liquid Glass
                         3. More localization
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 12")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.29")
                    
                    Text("""
                         This update added:
                         1. More units to length conversion
                         2. More localization
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 11")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.27")
                    
                    Text("""
                         This update added:
                         1. New Icon
                         2. Localization
                         
                         Fixed:
                         1. No Button for Simultaneous
                         2. Length should include displacement
                         3. TextField length unification for iOS 17 & 18 on Simultaneous
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 10")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.26")
                    
                    Text("""
                         This update added:
                         1. Finding 2 unknowns of Linear Simultaneous Equation
                         2. Length Conversion
                         3. Rounding up values on other modes
                         4. Distinguish modes in main menu
                         5. Improved entering values in in Sequence as keyboard users now can return to go to next TextField
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 9")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.24")
                    
                    Text("""
                         This update added:
                         1. Finding unknown from Simple or Compound interest
                         2. New Icon
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 8")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.23")
                    
                    Text("""
                         This update added:
                         1. Binary to Denary and inversely conversion
                         2. Adaptation to iOS 26 Liquid Glass
                         """)
                    
                    Spacer(minLength: 50)
                    
                    Text("Version 1.0, Build 7")
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("Released in: 2026.07.23")
                    
                    Text("""
                         This update added:
                         1. Binary to Denary and inversely conversion
                         2. Adaptation to iOS 26 Liquid Glass

                         Known Issues:
                         1. Conversion does not convert negative numbers
                         2. Decimal point can be entered in Conversion and will return a wrong value
                         """)
                }
                .modifier(TextAlignmentLeadingStyle())
            }
        }
    }
}

#Preview {
    ChangelogView()
}
