struct IntentRequest: Encodable {
    let state: String
    let model = "jev-latest"
    let questions = Questions()

    struct Questions: Encodable {
        let intent = Question()
    }

    struct Question: Encodable {
        let type = "choice"
        let instructions = "What is the user's intent?"
        let criteria = [
            "general": "General questions or requests that do not fit into billing, technical, or sales",
            "billing": "Billing, payments, charges, refunds, subscriptions, invoices, or other payment-related questions",
            "technical": "Technical issues, bugs, errors, login problems, app or website functionality, or other technical problems",
            "sales": "Questions about purchasing, pricing, plans, product availability, upgrades, or sales"
        ]
    }
}

struct IntentResponse: Decodable {
    let model: String
    let answers: Answers
    let usage: Usage

    struct Answers: Decodable {
        let intent: IntentAnswer
    }

    struct IntentAnswer: Decodable {
        let type: String
        let choice: SupportProfile
        let confidence: Double
        let probabilities: [String: Double]
    }

    struct Usage: Decodable {
        let inputTokens: Int
        let outputTokens: Int

        enum CodingKeys: String, CodingKey {
            case inputTokens = "input_tokens"
            case outputTokens = "output_tokens"
        }
    }
}
