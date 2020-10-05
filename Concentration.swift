//
//  Concentration.swift
//  Concentration
//
//  Created by Ishika Mitra on 02/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import Foundation
struct Concentration{
    private(set) var cards = Array<Card>() //[Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            return cards.indices.filter( {cards[$0].isFaceUp} ).oneAndOnly
//            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp }) 
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil

        }
        set(newVal){
            for index in cards.indices{
                cards[index].isFaceUp = (index == newVal)
            }
           
        }
    }
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"Concentration.chooseCard(at index: \(index)) : chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                    //one card up
                if cards[index] == cards[matchIndex]{
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
             
                
            }else{
                //two or no cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
        
    }
    mutating func resetGame(){
        for index in cards.indices{
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    func increaseFlipCount(for index: Int, flipCount: Int) -> Int {
        if cards[index].isFaceUp || cards[index].isMatched{
            return flipCount
        }
        return flipCount + 1
    }
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards>0, "Concentration.init(numberOfPairsOfCards: Int): minimum 1 pair of cards required")
        for _ in 0..<numberOfPairsOfCards{
                let card = Card()
                cards += [card, card]
        }
        cards.shuffle()
    }
    
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
