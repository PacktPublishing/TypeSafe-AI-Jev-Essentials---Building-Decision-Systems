export function mapResumeEvaluation(response) {

    return {
        skills: [
            {
                name: "SwiftUI",
                hasExperience:
                    response.answers.has_swiftui_experience.noul >= 0.5,
                confidence:
                    response.answers.has_swiftui_experience.noul
            },
            {
                name: "SwiftData",
                hasExperience:
                    response.answers.has_swiftdata_experience.noul >= 0.5,
                confidence:
                    response.answers.has_swiftdata_experience.noul
            },
            {
                name: "REST APIs",
                hasExperience:
                    response.answers.has_networking_experience.noul >= 0.5,
                confidence:
                    response.answers.has_networking_experience.noul
            },
            {
                name: "Swift Concurrency",
                hasExperience:
                    response.answers.has_concurrency_experience.noul >= 0.5,
                confidence:
                    response.answers.has_concurrency_experience.noul
            },
            {
                name: "Testing",
                hasExperience:
                    response.answers.has_testing_experience.noul >= 0.5,
                confidence:
                    response.answers.has_testing_experience.noul
            },
            {
                name: "Architecture",
                hasExperience:
                    response.answers.has_architecture_experience.noul >= 0.5,
                confidence:
                    response.answers.has_architecture_experience.noul
            },
            {
                name: "Persistence",
                hasExperience:
                    response.answers.has_persistence_experience.noul >= 0.5,
                confidence:
                    response.answers.has_persistence_experience.noul
            }
        ],

        productionExperience: {
            hasExperience:
                response.answers.has_production_experience.noul >= 0.5,
            confidence:
                response.answers.has_production_experience.noul
        },

        experienceLevel: {
            value:
                response.answers.experience_level.choice,
            confidence:
                response.answers.experience_level.confidence
        },

        technicalFit: {
            score:
                response.answers.technical_fit.score,
            confidence:
                response.answers.technical_fit.confidence
        }
    }
}