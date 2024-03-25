//
//  ActionButton.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 24/03/2024.
//

import SwiftUI

struct ActionButton: View {
    let buttonType: ActionButtonType
    let action: @Sendable () async throws -> Void
    
    var body: some View {
        Button {
            Task {
                try? await action()
            }
        } label: {
            HStack {
                Spacer()
                Text(buttonType.title)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding()
            .background(buttonType.color)
            .cornerRadius(10)
            .padding()
        }
    }
}

enum ActionButtonType {
    case save
    case delete
    case retry
}

extension ActionButtonType {
    var title: String {
        switch self {
        case .save: "Add to favourites"
        case .delete: "Delete from favourites"
        case .retry: "Retry"
        }
    }
    
    var color: Color {
        switch self {
        case .save: .green
        case .delete, .retry: .red
        }
    }
}

