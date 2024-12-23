import SwiftUI

struct MotivationalQuote {
    let text: String
}

class MotivationalViewModel: ObservableObject {
    let motivationalQuotes: [MotivationalQuote] = [
        MotivationalQuote(text: "Challenge is an opportunity to grow."),
        MotivationalQuote(text: "Perseverance brings you closer to your goal."),
        MotivationalQuote(text: "Every experience brings you closer to success."),
        MotivationalQuote(text: "Failure is a new beginning."),
        MotivationalQuote(text: "Your strength lies in overcoming."),
        MotivationalQuote(text: "Your determination is your power."),
        MotivationalQuote(text: "Learning is a journey, enjoy it."),
        MotivationalQuote(text: "You are smarter than you think."),
        MotivationalQuote(text: "Patience leads to success."),
        MotivationalQuote(text: "Success is for those who don't give up.")
    ]
    
    func getQuoteOfTheDay() -> String {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 0
        let quoteIndex = dayOfYear % motivationalQuotes.count
        return motivationalQuotes[quoteIndex].text
    }
}

struct MotivationalView: View {
    @StateObject var viewModel = MotivationalViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State private var navigateToProfile = false // State for navigation to ProfileView
    var name: String // Accept the user's name as a parameter

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Text("Hello, \(name)!")
                            .font(.system(size: geometry.size.width * 0.06, weight: .bold))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, geometry.size.height * 0.09)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(red: 179/255, green: 200/255, blue: 207/255))
                            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.3)
                            .shadow(radius: 9)
                        
                        VStack {
                            Spacer()
                            Text(viewModel.getQuoteOfTheDay())
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
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        VStack {
                            Image("Pengo1")
                                .resizable()
                                .frame(width: 28, height: 39)
                                .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                            Text("Home")
                                .font(.system(size: 10))
                                .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
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
                            Button(action: {
                                navigateToProfile = true // Trigger navigation to ProfileView
                            }) {
                                VStack {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                                    Text("Profile")
                                        .font(.system(size: 10))
                                        .foregroundColor(Color(red: 179/255, green: 200/255, blue: 207/255))
                                }
                            }
                        }
                        Spacer()
                    }
                    .frame(height: geometry.size.height * 0.1)
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .shadow(color: colorScheme == .dark ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 0, y: -3)
                }
                .background(colorScheme == .dark ? Color.black : Color.white)
                .ignoresSafeArea()
                .navigationBarBackButtonHidden(true)
                .navigationDestination(isPresented: $navigateToProfile) {
                    ProfileView() // Navigate to ProfileView
                }
            }
        }
    }
}

// MARK: - ProfileView


#Preview {
    MotivationalView(name: "Reham") // Example preview with a sample name
}
