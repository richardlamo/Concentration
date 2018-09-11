//
//  Card.swift
//  Concentration
//
//  Created by Richard Lam on 15/6/18.
//  Copyright © 2018 Nice Consulting. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIndentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func resetUniqueIndentifier() {
        identifierFactory = 0;
    }
    
    init() {
        self.identifier = Card.getUniqueIndentifier()
    }
}

