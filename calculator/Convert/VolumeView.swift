//
//  VolumeView.swift
//  calculator
//
//  Created by Aaron on 04/08/2026.
//

import SwiftUI

struct VolumeView: View {
    
    let units = [
        //---- metric
        "mm³": 0.000000000001,
        "cm³": 0.000001,
        "dm³": 0.0001,
        "m³": 1,
        "km³": 1000000000,
        "μL": 0.000000001,
        "nL": 0.000000000001,
        "mL": 0.000001,
        "cL": 0.00001,
        "dL": 0.0001,
        "L": 0.001,
        "daL": 0.01,
        "hL": 0.1,
        //---- imperial
        "in³": 0.000016387064,
        "ft³": 0.028316846592,
        "yd³": 0.764554857984,
        "mi³": 4168181825.44058,
        //---- us
        "US tsp": 0.00000492892159375,
        "US fl dr": 0.0000036966911953125,
        "US fl oz": 0.0000295735295625,
        "US tbsp": 0.00001478676478125,
        "US gi": 0.00011829411825,
        "US cup": 0.0002365882365,
        "US pt": 0.000473176473,
        "US qt": 0.000946352946,
        "US gal": 0.003785411784,
        "US bbl": 0.158987294928,
        //---- uk
        "UK fl dr": 0.0000035516328125,
        "UK tsp": 0.000005919388020833,
        "UK fl oz": 0.0000284130625,
        "UK tbsp": 0.0000177581640625,
        "UK gi": 0.0001420653125,
        "UK cup": 0.000284130625,
        "UK pt": 0.00056826125,
        "UK qt": 0.0011365225,
        "UK gal": 0.00454609,
        //---- other
        "ac·ft": 1233.48183754752,
        "bd ft": 0.002359737216,
    ]
    
    @AppStorage("volInitialUnit") private var initialUnit: String = "cm³"
    @AppStorage("volWantedUnit") private var wantedUnit: String = "m³"
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
                        Button("Cubic Millimeter (mm³)") {
                            initialUnit = "mm³"
                        }
                        Button("Cubic Centimeter (cm³)") {
                            initialUnit = "cm³"
                        }
                        Button("Cubic Decimeter (dm³)") {
                            initialUnit = "dm³"
                        }
                        Button("Cubic Meter (m³)") {
                            initialUnit = "m³"
                        }
                        Button("Cubic Kilometer (km³)") {
                            initialUnit = "km³"
                        }
                        Button("Microliter (μL)") {
                            initialUnit = "μL"
                        }
                        Button("Nanoliter (nL)") {
                            initialUnit = "nL"
                        }
                        Button("Milliliter (mL)") {
                            initialUnit = "mL"
                        }
                        Button("Centiliter (cL)") {
                            initialUnit = "cL"
                        }
                        Button("Deciliter (dL)") {
                            initialUnit = "dL"
                        }
                        Button("Liter (L)") {
                            initialUnit = "L"
                        }
                        Button("Decaliter (daL)") {
                            initialUnit = "daL"
                        }
                        Button("Hectoliter (hL)") {
                            initialUnit = "hL"
                        }
                        Text("Imperial")
                        Button("Cubic Inch (in³)") {
                            initialUnit = "in³"
                        }
                        Button("Cubic Foot (ft³)") {
                            initialUnit = "ft³"
                        }
                        Button("Cubic yard (yd³)") {
                            initialUnit = "yd³"
                        }
                        Button("Cubic mile (mi³)") {
                            initialUnit = "mi³"
                        }
                        
                        Text("US")
                        Button("Teaspoon (tsp)") {
                            initialUnit = "US tsp"
                        }
                        Button("Fluid Dram (fl dr)") {
                            initialUnit = "US fl dr"
                        }
                        Button("Fluid Ounce (fl oz)") {
                            initialUnit = "US fl oz"
                        }
                        Button("Tablespoon (tbsp)") {
                            initialUnit = "US tbsp"
                        }
                        Button("Gills (gi)") {
                            initialUnit = "US gi"
                        }
                        Button("Cup (cup)") {
                            initialUnit = "US cup"
                        }
                        Button("Pint (pt)") {
                            initialUnit = "US pt"
                        }
                        Button("Quart (qt)") {
                            initialUnit = "US qt"
                        }
                        Button("Gallon (gal)") {
                            initialUnit = "US gal"
                        }
                        Button("Barrel (bbl)") {
                            initialUnit = "US bbl"
                        }
                        
