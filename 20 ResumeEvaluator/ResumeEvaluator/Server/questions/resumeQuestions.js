export const resumeQuestions = {

    has_swiftui_experience: {
        type: "noul",
        instructions: "Does the candidate have experience with SwiftUI?"
    },

    has_swiftdata_experience: {
        type: "noul",
        instructions: "Does the candidate have experience with SwiftData?"
    },

    has_networking_experience: {
        type: "noul",
        instructions: "Does the candidate have experience consuming REST APIs or performing network requests?"
    },

    has_concurrency_experience: {
        type: "noul",
        instructions: "Does the candidate demonstrate experience with Swift concurrency such as async/await, Task, actors, or structured concurrency?"
    },

    has_testing_experience: {
        type: "noul",
        instructions: "Does the candidate demonstrate experience writing automated tests for iOS applications?"
    },

    has_architecture_experience: {
        type: "noul",
        instructions: "Does the candidate demonstrate experience with application architecture or separation of concerns?"
    },

    has_persistence_experience: {
        type: "noul",
        instructions: "Does the candidate demonstrate experience with local persistence such as SwiftData, Core Data, SQLite, or another database?"
    },

    has_production_experience: {
        type: "noul",
        instructions: "Does the resume provide evidence that the candidate has worked on production applications used by real users?"
    },

    experience_level: {
        type: "choice",
        instructions: "What is the candidate's iOS development experience level?",
        criteria: {
            no_experience: "Candidate does not have any experience as an iOS developer",
            entry_level: "Primarily educational, personal project, internship, or limited professional experience",
            mid_level: "Several years of professional iOS development experience with independent feature ownership",
            senior: "Extensive professional experience with architecture, complex systems, technical ownership, or leadership"
        }
    },

   technical_fit: {
    type: "score",
    instructions:
        "Evaluate the candidate's fit for a Senior SwiftUI Developer position.",
    criteria: [
        "Limited evidence of the SwiftUI skills and professional experience required for a senior role",
        "Relevant SwiftUI skills and professional experience, but some senior-level requirements are missing",
        "Strong evidence of advanced SwiftUI skills, substantial professional iOS experience, architecture ownership, and senior-level technical responsibility"
    ]
}
}