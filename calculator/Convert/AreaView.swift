//
//  AreaView.swift
//  calculator
//
//  Created by Aaron on 26/07/2026.
//

import SwiftUI

struct AreaView: View {
    
    let units = [
        "mm²": 0.000001,
        "cm²": 0.001,
        "dm²": 0.01,
        "m²": 1,
        "km²": 100000,
        "ha": 10000,
        "in²": 0.00064516,
        "ft²": 0.09290304,
        "yd²": 0.83612736,
        "mi²": 2589988.110336,
        "ac": 4046.8564224,
    ]
    
    @AppStorage("areaInitialUnit") private var initialUnit: String = "cm²"
    @AppStorage("areaWantedUnit") private var wantedUnit: String = "m²"
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack(spacing: 20) {
                    Menu {
                        Button("Sqr Milimeter (mm²)") {
                            initialUnit = "mm²"
                        }
                        Button("Sqr Centimeter (cm²)") {
                            initialUnit = "cm²"
                        }
                        Button("Sqr Decimeter (dm²)") {
                            initialUnit = "dm²"
                        }
                        Button("Sqr Meter (m²)") {
                            initialUnit = "m²"
                        }
                        Button("Sqr Kilometer (km²)") {
                            initialUnit = "km²"
                        }
                        Button("Hectare (ha)") {
                            initialUnit = "ha"
                        }
                        Button("Sqr Inch (in²)") {
                            initialUnit = "in²"
                        }
                        Button("Sqr Feet (ft²)") {
                            initialUnit = "ft²"
                        }
                        Button("Sqr Yard (yd²)") {
                            initialUnit = "yd²"
                        }
                        Button("Sqr Mile (mi²)") {
                            initialUnit = "mi²"
                        }
                        Button("Acres (ac)") {
                            initialUnit = "ac"
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
                        Button("Sqr Milimeter (mm²)") {
                            wantedUnit = "mm²"
                        }
                        Button("Sqr Centimeter (cm²)") {
                            wantedUnit = "cm²"
                        }
                        Button("Sqr Decimeter (dm²)") {
                            wantedUnit = "dm²"
                        }
                        Button("Sqr Meter (m²)") {
                            wantedUnit = "m²"
                        }
                        Button("Sqr Kilometer (km²)") {
                            wantedUnit = "km²"
                        }
                        Button("Hectare (ha)") {
                            wantedUnit = "ha"
                        }
                        Button("Sqr Inch (in²)") {
                            wantedUnit = "in²"
                        }
                        Button("Sqr Feet (ft²)") {
                            wantedUnit = "ft²"
                        }
                        Button("Sqr Yard (yd²)") {
                            wantedUnit = "yd²"
                        }
                        Button("Sqr Mile (mi²)") {
                            wantedUnit = "mi²"
                        }
                        Button("Acres (ac)") {
                            wantedUnit = "ac"
                        }
                    } label: {
                        Text("Unit (2)")
                    }
                }
            }
        }
        .navigationTitle("Convert area")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    AreaView()
}
