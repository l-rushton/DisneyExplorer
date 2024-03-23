//
//  URLSessionProtocol.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
