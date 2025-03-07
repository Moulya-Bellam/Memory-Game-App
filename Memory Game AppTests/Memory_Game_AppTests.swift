//
//  Memory_Game_AppTests.swift
//  Memory Game AppTests
//
//  Created by Moulya on 3/5/25.
//

import XCTest
@testable import Memory_Game_App 

class Memory_Game_AppTests: XCTestCase {
    func testCardMatching() {
        let viewModel = CardGameViewModel()
        viewModel.startNewGame()
        
        let firstCard = viewModel.cards[0]
        let secondCard = viewModel.cards[1]
        
        viewModel.selectCard(firstCard)
        viewModel.selectCard(secondCard)
        
        XCTAssertEqual(viewModel.score, firstCard.content == secondCard.content ? 2 : -1)
    }
}
