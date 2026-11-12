import Foundation

struct IntentClassifier {
    let httpClient: HTTPClient

    func classify(_ prompt: String) async throws -> SupportProfile {
        let intentRequest = IntentRequest(state: prompt)
        let data = try JSONEncoder().encode(intentRequest)
        let resource = Resource(
            url: Constants.Urls.jevURL,
            method: .post(data),
            responseType: IntentResponse.self
        )

        let response = try await httpClient.fetch(resource)
        return response.answers.intent.choice
    }
}
