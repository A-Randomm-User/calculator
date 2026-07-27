import SwiftUI

struct ContentView: View {
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
                        BinaryDenaryView()
                    } label: {
                        Text("Binary \(Image(systemName: "arrow.left.arrow.right")) Denary")
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
                        Text("Version 1.0, Build 11")
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
        }
    }
}

#Preview {
    ContentView()
}
