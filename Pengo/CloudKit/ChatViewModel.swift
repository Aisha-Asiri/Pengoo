
import SwiftUI
import CloudKit

class ChatViewModel: ObservableObject {
    private var database = CKContainer.default().publicCloudDatabase
    @Published var messages: [(String, Bool)] = [] // (Message, IsUserMessage)
    @Published var showLoader: Bool = false
    
    // Fetch messages from CloudKit
    func fetchMessages() {
        let predicate = NSPredicate(value: true) // Query all records
        let query = CKQuery(recordType: "ChatMessage", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        
        operation.recordFetchedBlock = { [weak self] record in
            guard let self = self else { return }
            if let question = record.value(forKey: "question") as? String,
               let response = record.value(forKey: "response") as? String {
                // Add messages (question and response) to the list
                self.messages.append((question, true))  // User message
                self.messages.append((response, false)) // Bot response
            }
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            if let error = error {
                print("Error fetching messages: \(error.localizedDescription)")
            }
        }
        
        database.add(operation)
    }
    
    // Save message to CloudKit
    func saveMessage(question: String, response: String) {
        let record = CKRecord(recordType: "ChatMessage")
        record.setValue(question, forKey: "question")
        record.setValue(response, forKey: "response")
        
        database.save(record) { _, error in
            if let error = error {
                print("Error saving message: \(error.localizedDescription)")
            } else {
                print("Message saved successfully")
            }
        }
    }
    
    // Send question and get response from the bot
    func sendQuestion(question: String, completion: @escaping (String) -> Void) {
        // Simulate sending the question to the bot and receiving a response
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let response = "This is a response to: \(question)"
            completion(response)
        }
    }
}
