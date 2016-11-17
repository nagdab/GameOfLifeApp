//
//  Colony.swift
//  GameOfLife
//
//  Created by John Barbone on 11/17/16.
//  Copyright © 2016 stulinProject. All rights reserved.
//

import Foundation

class colony{
    let size = 60
    var cells = Set<cell>()
    var ncells = Set<cell>()
    var generation = 0
    var numAlive: Int {
        return cells.count
    }

    
    
    func round1() {
        for c in cells{
            adder(create(c.x + 1,y: c.y))
            adder(create(c.x + 1,y: c.y + 1))
            adder(create(c.x + 1,y: c.y - 1))
            adder(create(c.x - 1,y: c.y))
            adder(create(c.x - 1,y: c.y + 1))
            adder(create(c.x - 1,y: c.y - 1))
            adder(create(c.x,y: c.y + 1))
            adder(create(c.x,y: c.y - 1))
            
        }
        
    }
    
    func counter(_ c :cell) -> (Int){
        var num = 0
        if c.x != 0 {
            if c.y != 0 {
                
                if cells.contains(create(c.x - 1,y: c.y + 1)){
                    num += 1
                }
                if c.y != size {
                }
                if cells.contains(create(c.x - 1,y: c.y - 1)){
                    num += 1
                }
            }
            if cells.contains(create(c.x - 1,y: c.y)){
                num += 1
            }
            
        }
        if c.x != size {
            if c.y != 0 {
                
                if cells.contains(create(c.x + 1,y: c.y + 1)){
                    num += 1
                }
                if c.y != size {
                }
                if cells.contains(create(c.x + 1,y: c.y - 1)){
                    num += 1
                }
            }
            if cells.contains(create(c.x + 1,y: c.y)){
                num += 1
            }
        }
        
        if c.y != size {
            if cells.contains(create(c.x,y: c.y + 1)){
                num += 1
            }
        }
        if c.y != 0 {
            if cells.contains(create(c.x,y: c.y - 1)){
                num += 1
            }
        }
        return num
    }
    
    func create(_ x : Int, y : Int) -> (cell){
        return cell(x: x, y: y)
        
    }
    
    func adder(_ c : cell){
        if counter(c) == 3 || (counter(c) == 2 && cells.contains(c)){
            ncells.insert(c)
        }
    }
    
    func evolve(){
        round1()
        cells = ncells
        ncells = []
        generation += 1
        
    }
    func newcell(_ x: Int, y: Int){
        cells.insert(create(x,y: y))
    }
    func alive(x: Int, y: Int) -> Bool{
        let isCell = cell(x: x, y: y)
        return cells.contains(isCell)
    }
    
    
}
