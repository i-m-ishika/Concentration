//
//  ViewController.swift
//  Concentration
//
//  Created by Ishika Mitra on 01/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1)/2) //initializes when someone tries to use game
    
    var flipCount = 0{
        didSet{
            //executed every time flipCount is set
            flipCountLabel.text = "FLIPS : \(flipCount)"
        }
    }
    
    @IBAction func reset(_ sender: UIButton) {
        game.resetGame() 
        updateViewFromModel()
        flipCount = 0
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            if(!game.cards[cardNumber].isMatched){
                flipCount += 1
            }
            
            updateViewFromModel()

        }else{
            print("chosen card not in cardButtons[]")
        }
        
        
    }
    func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if(card.isFaceUp){
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else{
                button.setTitle("", for: UIControl.State.normal )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    var emojiChoices = ["🧛🏻‍♀️","🎃","👻","🤡","💀","🧞‍♂️","😈","👺"]
    var emoji = [Int: String]() //Dictionary<Int,String>()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
        //if condition nill return "?"
    }
}

