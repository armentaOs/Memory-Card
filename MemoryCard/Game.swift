//
//  Game.swift
//  MemoryCard
//
//  Created by Oscar A on 27/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

class Game {
    var playerPoints: Int16
    var firstCardIndex: Card?
    var secondCardIndex: Card?
    var cards = Array<Card>()
    
    init(playerPoints: Int16, pairOfCards: Int, emojis: Array<String>) {
        self.playerPoints = playerPoints
        var emojisPack = emojis
        var counter = pairOfCards - 1
        for _ in 1...pairOfCards {
            let emoji = emojisPack.remove(at: counter)
            let aCard = Card(emoji: emoji, isFaceUp: false, isMatched: false)
            self.cards.append(aCard)
            self.cards.append(aCard)
            counter -= 1
        }
        self.cards.shuffle()
    }
    
    func touchCard(index: Int) -> Array<Int>? {
        
        // Si tenemos una carta dentro del property firstCardIndex, entramos quí.
        if let cardOne = firstCardIndex, cardOne.index != index {
            gettingCardReady(index: index, firstOrSecondCard: &secondCardIndex)
            
            // comparamos el emoji de ambas cartas que están dentro de las properties.
            if let cardTwo = secondCardIndex, cardTwo.emoji == cardOne.emoji {
                let indexes = touchCardHelper(isMatch: true)
                return indexes
            } else {
                let indexes = touchCardHelper(isMatch: false)
                return indexes
            }
        } else if firstCardIndex == nil {
            // Si no entramos al primer if entramos aquí.
             gettingCardReady(index: index, firstOrSecondCard: &firstCardIndex)
            var index = [Int]()
            index.append(firstCardIndex!.index)
            
            return index
        }
        return nil
    }
    
    func gettingCardReady(index: Int, firstOrSecondCard: inout Card?) -> Void {
        cards[index].isFaceUp = true
        cards[index].index = index
        firstOrSecondCard = cards[index]
    }
    
    func touchCardHelper(isMatch: Bool) -> Array<Int> {
        var indexes = [Int]()
        
        if isMatch {
            // Si son iguales, entramos al array de cartas dando los indices dentro de las properties.
            cards[secondCardIndex!.index].isMatched = true
            cards[firstCardIndex!.index].isMatched = true
            
            // Restamos los puntos necesarios y sumamos las veces que estas cartas se han visto, así como añadir puntos.
            playerPoints += 1
        } else {
            // En caso de no ser iguales.
            cards[firstCardIndex!.index].isFaceUp = false
            cards[secondCardIndex!.index].isFaceUp = false
            
            let minusPoints = cards[firstCardIndex!.index].timesSeen + cards[secondCardIndex!.index].timesSeen
            playerPoints -= minusPoints
            
            cards[secondCardIndex!.index].timesSeen += 1
            cards[secondCardIndex!.index].timesSeen += 1
        }
        let indexOne = firstCardIndex!.index
        let indexTwo = secondCardIndex!.index
        indexes = [indexOne, indexTwo]
        
        firstCardIndex = nil
        secondCardIndex = nil
        
        return indexes
    }
}
