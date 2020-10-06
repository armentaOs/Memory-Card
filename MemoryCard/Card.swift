//
//  Card.swift
//  MemoryCard
//
//  Created by Oscar A on 27/05/20.
//  Copyright © 2020 Oscar A. All rights reserved.
//

struct Card
{
    var emoji: String
    var isFaceUp = false
    var isMatched = false
    var timesSeen: Int16 = 0
    var index = 0
}

extension Card
{
    init(emoji: String) {
        self.emoji = emoji
    }
}
