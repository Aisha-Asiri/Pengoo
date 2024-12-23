import SwiftUI

// MARK: - Model
struct SignInCredentials {
    var email: String = ""
    var password: String = ""
}

// MARK: - ViewModel
class SignInViewModel: ObservableObject {
    @Published var credentials = SignInCredentials()
    @Published var errorMessage: String? = nil
    
    func signIn() -> Bool {
        // Example sign-in logic
        guard !credentials.email.isEmpty, !credentials.password.isEmpty else {
            errorMessage = "Email and password cannot be empty."
            return false
        }
        
        // Placeholder for API call or further login logic
        print("Attempting sign in with:")
        print("Email: \(credentials.email)")
        print("Password: \(credentials.password)")
        
        // Simulating a successful login
        errorMessage = nil
        return true
    }
}

// MARK: - View
struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @State private var navigateToMotivational = false // State to manage navigation
    @State private var userName = "John Doe" // Replace with actual logic for getting the name


    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                // Title
                Text("I have account already,")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                // Input Fields
                VStack(spacing: 24) {
                    TextField("Email", text: $viewModel.credentials.email)
                        .padding()
                        .frame(height: 50)
                        .background(Color("Field gray"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                    
                    SecureField("Password", text: $viewModel.credentials.password)
                        .padding()
                        .frame(height: 50)
                        .background(Color("Field gray"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                        .font(.system(size: 14))
                }
                .padding(.horizontal, 30)
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                }
                
                // Login Button
                Button(action: {
                    if viewModel.signIn() {
                        navigateToMotivational = true // Trigger navigation on successful login
                    }
                }) {
                    Text("Login")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                        .frame(width: 150, height: 50)
                        .background(Color("green-blue"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal, 60)
                
                Spacer()
            }
            .background(Color("background"))
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $navigateToMotivational) {
                MotivationalView(name: userName) // Pass the dynamic name
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Skip") {
                        navigateToMotivational = true // Navigate directly to MotivationalView
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    SignInView()
}
