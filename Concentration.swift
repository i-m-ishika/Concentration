//
//  Concentration.swift
//  Concentration
//
//  Created by Ishika Mitra on 02/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import Foundation
class Concentration{
    var cards = Array<Card>() //[Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                    //one card up
                if cards[index].identifier == cards[matchIndex].identifier{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
            }else{
                //two or no cards face up
                for cardIndex in cards.indices{
                    cards[cardIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
        
    }
    func resetGame(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    init(numberOfPairsOfCards: Int){
        for _ in 0..<numberOfPairsOfCards{
                let card = Card()
                cards += [card, card]
        }
        cards.shuffle()
    }
}
