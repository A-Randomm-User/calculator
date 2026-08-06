//
//  MMMRView.swift
//  calculator
//
//  Created by Aaron on 04/08/2026.
//

import SwiftUI

enum MMMR {
    case mean
    case mode
    case median
    case range
}

struct MMMRView: View {
    
    @State private var array: [Double] = []
    @State private var mean = ""
    @State private var mode = ""
    @State private var median = ""
    @State private var range = ""
    @State private var input: Double?
    
    @State private var showClearConfirmation = false
    
    func formatNumber(_ value: Double) -> String {
        if value == floor(value) {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
    
    func appendArray() {
        if let enter = input {
            withAnimation(.smooth) {
                array.append(enter)
            }
            input = nil
        }
    }
    
    func clearArray() {
        array.removeAll()
        mean = ""
        mode = ""
        median = ""
        range = ""
    }
    
    func findMean() {
        if array.count > 0 {
            let sum = array.reduce(0.0, +)
            let count = Double(array.count)
            withAnimation(.smooth) {
                mean = "\(sum / count)"
            }
        }
    }
    
    func findMedian() {
        guard !array.isEmpty else {
            return
        }
        
        let sorted = array.sorted()
        let count = array.count
        
        if count % 2 == 1 {
            median = "\(sorted[count / 2])"
        } else {
            median = "\((sorted[count / 2 - 1] + sorted[count / 2]) / 2)"
        }
    }
    
    func findRange() {
        guard let max = array.max(),
              let min = array.min() else {
            return
        }

        withAnimation(.smooth) {
            range = "\(max - min)"
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Enter a value", value: $input, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: input) {
                        mean = ""
                        mode = ""
                        median = ""
                        range = ""
                    }
                
                HStack {
                    Group {
                        if #available(iOS 26.0, *) {
                            Button {
                                appendArray()
                            } label: {
                                Text("Append")
                            }
                            .buttonStyle(.glass)
                            
                            Spacer()
                            
                            Button {
                                showClearConfirmation = true
                            } label: {
                                Text("Clear")
                            }
                            .buttonStyle(.glassProminent)
                            .tint(.red)
                        } else {
                            Button {
                                appendArray()
                            } label: {
                                Text("Append")
                            }
                            .buttonStyle(.bordered)
                            
                            Spacer()
                            
                            Button {
                                showClearConfirmation = true
                            } label: {
                                Text("Clear")
                            }
                            .buttonStyle(.bordered)
                            .tint(.red)
                        }
                    }
                    .padding()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .opacity(0.10)
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Values entered")
                            .font(.headline)
                            .padding(.horizontal, 20)

                        if array.isEmpty {
                            Text("No values added")
                                .foregroundStyle(.secondary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                        } else {
                            ForEach(array.indices, id: \.self) { index in
                                HStack {
                                    Text(formatNumber(array[index]))
                                        .padding(.leading, 5)

                                    Spacer()

                                    Button {
                                        array.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                    .buttonStyle(.bordered)
                                }
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(.gray.opacity(0.12))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.vertical, 15)
                }
                .animation(.smooth, value: array.count)
                .padding(.horizontal, 1)
            }
            
            Spacer(minLength: 60)
            
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .opacity(0.10)
                    .padding(.horizontal)
                
                VStack {
                    Group {
                        Text("Mean")
                            .fontWeight(.bold)
                        Text(mean)
                        Spacer(minLength: 10)
                        Text("Median")
                            .fontWeight(.bold)
                        Text(median)
                        Spacer(minLength: 10)
                        Text("Range")
                            .fontWeight(.bold)
                        Text(range)
                    }
                    .modifier(TextAlignmentLeadingStyle())
                    .contentTransition(.numericText())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 35)
                .padding(.vertical, 13)
            }
            .padding(.horizontal, 1)
        }
        .safeAreaInset(edge: .bottom) {
            Group {
                if #available(iOS 26.0, *) {
                    Button {
                        findMean()
                        findMedian()
                        findRange()
                    } label: {
                        Text("Get statitics")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.glassProminent)
                } else {
                    Button {
                        findMean()
                        findMedian()
                        findRange()
                    } label: {
                        Text("Get statitics")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 5)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .alert("Clear all values?",
               isPresented: $showClearConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                clearArray()
            }
        } message: {
            Text("Your current inputs and results will be cleared.")
        }
        
        .navigationTitle("Central Tendency")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    MMMRView()
}
