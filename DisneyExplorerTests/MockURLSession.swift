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

    func data(from url: URL) async throws -> (Data, URLResponse) {
        guard let data = self.data else {
            throw URLError(.badServerResponse)
        }
        guard let urlResponse = self.urlResponse else {
            throw URLError(.badServerResponse)
        }
        return (data, urlResponse)
    }
}
