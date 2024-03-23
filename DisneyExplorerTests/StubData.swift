//
//  StubData.swift
//  DisneyExplorerTests
//
//  Created by Louis Rushton on 23/03/2024.
//

import Foundation
@testable import DisneyExplorer

struct StubData {
    static func read(file: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else {
            throw StubDataError.noFileDetected
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            return data
        } catch {
            throw StubDataError.decodingError
        }
    }
}

enum StubDataError: Error {
    case decodingError
    case noFileDetected
}
