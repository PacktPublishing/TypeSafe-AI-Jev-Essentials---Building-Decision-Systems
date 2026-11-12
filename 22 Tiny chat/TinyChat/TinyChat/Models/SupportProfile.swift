import Observation

enum SupportProfile: String, Codable {
    case general
    case billing
    case technical
    case sales

    var title: String {
        switch self {
        case .general:
            "General Support"
        case .billing:
            "Billing Support"
        case .technical:
            "Technical Support"
        case .sales:
            "Sales Support"
        }
    }
}

@Observable
final class AssistantProfileSelection {
    var profile: SupportProfile = .general
}
