import Foundation

// تعريف الهيكل Message
struct Message: Identifiable, Codable {
    var id = UUID() // معرف فريد لكل رسالة
    var text: String
    var isUserMessage: Bool
}
