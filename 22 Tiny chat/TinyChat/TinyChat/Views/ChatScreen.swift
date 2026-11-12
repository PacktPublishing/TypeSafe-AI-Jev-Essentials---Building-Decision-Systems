import SwiftUI

struct ChatScreen: View {
    @State private var prompt = ""
    @Environment(Assistant.self) private var assistant

    var body: some View {
        VStack {
            Button("I am having an issue with my bill.") {
                prompt = "I am having an issue with my bill."
                Task { await performPrompt() }
            }

            Button("I can't login into my account") {
                prompt = "I can't login into my account"
                Task { await performPrompt() }
            }

            if let responseText = assistant.responseText {
                Text(assistant.selection.profile.title)
                Text(responseText)
            }
        }
        .padding()
    }

    private func performPrompt() async {
        do {
            try await assistant.ask(prompt)
        } catch {
            print(error.localizedDescription)
        }
    }
}
