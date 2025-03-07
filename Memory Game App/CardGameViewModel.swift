//
//  CardGameViewModel.swift
//  Memory Game App
//
//  Created by Moulya on 3/5/25.
//

import SwiftUI

class CardGameViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var score: Int = 0
    @Published var moves: Int = 0
    @Published var gameOver: Bool = false
    private var firstSelectedCard: Card?

    init() {
        startNewGame()
    }

    func startNewGame() {
        let emojis = ["❤️", "🌟", "🐶", "🐱", "🍦", "🚀", "🌈", "🎁"]
        let pairedEmojis = (emojis + emojis).shuffled()
        cards = pairedEmojis.map { Card(content: $0) }
        score = 0
        moves = 0
        gameOver = false
        firstSelectedCard = nil
    }

    func shuffleCards() {
        cards.shuffle()
    }

    func selectCard(_ selectedCard: Card) {
        guard let index = cards.firstIndex(where: { $0.id == selectedCard.id }),
              !cards[index].isMatched,
              !cards[index].isFaceUp else { return }

        if let firstCard = firstSelectedCard {
            // Second card selected
            moves += 1

            if selectedCard.content == firstCard.content {
                // Match found
                cards[index].isMatched = true
                if let firstIndex = cards.firstIndex(where: { $0.id == firstCard.id }) {
                    cards[firstIndex].isMatched = true
                }
                score += 2

                // Checking if all cards are matched
                if cards.allSatisfy({ $0.isMatched }) {
                    gameOver = true
                }
            } else {
                // No match
                if score > 0 {
                    score -= 1
                }

                // Flipping both cards back after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.cards[index].isFaceUp = false
                        if let firstIndex = self.cards.firstIndex(where: { $0.id == firstCard.id }) {
                            self.cards[firstIndex].isFaceUp = false
                        }
                    }
                }
            }

            // Resetting the first selected card
            firstSelectedCard = nil
        } else {
            // First card selected
            // Flipping all unmatched cards facing down
            cards.indices.forEach { index in
                if !cards[index].isMatched {
                    cards[index].isFaceUp = false
                }
            }

            // Setting the first selected card
            firstSelectedCard = selectedCard
        }

        // Flipping the selected card facing up
        withAnimation {
            cards[index].isFaceUp = true
        }
    }
}
