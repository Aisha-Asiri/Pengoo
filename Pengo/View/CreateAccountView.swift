import SwiftUI

struct CreateAccountView: View {
    @StateObject private var viewModel = CreateAccountViewModel()
    @State private var navigateToMotivational = false
    @State private var showErrorMessage = false // Tracks if the error message should be displayed
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Spacer()
                
                // Title
                Text("Create account.")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                
                // Input Fields
                VStack(spacing: 24) {
                    TextField("Name", text: $viewModel.userAccount.name)
                        .padding()
                        .frame(height: 50)
                        .background(Color("Field gray"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                    
                    TextField("Email", text: $viewModel.userAccount.email)
                        .padding()
                        .frame(height: 50)
                        .background(Color("Field gray"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .font(.system(size: 14))
                    
                    SecureField("Password", text: $viewModel.userAccount.password)
                        .padding()
                        .frame(height: 50)
                        .background(Color("Field gray"))
                        .cornerRadius(25)
                        .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                        .font(.system(size: 14))
                }
                .padding(.horizontal, 30)
                
                // Error Message
                if showErrorMessage {
                    Text("All fields are required. Please fill them in.")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                // Sign Up Button
                Button(action: {
                    if viewModel.userAccount.name.isEmpty ||
                        viewModel.userAccount.email.isEmpty ||
                        viewModel.userAccount.password.isEmpty {
                        showErrorMessage = true
                    } else {
                        showErrorMessage = false
                        viewModel.signUp()
                        navigateToMotivational = true // Trigger navigation on success
                    }
                }) {
                    Text("Sign up")
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
                MotivationalView(name: viewModel.userAccount.name) // Pass the name to MotivationalView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Skip") {
                        navigateToMotivational = true // Trigger navigation when Skip is pressed
                    }
                    .foregroundColor(.blue)
                    .font(.system(size: 18))
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
