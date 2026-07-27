//
//  SimultaneousView.swift
//  calculator
//
//  Created by Aaron on 25/07/2026.
//

import SwiftUI

struct SimultaneousView: View {
    
    @State var a1: Double? = nil
    @State var b1: Double? = nil
    @State var a2: Double? = nil
    @State var b2: Double? = nil
    @State var c1: Double? = nil
    @State var c2: Double? = nil
    @State var answer: String = ""
    
    @State var a1Animate = false
    @State var a2Animate = false
    @State var b1Animate = false
    @State var b2Animate = false
    @State var c1Animate = false
    @State var c2Animate = false
    
    func FindSolution() {
        if let a1, let b1, let c1, let a2, let b2, let c2 {
            let y = (a2 * c1 - a1 * c2) / (a2 * b1 - a1 * b2)
            let x = (c2 - b2 * y) / a2
            
            let roundedY = (y * 100).rounded() / 100
            let roundedX = (x * 100).rounded() / 100
            
            answer += "\(roundedX), \(roundedY)"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Solve 2 unknown Linear Simultaneous Equation")
                    .font(.title)
                    .fontWeight(.black)
                
                Text("a₁ + b₁ = c₁\na₂ + b₂ = c₂")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text("a₁:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 0.1) {
                    TextField("Enter for a₁", value: $a1, format: .number)
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
                        .onChange(of: a1) {
                            answer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = a1 {
                                    a1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = a1 {
                                    a1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: a1Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("b₁:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 0.1) {
                    TextField("Enter for b₁", value: $b1, format: .number)
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
                        .onChange(of: b1) {
                            answer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = b1 {
                                    b1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: b1Animate
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = b1 {
                                    b1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: b1Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("c₁")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                
                HStack(spacing: 0.1) {
                    TextField("Enter for c₁", value: $c1, format: .number)
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
                        .onChange(of: c1) {
                        answer = ""
                    }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = c1 {
                                    c1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: c1Animate
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = c1 {
                                    c1 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: c1Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("a₂:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 0.1) {
                    TextField("Enter for a₂", value: $a2, format: .number)
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
                        .onChange(of: a2) {
                            answer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = a2 {
                                    a2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = a2 {
                                    a2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: a1Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("b₂:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                HStack(spacing: 0.1) {
                    TextField("Enter for b₂", value: $b2, format: .number)
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
                        .onChange(of: b2) {
                            answer = ""
                        }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = b2 {
                                    b2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: b2Animate
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = b2 {
                                    b2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: b2Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Text("c₂")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, -10)
                
                HStack(spacing: 0.1) {
                    TextField("Enter for c₂", value: $c2, format: .number)
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
                        .onChange(of: c2) {
                        answer = ""
                    }
                    
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                if let value = c2 {
                                    c2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: c2Animate
                                    )
                            }
                            .padding()
                            .buttonStyle(.glass)
                        } else {
                            Button {
                                if let value = c2 {
                                    c2 = -value
                                }
                            } label: {
                                Image(systemName: "plus.forwardslash.minus")
                                    .symbolEffect(
                                        .bounce.down.wholeSymbol,
                                        options: .nonRepeating,
                                        value: c2Animate
                                    )
                            }
                            .padding()
                        }
                    }
                }
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("Solve") {
                            FindSolution()
                        }
                        .buttonStyle(.glass)
                        .padding()
                    } else {
                        Button("Solve") {
                            FindSolution()
                        }
                        .buttonStyle(.bordered)
                        .padding()
                    }
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack {
                        Text("Solution: \(answer)")
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
    SimultaneousView()
}
