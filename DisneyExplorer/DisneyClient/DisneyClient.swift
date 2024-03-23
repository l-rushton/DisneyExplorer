//
//  DisneyClient.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation

protocol DisneyClientProtocol {
    func getAllCharacters() async -> Result<GetAllDTO, ClientError>
}

enum ClientError: Error {
    case networkError
    case decodingError
}
