//
//  Quadratic.swift
//  calculator
//
//  Created by Aaron on 09/07/2026.
//

import SwiftUI
import Foundation

enum Discriminant {
    case noRoots
    case equalRoots
    case distinctRoots
    case notQuadratic
    case none
    
    var description: String {
        switch self {
        case .noRoots:
            return String(localized: "No Roots")
        case .equalRoots:
            return String(localized: "2 Equal Roots")
        case .distinctRoots:
            return String(localized: "2 Distinct Roots")
        case .notQuadratic:
            return String(localized: "Not a quadratic")
        case .none:
            return ""
        }
    }
}

struct QuadraticView: View {
    
    @State var a: Double? = nil
    @State var b: Double? = nil
    @State var c: Double? = nil
    
    @State private var discriminant: Discriminant = .none
    
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
                    discriminant = .equalRoots
                } else if value < 0 {
                    discriminant = .noRoots
                } else if value > 0 {
                    discriminant = .distinctRoots
                }
            } else {
                discriminant = .notQuadratic
            }
        }
    }
    
    func findSolution() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let value = b * b - 4 * a * c
                
                switch discriminant {
                case .noRoots:
                    solutionText = "No Solution"
                case .equalRoots:
                    let fractionUp = -b + sqrt(value)
                    let solution = fractionUp / (2 * a)
                    let roundedSolution = (solution * 100).rounded() / 100
                    solutionText = "x = \(roundedSolution)"
                case .distinctRoots:
                    let fractionUpPos = -b + sqrt(value)
                    let fractionUpNeg = -b - sqrt(value)
                    let solution1 = fractionUpPos / (2 * a)
                    let solution2 = fractionUpNeg / (2 * a)
                    let roundedSolution1 = (solution1 * 100).rounded() / 100
                    let roundedSolution2 = (solution2 * 100).rounded() / 100
                    solutionText = "x = \(roundedSolution1) or x = \(roundedSolution2)"
                case .notQuadratic:
                    solutionText = "Not a quadratic"
                case .none:
                    solutionText = "Not a quadratic"
                }
            }
        }
    }
    
    func findTurningPoint() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let x = (-b / 2) * a
                let y = a * pow(x, 2) + b * x + c
                let roundedX = (x * 100).rounded() / 100
                let roundedY = (y * 100).rounded() / 100
                turningPoint = "(\(roundedX),\(roundedY))"
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
                    .fontWeight(.bold)
                
                Spacer(minLength: 25)
                
                Text("Coefficient a")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 1) {
                    TextField("1", value: $a, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: a) {
                            discriminant = .none
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
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
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Text("Coefficient b")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 1) {
                    TextField("b", value: $b, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: b) {
                            discriminant = .none
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
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
                    .tint(.primary)
                    
                    Spacer()
                }
                
                
                Text("Coefficient c")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 1) {
                    TextField("c", value: $c, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: c) {
                            discriminant = .none
                            displayDiscriminant = ""
                            solutionText = ""
                            turningPoint = ""
                        }
                    
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
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            findDiscriminant()
                            findSolution()
                            findTurningPoint()
                        } label: {
                            Text("Solve")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            findDiscriminant()
                            findSolution()
                            findTurningPoint()
                        } label: {
                            Text("Solve")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer(minLength: 30)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Discriminant")
                        Text("\(discriminant.description)")
                                                
                        Spacer(minLength: 20)
                        Text("Roots")
                        Text("\(solutionText)")
                        
                        Spacer(minLength: 20)
                        Text("Turning Point")
                        Text("\(turningPoint)")
                                                
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 13)
                }
                .padding(.horizontal, 1)
            }
        }
    }
}

#Preview {
    QuadraticView()
}
