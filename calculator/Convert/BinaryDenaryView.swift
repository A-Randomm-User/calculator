//
//  BinaryDenaryView.swift
//  calculator
//
//  Created by Aaron on 23/07/2026.
//

import SwiftUI

struct BinaryDenaryView: View {
    
    @State var input: Int? = nil
    @State var output: String = ""
    @State var displayOutput: String = ""
    @State var mode: String? = nil
    
    func calcBinary(_ decimalNumber: Int32) -> String {
        let index = [30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
        
        var number = decimalNumber
        var binary = "0"

        for power in index {
            let value = Int32(pow(2.0, Double(power)))

            if number >= value {
                binary += "1"
                number -= value
            } else {
                binary += "0"
            }
        }

        output = binary
        return "0b\(binary)"
    }
    
    func calcDenary(_ binaryNumber: Int) -> String {
        let binary = String(binaryNumber)
        var decimal = 0

        let invalidDigits = ["2", "3", "4", "5", "6", "7", "8", "9"]

        if binary.contains(where: { invalidDigits.contains(String($0)) }) {
            return "Not a binary input"
        } else {
            var power = binary.count - 1

            for digit in binary {
                if digit == "1" {
                    decimal += Int(pow(2.0, Double(power)))
                }
                power -= 1
            }
        }
        output = String(decimal)
        return String(decimal)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Binary & Denary Conversion")
                    .font(.title)
                    .fontWeight(.black)
                
                Text("Select Conversion mode by clicking \"Select mode\"")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                Text("Current Mode: \(mode ?? "Not selected")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer()
                Spacer()
                
                Text("Enter input:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                TextField("Enter input", value: $input, format: .number)
                    .keyboardType(.numberPad)
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
                    .onChange(of: input) {
                        displayOutput = ""
                        output = ""
                    }
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("\(Image(systemName: "arrow.left.arrow.right")) Start conversion") {
                            if mode == "DtB", let input = input {
                                if input >= 0 {
                                    displayOutput = calcBinary(Int32(input))
                                } else if input < 0 {
                                    displayOutput = "Could not convert negative numbers"
                                }
                            } else if mode == "BtD", let input = input {
                                if input >= 0 {
                                    displayOutput = calcDenary(Int(input))
                                } else if input < 0 {
                                    displayOutput = "Could not convert negative numbers"
                                }
                            } else if mode == nil {
                                displayOutput = "Select a mode to start"
                            }
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button("\(Image(systemName: "arrow.left.arrow.right")) Start conversion") {
                            if mode == "DtB", let input = input {
                                if input >= 0 {
                                    displayOutput = calcBinary(Int32(input))
                                } else if input < 0 {
                                    displayOutput = "Could not convert negative numbers"
                                }
                            } else if mode == "BtD", let input = input {
                                if input >= 0 {
                                    displayOutput = calcDenary(Int(input))
                                } else if input < 0 {
                                    displayOutput = "Could not convert negative numbers"
                                }
                            } else if mode == nil {
                                displayOutput = "Select a mode to start"
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Text("Output: \n\(displayOutput)")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                Spacer()
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button("\(Image(systemName: "document.on.document")) Copy to Clipboard") {
                            UIPasteboard.general.string = output
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button("\(Image(systemName: "document.on.document")) Copy to Clipboard") {
                            UIPasteboard.general.string = output
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Spacer()
                
                Text("Decimal points are ignored automatically")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Menu {
                    Button("Binary to Denary") {
                        mode = "BtD"
                    }
                    Button("Denary to Binary") {
                        mode = "DtB"
                    }
                } label: {
                    Text("Select mode")
                }
            }
        }
    }
}

#Preview {
    BinaryDenaryView()
}
