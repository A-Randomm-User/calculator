//
//  CalcAreaView.swift
//  calculator
//
//  Created by Aaron on 02/08/2026.
//

import SwiftUI
import Foundation

enum AreaShape: String, CaseIterable, Identifiable, Equatable {
    case circle
    case triangle
    case square
    case rectangle
    case trapezoid // in British English - trapezium
    
    var id: String { self.rawValue }

    var localizedShape: String {
        switch self {
        case .circle:
            return String(localized: "circle")
        case .triangle:
            return String(localized: "triangle")
        case .square:
            return String(localized: "square")
        case .rectangle:
            return String(localized: "rectangle")
        case .trapezoid:
            return String(localized: "trapezoid")
        }
    }
}

struct CalcAreaView: View {
    
    let pi = Double.pi
    
    @State private var shape: AreaShape = .circle
    
    @State private var radius: Double?
    @State private var length: Double?
    @State private var width: Double?
    @State private var height: Double?
    @State private var base: Double?
    @State private var topBase: Double?
    @State private var bottomBase: Double?
    @State private var solution: Double?
    
    @State private var isSolving = false
    
    @State private var answer = ""
    
    func wait(_ time: Double) async {
        try? await Task.sleep(for: .seconds(time))
    }
    
    func formatNumber(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        } else {
            return String(format: "%.3f", value)
        }
    }
    
    func reset() {
        radius = nil
        length = nil
        width = nil
        height = nil
        base = nil
        topBase = nil
        bottomBase = nil
        solution = nil
        answer = ""
    }
    
    func circleFormula() {
        if radius != nil && solution == nil {
            if let radius {
                let exact = radius * radius
                
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "a = πr²\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "a = π(\(radius))²\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "a = \(radius * radius)π\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += String(localized: "Exact Form: \(formatNumber(exact))π\n")
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += String(localized: "Rounded Value: \(formatNumber(pi * exact))")
                    }
                    isSolving = false
                }
            }
        } else if radius == nil && solution != nil {
            if let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "πr² = \(solution)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "r² = \(formatNumber(solution / pi))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "r = √\(formatNumber(solution / pi))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "r = \(formatNumber(sqrt(solution / pi)))"
                    }
                    isSolving = false
                }
            }
        } else {
            withAnimation(.smooth) {
                answer = String(localized: "There should be only 1 unknown")
            }
            isSolving = false
        }
    }
    
    func triangleFormula() {
        if base != nil && height != nil && solution == nil {
            if let height, let base {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "a = 0.5(b)(h)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "a = 0.5(\(base))(\(height))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "a = 0.5(\(base * height))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "a = \(height * base * 0.5)"
                    }
                    isSolving = false
                }
            }
        } else if base == nil && height != nil && solution != nil {
            if let solution, let height {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "0.5(b)(h) = \(solution)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "b(\(height)) = \(solution) / 0.5\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "b(\(height)) = \(solution / 0.5)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "b = \((solution / 0.5) / height)"
                    }
                    isSolving = false
                }
            }
        } else if base != nil && height == nil && solution != nil {
            if let base, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "0.5(b)(h) = \(solution)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "h(\(base)) = \(solution) / 0.5\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "h(\(base)) = \(solution / 0.5)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "h = \((solution / 0.5) / base)"
                    }
                    isSolving = false
                }
            }
        } else {
            withAnimation(.smooth) {
                answer = String(localized: "There should be only 1 unknown")
            }
            isSolving = false
        }
    }
    
    func squareFormula() {
        if length != nil && solution == nil {
            if let length {
                isSolving = true
                Task { @MainActor in
                    withAnimation(.smooth) {
                        answer = "a = l²"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "a = \(length)²"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = \(length * length)"
                    }
                    isSolving = false
                }
            }
        } else if length == nil && solution != nil {
            if let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "l² = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "l = √\(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "l = \(sqrt(solution))"
                    }
                    isSolving = false
                }
            }
        } else {
            withAnimation(.smooth) {
                answer = String(localized: "There should be only 1 unknown")
            }
            isSolving = false
        }
    }
    
    func rectangleFormula() {
        if width != nil && length != nil && solution == nil {
            if let width, let length {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "a = wl"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "a = \(width) * \(length)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = \(width * length)"
                    }
                    isSolving = false
                }
            }
        } else if width == nil && length != nil && solution != nil {
            if let length, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "wl = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "w(\(length)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "w = \(solution) / \(length)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "w = \(solution / length)"
                    }
                    isSolving = false
                }
            }
        } else if width != nil && length == nil && solution != nil {
            if let width, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "wl = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "(\(width))l = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "l = \(solution) / \(width)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "l = \(solution / width)"
                    }
                    isSolving = false
                }
            }
        } else {
            withAnimation(.smooth) {
                answer = String(localized: "There should be only 1 unknown")
            }
            isSolving = false
        }
    }
    
    func trapezoidFormula() {
        if topBase != nil && bottomBase != nil && height != nil && solution == nil {
            if let topBase, let bottomBase, let height {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "a = 0.5(h)(a + b)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "a = 0.5(\(height))(\(topBase) + \(bottomBase))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = 0.5(\(height))(\(topBase + bottomBase))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = \(0.5 * (topBase + bottomBase) * height)"
                    }
                    isSolving = false
                }
            }
        } else if topBase == nil && bottomBase != nil && height != nil && solution != nil {
            if let bottomBase, let height, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "0.5(h)(a + b) = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "0.5(\(height))(a + \(bottomBase)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "(a + \(bottomBase)) = \(solution) / (0.5 * \(height))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "(a + \(bottomBase)) = \(solution) / \(height * 0.5)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a + \(bottomBase) = \(solution / (height * 0.5))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = \(solution / (height * 0.5)) - \(bottomBase)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "a = \((solution / (height * 0.5)) - bottomBase)"
                    }
                    isSolving = false
                }
            }
        } else if topBase != nil && bottomBase == nil && height != nil && solution != nil {
            if let topBase, let height, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "0.5(h)(a + b) = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "0.5(\(height))(b + \(topBase)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "(b + \(topBase)) = \(solution) / (0.5 * \(height))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "(b + \(topBase)) = \(solution) / \(height * 0.5)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "b + \(topBase) = \(solution / (height * 0.5))"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "b = \(solution / (height * 0.5)) - \(topBase)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "b = \((solution / (height * 0.5)) - topBase)"
                    }
                    isSolving = false
                }
            }
        } else if topBase != nil && bottomBase != nil && height == nil && solution != nil {
            if let topBase, let bottomBase, let solution {
                Task { @MainActor in
                    isSolving = true
                    withAnimation(.smooth) {
                        answer = "0.5(h)(a + b) = \(solution)"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "0.5(h)(\(topBase) + \(bottomBase)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "0.5(h)(\(topBase + bottomBase)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "h(\((topBase + bottomBase) * 0.5)) = \(solution)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "h = \(solution) / \((topBase + bottomBase) * 0.5)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "h = \(solution / ((topBase + bottomBase) * 0.5))"
                    }
                    isSolving = false
                }
            }
        } else {
            withAnimation(.smooth) {
                answer = String(localized: "There should be only 1 unknown")
            }
            isSolving = false
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Picker("Select Shape", selection: $shape) {
                    ForEach(AreaShape.allCases) { shape in
                        Text(shape.localizedShape).tag(shape)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .onChange(of: shape) {
                    reset()
                }
                
                Text("Leave it empty to make it as unknown")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, 20)
                
                Group {
                    if shape == .circle {
                        Text("Radius")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Radius", value: $radius, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: radius) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 25)
                        
                        Text("Area")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Area", value: $solution, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: solution) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                    } else if shape == .triangle {
                        Text("Height")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Height", value: $height, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: height) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 20)
                        
                        Text("Base")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Base", value: $base, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: base) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 25)
                        
                        Text("Area")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Area", value: $solution, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: solution) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                    } else if shape == .square {
                        Text("Length")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Length", value: $length, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: length) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 25)
                        
                        Text("Area")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Area", value: $solution, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: solution) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                    } else if shape == .rectangle {
                        Text("Width")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Width", value: $width, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: width) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 20)
                        
                        Text("Length")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Length", value: $length, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: length) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 25)
                        
                        Text("Area")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Area", value: $solution, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: solution) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                    } else if shape == .trapezoid {
                        Text("Top base length")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Base", value: $topBase, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: topBase) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 20)
                        
                        Text("Bottom base length")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Base", value: $bottomBase, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: bottomBase) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 20)
                        
                        Text("Height")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Height", value: $height, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: height) {
                                answer = ""
                            }
                            .disabled(isSolving)
                        
                        Spacer(minLength: 25)
                        
                        Text("Area")
                            .modifier(TextAlignmentLeadingStyle())
                            .padding(.vertical, -10)
                        
                        TextField("Area", value: $solution, format: .number)
                            .keyboardType(.decimalPad)
                            .modifier(CalculatorTextFieldStyle())
                            .onChange(of: solution) {
                                answer = ""
                            }
                            .disabled(isSolving)
                    }
                }
                
                Spacer(minLength: 50)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack {
                        Group {
                            Text("Output")
                                .fontWeight(.bold)
                            Text(answer)
                                .multilineTextAlignment(.leading)
                                .contentTransition(.numericText())
                        }
                        .modifier(TextAlignmentLeadingStyle())
                        Spacer(minLength: 30)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                    .disabled(isSolving)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            Group {
                if #available(iOS 26.0, *) {
                    Button {
                        switch shape {
                        case .circle:
                            circleFormula()
                            
                        case .triangle:
                            triangleFormula()
                            
                        case .square:
                            squareFormula()
                            
                        case .rectangle:
                            rectangleFormula()
                        
                        case .trapezoid:
                            trapezoidFormula()
                        }
                    } label: {
                        Text("Find Area")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.glassProminent)
                    .disabled(isSolving)
                } else {
                    Button {
                        switch shape {
                        case .circle:
                            circleFormula()
                            
                        case .triangle:
                            triangleFormula()
                            
                        case .square:
                            squareFormula()
                            
                        case .rectangle:
                            rectangleFormula()
                        
                        case .trapezoid:
                            trapezoidFormula()
                        }
                    } label: {
                        Text("Find Area")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                    .disabled(isSolving)
                }
            }
        }
        .navigationTitle("Find Area of Shape")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CalcAreaView()
}
