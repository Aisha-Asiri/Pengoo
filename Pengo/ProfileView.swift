import SwiftUI

struct ProfileView: View {
    // AppStorage properties for user preferences
    @AppStorage("selectedLanguage") private var selectedLanguage = "English" // Stores selected language
    @AppStorage("hasEnteredProfile") private var hasEnteredProfile: Bool = false // Tracks if the user has entered the profile page before
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false // Stores the user's Dark Mode preference
    
    private let cloudKitHelper = ProfilePage() // CloudKit Helper instance
    
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light or dark)
    
    var body: some View {
        NavigationStack {
            VStack {
                // Page header displaying the title
                header
                
                // User's profile image section
                profileImage
                
                // Dark mode toggle switch
                darkModeToggle
                
                // Language selection buttons
                languageButtons
                
                Spacer()
                
                // Bottom navigation bar
                BottomBar(currentPage: "ProfileView")
                    .padding(.bottom, 10) // Adds padding to avoid overlapping with screen edges
            }
            .background(Color("background")) // Use the same background color as other pages
            .edgesIgnoringSafeArea(.bottom) // Ensures bottom bar covers the full width
            .navigationBarBackButtonHidden(true) // Hides the back button
            .onAppear {
                // Fetch preferences from CloudKit when the view appears
                cloudKitHelper.fetchPreferences { success, darkMode, language, profileEntered in
                    if success {
                        self.selectedLanguage = language
                        self.hasEnteredProfile = profileEntered
                        self.isDarkMode = darkMode // Set Dark Mode preference from CloudKit
                    }
                }
            }
            .onAppear {
                // Sets the value when the user enters the profile page for the first time
                if !hasEnteredProfile {
                    hasEnteredProfile = true // Marked as visited
                    cloudKitHelper.savePreferences(isDarkMode: isDarkMode, selectedLanguage: selectedLanguage, hasEnteredProfile: true) { success in
                        if success {
                            print("User profile entry marked.")
                        }
                    }
                }
            }
            // Apply the color scheme dynamically based on user preference
            .preferredColorScheme(isDarkMode ? .dark : .light) // Apply the color scheme based on the user's preference
        }
    }
    
    // MARK: - Page Header
    private var header: some View {
        Text(selectedLanguage == "English" ? "Profile" : "الملف الشخصي") // Dynamic text based on language
            .font(.system(size: 24, weight: .bold)) // Header font style
            .foregroundColor(colorScheme == .dark ? .white : .black) // Adjusts color to always be white in dark mode
            .padding(.top, 30) // Adds space at the top
    }
    
    // MARK: - Profile Image Section
    private var profileImage: some View {
        Image(systemName: hasEnteredProfile ? "person.crop.circle.fill" : "person.crop.circle") // Filled icon if the user has visited
            .resizable()
            .frame(width: 120, height: 120) // Profile image size
            .foregroundColor(colorScheme == .dark ? .gray.opacity(0.6) : Color.gray.opacity(0.3)) // Adjusts color based on mode
            .padding(.top, 20) // Adds top padding
    }
    
    // MARK: - Dark Mode Toggle
    private var darkModeToggle: some View {
        HStack {
            Text(selectedLanguage == "English" ? "Dark Mode" : "الوضع الليلي") // Dynamic label
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(colorScheme == .dark ? .white : .black) // Adjusts color based on mode
            Spacer() // Adds spacing between label and toggle
            Toggle("", isOn: $isDarkMode) // Use the bound isDarkMode property to toggle dark mode
                .labelsHidden() // Hides toggle label
        }
        .padding()
        .frame(height: 50)
        .background(colorScheme == .dark ? Color.black.opacity(0.3) : Color.gray.opacity(0.2)) // Background styling
        .cornerRadius(12) // Rounded corners
        .padding(.horizontal, 20) // Horizontal padding
        .padding(.top, 30) // Top padding
    }
    
    // MARK: - Language Selection Buttons
    private var languageButtons: some View {
        HStack(spacing: 0) { // Aligns buttons horizontally
            languageButton(title: "English", language: "English") // English language button
            languageButton(title: "العربية", language: "Arabic") // Arabic language button
        }
        .padding(.horizontal, 20) // Horizontal padding
        .padding(.top, 10) // Top padding
    }
    
    // MARK: - Individual Language Button
    private func languageButton(title: String, language: String) -> some View {
        Button(action: {
            selectedLanguage = language // Updates the selected language
        }) {
            Text(title) // Button label
                .frame(maxWidth: .infinity) // Ensures equal button width
                .frame(height: 40) // Button height
                .background(selectedLanguage == language ? Color(red: 179/255, green: 200/255, blue: 207/255) : Color.clear) // Highlights selected language
                .foregroundColor(selectedLanguage == language ? .black : .gray) // Adjusts text color based on selection
                .cornerRadius(8) // Rounded corners
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environment(\.colorScheme, .light) // Light mode preview
        ProfileView()
            .environment(\.colorScheme, .dark) // Dark mode preview
    }
}
