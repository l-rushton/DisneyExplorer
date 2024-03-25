//
//  DisneyClient.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation

class DisneyClient {
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getCharacters(url: String = "https://api.disneyapi.dev/character") async -> Result<GetAllDTO, ClientError> {
        let combinedUrl = URL(string: url)
        
        if let combinedUrl {
            do {
                let (data, _) = try await urlSession.data(from: combinedUrl)
                let response = try JSONDecoder().decode(GetAllDTO.self, from: data)
                
                return .success(response)
                
            } catch {
                if error is URLError {
                    return .failure(.networkError)
                } else {
                    return .failure(.decodingError)
                }
            }
        } else {
            return .failure(.invalidUrl)
        }
    }
}

enum ClientError: Error {
    case networkError
    case decodingError
    case invalidUrl
}

extension ClientError {
    var string: String {
        switch self {
        case .networkError: "Network error, please try again"
        case .decodingError: "Network response invalid, please try again"
        case .invalidUrl: "Invalid request, please try again"
        }
    }
}
