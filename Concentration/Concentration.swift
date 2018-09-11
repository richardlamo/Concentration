//
//  Concentration.swift
//  Concentration
//
//  Created by Richard Lam on 15/6/18.
//  Copyright © 2018 Nice Consulting. All rights reserved.
//

import Foundation

class Concentration {

    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                   cards[matchIndex].isMatched = true
                   cards[index].isMatched = true
                }

                print("\(cards[matchIndex].identifier) : \(cards[index].identifier)")

                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face upø
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
   
        
    }
    
    func newGame(numberOfPairsOfCards: Int){
        Card.resetUniqueIndentifier()
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        // TODO: Shuffle the cards
        var randomCards = [Card]();
        while cards.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            randomCards.append(cards[randomIndex])
            cards.remove(at: randomIndex)
        }
        cards = randomCards
        
        indexOfOneAndOnlyFaceUpCard = nil
        for flipDownIndex in cards.indices {
            cards[flipDownIndex].isFaceUp = false
            cards[flipDownIndex].isMatched = false
        }

    }
    
    init(numberOfPairsOfCards: Int){
        newGame(numberOfPairsOfCards: numberOfPairsOfCards)
    }
    
    
}

