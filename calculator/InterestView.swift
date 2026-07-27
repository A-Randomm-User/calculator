//
//  InterestView.swift
//  calculator
//
//  Created by Aaron on 24/07/2026.
//

import SwiftUI
import Foundation

struct InterestView: View {
    
    @State var original: Double? = nil
    @State var rate: Double? = nil
    @State var year: Double? = nil
    @State var final: Double? = nil
    @State var target = ""
    @State var mode = ""
    @State var answer: Double? = nil
    @State var displayAnswer = ""
    
    @State var originalAnimate = false
    @State var rateAnimate = false
    @State var yearAnimate = false
    @State var finalAnimate = false
    
    func log(base: Double, value: Double) -> Double {
        return Foundation.log(value) / Foundation.log(base)
    }
    
    func identifyFindTarget(original: Double, rate: Double, year: Double, final: Double) -> String {
        if original == -1 && rate != -1 && year != -1 && final != -1 {
            return "original"
        } else if rate == -1 && original != -1 && year != -1 && final != -1 {
            return "rate"
        } else if year == -1 && rate != -1 && original != -1 && final != -1 {
            return "year"
        } else if final == -1 && rate != -1 && year != -1 && original != -1 {
            return "final"
        }
        return "nothing"
    }
    
    func simpleInterest(target: String, original: Double, rate: Double, year: Double, final: Double) -> Double {
        if target == "original" {
            let ans = final / ((rate / 100) * year)
            return ans
        } else if target == "rate" {
            let ans = (final / (original * year)) * 100
            return ans
        } else if target == "year" {
            let ans = final / (original * (rate / 100))
            return ans
        } else if target == "final" {
            let ans = original * (rate / 100) * year
            return ans
        }
        return 0.0
    }
    
    func compoundInterest(target: String, original: Double, rate: Double, year: Double, final: Double) -> Double {
        if target == "original" {
            let ans = final / pow(1 + (rate / 100), year)
            return ans
        } else if target == "rate" {
            let ans = 100 * (pow(((final / original)), 1 / year) - 1)
            return ans
        } else if target == "year" {
            let ans = log(base: (1 + (rate / 100)), value: (final / original))
            return ans
        } else if target == "final" {
            let ans = original * pow((1 + (rate / 100)), year)
            return ans
        }
        return 0.0
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Interest")
                    .font(.title)
                    .fontWeight(.black)
                
                Spacer()
                
                Text("Click \(Image(systemName: "questionmark")) to set it as unknown, \"-1\" means unknown")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Text("Current mode: \(mode)")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                HStack(spacing: 0.1) {
                    TextField("Enter for original amount", value: $original, format: .number)
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
                        .onChange(of: original) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                original = -1
                                originalAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: originalAnimate)
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                original = -1
                                originalAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: originalAnimate)
                            }
                            .padding()
                        }
                    }
                }
                
                HStack(spacing: 0.1) {
                    TextField("Enter for rate", value: $rate, format: .number)
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
                        .onChange(of: rate) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                rate = -1
                                rateAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: rateAnimate)
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                rate = -1
                                rateAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: rateAnimate)
                            }
                            .padding()
                        }
                    }
                }
                
                HStack(spacing: 0.1) {
                    TextField("Enter for year", value: $year, format: .number)
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
                        .onChange(of: year) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                year = -1
                                yearAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: yearAnimate)
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                year = -1
                                yearAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: yearAnimate)
                            }
                            .padding()
                        }
                    }
                }
                
                HStack(spacing: 0.1) {
                    TextField("Enter for final amount", value: $final, format: .number)
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
                        .onChange(of: final) {
                            answer = nil
                            displayAnswer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                final = -1
                                finalAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: finalAnimate)
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                final = -1
                                finalAnimate.toggle()
                            } label: {
                                Image(systemName: "questionmark")
                                    .symbolEffect(
                                        .bounce.down.byLayer,
                                        options: .nonRepeating,
                                        value: finalAnimate)
                            }
                            .padding()
                        }
                    }
                }
                
                Text("Do not include the original amount in the final amount in Simple Interest")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("Find unknown") {
                            if let original, let rate, let year, let final {
                                target = identifyFindTarget(original: original, rate: rate, year: year, final: final)
                                if target != "nothing" && mode == "simple" {
                                    answer = simpleInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String((answer * 100).rounded() / 100)
                                    }
                                }
                            }
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button("Find unknown") {
                            if let original, let rate, let year, let final {
                                target = identifyFindTarget(original: original, rate: rate, year: year, final: final)
                                if target != "nothing" && mode == "simple" {
                                    answer = simpleInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                } else if target != "nothing" && mode == "compound" {
                                    answer = compoundInterest(target: target, original: original, rate: rate, year: year, final: final)
                                    if let answer {
                                        displayAnswer = String(format: "%.2f", answer)
                                    }
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Text("Finding: \(target)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Text("Answer: \(displayAnswer)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
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
