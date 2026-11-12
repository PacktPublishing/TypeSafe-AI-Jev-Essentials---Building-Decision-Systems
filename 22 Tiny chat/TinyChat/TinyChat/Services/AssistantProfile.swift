import FoundationModels

struct GeneralAssistantInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            You are a general support assistant.
            Help users with general questions about the product or service.
            Provide clear and helpful answers.
            """
        }
    }
}

struct BillingAssistantInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            You are a billing support assistant.
            Help users with questions about payments, charges,
            refunds, subscriptions, and invoices.
            """
        }
    }
}

struct TechnicalAssistantInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            You are a technical support assistant.
            Help users troubleshoot technical issues, bugs,
            login problems, errors, and application functionality.
            Provide clear steps to diagnose and resolve the problem.
            """
        }
    }
}

struct SalesAssistantInstructions: DynamicInstructions {
    var body: some DynamicInstructions {
        Instructions {
            """
            You are a sales assistant.
            Help users with questions about products, pricing,
            plans, upgrades, and purchasing options.
            """
        }
    }
}

struct AssistantProfile: LanguageModelSession.DynamicProfile {
    let selection: AssistantProfileSelection

    var body: some LanguageModelSession.DynamicProfile {
        switch selection.profile {
        case .general:
            Profile {
                GeneralAssistantInstructions()
            }.onActivate {
                print("General")
            }
        case .billing:
            Profile {
                BillingAssistantInstructions()
            }.onActivate {
                print("Billing")
            }
        case .technical:
            Profile {
                TechnicalAssistantInstructions()
            }.onActivate {
                print("Technical")
            }
        case .sales:
            Profile {
                SalesAssistantInstructions()
            }.onActivate {
                print("Sales")
            }
        }
    }
}
