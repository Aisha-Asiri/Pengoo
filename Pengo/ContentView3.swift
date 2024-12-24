import SwiftUI

struct ContentView3: View {
    @StateObject private var viewModel = MotivationalViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    @AppStorage("userName") private var userName: String = "User" // Retrieve the stored name
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    headingSection(geometry: geometry)
                    motivationalQuoteBox(geometry: geometry)
                    Spacer()
                    BottomBar(currentPage: "ContentView")
                        .padding(.bottom, 10)
                }
                .background(isDarkMode ? Color.black : Color.white)
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
                .foregroundColor(isDarkMode ? .white : .black)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.top, geometry.size.height * 0.1)
    }
    
    // MARK: - Motivational Quote Box
    private func motivationalQuoteBox(geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(red: 179/255, green: 200/255, blue: 207/255))
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                .shadow(radius: 9)
            
            VStack {
                Spacer()
                Text(selectedLanguage == "English" ? viewModel.currentQuote : viewModel.currentQuoteAr)
                    .multilineTextAlignment(.center)
                    .font(.system(size: geometry.size.width * 0.045, weight: .medium))
                    .foregroundColor(isDarkMode ? .white : .black)
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
        ContentView3()
            .environment(\.colorScheme, .light)
        ContentView3()
            .environment(\.colorScheme, .dark)
    }
}
