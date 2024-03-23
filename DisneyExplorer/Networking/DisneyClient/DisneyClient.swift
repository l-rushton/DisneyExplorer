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
    
    func getAllCharacters(url: String = ClientUrls.getAllCharacters.rawValue) async -> Result<GetAllDTO, ClientError> {
        let url = URL(string: url)
        
        if let url {
            do {
                let (data, _) = try await urlSession.data(from: url)
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

enum ClientUrls: String {
    case getAllCharacters = "https://api.disneyapi.dev/character"
}
