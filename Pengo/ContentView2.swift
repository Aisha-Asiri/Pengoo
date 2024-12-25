
import SwiftUI

struct ContentView2: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var textField = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Chat messages area
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.messages.indices, id: \.self) { index in
                                let message = viewModel.messages[index]
                                HStack {
                                    if message.1 {
                                        Spacer()
                                        Text(message.0)
                                            .padding()
                                            .background(Color.greenBlue)
                                            .cornerRadius(15)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .foregroundColor(Color(hex: "#B3C8CF"))
                                    } else {
                                        Text(message.0)
                                            .padding()
                                            .background(Color.gray.opacity(0.2))
                                            .cornerRadius(15)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(Color(hex: "#E0DFDF"))
                                        Spacer()
                                    }
                                }
                                .id(index)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.indices.last, anchor: .bottom)
                        }
                    }
                }
                .background(Color(.systemGroupedBackground))

                // Input area
                HStack {
                    TextField("Enter your question...", text: $textField, axis: .vertical)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(minHeight: 15, maxHeight: 40)
                        .padding(.horizontal, 2)
                        .onSubmit {
                            sendQuestion(textField)
                        }
                        .accessibilityLabel("Enter your question")
                        .accessibilityHint("Use dictation or typing to ask a question")

                    Button(action: {
                        sendQuestion(textField)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 2)
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .showLoader(showLoader: viewModel.showLoader)
            .onAppear {
                // Fetch messages when the view appears
                viewModel.fetchMessages()
            }
        }
    }
    
    func sendQuestion(_ question: String) {
        guard !question.isEmpty else { return }
        
        // Append the user's message
        viewModel.messages.append((question, true))
        textField = ""
        viewModel.showLoader = true
        
        // Get the bot's response
        viewModel.sendQuestion(question: question) { response in
            // Append bot's response and save to CloudKit
            DispatchQueue.main.async {
                viewModel.messages.append((response, false))
                viewModel.saveMessage(question: question, response: response)
                viewModel.showLoader = false
            }
        }
    }
}

struct ProgressViewScreen: ViewModifier {
    let showLoader: Bool
    func body(content: Content) -> some View {
        content.overlay {
            if showLoader {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
            }
        }
    }
}

extension View {
    func showLoader(showLoader: Bool) -> some View {
        self.modifier(ProgressViewScreen(showLoader: showLoader))
    }
}

// Hex Color Extension
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}

#Preview {
    ContentView2()
}
