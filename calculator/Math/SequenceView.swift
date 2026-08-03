//
//  Sequence.swift
//  calculator
//
//  Created by Aaron on 16/07/2026.
//

import SwiftUI

enum SequenceType {
    case linear
    case quadratic
    case cubic
    case unknown
    case none
    
    var description: String {
        switch self {
        case .linear:
            return String(localized: "linear")
        case .quadratic:
            return String(localized: "quadratic")
        case .cubic:
            return String(localized: "cubic")
        case .unknown:
            return String(localized: "unknown")
        case .none:
            return ""
        }
    }
}

struct SequenceView: View {
    
    @State var n1: Double? = nil
    @State var n2: Double? = nil
    @State var n3: Double? = nil
    @State var n4: Double? = nil
    @State var n5: Double? = nil
    
    @State var nthTerm = ""
    @State var sequenceType: SequenceType = .none
    
    @State var animateSymbol1 = false
    @State var animateSymbol2 = false
    @State var animateSymbol3 = false
    @State var animateSymbol4 = false
    @State var animateSymbol5 = false
    
    enum Field: Hashable {
        case n1, n2, n3, n4, n5
    }

    @FocusState private var focusedField: Field?
    
    func identifySequence() {
        if let N1 = n1, let N2 = n2, let N3 = n3, let N4 = n4, let N5 = n5 {
            let seq11 = N2 - N1
            let seq12 = N3 - N2
            let seq13 = N4 - N3
            let seq14 = N5 - N4
            
            let seq21 = seq12 - seq11
            let seq22 = seq13 - seq12
            let seq23 = seq14 - seq13
            
            let seq31 = seq22 - seq21
            let seq32 = seq23 - seq22
            
            if seq11 == seq12 && seq12 == seq13 && seq13 == seq14 {
                sequenceType = .linear
            } else if seq21 == seq22 && seq22 == seq23 {
                sequenceType = .quadratic
            } else if seq31 == seq32 {
                sequenceType = .cubic
            } else {
                sequenceType = .unknown
            }
        }
    }
    
    func identifySymbol(value: Double) -> String {
        if value > 0 {
            let change = "+\(value)"
            return change
        } else if value == 0 {
            let change = ""
            return change
        } else {
            let change = "\(value)"
            return change
        }
    }
    
    func identifyStartCoefficient(value: Double) -> String {
        if value == 0 {
            return ""
        } else if value == 1 {
            return "n"
        } else if value == -1 {
            return "-n"
        } else if value > 0 {
            return "+\(value)n"
        } else {
            return "\(value)n"
        }
    }
    
    func identifyMidCoefficient(value: Double) -> String {
        if value == 0 {
            return ""
        } else if value == 1 {
            return "+n"
        } else if value == -1 {
            return "-n"
        } else if value > 0 {
            return "+\(value)n"
        } else {
            return "\(value)n"
        }
    }
    
    func findTerm() {
        if let N1 = n1, let N2 = n2, let N3 = n3, let N4 = n4 {
            if sequenceType == .linear {
                let a = N2 - N1
                let n0 = N1 - a
                
                let n0Str = identifySymbol(value: n0)
                
                nthTerm = "\(a)n\(n0Str)"
                
            } else if sequenceType == .quadratic {
                let seq1 = N2 - N1
                let seq2 = N3 - N2
                let seqsec1 = seq2 - seq1
                
                let a = seqsec1 / 2
                let b = seq1 - ( 3 * a )
                let c = N1 - a - b
                
                let aStr = identifyStartCoefficient(value: a)
                let bStr = identifyMidCoefficient(value: b)
                let cStr = identifySymbol(value: c)
                
                nthTerm = "\(aStr)²\(bStr)\(cStr)"
                
            } else if sequenceType == .cubic {
                let seq1 = N2 - N1
                let seq2 = N3 - N2
                let seq3 = N4 - N3
                
                let seqsec1 = seq2 - seq1
                let seqsec2 = seq3 - seq2
                
                let seqseqsec1 = seqsec2 - seqsec1
                
                let a = seqseqsec1 / 6
                let b = (seqsec1 - 12 * a) / 2
                let c = seq1 - (7 * a) - (3 * b)
                let d = N1 - a - b - c
                
                let aStr = identifyStartCoefficient(value: a)
                let bStr = identifyMidCoefficient(value: b)
                let cStr = identifyMidCoefficient(value: c)
                let dStr = identifySymbol(value: d)
                
                if bStr != "" {
                    nthTerm = "\(aStr)³\(bStr)²\(cStr)\(dStr)"
                } else if bStr == "" {
                    nthTerm = "\(aStr)³\(cStr)\(dStr)"
                }
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Find nth term")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 20)
                
                Text("n₁")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, -10)
                
                HStack {
                    TextField("n₁", value: $n1, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .n1)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .n2
                            }
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: n1) {
                            sequenceType = .none
                            nthTerm = ""
                        }
                    
                    Button {
                        if let value = n1 {
                            n1 = -value
                        }

                        animateSymbol1.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animateSymbol1
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Text("n₂")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, -10)

                HStack {
                    TextField("n₂", value: $n2, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .n2)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .n3
                            }
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: n2) {
                            sequenceType = .none
                            nthTerm = ""
                        }
                    
                    Button {
                        if let value = n2 {
                            n2 = -value
                        }

                        animateSymbol2.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animateSymbol2
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Text("n₃")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, -10)

                HStack {
                    TextField("n₃", value: $n3, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .n3)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .n4
                            }
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: n3) {
                            sequenceType = .none
                            nthTerm = ""
                        }
                    
                    Button {
                        if let value = n3 {
                            n3 = -value
                        }

                        animateSymbol3.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animateSymbol3
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Text("n₄")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, -10)

                HStack {
                    TextField("n₄", value: $n4, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .n4)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .n5
                            }
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: n4) {
                            sequenceType = .none
                            nthTerm = ""
                        }
                    
                    Button {
                        if let value = n4 {
                            n4 = -value
                        }

                        animateSymbol4.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animateSymbol4
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Text("n₅")
                    .modifier(TextAlignmentLeadingStyle())
                    .padding(.vertical, -10)

                HStack {
                    TextField("n₅", value: $n5, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focusedField, equals: .n5)
                            .submitLabel(.done)
                            .onSubmit {
                                focusedField = nil
                            }
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: n5) {
                            sequenceType = .none
                            nthTerm = ""
                        }
                    
                    Button {
                        if let value = n5 {
                            n5 = -value
                        }

                        animateSymbol5.toggle()
                    } label: {
                        Image(systemName: "plus.forwardslash.minus")
                            .symbolEffect(
                                .bounce.down.wholeSymbol,
                                options: .nonRepeating,
                                value: animateSymbol5
                            )
                    }
                    .padding()
                    .tint(.primary)
                    
                    Spacer()
                }
                
                Spacer(minLength: 15)
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            identifySequence()
                            findTerm()
                        } label: {
                            Text("Find nth Term")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            identifySequence()
                            findTerm()
                        } label: {
                            Text("Find nth Term")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 5)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .buttonStyle(.borderedProminent)
                    }
                }
                
                Spacer(minLength: 15)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack(alignment: .leading) {
                        Text("Sequence Type")
                        Text("\(sequenceType.description)")
                        
                        Spacer(minLength: 10)
                        Text("nth Term")
                        Text("\(nthTerm)")
                        
                        Spacer(minLength: 10)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                }
                .padding(.horizontal, 1)
            }
        }
    }
}

#Preview {
    SequenceView()
}
