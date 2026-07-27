//
//  LengthView.swift
//  calculator
//
//  Created by Aaron on 26/07/2026.
//

import SwiftUI

struct LengthView: View {
    
    let units = [
        "mm": 0.001,
        "cm": 0.01,
        "dm": 0.1,
        "m": 1,
        "km": 1000,
        "in": 0.0254,
        "ft": 0.3048,
        "yd": 0.9144,
        "mi": 1609.344,
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
            
            output = "\((result * 100).rounded() / 100)\(wantedUnit)"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Convert units in length")
                    .font(.title)
                    .fontWeight(.black)
                
                Text("Unit (1): \(initialUnit ?? "select")\nUnit (2): \(wantedUnit ?? "select")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                HStack {
                    TextField("Enter input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .padding(.horizontal, 30)
                        .background {
                            if #available(iOS 26.0, *) {
                                RoundedRectangle(cornerRadius: 30)
                                    .opacity(0)
                                    .glassEffect()
                                    .padding(.horizontal)
                            } else {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.gray.opacity(0.15))
                                    .padding(.horizontal)
                            }
                        }
                        .onChange(of: input) {
                            output = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = input {
                                    input = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animate
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = input {
                                    input = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("Convert") {
                            if initialUnit != nil && wantedUnit != nil && input != nil {
                                convert()
                            } else {
                                output = "Choose a unit / enter a value"
                            }
                        }
                        .padding()
                        .buttonStyle(.glass)
                    } else {
                        Button("Convert") {
                            if initialUnit != nil && wantedUnit != nil && input != nil {
                                convert()
                            } else {
                                output = "Choose a unit / enter a value"
                            }
                        }
                        .padding()
                        .buttonStyle(.bordered)
                    }
                }
                
                Text("Output: \(output)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 20) {
                    Menu {
                        Button("Milimetres (mm)") {
                            initialUnit = "mm"
                        }
                        Button("Centimetres (cm)") {
                            initialUnit = "cm"
                        }
                        Button("Decimetres (dm)") {
                            initialUnit = "dm"
                        }
                        Button("Metres (m)") {
                            initialUnit = "m"
                        }
                        Button("Kilometres (km)") {
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
                        Button("Milimetres (mm)") {
                            wantedUnit = "mm"
                        }
                        Button("Centimetres (cm)") {
                            wantedUnit = "cm"
                        }
                        Button("Decimetres (dm)") {
                            wantedUnit = "dm"
                        }
                        Button("Metres (m)") {
                            wantedUnit = "m"
                        }
                        Button("Kilometres (km)") {
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
