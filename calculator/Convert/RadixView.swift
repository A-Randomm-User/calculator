//
//  RadixView.swift
//  calculator
//
//  Created by Aaron on 29/07/2026.
//

import SwiftUI
import Foundation

enum Radix: String, CaseIterable, Identifiable, Equatable {
    case binary
    case octal
    case denary
    case hexa
    
    var id: String { self.rawValue }
    
    var value: Int {
        switch self {
        case .binary:
            return 2
        case .octal:
            return 8
        case .denary:
            return 10
        case .hexa:
            return 16
        }
    }

    var localizedRadix: String {
        switch self {
        case .binary:
            return String(localized: "Binary")
        case .octal:
            return String(localized: "Octal")
        case .denary:
            return String(localized: "Decimal")
        case .hexa:
            return String(localized: "Hexadecimal")
        }
    }
}

struct RadixView: View {
    
    @State private var input: String = ""
    @State private var initial: Radix = .binary
    @State private var output2 = "－"
    @State private var output8 = "－"
    @State private var output10 = "－"
    @State private var output16 = "－"
    
    func increment() {
        guard let number = Int(input, radix: initial.value) else {
            return
        }
        input = String(number + 1, radix: initial.value).uppercased()
    }
    
    func decrement() {
        guard let number = Int(input, radix: initial.value) else {
            return
        }
        input = String(number - 1, radix: initial.value).uppercased()
    }
    
    func convert() {
        let mode = initial.value

        let number: Int? = Int(input, radix: mode)

        if let number {
            withAnimation(.smooth) {
                output2 = String(number, radix: 2)
                output8 = String(number, radix: 8)
                output10 = String(number)
                output16 = String(number, radix: 16).uppercased()
            }
        } else {
            withAnimation(.smooth) {
                output2 = "－"
                output8 = "－"
                output10 = "－"
                output16 = "－"
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Convert Number")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer(minLength: 10)
                
                Picker("Select System", selection: $initial) {
                    ForEach(Radix.allCases) { radix in
                        Text(radix.localizedRadix).tag(radix)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Spacer(minLength: 20)
                
                HStack(spacing: 20) {
                    TextField("Enter input", text: $input)
                        .keyboardType(.asciiCapable)
                        .modifier(CalculatorTextFieldStyle())
                        .onChange(of: input) {
                            convert()
                        }
                        .onChange(of: initial) {
                            convert()
                        }
                        .layoutPriority(1)
                    
                    Button {
                        decrement()
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 40, height: 24)
                    }

                    Button {
                        increment()
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 40, height: 24)
                    }
                }
                .buttonStyle(.bordered)
                .tint(.primary)
                .padding(.horizontal)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .opacity(0.10)
                        .padding(.horizontal)
                    VStack {
                        HStack {
                            Text("Binary:")
                            Spacer()
                            Text(output2)
                                .contentTransition(.numericText())
                        }
                        HStack {
                            Text("Octal:")
                            Spacer()
                            Text(output8)
                                .contentTransition(.numericText())
                        }
                        HStack {
                            Text("Decimal:")
                            Spacer()
                            Text(output10)
                                .contentTransition(.numericText())
                        }
                        HStack {
                            Text("Hexadecimal:")
                            Spacer()
                            Text(output16)
                                .contentTransition(.numericText())
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
                }
            }
        }
    }
}

#Preview {
    RadixView()
}
