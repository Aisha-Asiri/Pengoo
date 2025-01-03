import SwiftUI

struct ContentView3: View {
    @StateObject private var viewModel = MotivationalViewModel()
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    @AppStorage("userName") private var userName: String = "User"
    @State private var navigateToContentView2 = false
    
    @Environment(\.colorScheme) var colorScheme
    
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
                .background(Color("background"))
                .ignoresSafeArea()
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width > 100 {
                                navigateToContentView2 = true
                            }
                        }
                )
            }
            .navigationDestination(isPresented: $navigateToContentView2) {
                ContentView2()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // MARK: - Heading Section
    private func headingSection(geometry: GeometryProxy) -> some View {
        HStack {
            Text(selectedLanguage == "English" ? "Hello, \(userName)!" : "مرحبًا، \(userName)!")
                .font(.system(size: geometry.size.width * 0.06, weight: .bold))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .padding(.leading, 20)
            Spacer()
        }
        .padding(.top, geometry.size.height * 0.1)
    }
    
    // MARK: - Motivational Quote Box
    private func motivationalQuoteBox(geometry: GeometryProxy) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color("green-blue"))
                .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                .shadow(radius: 9)
            
            VStack {
                Spacer()
                Text(selectedLanguage == "English" ? viewModel.currentQuote : viewModel.currentQuoteAr)
                    .multilineTextAlignment(.center)
                    .font(.system(size: geometry.size.width * 0.045, weight: .medium))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
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
struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView3()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Light Mode")
            
            ContentView3()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")
        }
        .previewLayout(.sizeThatFits)
    }
}
