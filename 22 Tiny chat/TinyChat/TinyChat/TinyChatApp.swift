//
//  TinyChatApp.swift
//  TinyChat
//
//  Created by Mohammad Azam on 9/18/26.
//

import SwiftUI
import FoundationModels

@main
struct TinyChatApp: App {
    
    @State private var assistant: Assistant
    
    init() {
        
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { fatalError("API_KEY not configured.") }
        
        let defaultHeaders = ["Content-Type": "application/json", "Authorization": "Bearer \(apiKey)"]
        
        let httpClient = HTTPClient(defaultHeaders: defaultHeaders)
        let intentClassifier = IntentClassifier(httpClient: httpClient)
        
        let assistantProfileSelection = AssistantProfileSelection()
        
        let session = LanguageModelSession(profile: AssistantProfile(selection: assistantProfileSelection))
        _assistant = State(initialValue: Assistant(session: session, intentClassifier: intentClassifier, selection: assistantProfileSelection))
    }
    
    var body: some Scene {
        WindowGroup {
            ChatScreen()
                .environment(assistant)
        }
    }
}
