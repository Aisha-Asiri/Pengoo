import SwiftUI
import CloudKit

// MARK: - ViewModel
class StartPageViewModel: ObservableObject {
    @Published var name: String = "" // Tracks the entered name
    @Published var isAuthenticated: Bool = false // Tracks the authentication status
    
    private let container = CKContainer.default() // CloudKit container
    private let database = CKContainer.default().publicCloudDatabase // Public database for your app
    
    // Check iCloud Authentication status
    func checkiCloudAuthentication() {
        container.accountStatus { (status, error) in
            switch status {
            case .available:
                // User is logged in to iCloud and can use CloudKit
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .noAccount:
                // User is not signed into iCloud
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            case .restricted:
                // iCloud is restricted, no access allowed
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            case .couldNotDetermine:
                // Could not determine account status
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            @unknown default:
                // Handle unexpected cases
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                }
            }
        }
    }
    
    // Save name to CloudKit
    func saveNameToCloudKit() {
        // Create a new CKRecord with the name as a field
        let record = CKRecord(recordType: "User") // "User" is the record type
        record.setValue(name, forKey: "name") // "name" is the field
        
        // Save the record to CloudKit
        database.save(record) { (savedRecord, error) in
            if let error = error {
                print("Error saving to CloudKit: \(error.localizedDescription)")
            } else {
                print("Successfully saved name to CloudKit.")
            }
        }
    }
    
    // Fetch the saved name from CloudKit
    func fetchNameFromCloudKit(completion: @escaping (String?) -> Void) {
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true)) // Query to fetch all records
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordMatchedBlock = { (recordID: CKRecord.ID, result: Result<CKRecord, Error>) in
            switch result {
            case .success(let record):
                // Safely extract the "name" field from the record
                if let name = record.value(forKey: "name") as? String {
                    completion(name)
                }
            case .failure(let error):
                print("Error fetching record \(recordID): \(error.localizedDescription)")
            }
        }
        
        operation.queryResultBlock = { (result: Result<CKQueryOperation.Cursor?, Error>) in
            switch result {
            case .success(let cursor):
                print("Query completed successfully.")
            case .failure(let error):
                print("Error completing query: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        database.add(operation)
    }
    
    func printName() {
        print("Name entered: \(name)") // Prints the entered name
    }
}

// MARK: - View
struct StartPage: View {
    @StateObject private var viewModel = StartPageViewModel() // Creates ViewModel
    @State private var navigateToContentView3 = false // State to trigger navigation
    @AppStorage("userName") private var userName: String = "User" // Store the name persistently
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        VStack(spacing: 40) { // Adjusts spacing between elements
                            // Texts
                            VStack(spacing: 5) { // Reduces space between texts
                                Text("Welcome 👋")
                                    .font(.system(size: 24, weight: .semibold))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("font"))
                                
                                Text("Enter your name to continue.")
                                    .font(.system(size: 14))
                                    .foregroundColor(Color("font"))
                            }
                            
                            // Text Field
                            TextField("Enter your name", text: $viewModel.name)
                                .autocorrectionDisabled(true)
                                .padding()
                                .background(Color("Field gray"))
                                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                                .cornerRadius(25)
                                .shadow(radius: 2)
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .font(.system(size: 14))
                            
                            // NavigationLink for "Start" Button
                            NavigationLink(destination: ContentView3(), isActive: $navigateToContentView3) {
                                Text("Start")
                                    .font(.system(size: 20, weight: .medium))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color("font"))
                                    .frame(width: 151, height: 48)
                                    .background(Color("green-blue"))
                                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 2)
                                    .cornerRadius(25)
                                    .shadow(radius: 2)
                                    .onTapGesture {
                                        // Save the name and navigate to ContentView3
                                        userName = viewModel.name // Save the entered name to AppStorage
                                        viewModel.printName()
                                        viewModel.saveNameToCloudKit() // Save name to CloudKit
                                        navigateToContentView3 = true // Trigger navigation
                                    }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .navigationBarBackButtonHidden(true)
                .onAppear {
                    // Check iCloud authentication status when the view appears
                    viewModel.checkiCloudAuthentication()
                    
                    // Fetch user name from CloudKit when the view appears
                    viewModel.fetchNameFromCloudKit { fetchedName in
                        if let fetchedName = fetchedName {
                            userName = fetchedName // Set the fetched name from CloudKit to AppStorage
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}
