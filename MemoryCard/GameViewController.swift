//
//  ViewController.swift
//  MemoryCard
//
//  Created by Oscar A on 27/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

import UIKit
import CoreData

class GameViewController: UIViewController {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var statusColorPoints: UIButton!
    
    var emojis: Array<String>!
    var game: Game!
    var bg: UIImage!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if emojis != nil, bg != nil {
            game = Game(playerPoints: 3, pairOfCards: emojis.count, emojis: emojis)
        }
        setUI()
    }
    
// MARK:- Volteando todas las cartas arriba y abajo al inicio.
    
    override func viewDidAppear(_ animated: Bool) {
        if emojis != nil {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                self.flipAllCardsUp(pairOfCards: self.emojis.count)
            }
            Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { (_) in
                self.flipAllCardsReversed(pairOfCards: self.emojis.count)
            }
        }
    }
    
    // MARK:- Funciones principales.
    
    @IBAction func touch(_ sender: UIButton) {
        let index = getIndex(button: sender)
        flipCard(index: index, flipTime: 0.3, isDefaultEnabled: false)
        
        let indexes = self.game.touchCard(index: index)
        setPoints()
        if let indexesContainer = indexes {
            if indexesContainer.count == 1 {
                self.cardButtons[indexesContainer[0]].isEnabled = false
            } else {
                self.cardButtons[indexesContainer[1]].isEnabled = false
                if self.game.cards[index].isMatched == false {
                    
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [unowned self] (nil) in
                        self.flipCard(index: indexesContainer[0], flipTime: 0.3, isDefaultEnabled: true)
                        self.flipCard(index: indexesContainer[1], flipTime: 0.3, isDefaultEnabled: true)
                        self.cardButtons[indexesContainer[0]].isEnabled = true
                        self.cardButtons[indexesContainer[1]].isEnabled = true
                    }
                }
            }
        }
    }
    
// MARK:- Funciones auxiliares.
    
    func getIndex(button: UIButton) -> Int {
        let onlyDefault = 0
        let number = cardButtons.firstIndex(of: button) ?? onlyDefault
        return number
    }
    
    func flipCard(index: Int, flipTime: Double, isDefaultEnabled: Bool) -> Void {
        if isDefaultEnabled {
            flipCardHelper(index: index, color: #colorLiteral(red: 0.6547160534, green: 0.4901011686, blue: 1, alpha: 1), flipTime: flipTime, emoji: "")
        } else {
            let card = self.game.cards[index]
            if card.isFaceUp && !card.isMatched {
                flipCardHelper(index: index, color: #colorLiteral(red: 0.6547160534, green: 0.4901011686, blue: 1, alpha: 1), flipTime: flipTime, emoji: "")
            } else {
                flipCardHelper(index: index, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), flipTime: flipTime, emoji: card.emoji)
            }
        }
    }
    
    func flipCardHelper(index: Int, color: UIColor, flipTime: Double, emoji: String) -> Void {
        let button = cardButtons[index]
        button.backgroundColor = color
        button.setTitle(emoji, for: UIControl.State.normal)
        UIView.transition(with: button, duration: flipTime, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    func flipAllCardsUp(pairOfCards: Int) -> Void {
    // Usamos el property pairOfCards para iterar a travez de todos los botones, cada iteración, volteará boca arriba o abajo.
        var startBy = 0.1
        for indexForger in 0..<pairOfCards * 2 {
            flipCard(index: indexForger, flipTime: startBy, isDefaultEnabled: false)
            game.cards[indexForger].isFaceUp = true
            startBy += 0.2
        }
    }
    
    func flipAllCardsReversed(pairOfCards: Int) -> Void {
        var startBy = 0.1
        for indexForger in (0..<pairOfCards * 2).reversed() {
            flipCard(index: indexForger, flipTime: startBy, isDefaultEnabled: false)
            game.cards[indexForger].isFaceUp = false
            startBy += 0.2
            cardButtons[indexForger].isEnabled = true
        }
    }
    
    func setUI() -> Void {
        for eachButton in self.cardButtons.indices {
            cardButtons[eachButton].isEnabled = false
            cardButtons[eachButton].layer.cornerRadius = 6.0
        }
        background.backgroundColor = UIColor(patternImage: bg)
    }

    func setPoints() -> Void {
        self.pointsLabel.text = String(game.playerPoints)
        switch game.playerPoints {
        case -10...0 :
            self.statusColorPoints.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            self.pointsLabel.text = "Perdiste 😈"
            for card in cardButtons {
                card.isEnabled = false
            }
        case 1..<3 : self.statusColorPoints.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        case 3..<5 : self.statusColorPoints.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case 5..<100 : self.statusColorPoints.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        default: self.statusColorPoints.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        
// MARK: - Core Data.
        
        func getGame() {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                if let oldGame = try? context.fetch(GameDM.fetchRequest()) {
                    if let theOldGame = oldGame as? GameDM {
                        game.playerPoints = theOldGame.playerPoints
                    
                    }
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newGame = GameDM(context: context)
            newGame.playerPoints = game.playerPoints
            
            for card in game.cards {
                let newCard = CardDM(context: context)
                newCard.emoji = card.emoji
                newCard.index = Int16(card.index)
                newCard.isFaceUp = card.isFaceUp
                newCard.isMatched = card.isMatched
                newCard.gameoOne = newGame
                newCard.gameTwo = nil
                newCard.gameTree = nil
            }
            
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
}

