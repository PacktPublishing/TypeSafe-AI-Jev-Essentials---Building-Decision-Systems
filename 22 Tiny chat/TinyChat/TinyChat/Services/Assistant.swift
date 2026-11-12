import FoundationModels
import Observation

@Observable
final class Assistant {
    let session: LanguageModelSession
    let intentClassifier: IntentClassifier
    let selection: AssistantProfileSelection

    var responseText: String?

    init(
        session: LanguageModelSession,
        intentClassifier: IntentClassifier,
        selection: AssistantProfileSelection
    ) {
        self.session = session
        self.intentClassifier = intentClassifier
        self.selection = selection
    }

    func ask(_ prompt: String) async throws {
        selection.profile = try await intentClassifier.classify(prompt)
        let response = try await session.respond(to: prompt)
        responseText = response.content
    }
}
