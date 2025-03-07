//
//  MainGameView.swift
//  Memory Game App
//
//  Created by Moulya on 3/5/25.
//

import SwiftUI

struct MainGameView: View {
    @StateObject private var viewModel = CardGameViewModel() 
    @State private var deviceOrientation = UIDeviceOrientation.portrait

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.blue.opacity(0.1).edgesIgnoringSafeArea(.all)

                if geometry.size.width > geometry.size.height {
                    HStack {
                        createCardGrid(screenSize: geometry.size)
                        ControlPanel(viewModel: viewModel)
                    }
                } else {
                    VStack {
                        createCardGrid(screenSize: geometry.size)
                        ControlPanel(viewModel: viewModel)
                    }
                }
            }
            .onRotate { newOrientation in
                deviceOrientation = newOrientation
            }
        }
    }

    private func createCardGrid(screenSize: CGSize) -> some View {
        let columns = [GridItem(.adaptive(minimum: screenSize.width > screenSize.height ? 100 : 80))]
        return LazyVGrid(columns: columns, spacing: 10) {
            ForEach(viewModel.cards) { card in
                CardView(viewModel: viewModel, card: card)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
    }
}
