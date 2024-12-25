
import CloudKit

class ProfilePage {
    private let database = CKContainer.default().privateCloudDatabase
    
    // Save user preferences to CloudKit
    func savePreferences(isDarkMode: Bool, selectedLanguage: String, hasEnteredProfile: Bool, completion: @escaping (Bool) -> Void) {
        let recordID = CKRecord.ID(recordName: "userPreferences") // Unique record ID for each user
        let record = CKRecord(recordType: "Preferences", recordID: recordID)
        
        record["isDarkMode"] = isDarkMode as CKRecordValue
        record["selectedLanguage"] = selectedLanguage as CKRecordValue
        record["hasEnteredProfile"] = hasEnteredProfile as CKRecordValue
        
        database.save(record) { _, error in
            if let error = error {
                print("Error saving preferences: \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    // Fetch user preferences from CloudKit
    func fetchPreferences(completion: @escaping (Bool, Bool, String, Bool) -> Void) {
        let recordID = CKRecord.ID(recordName: "userPreferences")
        
        database.fetch(withRecordID: recordID) { record, error in
            if let error = error {
                print("Error fetching preferences: \(error)")
                completion(false, false, "English", false)
                return
            }
            
            guard let record = record else {
                completion(false, false, "English", false)
                return
            }
            
            let isDarkMode = record["isDarkMode"] as? Bool ?? false
            let selectedLanguage = record["selectedLanguage"] as? String ?? "English"
            let hasEnteredProfile = record["hasEnteredProfile"] as? Bool ?? false
            
            completion(true, isDarkMode, selectedLanguage, hasEnteredProfile)
        }
    }
}
