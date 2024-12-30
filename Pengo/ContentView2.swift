import SwiftUI

struct ContentView2: View {
    
    private let viewModel = ChatBotViewModel()
    @State private var textField = ""
    @State private var showLoader: Bool = false
    @State private var messages: [Message] = [] // استخدام Message بدلاً من (String, Bool)
    
    var body: some View {
        NavigationView {
            VStack {
                // Chat messages area
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(messages) { message in
                                HStack {
                                    if message.isUserMessage {
                                        Spacer()
                                        Text(message.text)
                                            .padding()
                                            .background(Color.greenBlue1)
                                            .cornerRadius(15)
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            .foregroundColor(Color(hex: "#E0DFDF"))
                                    } else {
                                        Text(message.text)
                                            .padding()
                                            .background(Color.gray)
                                            .cornerRadius(15)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .foregroundColor(Color(hex: "#E0DFDF"))
                                        Spacer()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    .onChange(of: messages.count) { _ in
                        withAnimation {
                            proxy.scrollTo(messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                .background(Color(.systemGroupedBackground))
                
                // Input bar
                HStack {
                    TextField("Enter your question...", text: $textField, axis: .vertical)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .foregroundColor(.primary)
                        .onSubmit {
                            sendQuestion(textField)
                        }
                    
                    Button(action: {
                        sendQuestion(textField)
                    }) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemBackground)) // خلفية الشريط بالكامل
                
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationTitle("Chat")
            .navigationBarTitleDisplayMode(.inline)
            .showLoader(showLoader: showLoader)
        }
    }
    
    func sendQuestion(_ question: String) {
        guard !question.isEmpty else { return }
        messages.append(Message(text: question, isUserMessage: true)) // Append user message
        textField = ""
        showLoader = true
        
        // حفظ الرسائل في UserDefaults
        saveMessagesToUserDefaults()
        
        Task {
            try await viewModel.generateAnswer(question: question)
            if let response = viewModel.response {
                messages.append(Message(text: response, isUserMessage: false)) // Append bot response
            }
            showLoader = false
            saveMessagesToUserDefaults() // تحديث الرسائل المحفوظة بعد الرد
        }
    }

    // دالة لحفظ الرسائل في UserDefaults
    func saveMessagesToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(encoded, forKey: "chatHistory")
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
