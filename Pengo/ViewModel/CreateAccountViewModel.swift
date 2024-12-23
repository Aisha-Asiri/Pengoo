//
//  CreateAccountViewModel.swift
//  Pengo
//
//  Created by Aisha Asiri on 17/06/1446 AH.
//

import Foundation
import CloudKit

class CloudKitHelper {
    private let container = CKContainer.default()
    private let publicDatabase = CKContainer.default().publicCloudDatabase
    
    func saveUserAccount(name: String, email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // Create a new CKRecord
        let userRecord = CKRecord(recordType: "UserAccount")
        userRecord["name"] = name as CKRecordValue
        userRecord["email"] = email as CKRecordValue
        userRecord["password"] = password as CKRecordValue // Avoid storing passwords in plaintext (use hashing in a real app)
        
        // Save the record to the public database
        publicDatabase.save(userRecord) { record, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

class CreateAccountViewModel: ObservableObject {
    @Published var userAccount = UserAccount()
    @Published var errorMessage: String? = nil
    private let cloudKitHelper = CloudKitHelper()
    
    func signUp() {
        // Validate inputs
        guard !userAccount.name.isEmpty,
              !userAccount.email.isEmpty,
              !userAccount.password.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        
        // Save to CloudKit
        cloudKitHelper.saveUserAccount(name: userAccount.name, email: userAccount.email, password: userAccount.password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("Account created successfully.")
                case .failure(let error):
                    self.errorMessage = "Failed to create account: \(error.localizedDescription)"
                }
            }
        }
    }
}


