//
//  ActionButton.swift
//  DisneyExplorer
//
//  Created by Louis Rushton on 24/03/2024.
//

import SwiftUI

@ViewBuilder
func actionButton(buttonType: ActionButton, action: @escaping () -> Void) -> some View {
    Button {
        action()
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

enum ActionButton {
    case save
    case delete
    case retry
}

extension ActionButton {
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

