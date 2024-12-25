
//
//  SplashPage.swift
//  Pengo
//
//  Created by Aisha Asiri on 17/06/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false // State to manage navigation trigger
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("Pengo0")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding([.leading, .bottom], 50.0)
                }
            }
            // NavigationLink triggered automatically after 2 seconds
            .navigationDestination(isPresented: $isActive) {
                StartPage() // Navigates to StartPage
            }
            .onAppear {
                // Delay before navigating to the StartPage
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
