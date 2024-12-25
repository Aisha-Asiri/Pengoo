
import SwiftUI

struct BottomBar: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("selectedLanguage") private var selectedLanguage = "English"
    
    var currentPage: String? // The current page name
    
    var body: some View {
        HStack {
            Spacer()
            
            // Pengo Button
            if currentPage != "ContentView" {
                NavigationLink(destination: ContentView3()) {
                    VStack {
                        Image("Pengo1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                        Text(selectedLanguage == "English" ? "Pengo" : "بنقو")
                            .font(.system(size: 8))
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                    }
                }
            } else {
                Button(action: {}) {
                    VStack {
                        Image("Pengo3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                        Text(selectedLanguage == "English" ? "Pengo" : "بنقو")
                            .font(.system(size: 8))
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                    }
                }
            }

            Spacer()

            // Chat Button (Navigate to ContentView2)
            NavigationLink(destination: ContentView2()) {
                VStack {
                    Image(systemName: "message")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                    Text(selectedLanguage == "English" ? "Chat" : "دردشة")
                        .font(.system(size: 8))
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                }
            }

            Spacer()

            // History Button
            if currentPage == "HistoryView" {
                VStack {
                    Image(systemName: "folder.fill") // Highlighted folder icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#D3D3D3"))
                    Text(selectedLanguage == "English" ? "History" : "الأرشيف")
                        .font(.system(size: 8))
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#D3D3D3"))
                }
            } else {
                NavigationLink(destination: HistoryView()) {
                    VStack {
                        Image(systemName: "folder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                        Text(selectedLanguage == "English" ? "History" : "الأرشيف")
                            .font(.system(size: 8))
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                    }
                }
            }

            Spacer()

            // Profile Button
            if currentPage == "ProfileView" {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#D3D3D3"))
                    Text(selectedLanguage == "English" ? "Profile" : "الملف الشخصي")
                        .font(.system(size: 8))
                        .foregroundColor(isDarkMode ? Color.white : Color(hex: "#D3D3D3"))
                }
            } else {
                NavigationLink(destination: ProfileView()) {
                    VStack {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                        Text(selectedLanguage == "English" ? "Profile" : "الملف الشخصي")
                            .font(.system(size: 8))
                            .foregroundColor(isDarkMode ? Color.white : Color(hex: "#979797"))
                    }
                }
            }

            Spacer()
        }
        .frame(height: 60)
        .background(isDarkMode ? Color.black : Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(isDarkMode ? Color.white.opacity(0.2) : Color.black.opacity(0.2)),
            alignment: .top
        )
        .shadow(color: isDarkMode ? Color.white.opacity(0.1) : Color.black.opacity(0.1), radius: 3, x: 0, y: -3)
    }
}
