//
//  MockDisneyClient.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

@testable import DisneyExplorer
import Foundation

class MockDisneyClient: DisneyClientProtocol {
    let environment: MockDisneyClientEnvironment
    
    init(environment: MockDisneyClientEnvironment) {
        self.environment = environment
    }
    
    func getAllCharacters() async -> Result<GetAllDTO, ClientError> {
        switch self.environment {
        case .success:
            do {
                let dto: GetAllDTO = try StubData.read(file: "GetAllSuccess")
                return .success(dto)
            } catch {
                return .failure(.decodingError)
            }
        case .failure:
            return .failure(.networkError)
        }
    }
}

enum MockDisneyClientEnvironment {
    case success
    case failure
}
