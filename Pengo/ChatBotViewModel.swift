//
//  ChatBotViewModel.swift
//  PengoAI
//
//  Created by E07 on 17/06/1446 AH.
//

import Foundation
import GoogleGenerativeAI
import AVFoundation

@Observable
class ChatBotViewModel {
    let model: GenerativeModel
    var response: String?
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    // Initialize the model with the API key
    init() {
        guard Bundle.main.infoDictionary?["API_KEY"] is String else {
            fatalError("API key not found")
        }
        self.model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyB8q4Jue3P3KJqWsXLkdWc4F3nuo0V8BOA")
        self.response = nil
    }
    
    // Function to generate a regular AI answer
    func generateAnswer(question: String) async throws {
        self.response = nil
        do {
            let response = try await model.generateContent(question)
            self.response = response.text ?? "Bad request try again"
        } catch {
            throw error
        }
    }

    // Custom function to generate a customized response automatically
    func customizeAIResponse(question: String) async throws {
        self.response = nil
        
        // Default customizations for users with learning difficulties
        let simplifiedLanguage = true
        let encouragingTone = true
        let stepByStep = true
        
        // Customize the question or prepare a special prompt based on default preferences
        var customizedQuestion = question
        
        // Apply default customizations
        if simplifiedLanguage {
            customizedQuestion = "Please explain in simple terms: \(customizedQuestion)"
        }
        
        if encouragingTone {
            customizedQuestion = "Be positive and encouraging: \(customizedQuestion)"
        }
        
        if stepByStep {
            customizedQuestion = "Please break it down step by step: \(customizedQuestion)"
        }
        
        do {
            // Generate content based on the customized question
            let response = try await model.generateContent(customizedQuestion)
            self.response = response.text ?? "Bad request try again"
        } catch {
            throw error
        }
    }
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US") // Set language
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate // Adjust speaking rate
        speechSynthesizer.speak(utterance) // Speak the text
    }
}
