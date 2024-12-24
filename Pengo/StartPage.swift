import SwiftUI

// MARK: - ViewModel
class StartPageViewModel: ObservableObject {
    @Published var name: String = "" // Tracks the entered name
    
    func printName() {
        print("Name entered: \(name)") // Prints the entered name
    }
}

// MARK: - View
struct StartPage: View {
    @StateObject private var viewModel = StartPageViewModel() // Creates ViewModel
    @State private var navigateToContentView3 = false // State to trigger navigation
    @AppStorage("userName") private var userName: String = "User" // Store the name persistently
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        VStack(spacing: 40) { // Adjusts spacing between elements
                            // Texts
                            VStack(spacing: 5) { // Reduces space between texts
                                Text("Welcome 👋")
                                    .font(.system(size: 24, weight: .semibold))
                                    .fontWeight(.regular)
                                    .foregroundColor(.black)
                                
                                Text("Enter your name to continue.")
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                            }
                            
                            // Text Field
                            TextField("Enter your name", text: $viewModel.name)
                                .padding()
                                .background(Color("Field gray"))
                                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                                .cornerRadius(25)
                                .shadow(radius: 2)
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .font(.system(size: 14))
                            
                            // Start Button
                            Button(action: {
                                userName = viewModel.name // Save the entered name to AppStorage
                                viewModel.printName()
                                navigateToContentView3 = true // Trigger navigation
                            }) {
                                Text("Start")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.regular)
                                    .foregroundColor(.black)
                                    .frame(width: 151, height: 48)
                                    .background(Color("green-blue"))
                                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                                    .cornerRadius(25)
                                    .shadow(radius: 2)
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                // Navigation Destination
                .navigationDestination(isPresented: $navigateToContentView3) {
                    ContentView3() // Navigate to ContentView3
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    StartPage()
}
