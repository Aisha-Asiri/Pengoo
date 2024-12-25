import SwiftUI

struct HistoryView: View {
    @State private var searchText: String = "" // State for search bar input
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light or dark)
    @AppStorage("selectedLanguage") private var selectedLanguage = "English" // Selected language
    @State private var historyItems: [String] = [] // Holds the history items fetched from CloudKit
    private var cloudKitHelper = HistoryPage() // CloudKit helper instance

    private var header: some View {
        Text(selectedLanguage == "English" ? "History" : "الأرشيف") // Dynamic text based on language
            .font(.system(size: 24, weight: .bold)) // Header font style
            .foregroundColor(colorScheme == .dark ? .white : .black) // Adjusts color based on dark mode
            .padding(.top, 60) // Padding for the header
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Header view displaying the dynamic title
                header

                // Search Bar
                HStack {
                    // Search icon
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(colorScheme == .dark ? .white : .gray)
                        .padding(.leading, 15)

                    // TextField for user input
                    ZStack(alignment: .leading) {
                        if searchText.isEmpty {
                            Text(selectedLanguage == "English" ? "Search" : "بحث")
                                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.6) : Color.black.opacity(0.6))
                                .padding(.leading, 15)
                        }

                        TextField("", text: $searchText)
                            .padding(10)
                            .background(colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white.opacity(0.6))
                            .cornerRadius(12)
                            .foregroundColor(colorScheme == .dark ? Color.white : .black)
                            .autocapitalization(.none)
                            .keyboardType(.default)
                            .padding(.leading, 10)
                    }
                }
                .frame(height: 45)
                .background(colorScheme == .dark ? Color.gray.opacity(0.4) : Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 30)

                // Spacer between search bar and content
                Spacer()

                // Content Section
                VStack {
                    // Show history or no history message based on fetched data
                    if historyItems.isEmpty {
                        // Placeholder image with reduced opacity
                        Image("Pengo4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .opacity(0.6)
                            .foregroundColor(.gray)

                        // No History text
                        Text(selectedLanguage == "English" ? "No History" : "لا يوجد أرشيف")
                            .font(.headline)
                            .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.7) : Color.black.opacity(0.6))
                            .padding(.top, -30)
                    } else {
                        // Display history items
                        List(historyItems, id: \.self) { item in
                            Text(item)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }

                Spacer()

                // Reusable toolbar at the bottom
                BottomBar(currentPage: "HistoryView")
                    .padding(.bottom, 10)
            }
            .background(Color("background")) // Use the same background color as SplashPage
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
            .onAppear {
                // Fetch history when the view appears
                cloudKitHelper.fetchHistory { success, items in
                    if success {
                        self.historyItems = items
                    } else {
                        print("Failed to fetch history.")
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView()
}
