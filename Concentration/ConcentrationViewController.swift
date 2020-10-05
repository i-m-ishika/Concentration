//
//  ViewController.swift
//  Concentration
//
//  Created by Ishika Mitra on 01/10/20.
//  Copyright © 2020 Ishika Mitra. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards) //initializes when someone tries to use game
    var numberOfPairsOfCards : Int {
        return (cardButtons.count + 1)/2
        //read-only computed property
        
    }
   
    private(set) var flipCount = 0{
        didSet{
            //executed every time flipCount is set
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 40),
            .foregroundColor: UIColor.black
        ]
        let attributedString = NSAttributedString(string: "FLIPS : \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    @IBAction private func reset(_ sender: UIButton) {
        flipCount = 0
        game.resetGame()
        updateViewFromModel()
        
    }
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            flipCount = game.increaseFlipCount(for: cardNumber, flipCount: flipCount)
            game.chooseCard(at: cardNumber)
            
            updateViewFromModel()

        }else{
            print("chosen card not in cardButtons[]")
        }
        
        
    }
    private func updateViewFromModel(){
        if cardButtons != nil{
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if(card.isFaceUp){
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
                else{
                    button.setTitle("", for: UIControl.State.normal )
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
                }
            }
        }
        
    }
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:] //reset dictionary
            updateViewFromModel()
        }
    }
    private var emojiChoices = "🧛🏻‍♀️🎃👻🤡💀🧞‍♂️😈👺"
    private var emoji = [Card: String]() //Dictionary<Card,String>()
    
    private func emoji(for card: Card) -> String{
        if emoji[card] == nil, emojiChoices.count > 0{
            let randomInt = emojiChoices.count.arc4random
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: randomInt)
          
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
        //if condition nill return "?"
    }
}
extension Int{
    var arc4random: Int {
        if self > 0{
                return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}

