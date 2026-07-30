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
            return String(localized: "No Real Roots")
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
    
    @State private var a: Double? = nil
    @State private var b: Double? = nil
    @State private var c: Double? = nil
    
    @State private var A = ""
    @State private var B = ""
    @State private var C = ""
    
    @State private var initA = "a"
    @State private var initB = "b"
    @State private var initC = "c"
    
    @State private var initB2 = ""
    
    @State private var stepsText = ""
    @State private var stepsValue: Double = 0
    
    @State private var quadStepsText = ""
    @State private var quadStepsValue: Double = 0
    
    @State private var turnStepsText = ""
    @State private var turnStepsValue: Double = 0
    
    @State private var discrText = String(localized: "Waiting...")
    @State private var soluText = String(localized: "Waiting...")
    @State private var turnText = String(localized: "Waiting...")
    
    @State private var discriminant: Discriminant = .none
    
    @State private var displayDiscriminant = ""
    @State private var solutionText = ""
    @State private var turningPoint = ""
    
    @State private var isSolving = false
    
    @State private var animateSymbolA = false
    @State private var animateSymbolB = false
    @State private var animateSymbolC = false
    
    @State private var showClearConfirmation = false
    
    func reset() {
        discriminant = .none
        withAnimation(.smooth) {
            displayDiscriminant = ""
            solutionText = ""
            turningPoint = ""
            stepsText = ""
            quadStepsText = ""
            turnStepsText = ""
            discrText = String(localized: "Waiting...")
            soluText = String(localized: "Waiting...")
            turnText = String(localized: "Waiting...")
        }
    }
    
    func clear() {
        a = nil
        b = nil
        c = nil
        reset()
    }
    
    func tasks() {
        isSolving = true
        
        Task { @MainActor in
            if a != 0 {
                withAnimation(.smooth) {
                    discrText = String(localized: "Working out the Discriminant")
                }
                try? await Task.sleep(for: .seconds(0.5))
                withAnimation(.smooth) {
                    stepsText = "b²-4(a)(c)"
                }
                try? await Task.sleep(for: .seconds(1.25))
                step1()
                try? await Task.sleep(for: .seconds(1))
                step2()
                try? await Task.sleep(for: .seconds(1))
                step3()
                try? await Task.sleep(for: .seconds(1))
                step4()
                try? await Task.sleep(for: .seconds(1))
                step5()
                try? await Task.sleep(for: .seconds(1))
                step6()
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation(.smooth) {
                    discrText = String(localized: "Discriminant")
                }
                try? await Task.sleep(for: .seconds(1))
                findDiscriminant()
                
                try? await Task.sleep(for: .seconds(1.25))
                withAnimation(.smooth) {
                    soluText = String(localized: "Working out the Solution")
                }
                try? await Task.sleep(for: .seconds(0.5))
                withAnimation(.smooth) {
                    quadStepsText = "[-b ± √(b²-4(a)(c))] ÷ [2(a)]"
                }
                try? await Task.sleep(for: .seconds(1))
                quadStep1()
                try? await Task.sleep(for: .seconds(1))
                quadStep2()
                try? await Task.sleep(for: .seconds(1))
                quadStep3()
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation(.smooth) {
                    soluText = String(localized: "Roots")
                }
                try? await Task.sleep(for: .seconds(1))
                findSolution()
                try? await Task.sleep(for: .seconds(1.25))
                withAnimation(.smooth) {
                    turnText = String(localized: "Working out the Turning Point")
                }
                try? await Task.sleep(for: .seconds(1))
                turnStep1()
                try? await Task.sleep(for: .seconds(1))
                turnStep2()
                try? await Task.sleep(for: .seconds(1))
                turnStep3()
                try? await Task.sleep(for: .seconds(1))
                turnStep4()
                try? await Task.sleep(for: .seconds(1))
                turnStep5()
                try? await Task.sleep(for: .seconds(1))
                turnStep6()
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation(.smooth) {
                    turnText = String(localized: "Turning Point")
                }
                try? await Task.sleep(for: .seconds(1))
                findTurningPoint()
                isSolving = false
            } else {
                withAnimation(.smooth) {
                    discrText = String(localized: "Discriminant")
                    soluText = String(localized: "Roots")
                    turnText = String(localized: "Turning Point")
                    stepsText = String(localized: "")
                }
                findDiscriminant()
                findSolution()
                findTurningPoint()
            }
        }
    }
    func formatNumber(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    func step1() {
        if let b, let c {
            let a = a ?? 1
            A = formatNumber(a)
            B = formatNumber(b)
            C = formatNumber(c)
            
            withAnimation(.smooth) {
                initA = A
                initB = B
                initC = C
                
                stepsText = "\(initB)²-4(\(initA))(\(initC))"
            }
        }
    }
    
    func step2() {
        if let b {
            initB = String(formatNumber(b * b))
        }
        
        withAnimation(.smooth) {
            stepsText = "\(initB)-4(\(initA))(\(initC))"
        }
    }
    
    func step3() {
        if let c {
            let a = a ?? 1
            initA = String(formatNumber(a * c))
        }
        
        withAnimation(.smooth) {
            stepsText = "\(initB)-4(\(initA))"
        }
    }
    
    func step4() {
        if let c {
            let a = a ?? 1
            if -4 * a * c >= 0 {
                initA = "+\(formatNumber(-4 * a * c))"
            } else {
                initA = "\(formatNumber(-4 * a * c))"
            }
        }
        
        withAnimation(.smooth) {
            stepsText = "\(initB)\(initA)"
        }
    }
    
    func step5() {
        if let b, let c {
            let a = a ?? 1
            if -4 * a * c >= 0 {
                initA = "+\(formatNumber(-4 * a * c))"
            } else {
                initA = "\(formatNumber(-4 * a * c))"
            }
            stepsValue = (b * b) - 4 * a * c
        }
        
        withAnimation(.smooth) {
            stepsText = "\(initB)\(initA) = \(stepsValue)"
        }
    }
    
    func step6() {
        withAnimation(.smooth) {
            if stepsValue == 0 {
                stepsText += "\n" + String(localized: "Value = 0")
            } else if stepsValue < 0 {
                stepsText += "\n" + String(localized: "Value < 0")
            } else if stepsValue > 0 {
                stepsText += "\n" + String(localized: "Value > 0")
            }
        }
    }
    
    func quadStep1() {
        if let b, let c, stepsValue >= 0 {
            let a = a ?? 1
            switch discriminant {
            case .noRoots:
                withAnimation(.smooth) {
                    quadStepsText = String(localized: "Cannot take the square root of a negative number")
                }
            case .equalRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initA = A
                    initB = B
                    initC = C
                    
                    quadStepsText = "[-\(initB) ± √(\(stepsValue)] ÷ [2(\(initA))]"
                }
            case .distinctRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initA = A
                    initB = B
                    initC = C
                    
                    quadStepsText = "[-\(initB) ± √(\(stepsValue))] ÷ [2(\(initA))]"
                }
            case .notQuadratic:
                withAnimation(.smooth) {
                    quadStepsText = ""
                }
            case .none:
                break
            }
        } else {
            Task {
                withAnimation(.smooth) {
                    quadStepsText = "[-\(initB) ± √(\(stepsValue))] ÷ [2(\(initA))]"
                }
                try? await Task.sleep(for: .seconds(0.3))
                withAnimation(.smooth) {
                    quadStepsText = String(localized: "Cannot take the square root of a negative number")
                }
            }
        }
    }
    
    func quadStep2() {
        if let b, let c, stepsValue >= 0 {
            let a = a ?? 1
            switch discriminant {
            case .noRoots:
                withAnimation(.smooth) {
                    quadStepsText = String(localized: "Cannot take the square root of a negative number")
                }
            case .equalRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initB = "\(-b)"
                    stepsValue = sqrt(stepsValue)
                    initA = "\(2 * a)"
                    
                    quadStepsText = "[\(initB) ± \(stepsValue)] ÷ [\(initA)]"
                }
            case .distinctRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initB = "\(-b)"
                    stepsValue = sqrt(stepsValue)
                    initA = "\(2 * a)"
                    
                    quadStepsText = "[\(initB) ± \(stepsValue)] ÷ [\(initA)]"
                }
            case .notQuadratic:
                withAnimation(.smooth) {
                    quadStepsText = ""
                }
            case .none:
                break
            }
        }
    }
    
    func quadStep3() {
        if let b, let c {
            let a = a ?? 1
            switch discriminant {
            case .noRoots:
                withAnimation(.smooth) {
                    quadStepsText = String(localized: "Cannot take the square root of a negative number")
                }
            case .equalRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initB = "\(-b + stepsValue)"
                    initB2 = "\(-b - stepsValue)"
                    
                    quadStepsText = "x = [\(initB)] ÷ [\(initA)] \nx = [\(initB2)] ÷ [\(initA)]"
                }
            case .distinctRoots:
                A = formatNumber(a)
                B = formatNumber(b)
                C = formatNumber(c)
                
                withAnimation(.smooth) {
                    initB = "\(-b + stepsValue)"
                    initB2 = "\(-b - stepsValue)"
                    
                    quadStepsText = "x = [\(initB)] ÷ [\(initA)] \nx = [\(initB2)] ÷ [\(initA)]"
                }
            case .notQuadratic:
                withAnimation(.smooth) {
                    quadStepsText = ""
                }
            case .none:
                break
            }
        }
    }
    
    func turnStep1() {
        if let b {
            let a = a ?? 1
            if a != 0 {
                initA = formatNumber(a)
                initB = formatNumber(b)
                
                if b >= 0 {
                    withAnimation(.smooth) {
                        turnStepsText = "dy/dx = 2(\(initA))x+\(initB)"
                    }
                } else {
                    withAnimation(.smooth) {
                        turnStepsText = "dy/dx = 2(\(initA))x\(initB)"
                    }
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func turnStep2() {
        if let b {
            let a = a ?? 1
            if a != 0 {
                initA = "\(2 * a)"
                
                if b >= 0 {
                    withAnimation(.smooth) {
                        turnStepsText = "dy/dx = \(initA)x+\(b)"
                    }
                } else {
                    withAnimation(.smooth) {
                        turnStepsText = "dy/dx = \(initA)x\(b)"
                    }
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func turnStep3() {
        if let b {
            let a = a ?? 1
            if a != 0 {
                initA = "\(2 * a)"
                
                if b >= 0 {
                    withAnimation(.smooth) {
                        turnStepsText = "\(initA)x+\(b) = 0"
                    }
                } else {
                    withAnimation(.smooth) {
                        turnStepsText = "\(initA)x\(b) = 0"
                    }
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func turnStep4() {
        if let b {
            let a = a ?? 1
            if a != 0 {
                initA = "\(2 * a)"
                
                withAnimation(.smooth) {
                    turnStepsText = "\(initA)x = \(-b)"
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func turnStep5() {
        if let b {
            let a = a ?? 1
            if a != 0 {
                initA = "\(2 * a)"
                
                withAnimation(.smooth) {
                    turnStepsText = "x = \(-b) / \(initA)"
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func turnStep6() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                initA = "\(2 * a)"
                
                let x = -b / (2 * a)
                let roundedX = (x * 100).rounded() / 100
                
                if c >= 0 {
                    withAnimation(.smooth) {
                        turnStepsText = "x = \(roundedX)\ny = (\(a))(\(roundedX)²+(\(b))(\(roundedX)+\(c))"
                    }
                } else {
                    withAnimation(.smooth) {
                        turnStepsText = "x = \(roundedX)\ny = (\(a))(\(roundedX)²+(\(b))(\(roundedX)\(c))"
                    }
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func findDiscriminant() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let value = b * b - 4 * a * c
                    withAnimation(.smooth) {
                        if value == 0 {
                            discriminant = .equalRoots
                        } else if value < 0 {
                            discriminant = .noRoots
                        } else if value > 0 {
                            discriminant = .distinctRoots
                        }
                    }
            } else {
                withAnimation(.smooth) {
                    discriminant = .notQuadratic
                }
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
                    withAnimation(.smooth) {
                        solutionText = String(localized: "No Solution")
                    }
                case .equalRoots:
                    let fractionUp = -b + sqrt(value)
                    let solution = fractionUp / (2 * a)
                    let roundedSolution = (solution * 100).rounded() / 100
                    withAnimation(.smooth) {
                        solutionText = "x = \(roundedSolution)"
                    }
                case .distinctRoots:
                    let fractionUpPos = -b + sqrt(value)
                    let fractionUpNeg = -b - sqrt(value)
                    let solution1 = fractionUpPos / (2 * a)
                    let solution2 = fractionUpNeg / (2 * a)
                    let roundedSolution1 = (solution1 * 100).rounded() / 100
                    let roundedSolution2 = (solution2 * 100).rounded() / 100
                    withAnimation(.smooth) {
                        solutionText = "x = \(roundedSolution1) or x = \(roundedSolution2)"
                    }
                case .notQuadratic:
                    withAnimation(.smooth) {
                        solutionText = String(localized: "Not a quadratic")
                    }
                case .none:
                    break
                }
            } else {
                withAnimation(.smooth) {
                    solutionText = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    func findTurningPoint() {
        if let b, let c {
            let a = a ?? 1
            if a != 0 {
                let x = -b / (2 * a)
                let y = a * pow(x, 2) + b * x + c
                let roundedX = (x * 100).rounded() / 100
                let roundedY = (y * 100).rounded() / 100
                withAnimation(.smooth) {
                    turningPoint = "(\(roundedX),\(roundedY))"
                }
            } else {
                withAnimation(.smooth) {
                    turningPoint = String(localized: "Not a quadratic")
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Coefficient a")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 1) {
                    TextField("1", value: $a, format: .number)
                        .keyboardType(.decimalPad)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: a) {
                            reset()
                        }
                        .disabled(isSolving)
                    
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
                    .disabled(isSolving)
                    
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
                            reset()
                        }
                        .disabled(isSolving)
                    
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
                    .disabled(isSolving)
                    
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
                            reset()
                        }
                        .disabled(isSolving)
                    
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
                    .disabled(isSolving)
                    
                    Spacer()
                }
                
                Spacer(minLength: 30)
                
                HStack {
                    Spacer()
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button("Clear") {
                                showClearConfirmation = true
                            }
                            .buttonStyle(.glass)
                            .disabled(isSolving)
                        } else {
                            Button("Clear") {
                                showClearConfirmation = true
                            }
                            .buttonStyle(.bordered)
                            .disabled(isSolving)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer(minLength: 30)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text(discrText)
                            .fontWeight(.bold)
                            .contentTransition(.numericText())
                        Text(stepsText)
                            .contentTransition(.numericText())
                        Text("\(discriminant.description)")
                            .contentTransition(.numericText())
                        
                        Spacer(minLength: 20)
                        
                        Text(soluText)
                            .fontWeight(.bold)
                            .contentTransition(.numericText())
                        Text(quadStepsText)
                            .contentTransition(.numericText())
                        Text("\(solutionText)")
                            .contentTransition(.numericText())
                        
                        Spacer(minLength: 20)
                        
                        Text(turnText)
                            .fontWeight(.bold)
                            .contentTransition(.numericText())
                        Text(turnStepsText)
                            .contentTransition(.numericText())
                        Text("\(turningPoint)")
                            .contentTransition(.numericText())
                                                
                        Spacer(minLength: 20)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 13)
                }
                .padding(.horizontal, 1)
            }
        }
        
        .safeAreaInset(edge: .bottom) {
            Group {
                if #available(iOS 26.0, *) {
                    Button {
                        if b != nil && c != nil {
                            reset()
                            tasks()
                        } else {
                            isSolving = false
                        }
                        
                    } label: {
                        Text("Solve")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.glassProminent)
                    .disabled(isSolving)
                } else {
                    Button {
                        if b != nil && c != nil {
                            reset()
                            tasks()
                        } else {
                            isSolving = false
                        }
                    } label: {
                        Text("Solve")
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
        
        .alert("Clear all values?",
               isPresented: $showClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                clear()
            }
        } message: {
            Text("Your current inputs and results will be cleared.")
        }
        
        .navigationTitle("Quadratic")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    QuadraticView()
}
