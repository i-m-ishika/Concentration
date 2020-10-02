//
//  Card.swift
//  Concentration
//
//  Created by Ishika Mitra on 02/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import Foundation
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
