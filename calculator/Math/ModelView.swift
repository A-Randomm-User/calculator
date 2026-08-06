//
//  InterestView.swift
//  calculator
//
//  Created by Aaron on 24/07/2026.
//

import SwiftUI
import Foundation

enum InterestTarget {
    case original
    case rate
    case year
    case final
    case none
}

enum ModelMode: CaseIterable, Identifiable {
    case simple
    case compound
    case exponential
    case decay
    
    var id: Self { self }

    var localizedMode: String {
        switch self {
        case .simple: return String(localized: "Simple Interest")
        case .compound: return String(localized: "Compound Interest")
        case .exponential: return String(localized: "Exponential Increase")
        case .decay: return String(localized: "Exponential Decay")
        }
    }
}

struct ModelView: View {
    
    @State private var original: Double?
    @State private var rate: Double?
    @State private var year: Double?
    @State private var final: Double?
    @State private var answer = ""
    
    @State private var target: InterestTarget = .none
    @State private var mode: ModelMode = .simple
    
    @State private var isWorking = false
    
    var localizedTarget: String {
        switch target {
        case .original:
            return String(localized: "Original Amount")
        case .rate:
            return String(localized: "Rate")
        case .year:
            return String(localized: "Year")
        case .final:
            return String(localized: "Final Amount")
        case .none:
            return String(localized: "None")
            }
        }
    
    func wait(_ time: Double) async {
        try? await Task.sleep(for: .seconds(time))
    }
    
    func log(base: Double, value: Double) -> Double {
        return Foundation.log(value) / Foundation.log(base)
    }
    
    func findTarget() -> InterestTarget {
        if original == nil && rate != nil && year != nil && final != nil {
            return .original
        } else if rate == nil && original != nil && year != nil && final != nil {
            return .rate
        } else if year == nil && original != nil && rate != nil && final != nil {
            return .year
        } else if final == nil && original != nil && rate != nil && year != nil {
            return .final
        } else {
            return .none
        }
    }
    
