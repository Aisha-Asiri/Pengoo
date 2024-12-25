import SwiftUI

struct ContentView3: View {
    @StateObject private var viewModel = MotivationalViewModel()
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    @AppStorage("userName") private var userName: String = "User" // Retrieve the stored name
    
    @Environment(\.colorScheme) var colorScheme // Access the current color scheme (light or dark)
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    headingSection(geometry: geometry)
                    motivationalQuoteBox(geometry: geometry) // Call the updated function here
                    Spacer()
                    BottomBar(currentPage: "ContentView")
                        .padding(.bottom, 10)
                }
                .background(Color("background")) // Use the same background color as other pages
                .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Heading Section
    private func headingSection(geometry: GeometryProxy) -> some View {
        HStack {
            Text(selectedLanguage == "English" ? "Hello, \(userName)!" : "مرحبًا، \(userName)!")
                .font(.system(size: geometry.size.width * 0.06, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black) // Change text color based on the current mode (Dark/Light)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.top, geometry.size.height * 0.1)
    }
    
    // MARK: - Motivational Quote Box
    private func motivationalQuoteBox(geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("green-blue")) // تغيير اللون إلى الأخضر الأزرق
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                .shadow(radius: 9)
            
            VStack {
                Spacer()
                Text(selectedLanguage == "English" ? viewModel.currentQuote : viewModel.currentQuoteAr)
                    .multilineTextAlignment(.center)
                    .font(.system(size: geometry.size.width * 0.045, weight: .medium))
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Change text color based on the current mode (Dark/Light)
                    .padding(.horizontal, 20)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            
            Image("Pengo2")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width * 0.25, height: geometry.size.width * 0.25)
                .offset(x: geometry.size.width * 0.37, y: geometry.size.height * 0.09)
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Show Light Mode Preview
            ContentView3()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode") // Optional: gives it a name

            // Show Dark Mode Preview
            ContentView3()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode") // Optional: gives it a name
        }
        .previewLayout(.sizeThatFits) // Optional: adjust the layout for previews
    }
}
