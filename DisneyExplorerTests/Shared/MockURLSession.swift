//
//  MockURLSession.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

@testable import DisneyExplorer
import Foundation

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?

    init(data: Data? = nil, urlResponse: URLResponse? = nil, error: Error? = nil) {
        self.data = data
        self.urlResponse = urlResponse
        self.error = error
    }
    
    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard error == nil, let data = self.data, let urlResponse = self.urlResponse else {
            throw URLError(.badServerResponse)
        }

        return (data, urlResponse)
    }
}
