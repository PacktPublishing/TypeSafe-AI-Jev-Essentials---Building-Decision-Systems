//
//  ContentView.swift
//  Learn
//
//  Created by Mohammad Azam on 5/27/26.
//

import Foundation

struct APIError: Decodable {
    let field: String
    let message: String
}

struct ErrorResponse: Decodable {
    let message: String
    let errors: [APIError]?

    var errorMessage: String {
        guard let errors, !errors.isEmpty else {
            return message
        }

        return errors
            .map(\.message)
            .joined(separator: "\n")
    }
}

enum HTTPMethod {
    case get
    case post(Data)
    case delete
    case put
    
    var rawValue: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .delete:
            "DELETE"
        case .put:
            "PUT"
        }
    }
    
    
    var body: Data? {
        switch self {
        case .post(let data):
            data
        default:
            nil
        }
    }
}

struct Resource<T: Decodable> {
    let url: URL
    var method: HTTPMethod = .get
    let responseType: T.Type
}

enum NetworkError: Error {
    case badRequest(ErrorResponse)
    case invalidResponse
    case decodingFailed(Error)
    case serverError
}

extension NetworkError: LocalizedError {

    var errorDescription: String? {
        switch self {

        case .badRequest(let response):
            return response.errorMessage

        case .invalidResponse:
            return "The server returned an invalid response."

        case .decodingFailed:
            return "Unable to process the server response."
        
        case .serverError:
            return "The server encountered an error. Please try again later."
        }
    }
}

struct HTTPClient {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let defaultHeaders: [String: String]
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder(), defaultHeaders: [String : String] = ["Content-Type": "application/json"]) {
        self.session = session
        self.decoder = decoder
        self.defaultHeaders = defaultHeaders
    }
    
    func fetch<T>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.method.rawValue
        request.allHTTPHeaderFields = defaultHeaders
        request.httpBody = resource.method.body
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print(error.localizedDescription)
                throw NetworkError.decodingFailed(error)
            }
        case 400...499:
            do {
                let errorResponse = try JSONDecoder().decode(
                    ErrorResponse.self,
                    from: data
                )
                
                throw NetworkError.badRequest(errorResponse)
            } catch let error as NetworkError {
                throw error
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        case 500...599:
            throw NetworkError.serverError
        default:
            throw NetworkError.invalidResponse
        }
    }
}


