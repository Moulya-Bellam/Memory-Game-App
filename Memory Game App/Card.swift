//
//  Card.swift
//  Memory Game App
//
//  Created by Moulya on 3/5/25.
//

import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var isFaceUp: Bool = false
    var isMatched: Bool = false
    let content: String // Emoji
    var position: CGSize = .zero
}
