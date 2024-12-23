import SwiftUI

struct ProfileView: View {
    @State private var isDarkMode = false
    @State private var selectedLanguage = "English"
    @State private var navigateToSignIn = false // State to manage navigation to SignInView
    @State private var navigateToMotivational = false // State to manage navigation to MotivationalView
    @State private var navigateToCreateAccount = false // State to manage navigation to CreateAccountView
    @State private var userName = "John Doe"

    var body: some View {
        NavigationStack {
            VStack {
                Text("Profile")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .white : .black)
                    .padding(.top, 30)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(isDarkMode ? .gray.opacity(0.6) : Color.gray.opacity(0.3))
                    .padding(.top, 20)
                
                HStack(spacing: 4) {
                    Button(action: {
                        navigateToSignIn = true // Trigger navigation
                    }) {
                        Text("Login")
                            .foregroundColor(.blue)
                            .font(.system(size: 16, weight: .medium))
                    }
                    
                    Text("/")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.system(size: 16, weight: .medium))
                    
                    Button(action: {
                        navigateToCreateAccount = true // Trigger navigation to CreateAccountView
                    }) {
                        Text("Sign Up")
                            .foregroundColor(Color.cyan)
                            .font(.system(size: 16, weight: .medium))
                    }
                }
                .padding(.top, 10)
                
                HStack {
                    Text("Dark Mode")
                        .font(.system(size: 18, weight: .medium))
                        .fontWeight(.regular)
                        .foregroundColor(isDarkMode ? .white : .black)
                    Spacer()
                    Toggle("", isOn: $isDarkMode)
                        .labelsHidden()
                }
                .padding()
                .frame(height: 50)
                .background(isDarkMode ? Color.black.opacity(0.3) : Color.gray.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                HStack(spacing: 0) {
                    Button(action: {
                        selectedLanguage = "English"
                    }) {
                        Text("English")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(selectedLanguage == "English" ? Color(red: 179/255, green: 200/255, blue: 207/255) : Color.clear)
                            .foregroundColor(selectedLanguage == "English" ? .black : .gray)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        selectedLanguage = "Arabic"
                    }) {
                        Text("Arabic")
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(selectedLanguage == "Arabic" ? Color(red: 179/255, green: 200/255, blue: 207/255) : Color.clear)
                            .foregroundColor(selectedLanguage == "Arabic" ? .black : .gray)
                            .cornerRadius(8)
                    }
                }
                .frame(height: 40)
                .background(isDarkMode ? Color.black.opacity(0.3) : Color.gray.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            navigateToMotivational = true // Trigger navigation to MotivationalView
                        }) {
                            Image("Pengo1")
                                .resizable()
                                .frame(width: 28, height: 39)
                                .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                            Text("Home")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                        }
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "mic")
                            .resizable()
                            .frame(width: 20, height: 28)
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                        Text("Voice")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "message")
                            .resizable()
                            .frame(width: 25, height: 28)
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                        Text("Chat")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                    }
                    Spacer()
                    VStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                        Text("Profile")
                            .font(.system(size: 10))
                            .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                    }
                    Spacer()
                }
                .frame(height: 60)
                .background(isDarkMode ? Color.black : Color.white)
                .shadow(color: isDarkMode ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 0, y: -3)
            }
            .background(isDarkMode ? Color.black : Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.bottom)
            .navigationDestination(isPresented: $navigateToSignIn) {
                SignInView() // Navigate to SignInView
            }
            .navigationDestination(isPresented: $navigateToMotivational) {
                MotivationalView(name: userName)
                    .navigationBarBackButtonHidden(true)
            }
            
            .navigationDestination(isPresented: $navigateToCreateAccount) {
                CreateAccountView() // Navigate to CreateAccountView
                    
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
