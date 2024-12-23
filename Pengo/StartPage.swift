import SwiftUI

// MARK: - ViewModel
class StartPageViewModel: ObservableObject {
    @Published var name: String = "" // متغير لمراقبة النص المدخل
    
    func printName() {
        print("Name entered: \(name)") // دالة لطباعة الاسم
    }
}

// MARK: - View
struct StartPage: View {
    @StateObject private var viewModel = StartPageViewModel()
    // إنشاء ViewModel
    
    var body: some View {
        ZStack {
            Color("background")
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                   
                    
                    VStack(spacing: 40) { // تعديل المسافة بين جميع العناصر داخل الـ VStack
                        // النصوص
                        VStack(spacing: 5) { // تقليل المسافة بين النصين
                            Text("Welcome 👋")
                                .font(.system(size: 24, weight: .semibold))
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                            
                            Text("Enter your name to continue.")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                        }
                        
                        // حقل النص
                        TextField("Enter your name", text: $viewModel.name)
                            .padding()
                            .background(Color("Field gray"))
                            .shadow( color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                            .cornerRadius(25)
                            .shadow(radius: 2)
                            .frame( height: 50)
                            .padding(.horizontal, 20)
                            .font(.system(size: 14))
                        
                        // زر البدء
                        Button(action: {
                            viewModel.printName()
                            // استدعاء الدالة من ViewModel
                        }) {
                            Text("Start")
                                .font(.system(size: 20, weight: .medium))
                                .fontWeight(.regular)
                                .foregroundColor(.black)
                                .frame(width: 151, height: 48)
                                .background(Color("green-blue"))
                                .shadow( color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                                .cornerRadius(25)
                                .shadow(radius: 2)
                        }
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    StartPage()
}
