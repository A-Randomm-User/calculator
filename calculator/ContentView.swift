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
    @State var build = "13"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Math")
                        .font(.title3)

                    NavigationLink {
                        InterestView()
                    } label: {
                        Text("Find unknown on Simple / Compound Interest")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    NavigationLink {
                        QuadraticView()
                    } label: {
                        Text("Solve Quadratic Equation")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    NavigationLink {
                        SequenceView()
                    } label: {
                        Text("Find nth term in Sequence")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    NavigationLink {
                        SimultaneousView()
                    } label: {
                        Text("Solve 2 unknowns of Linear Simultaneous Equation")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    Text("Conversion")
                        .font(.title3)

                    NavigationLink {
                        RadixView()
                    } label: {
                        Text("Convert Number System")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    NavigationLink {
                        LengthView()
                    } label: {
                        Text("Length Conversion")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .padding()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.15))
                    }
                    
                    Divider()

                    NavigationLink("About This Build") {
                        ChangelogView()
                    }

                    Spacer(minLength: 20)

                    VStack {
                        Text("Version \(version), Build \(build)")
                        Text("Created by Aaron")
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.secondary)
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationTitle("Calculator")
            
            .onReceive(
                NotificationCenter.default.publisher(
                    for: .openCalculator
                )
            ) { notification in
                
                selectedView = notification.object as? String
            }
            
            .navigationDestination(item: $selectedView) { value in
                switch value {
                    
                case "quadratic":
                    QuadraticView()
                    
                default:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
