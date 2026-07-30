import SwiftUI

struct CalculatorTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 30)
            .padding(.vertical, 5)
            .background {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.secondary.opacity(0.08))
                    .padding(.horizontal, 10)
            }
    }
}

struct ContentView: View {
    
    @State private var selectedView: String?
    
    @State var version = "1.0"
    @State var build = "14"
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selectedView) {
                
                Section("Math") {
                    NavigationLink(value: "interest") {
                        Text("Find unknown on Simple / Compound Interest")
                    }
                    
                    NavigationLink(value: "quadratic") {
                        Text("Solve Quadratic Equation")
                    }
                    
                    NavigationLink(value: "sequence") {
                        Text("Find nth term in Sequence")
                    }
                    
                    NavigationLink(value: "simultaneous") {
                        Text("Solve 2 unknowns of Linear Simultaneous Equation")
                    }
                }
                
                Section("Conversion") {
                    NavigationLink(value: "radix") {
                        Text("Convert Number System")
                    }
                    
                    NavigationLink(value: "length") {
                        Text("Length Conversion")
                    }
                }
                
                Section {
                    NavigationLink(value: "about") {
                        Text("About This Build")
                    }
                }
                
                Section {
                    VStack {
                        Text("Version \(version), Build \(build)")
                        Text("Created by Aaron")
                    }
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Calculator")
            
        } detail: {
            NavigationStack {
                if let selectedView {
                    switch selectedView {
                        
                    case "interest":
                        InterestView()
                        
                    case "quadratic":
                        QuadraticView()
                        
                    case "sequence":
                        SequenceView()
                        
                    case "simultaneous":
                        SimultaneousView()
                        
                    case "radix":
                        RadixView()
                        
                    case "length":
                        LengthView()
                        
                    case "about":
                        ChangelogView()
                        
                    default:
                        Text("Select a calculator")
                    }
                    
                } else {
                    Text("Select a calculator")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: .openCalculator
            )
        ) { notification in
            selectedView = notification.object as? String
        }
    }
}

#Preview {
    ContentView()
}
