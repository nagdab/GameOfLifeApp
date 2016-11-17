//
//  Cell.swift
//  GameOfLife
//
//  Created by John Barbone on 11/17/16.
//  Copyright © 2016 stulinProject. All rights reserved.
//

import Foundation

struct cell : Hashable{
    var x : Int
    var y : Int
    var hashValue: Int {
        return x * 83 + y
    }
}

func ==(lhs: cell, rhs: cell) -> Bool {
    return (lhs.x == rhs.x) && (lhs.y == rhs.y)
}