    func simpleInterest() {
        switch target {
        case .original:
            if let rate, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "Final = Original * (1 + rate% * year)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(final) = Original * (1 + \(rate / 100) * \(year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final) = Original * \(1 + (rate / 100) * year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Original = \(final / (1 + (rate / 100) * year))"
                    }
                    isWorking = false
                }
            }
            
        case .rate:
            if let original, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "Final = Original * (1 + rate * year)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(final) = \(original) * (1 + rate * \(year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final / original) = 1 + rate * \(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final / original - 1) = rate * \(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Rate = \((final / original - 1) / year * 100)%"
                    }
                    isWorking = false
                }
            }
            
        case .year:
            if let original, let rate, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "Final = Original * (1 + rate * year)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(final) = \(original) * (1 + \(rate / 100) * year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final / original) = 1 + \(rate / 100) * year\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final / original - 1) = \(rate / 100) * year\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Year = \((final / original - 1) / (rate / 100))"
                    }
                    isWorking = false
                }
            }
            
        case .final:
            if let original, let rate, let year {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "Final = Original * (1 + rate * year)\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "Final = \(original) * (1 + \(rate / 100) * \(year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Final = \(original) * \(1 + (rate / 100) * year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Final = \(original * (1 + (rate / 100) * year))"
                    }
                    isWorking = false
                }
            }
            
        case .none:
            return
        }
    }
    
    func compoundInterest() {
        switch target {
        case .original:
            if let rate, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 + (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "original * (1 + (\(rate / 100)^\(year))) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original * \( 1 + (rate / 100))^\(year) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original * \(pow(1 + (rate / 100), year)) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original = \(final) / \(pow(1 + (rate / 100), year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original = \(final / pow(1 + (rate / 100), year))\n"
                    }
                    isWorking = false
                }
            }
        case .rate:
            if let original, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 + (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(original) * (1 + (rate / 100)^\(year)) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "1 + (rate / 100)^\(year) = \(final) / \(original)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "1 + (rate / 100)^\(year) = \(final / original)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "1 + (rate / 100)= \((final / original) - 1)^(1 / \(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "rate / 100= \(pow(((final / original)), 1 / year)) - 1\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "rate / 100= \(pow(((final / original)), 1 / year) - 1)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "rate = \(100 * (pow(((final / original)), 1 / year) - 1)) %"
                    }
                    isWorking = false
                }
            }
        case .year:
            if let original, let rate, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 + (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(original) * (1 + (\(rate) / 100)^year) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "(1 + (\(rate) / 100)^year) = \(final) / \(original)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "year = log(\(final / original)) / log(1 + (\(rate) / 100)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "year = \(log(base: (1 + (rate / 100)), value: (final / original)))"
                    }
                    isWorking = false
                }
            }
        case .final:
            if let original, let rate, let year {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 + (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * (1 + (\(rate) / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * (\(1 + rate / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * \(pow((1 + (rate / 100)), year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original * pow((1 + (rate / 100)), year))"
                    }
                    isWorking = false
                }
            }
        case .none:
            return
        }
        return
    }
    
    func decay() {
        switch target {
        case .original:
            if let rate, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 - (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "original * (1 - (\(rate / 100)^\(year))) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original * \( 1 - (rate / 100))^\(year) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original * \(pow(1 - (rate / 100), year)) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original = \(final) / \(pow(1 - (rate / 100), year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "original = \(final / pow(1 + (rate / 100), year))\n"
                    }
                    isWorking = false
                }
            }
        case .rate:
            if let original, let year, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "final = original * (1 - (rate / 100))^year\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(final) = \(original) * (1 - (rate / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(final / original) = (1 - (rate / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(pow(final / original, 1 / year)) = 1 - (rate / 100)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "\(1 - pow(final / original, 1 / year)) = rate / 100\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "Rate = \(100 * (1 - pow(final / original, 1 / year)))%"
                    }
                    isWorking = false
                }
            }
        case .year:
            if let original, let rate, let final {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 - (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer += "\(original) * (1 - (\(rate) / 100)^year) = \(final)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "(1 - (\(rate) / 100)^year) = \(final) / \(original)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "year = log(\(final / original)) / log(1 - (\(rate) / 100)"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer += "year = \(log(base: (1 - (rate / 100)), value: (final / original)))"
                    }
                    isWorking = false
                }
            }
        case .final:
            if let original, let rate, let year {
                Task { @MainActor in
                    isWorking = true
                    withAnimation(.smooth) {
                        answer = "original * (1 + (rate / 100))^year = final\n"
                    }
                    await wait(1)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * (1 - (\(rate) / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * (\(1 - rate / 100))^\(year)\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original) * \(pow((1 - (rate / 100)), year))\n"
                    }
                    await wait(0.7)
                    withAnimation(.smooth) {
                        answer = "final = \(original * pow((1 - (rate / 100)), year))"
                    }
                    isWorking = false
                }
            }
        case .none:
            return
        }
        return
    }
    
    var body: some View {
        ScrollView {
            VStack {
                
                Picker("Select System", selection: $mode) {
                    ForEach(ModelMode.allCases) { mode in
                        Text(mode.localizedMode).tag(mode)
                    }
                }
                .pickerStyle(.wheel)
                .padding(.horizontal)
                .disabled(isWorking)
                
                Text("Leave it empty to make it as unknown")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, 20)
                
                TextField("Original Amount", value: $original, format: .number)
                    .keyboardType(.decimalPad)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: original) {
                        withAnimation(.smooth) {
                            answer = ""
                        }
                    }
                    .disabled(isWorking)
                Spacer(minLength: 20)
                TextField("Rate", value: $rate, format: .number)
                    .keyboardType(.decimalPad)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: original) {
                        withAnimation(.smooth) {
                            answer = ""
                        }
                    }
                    .disabled(isWorking)
                Spacer(minLength: 20)
                TextField("Years", value: $year, format: .number)
                    .keyboardType(.decimalPad)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: original) {
                        withAnimation(.smooth) {
                            answer = ""
                        }
                    }
                    .disabled(isWorking)
                Spacer(minLength: 20)
                TextField("Final Amount", value: $final, format: .number)
                    .keyboardType(.decimalPad)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: original) {
                        withAnimation(.smooth) {
                            answer = ""
                        }
                    }
                    .disabled(isWorking)
                
                Spacer(minLength: 40)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Group {
                            Text("Output")
                            Text(answer)
                                .contentTransition(.numericText())
                            
                            Spacer(minLength: 40)
                        }
                        .contentTransition(.numericText())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 13)
                }
                .padding(.horizontal, 1)
                
            }
            .navigationTitle("Growth and Decay")
            .navigationBarTitleDisplayMode(.large)
        }
        .safeAreaInset(edge: .bottom) {
            Group {
                if #available(iOS 26.0, *) {
                    Button {
                        target = findTarget()
                        
                        if mode == .simple {
                            simpleInterest()
                        } else if mode == .compound || mode == .exponential {
                            compoundInterest()
                        } else if mode == .decay {
                            decay()
                        }
                    } label: {
                        Text("Solve")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.glassProminent)
                    .disabled(isWorking)
                } else {
                    Button {
                        
                    } label: {
                        Text("Solve")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                    .disabled(isWorking)
                }
            }
        }
    }
}

#Preview {
    ModelView()
}
