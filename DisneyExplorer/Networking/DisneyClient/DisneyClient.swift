//
//  DisneyClient.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation

protocol DisneyClientProtocol {
    var urlSession: URLSessionProtocol { get }
    func getAllCharacters() async -> Result<GetAllDTO, ClientError>
}

class DisneyClient: DisneyClientProtocol {
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func getAllCharacters() async -> Result<GetAllDTO, ClientError> {
        let url = URL(string: "https://api.disneyapi.dev/character")
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
