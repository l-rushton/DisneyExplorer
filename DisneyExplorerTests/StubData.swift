//
//  StubData.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
@testable import DisneyExplorer

struct StubData {
    static func read<V: Decodable>(file: String) throws -> V {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            throw StubDataError.noFileDetected
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let result = try JSONDecoder().decode(V.self, from: data)
            return result
        } catch {
            throw StubDataError.decodingError
        }
    }
}

enum StubDataError: Error {
    case decodingError
    case noFileDetected
}
