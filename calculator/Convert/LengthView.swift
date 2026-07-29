//
//  LengthView.swift
//  calculator
//
//  Created by Aaron on 26/07/2026.
//

import SwiftUI

struct LengthView: View {
    
    let units = [
        "pm": 0.000000000001,
        "nm": 0.000000001,
        "µm": 0.000001,
        "mm": 0.001,
        "cm": 0.01,
        "dm": 0.1,
        "m": 1,
        "km": 1000,
        "in": 0.0254,
        "ft": 0.3048,
        "yd": 0.9144,
        "mi": 1609.344,
        "nmi": 1852,
        "fm": 1.828800164445711,
        "fur": 201.168,
        "AU": 149597870700,
        "ly": 9460730472580800,
        "pc": 30856775814913672.78913938,
        "ld": 384402000,
    ]
    
    @State var initialUnit: String? = nil
    @State var wantedUnit: String? = nil
    @State var input: Double? = nil
    
    @State var output: String = ""
    
    @State var animate = false
    
    func convert() {
        if let input, let initialUnit, let wantedUnit {
            let metres = input * units[initialUnit]!
            let result = metres / units[wantedUnit]!
            
            output = "\((result * 10_000_000_000).rounded() / 10_000_000_000) \(wantedUnit)"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Convert units in length")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 20)
                
                Text("Unit (1): \(initialUnit ?? String(localized: "Select"))\nUnit (2): \(wantedUnit ?? String(localized: "Select"))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                HStack {
                    TextField("Enter input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: input) {
                            output = ""
                        }
                    
                    Button {
                        if let value = input {
                            input = -value
                        }
                        
                        animate.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animate
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Spacer(minLength: 20)
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            if initialUnit != nil && wantedUnit != nil && input != nil {
                                convert()
                            } else {
                                output = "Choose a unit / enter a value"
                            }
                        } label: {
                            Text("Convert")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            if initialUnit != nil && wantedUnit != nil && input != nil {
                                convert()
                            } else {
                                output = "Choose a unit / enter a value"
                            }
                        } label: {
                            Text("Convert")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer(minLength: 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        Text("Output")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        Text("\(output)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 1)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 20) {
                    Menu {
                        Button("Picometer (pm)") {
                            initialUnit = "pm"
                        }
                        Button("Nanometer (nm)") {
                            initialUnit = "nm"
                        }
                        Button("Micrometers (µm)") {
                            initialUnit = "µm"
                        }
                        Button("Milimeters (mm)") {
                            initialUnit = "mm"
                        }
                        Button("Centimeters (cm)") {
                            initialUnit = "cm"
                        }
                        Button("Decimeters (dm)") {
                            initialUnit = "dm"
                        }
                        Button("Meters (m)") {
                            initialUnit = "m"
                        }
                        Button("Kilometers (km)") {
                            initialUnit = "km"
                        }
                        Button("Inch (in)") {
                            initialUnit = "in"
                        }
                        Button("Foot (ft)") {
                            initialUnit = "ft"
                        }
                        Button("Yard (yd)") {
                            initialUnit = "yd"
                        }
                        Button("Miles (mi)") {
                            initialUnit = "mi"
                        }
                        Button("Nautical mile (nmi)") {
                            initialUnit = "nmi"
                        }
                        Button("fathom (fm)") {
                            initialUnit = "fm"
                        }
                        Button("Astronomical Unit (AU)") {
                            initialUnit = "AU"
                        }
                        Button("Light years (ly)") {
                            initialUnit = "ly"
                        }
                        Button("Parsec (pc)") {
                            initialUnit = "pc"
                        }
                        Button("Lunar distance (ld)") {
                            initialUnit = "ld"
                        }
                    } label: {
                        Text("Unit (1)")
                    }

                    Button {
                        let temp = initialUnit
                        initialUnit = wantedUnit
                        wantedUnit = temp
                    } label: {
                        Image(systemName: "arrow.right.arrow.left")
                    }
                    
                    Menu {
                        Button("Picometer (pm)") {
                            wantedUnit = "pm"
                        }
                        Button("Nanometer (nm)") {
                            wantedUnit = "µm"
                        }
                        Button("Micrometers (µm)") {
                            wantedUnit = "um"
                        }
                        Button("Milimeters (mm)") {
                            wantedUnit = "mm"
                        }
                        Button("Centimeters (cm)") {
                            wantedUnit = "cm"
                        }
                        Button("Decimeters (dm)") {
                            wantedUnit = "dm"
                        }
                        Button("Meters (m)") {
                            wantedUnit = "m"
                        }
                        Button("Kilometers (km)") {
                            wantedUnit = "km"
                        }
                        Button("Inch (in)") {
                            wantedUnit = "in"
                        }
                        Button("Foot (ft)") {
                            wantedUnit = "ft"
                        }
                        Button("Yard (yd)") {
                            wantedUnit = "yd"
                        }
                        Button("Miles (mi)") {
                            wantedUnit = "mi"
                        }
                        Button("Nautical mile (nmi)") {
                            wantedUnit = "nmi"
                        }
                        Button("fathom (fm)") {
                            wantedUnit = "fm"
                        }
                        Button("Astronomical Unit (AU)") {
                            wantedUnit = "AU"
                        }
                        Button("Light years (ly)") {
                            wantedUnit = "ly"
                        }
                        Button("Parsec (pc)") {
                            wantedUnit = "pc"
                        }
                        Button("Lunar distance (ld)") {
                            wantedUnit = "ld"
                        }
                    } label: {
                        Text("Unit (2)")
                    }
                }
            }
        }
    }
}

#Preview {
    LengthView()
}
