//
//  CardView.swift
//  Memory Game App
//
//  Created by Moulya on 3/5/25.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var viewModel: CardGameViewModel
    let card: Card
    @State private var dragAmount: CGSize = .zero

    var body: some View {
        ZStack {
            CardFront(card: card)
                .opacity(card.isFaceUp ? 1 : 0)
            CardBack(card: card)
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(
            .degrees(card.isFaceUp ? 0 : 180),
            axis: (x: 0, y: 1, z: 0)
        )
        .offset(dragAmount)
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in dragAmount = .zero }
        )
        .onTapGesture(count: 2) {
            if !card.isMatched {
                viewModel.selectCard(card)
            }
        }
        .disabled(card.isMatched)
        .opacity(card.isMatched ? 0.5 : 1)
    }
}


private struct CardFront: View {
    let card: Card

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)
            .overlay(
                Text(card.content)
                    .font(.largeTitle)
            )
    }
}


private struct CardBack: View {
    let card: Card

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.blue)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}
