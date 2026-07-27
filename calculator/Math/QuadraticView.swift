//
//  Quadratic.swift
//  calculator
//
//  Created by Aaron on 09/07/2026.
//

import SwiftUI
import Foundation

struct QuadraticView: View {
    
    @State var a: Double? = nil
    @State var b: Double? = nil
    @State var c: Double? = nil
    @State var discriminant = ""
    @State var displayDiscriminant = ""
    @State var solutionText = ""
    @State var turningPoint = ""
    @State var animateSymbolA = false
    @State var animateSymbolB = false
    @State var animateSymbolC = false
    
    func findDiscriminant() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let value = b * b - 4 * a * c
                if value == 0 {
                    discriminant = "1"
                    displayDiscriminant = "2 Equal Roots"
                } else if value < 0 {
                    discriminant = "0"
                    displayDiscriminant = "No Roots"
                } else if value > 0 {
                    discriminant = "2"
                    displayDiscriminant = "2 Distinct Roots"
                }
            } else {
                discriminant = "Not a quadratic"
                displayDiscriminant = "Not a quadratic"
            }
        }
    }
    
    func findSolution() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let value = b * b - 4 * a * c
                if discriminant == "0" {
                    solutionText = "No Solution"
                } else if discriminant == "1" {
                    let fractionUp = -b + sqrt(value)
                    let solution = fractionUp / (2 * a)
                    solutionText = "x = \(solution)"
                } else if discriminant == "2" {
                    let fractionUpPos = -b + sqrt(value)
                    let fractionUpNeg = -b - sqrt(value)
                    let solution1 = fractionUpPos / (2 * a)
                    let solution2 = fractionUpNeg / (2 * a)
                    solutionText = "x = \(solution1) or x = \(solution2)"
                }
            } else {
                solutionText = "Not a quadratic"
            }
        }
    }
    
    func findTurningPoint() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let x = (-b / 2) * a
                let y = a * pow(x, 2) + b * x + c
                turningPoint = "(\(x),\(y))"
            } else {
                turningPoint = "Not a quadratic"
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Quadratic")
                    .font(.title)
                    .fontWeight(.black)
                
                Text("a: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                HStack(spacing: 1) {
                    TextField("Default is 1", value: $a, format: .number)
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
                        .onChange(of: a) {
                            discriminant = ""
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = a {
                                    a = -value
                                }

                                animateSymbolA.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolA
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = a {
                                    a = -value
                                }

                                animateSymbolA.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolA
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("b: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                HStack(spacing: 1) {
                    TextField("Enter for b", value: $b, format: .number)
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
                        .onChange(of: b) {
                            discriminant = ""
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = b {
                                    b = -value
                                }

                                animateSymbolB.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolB
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = b {
                                    b = -value
                                }

                                animateSymbolB.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolB
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("c: ")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                HStack(spacing: 1) {
                    TextField("Enter for c", value: $c, format: .number)
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
                        .onChange(of: c) {
                            discriminant = ""
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = c {
                                    c = -value
                                }

                                animateSymbolC.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolC
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = c {
                                    c = -value
                                }

                                animateSymbolC.toggle()
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: animateSymbolC
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("Find Discriminant") {
                            findDiscriminant()
                        }
                        .buttonStyle(.glass)
                        Button("Find Solution") {
                            findDiscriminant()
                            findSolution()
                        }
                        .buttonStyle(.glass)
                        Button("Find Turning Point") {
                            findTurningPoint()
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button("Find Discriminant") {
                            findDiscriminant()
                        }
                        .buttonStyle(.bordered)
                        Button("Find Solution") {
                            findDiscriminant()
                            findSolution()
                        }
                        .buttonStyle(.bordered)
                        Button("Find Turning Point") {
                            findTurningPoint()
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        Text("Discriminant: \(displayDiscriminant)")
                        Text("Roots: \(solutionText)")
                        Text("Turning Point: \(turningPoint)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 1)
                .frame(minHeight: 140)
            }
        }
    }
}

#Preview {
    QuadraticView()
}
