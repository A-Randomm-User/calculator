//
//  PieChartView.swift
//  calculator
//
//  Created by Aaron on 06/08/2026.
//

import SwiftUI

struct Slice {
    var start: Double
    var end: Double
    var color: Color
    var text: String
}

struct PieChartView: View {
    
    @State private var input: Double?
    
    @State private var items: [Double] = []
    
    @State private var warning = String(localized: "")
    
    @State private var slices: [Slice] = []
    
    let colors: [Color] = [
        .red,
        .blue,
        .green,
        .orange,
        .purple,
        .pink,
        .cyan,
        .mint,
        .teal,
        .yellow,
        Color(hue: 0.1639, saturation: 1, brightness: 1), // lemonYellow
        Color(red: 0.4627, green: 0.8392, blue: 1.0), // skyBlue
    ]
    
    func appendArray() {
        if let enter = input {
            if enter > 0 {
                withAnimation(.smooth) {
                    items.append(enter)
                }
                input = nil
            }
        }
    }
    
    func convert() {
        guard !items.isEmpty else {
            return
        }
        
        slices = []

        let totalItems = items.reduce(0.0, +)
        var current = 0.0

        for (index, item) in items.enumerated() {
            let percentage = item / totalItems
            
            let start = current
            let end = current + percentage
            let color = colors[index % colors.count]
            
            slices.append(
                Slice(start: start, end: end, color: color, text: "\(item)")
            )
            
            current = end
        }
    }
    
    var body: some View {
        List {
            VStack {
                Text("Value")
                    .modifier(TextAlignmentLeadingStyle())
                
                TextField("Enter value", value: $input, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .modifier(CalculatorTextFieldStyle())
                    .onChange(of: input) {
                        withAnimation(.smooth) {
                            warning = ""
                            slices.removeAll()
                        }
                    }
                    .onSubmit {
                        appendArray()
                    }
                
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            appendArray()
                        } label: {
                            Text("Append")
                        }
                        .buttonStyle(.glass)
                    } else {
                        Button {
                            appendArray()
                        } label: {
                            Text("Append")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                
                Text(warning)
                    .contentTransition(.numericText())
            }
            
            ForEach(items.indices, id: \.self) { index in
                Text(items[index].formatted())
                    .swipeActions {
                        Button(role: .destructive) {
                            items.remove(at: index)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
            .onMove { from, to in
                items.move(fromOffsets: from, toOffset: to)
            }
            
            HStack {
                Spacer()
                GeometryReader { geometry in
                    let size = min(geometry.size.width, 350)
                    let center = size / 2
                    let radius = size * 0.35
                    
                    ZStack {
                        ForEach(slices, id: \.start) { slice in
                            let middle = (slice.start + slice.end) / 2
                            let angle = middle * 360 - 90
                            let radians = angle * .pi / 180
                            
                            Circle()
                                .trim(from: slice.start, to: slice.end)
                                .stroke(slice.color, lineWidth: size * 0.05)
                                .rotationEffect(.degrees(-90))
                            
                            if slice.end - slice.start > 0.05 {
                                Text(slice.text)
                                    .font(.caption)
                                    .position(
                                        x: center + cos(radians) * radius,
                                        y: center + sin(radians) * radius
                                    )
                            }
                        }
                    }
                    .frame(width: size, height: size)
                }
                .aspectRatio(1, contentMode: .fit)
                
                Spacer()
            }
        }
        .toolbar {
            EditButton()
        }
        .safeAreaInset(edge: .bottom) {
            if #available(iOS 26.0, *) {
                Button {
                    convert()
                } label: {
                    Text("Create Pie Chart")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .buttonStyle(.glassProminent)
            } else {
                Button {
                    convert()
                } label: {
                    Text("Create Pie Chart")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 5)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    PieChartView()
}
