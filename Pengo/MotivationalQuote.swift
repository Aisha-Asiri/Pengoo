
import SwiftUI

struct MotivationalQuote {
    let text: String
    let textAr: String
}

class MotivationalViewModel: ObservableObject {
    @Published var currentQuote: String = ""
    @Published var currentQuoteAr: String = ""
    

    private let motivationalQuotes: [MotivationalQuote] = [
        MotivationalQuote(text: "Challenge is an opportunity to grow.", textAr: "التحدي فرصة للنمو."),
        MotivationalQuote(text: "Perseverance brings you closer to your goal.", textAr: "المثابرة تقربك من هدفك."),
        MotivationalQuote(text: "Every experience brings you closer to success.", textAr: "كل تجربة تقربك من النجاح."),
        MotivationalQuote(text: "Failure is a new beginning.", textAr: "الفشل هو بداية جديدة."),
        MotivationalQuote(text: "Your strength lies in overcoming.", textAr: "قوتك تكمن في التغلب."),
        MotivationalQuote(text: "Your determination is your power.", textAr: "عزيمتك هي قوتك."),
        MotivationalQuote(text: "Learning is a journey, enjoy it.", textAr: "التعلم رحلة، استمتع بها."),
        MotivationalQuote(text: "You are smarter than you think.", textAr: "أنت أذكى مما تعتقد."),
        MotivationalQuote(text: "Patience leads to success.", textAr: "الصبر يؤدي إلى النجاح."),
        MotivationalQuote(text: "Success is for those who don't give up.", textAr: "النجاح لمن لا يستسلم.")
    ]
    
  
    init() {
        updateQuoteOfTheDay()
    }
    
    func updateQuoteOfTheDay() {
        let calendar = Calendar.current
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: Date()) ?? 0
        let quoteIndex = dayOfYear % motivationalQuotes.count
        currentQuote = motivationalQuotes[quoteIndex].text
        currentQuoteAr = motivationalQuotes[quoteIndex].textAr
    }
}
