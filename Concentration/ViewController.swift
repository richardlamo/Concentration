//
//  ViewController.swift
//  Concentration
//
//  Created by Richard Lam on 25/5/18.
//  Copyright © 2018 Nice Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var holloweenTheme = [
        "👻","🎃","😈","👹","☠️","🧟‍♂️"
    ]

    var animalFaceTheme = [
        "🐶","🐯","🐷","🦁","🐸","🐼"
    ]

    
    var themeDictionary : Dictionary<String, Array<String>>
    
    var themeChosen = "animalFace"
  
    required init?(coder aDecoder: NSCoder) {
        themeDictionary = [String:[String]]()
        themeDictionary["holloween"] = holloweenTheme
        themeDictionary["animalFace"] = animalFaceTheme
        super.init(coder: aDecoder)
    }



    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        themeDictionary = [String:[String]]()
        themeDictionary["holloween"] = holloweenTheme
        themeDictionary["animalFace"] = animalFaceTheme
    }
    
    
    @IBAction func newGame(_ sender: UIButton) {
        print("New Game!!")
        flipCount = 0
        game.newGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        // initialiseEmoji()
        updateViewFromModel()
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was not in carButtons!")
        }
        
    }
    

    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }

    
    var emoji = Dictionary<Int,String>()
    

    func emoji(for card: Card) -> String {
        var emojiChoices = themeDictionary[themeChosen]!
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    

    
    func flipCard(withEmoji emoji: String, on button: UIButton){
        print("flipCard(withEmoji: \(emoji))")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        flipCount += 1
        
        
        
    }
}