                        Text("UK")
                        Button("Fluid Dram (fl dr)") {
                            initialUnit = "UK fl dr"
                        }
                        Button("Teaspoon (tsp)") {
                            initialUnit = "UK tsp"
                        }
                        Button("Fluid Ounce (fl oz)") {
                            initialUnit = "UK fl oz"
                        }
                        Button("Tablespoon (tbsp)") {
                            initialUnit = "UK tbsp"
                        }
                        Button("Gills (gi)") {
                            initialUnit = "UK gi"
                        }
                        Button("Cup (cup)") {
                            initialUnit = "UK cup"
                        }
                        Button("Pint (pt)") {
                            initialUnit = "UK pt"
                        }
                        Button("Quart (qt)") {
                            initialUnit = "UK qt"
                        }
                        Button("Gallon (gal)") {
                            initialUnit = "UK gal"
                        }
                        
                        Text("Others")
                        Button("Acre Foot (ac·ft)") {
                            initialUnit = "ac·ft"
                        }
                        Button("Board Foot (bd ft)") {
                            initialUnit = "bd ft"
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
                        Button("Cubic Millimeter (mm³)") {
                            wantedUnit = "mm³"
                        }
                        Button("Cubic Centimeter (cm³)") {
                            wantedUnit = "cm³"
                        }
                        Button("Cubic Decimeter (dm³)") {
                            wantedUnit = "dm³"
                        }
                        Button("Cubic Meter (m³)") {
                            wantedUnit = "m³"
                        }
                        Button("Cubic Kilometer (km³)") {
                            wantedUnit = "km³"
                        }
                        Button("Microliter (μL)") {
                            wantedUnit = "μL"
                        }
                        Button("Nanoliter (nL)") {
                            wantedUnit = "nL"
                        }
                        Button("Milliliter (mL)") {
                            wantedUnit = "mL"
                        }
                        Button("Centiliter (cL)") {
                            wantedUnit = "cL"
                        }
                        Button("Deciliter (dL)") {
                            wantedUnit = "dL"
                        }
                        Button("Liter (L)") {
                            wantedUnit = "L"
                        }
                        Button("Decaliter (daL)") {
                            wantedUnit = "daL"
                        }
                        Button("Hectoliter (hL)") {
                            wantedUnit = "hL"
                        }
                        Text("Imperial")
                        Button("Cubic Inch (in³)") {
                            wantedUnit = "in³"
                        }
                        Button("Cubic Foot (ft³)") {
                            wantedUnit = "ft³"
                        }
                        Button("Cubic yard (yd³)") {
                            wantedUnit = "yd³"
                        }
                        Button("Cubic mile (mi³)") {
                            wantedUnit = "mi³"
                        }
                        
                        Text("US")
                        Button("Teaspoon (tsp)") {
                            wantedUnit = "US tsp"
                        }
                        Button("Fluid Dram (fl dr)") {
                            wantedUnit = "US fl dr"
                        }
                        Button("Fluid Ounce (fl oz)") {
                            wantedUnit = "US fl oz"
                        }
                        Button("Tablespoon (tbsp)") {
                            wantedUnit = "US tbsp"
                        }
                        Button("Gills (gi)") {
                            wantedUnit = "US gi"
                        }
                        Button("Cup (cup)") {
                            wantedUnit = "US cup"
                        }
                        Button("Pint (pt)") {
                            wantedUnit = "US pt"
                        }
                        Button("Quart (qt)") {
                            wantedUnit = "US qt"
                        }
                        Button("Gallon (gal)") {
                            wantedUnit = "US gal"
                        }
                        Button("Barrel (bbl)") {
                            wantedUnit = "US bbl"
                        }
                        
                        Text("UK")
                        Button("Fluid Dram (fl dr)") {
                            wantedUnit = "UK fl dr"
                        }
                        Button("Teaspoon (tsp)") {
                            wantedUnit = "UK tsp"
                        }
                        Button("Fluid Ounce (fl oz)") {
                            wantedUnit = "UK fl oz"
                        }
                        Button("Tablespoon (tbsp)") {
                            wantedUnit = "UK tbsp"
                        }
                        Button("Gills (gi)") {
                            wantedUnit = "UK gi"
                        }
                        Button("Cup (cup)") {
                            wantedUnit = "UK cup"
                        }
                        Button("Pint (pt)") {
                            wantedUnit = "UK pt"
                        }
                        Button("Quart (qt)") {
                            wantedUnit = "UK qt"
                        }
                        Button("Gallon (gal)") {
                            wantedUnit = "UK gal"
                        }
                        
                        Text("Others")
                        Button("Acre Foot (ac·ft)") {
                            wantedUnit = "ac·ft"
                        }
                        Button("Board Foot (bd ft)") {
                            wantedUnit = "bd ft"
                        }
                    } label: {
                        Text("Unit (2)")
                    }
                }
                
                Text("Unit (1): \(initialUnit)\nUnit (2): \(wantedUnit)")
                    .modifier(TextAlignmentLeadingStyle())
                    .multilineTextAlignment(.leading)
                
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
        .navigationTitle("Convert volume")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    VolumeView()
}
