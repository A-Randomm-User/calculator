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

struct InterestView: View {
    
    @State private var original: Double? = nil
    @State private var rate: Double? = nil
    @State private var year: Double? = nil
    @State private var final: Double? = nil
    @State private var mode = ""
    @State private var answer: Double? = nil
    @State private var displayAnswer = ""
    
    @State private var originalAnimate = false
    @State private var rateAnimate = false
    @State private var yearAnimate = false
    @State private var finalAnimate = false

    @State private var target: InterestTarget = .none
    
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

    func log(base: Double, value: Double) -> Double {
        return Foundation.log(value) / Foundation.log(base)
    }
    
    func identifyFindTarget(original: Double, rate: Double, year: Double, final: Double) -> InterestTarget {
        if original == -1 && rate != -1 && year != -1 && final != -1 {
            return .original
        } else if rate == -1 && original != -1 && year != -1 && final != -1 {
            return .rate
        } else if year == -1 && rate != -1 && original != -1 && final != -1 {
            return .year
        } else if final == -1 && rate != -1 && year != -1 && original != -1 {
            return .final
        }
        return .none
    }
    
    func simpleInterest(target: InterestTarget, original: Double, rate: Double, year: Double, final: Double) -> Double {
        switch target {
        case .original:
            return final / ((rate / 100) * year)

        case .rate:
            return (final / (original * year)) * 100

        case .year:
            return final / (original * (rate / 100))

        case .final:
            return original * (rate / 100) * year

        case .none:
            return 0
        }
    }
    
    func compoundInterest(target: InterestTarget, original: Double, rate: Double, year: Double, final: Double) -> Double {
        switch target {
        case .original:
            let ans = final / pow(1 + (rate / 100), year)
            return ans
            
        case .rate:
            let ans = 100 * (pow(((final / original)), 1 / year) - 1)
            return ans
            
        case .year:
            let ans = log(base: (1 + (rate / 100)), value: (final / original))
            return ans
            
        case .final:
            let ans = original * pow((1 + (rate / 100)), year)
            return ans
            
        case .none:
            return 0
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Interest")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 20)
                
                Text("Click \(Image(systemName: "questionmark")) to set it as unknown, \"-1\" means unknown")
                    .modifier(TextAlignmentLeadingStyle())
                
                Text("Current mode: \(mode)")
                    .fontWeight(.bold)
                    .modifier(TextAlignmentLeadingStyle())
                
                HStack(spacing: 0.1) {
                    TextField("Original Amount", value: $original, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: original) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    UnknownButton(value: $original)
                    
                    Spacer()
                }
                
                HStack(spacing: 0.1) {
                    TextField("Interest Rate (%)", value: $rate, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: rate) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    UnknownButton(value: $rate)
                    
                    Spacer()
                }
                
                HStack(spacing: 0.1) {
                    TextField("Number of Years", value: $year, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: year) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    UnknownButton(value: $year)
                    
                    Spacer()
                }
                
                HStack(spacing: 0.1) {
                    TextField("Final Amount", value: $final, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: final) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    UnknownButton(value: $final)
                    
                    Spacer()
                }
                
                Text("Do not include the original amount in the final amount in Simple Interest")
                    .font(.footnote)
                    .modifier(TextAlignmentLeadingStyle())
                
                Spacer(minLength: 20)
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            if let original, let rate, let year, let final {
                                target = identifyFindTarget(original: original, rate: rate, year: year, final: final)
                                if target != .none && mode == "simple" {
                                    answer = simpleInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                } else if target != .none && mode == "compound" {
                                    answer = compoundInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                }
                            }
                        } label: {
                            Text("Find unknown")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            if let original, let rate, let year, let final {
                                target = identifyFindTarget(original: original, rate: rate, year: year, final: final)
                                if target != .none && mode == "simple" {
                                    answer = simpleInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                } else if target != .none && mode == "compound" {
                                    answer = compoundInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                }
                            }
                        } label: {
                            Text("Find unknown")
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
                        Group {
                            Text("Unknown")
                            Text("\(localizedTarget)")
                            
                            Spacer(minLength: 30)
                            
                            Text("Answer")
                            Text("\(displayAnswer)")
                            
                            Spacer(minLength: 30)
                        }
                        .modifier(TextAlignmentLeadingStyle())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 1)
                
                Spacer(minLength: 25)
                
                Text("Simple interest answer for final does not include the original amount")
                    .font(.footnote)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button("Simple Interest") {
                            mode = "simple"
                        }
                        Button("Compound Interest") {
                            mode = "compound"
                        }
                    } label: {
                        Text("Select mode")
                    }
                }
            }
        }
    }
}

#Preview {
    InterestView()
}
