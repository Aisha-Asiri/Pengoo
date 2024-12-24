import SwiftUI

struct HistoryView: View {
    @State private var searchText: String = "" // State for search bar input
    @AppStorage("isDarkMode") private var isDarkMode = false // Access dark mode preference
    @AppStorage("selectedLanguage") private var selectedLanguage = "English" // Access selected language

    private var header: some View {
        Text(selectedLanguage == "English" ? "History" : "الأرشيف") // Dynamic text based on language
            .font(.system(size: 24, weight: .bold)) // Header font style
            .foregroundColor(isDarkMode ? .white : .black) // Adjusts color based on dark mode
            .padding(.top, 60) // Increased padding to move the header down more
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Header view displaying the dynamic title
                header

                // Search Bar with adjusted position and colors
                TextField(selectedLanguage == "English" ? "Search" : "بحث", text: $searchText)
                    .padding(10)
                    .background(isDarkMode ? Color.gray.opacity(0.4) : Color.white.opacity(0.6)) // Adjusted background for better contrast
                    .cornerRadius(11)
                    .padding(.horizontal)
                    .padding(.top, 30) // Adjusted search bar top padding
                    .foregroundColor(isDarkMode ? .white : .black) // Text color change based on dark mode
                    .autocapitalization(.none) // Disable autocapitalization
                    .keyboardType(.default) // Set keyboard type to default
                
                // Spacer between search bar and content
                Spacer()

                VStack {
                    // Placeholder image
                    Image("Pengo4")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)

                    // Display text based on selected language
                    Text(selectedLanguage == "English" ? "No History" : "لا يوجد أرشيف")
                        .font(.headline)
                        .foregroundColor(isDarkMode ? .white : .black) // Text color adjustment based on mode
                        .padding(.top, -30)
                }

                // Spacer to push the content towards the top
                Spacer()

                // Reusable toolbar at the bottom
                BottomBar(currentPage: "HistoryView")
                    .padding(.bottom, 10)
            }
            .background(isDarkMode ? Color.black : Color(red: 0.914, green: 0.914, blue: 0.914)) // Background color
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true) // Hide the back button
        }
    }
}

#Preview {
    HistoryView()
}
