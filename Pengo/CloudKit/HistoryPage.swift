
import CloudKit

class HistoryPage {
    private let database = CKContainer.default().privateCloudDatabase

    // Fetch History from CloudKit
    func fetchHistory(completion: @escaping (Bool, [String]) -> Void) {
        let query = CKQuery(recordType: "History", predicate: NSPredicate(value: true)) // Fetch all history records
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        query.sortDescriptors = [sortDescriptor]

        let operation = CKQueryOperation(query: query)
        var historyItems: [String] = []

        operation.recordFetchedBlock = { record in
            if let historyItem = record["historyItem"] as? String {
                historyItems.append(historyItem)
            }
        }

        operation.queryCompletionBlock = { _, error in
            if let error = error {
                print("Error fetching history: \(error)")
                completion(false, [])
            } else {
                completion(true, historyItems)
            }
        }

        database.add(operation)
    }

    // Save new History item to CloudKit
    func saveHistory(item: String, completion: @escaping (Bool) -> Void) {
        let record = CKRecord(recordType: "History")
        record["historyItem"] = item as CKRecordValue
        record["createdAt"] = Date() as CKRecordValue

        database.save(record) { _, error in
            if let error = error {
                print("Error saving history: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
