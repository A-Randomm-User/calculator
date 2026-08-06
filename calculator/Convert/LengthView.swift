//
//  LengthView.swift
//  calculator
//
//  Created by Aaron on 26/07/2026.
//

import SwiftUI

struct LengthView: View {
    
    let units = [
        //---- metric
        "pm": 0.000000000001,
        "nm": 0.000000001,
        "µm": 0.000001,
        "mm": 0.001,
        "cm": 0.01,
        "dm": 0.1,
        "m": 1,
        "dam": 10,
        "hm": 100,
        "km": 1000,
        "Mm": 1000000,
        //---- imperial
        "in": 0.0254,
        "ft": 0.3048,
        "yd": 0.9144,
        "mi": 1609.344,
        "nmi": 1852,
        "fm": 1.8288,
        "fur": 201.168,
        //---- astronomical
        "AU": 149597870700,
        "ld": 384402000,
        "ly": 9460730472580800,
        "pc": 30856775814913672.78913938,
    ]
    
    @AppStorage("lengthInitialUnit") private var initialUnit: String = "cm"
    @AppStorage("lengthWantedUnit") private var wantedUnit: String = "m"
    @State private var input: Double? = nil
    
    @State private var output: String = ""
    
    @State private var animate = false
    
    func convert() {
        if let input {
            let metres = input * units[initialUnit]!
            let result = metres / units[wantedUnit]!
            
            withAnimation(.smooth) {
                output = "\((result * 10_000_000_000).rounded() / 10_000_000_000) \(wantedUnit)"
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                HStack(spacing: 20) {
                    Menu {
                        Text("Metric")
                        Button("Picometer (pm)") {
                            initialUnit = "pm"
                        }
                        Button("Nanometer (nm)") {
                            initialUnit = "nm"
                        }
                        Button("Micrometer (µm)") {
                            initialUnit = "µm"
                        }
                        Button("Millimeter (mm)") {
                            initialUnit = "mm"
                        }
                        Button("Centimeter (cm)") {
                            initialUnit = "cm"
                        }
                        Button("Decimeter (dm)") {
                            initialUnit = "dm"
                        }
                        Button("Meter (m)") {
                            initialUnit = "m"
                        }
                        Button("Decameter (dam)") {
                            initialUnit = "dam"
                        }
                        Button("Hectometer (hm)") {
                            initialUnit = "hm"
                        }
                        Button("Kilometer (km)") {
                            initialUnit = "km"
                        }
                        Button("Megameter (Mm)") {
                            initialUnit = "Mm"
                        }

                        Text("Imperial")
                        Button("Inch (in)") {
                            initialUnit = "in"
                        }
                        Button("Foot (ft)") {
                            initialUnit = "ft"
                        }
                        Button("Yard (yd)") {
                            initialUnit = "yd"
                        }
                        Button("Mile (mi)") {
                            initialUnit = "mi"
                        }
                        Button("Nautical Mile (nmi)") {
                            initialUnit = "nmi"
                        }
                        Button("Fathom (fm)") {
                            initialUnit = "fm"
                        }

                        Text("Others")
                        Button("Astronomical Unit (AU)") {
                            initialUnit = "AU"
                        }
                        Button("Light Year (ly)") {
                            initialUnit = "ly"
                        }
                        Button("Parsec (pc)") {
                            initialUnit = "pc"
                        }
                        Button("Lunar Distance (ld)") {
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
                        Text("Metric")
                        Button("Picometer (pm)") {
                            wantedUnit = "pm"
                        }
                        Button("Nanometer (nm)") {
                            wantedUnit = "nm"
                        }
                        Button("Micrometer (µm)") {
                            wantedUnit = "µm"
                        }
                        Button("Millimeter (mm)") {
                            wantedUnit = "mm"
                        }
                        Button("Centimeter (cm)") {
                            wantedUnit = "cm"
                        }
                        Button("Decimeter (dm)") {
                            wantedUnit = "dm"
                        }
                        Button("Meter (m)") {
                            wantedUnit = "m"
                        }
                        Button("Decameter (dam)") {
                            wantedUnit = "dam"
                        }
                        Button("Hectometer (hm)") {
                            wantedUnit = "hm"
                        }
                        Button("Kilometer (km)") {
                            wantedUnit = "km"
                        }
                        Button("Megameter (Mm)") {
                            wantedUnit = "Mm"
                        }

                        Text("Imperial")
                        Button("Inch (in)") {
                            initialUnit = "in"
                        }
                        Button("Foot (ft)") {
                            wantedUnit = "ft"
                        }
                        Button("Yard (yd)") {
                            wantedUnit = "yd"
                        }
                        Button("Mile (mi)") {
                            wantedUnit = "mi"
                        }
                        Button("Nautical Mile (nmi)") {
                            wantedUnit = "nmi"
                        }
                        Button("Fathom (fm)") {
                            wantedUnit = "fm"
                        }

                        Text("Others")
                        Button("Astronomical Unit (AU)") {
                            wantedUnit = "AU"
                        }
                        Button("Light Year (ly)") {
                            wantedUnit = "ly"
                        }
                        Button("Parsec (pc)") {
                            wantedUnit = "pc"
                        }
                        Button("Lunar Distance (ld)") {
                            wantedUnit = "ld"
                        }
                    } label: {
                        Text("Unit (2)")
                    }
                }
                
                Text("Unit (1): \(initialUnit)\nUnit (2): \(wantedUnit)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                HStack {
                    TextField("Enter input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: input) {
                            withAnimation(.smooth) {
                                output = ""
                            }
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
                            if input != nil {
                                convert()
                            } else {
                                withAnimation(.smooth) {
                                    output = "Choose a unit / enter a value"
                                }
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
                            if input != nil {
                                convert()
                            } else {
                                withAnimation(.smooth) {
                                    output = "Choose a unit / enter a value"
                                }
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
                            .contentTransition(.numericText())
                        
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 1)
            }
        }
        .navigationTitle("Convert length")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    LengthView()
}
