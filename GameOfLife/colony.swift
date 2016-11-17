//
//  colony.swift
//  colonyWithSets
//
//  Created by Bhavik Nagda on 9/22/16.
//  Copyright © 2016 BhavikNagda. All rights reserved.
//

import Foundation

// allows cell to conform to hashable protocol
func ==(cell1: Cell, cell2: Cell) -> Bool {
    return cell1.xCoor == cell2.xCoor && cell1.yCoor == cell2.yCoor
}

struct Cell : Hashable {
    
    init(x: Int, y: Int) {
        xCoor = x
        yCoor = y
    }
    
    let xCoor: Int
    let yCoor: Int
    
    var hashValue: Int {
        return xCoor*1000 + yCoor
    }
}



class Colony: CustomStringConvertible{
    
    // set containing cells
    var colonyCells = Set<Cell>()
    var generationNum = 0
    
    // EXTRA CREDIT: specify size of board
    var size = 20
    
    // EXTRA CREDIT: specify print window
    var corner1 = (0, 0)
    var corner2 = (19, 19)
    
    // sets a cell with given coordinates alive
    func setCellAlive(_ xCoor: Int, yCoor: Int){
        colonyCells.insert(Cell(x: xCoor, y: yCoor))
        //print("Successfully born")
    }
    
    // sets a cell with given coordinates dead
    func setCellDead(_ xCoor: Int, yCoor: Int){
        if colonyCells.remove(Cell(x: xCoor, y: yCoor)) != nil{
            //print("Sucessfully died")
        } else {
            //print("Didn't die: ERROR")
        }
    }
    
    // resets entire colony
    func resetColony(){
        colonyCells.removeAll()
    }
    
    // graphically represents colony with print window
    var description: String {
        // print generation number
        var string = "Generation Number: \(generationNum) \n\n"
        
        // loop through coordinate system
        for x in corner1.0 ... corner2.0 {
            for y in corner1.1 ... corner2.1{
                if colonyCells.contains(Cell(x: x, y: y)) {
                    string += "*"
                } else {
                    string += " "
                }
            }
            string += "\n"
        }
        return string
    }
    
    // checks if cell is alive
    func isCellAlive(_ xCoor: Int, yCoor: Int) -> Bool {
        return colonyCells.contains(Cell(x: xCoor, y: yCoor))
    }
    
    // evolves to next generation
    func evolve(){
        
        // set of cells for next generation
        var newCells = Set<Cell>()
        
        // loops through all living cells
        for cell in colonyCells{
            
            // stores number of surrounding cells
            let cellNum = surroundCellNum(cell)
            
            // cells with 2 or 3 neighbors live on
            if cellNum == 2 || cellNum == 3 {
                newCells.insert(cell)
            }
            
            // array of surrounding cells
            let surrounding = [Cell(x: cell.xCoor - 1, y: cell.yCoor - 1),
                               Cell(x: cell.xCoor, y: cell.yCoor - 1),
                               Cell(x: cell.xCoor + 1, y: cell.yCoor - 1),
                               Cell(x: cell.xCoor - 1, y: cell.yCoor),
                               Cell(x: cell.xCoor + 1, y: cell.yCoor),
                               Cell(x: cell.xCoor - 1, y: cell.yCoor + 1),
                               Cell(x: cell.xCoor, y: cell.yCoor + 1),
                               Cell(x: cell.xCoor + 1, y: cell.yCoor + 1)]
            
            // loops through surrounding cells
            for sur in surrounding {
                
                // if 3 neighbors and within board, cell is born
                if surroundCellNum(sur) == 3 && inBoard(sur) {
                    newCells.insert(sur)
                }
            }
        }
        
        // sets new colony, increase generation
        colonyCells = newCells
        generationNum += 1
    }
    
    // checks if given cell is within board dimensions
    func inBoard(_ workCell: Cell) -> Bool{
        return workCell.xCoor < size && workCell.xCoor >= 0 && workCell.yCoor < size && workCell.yCoor >= 0
    }
    
    // returns number of living cells surrounding given cell
    func surroundCellNum(_ workCell: Cell)-> Int{
        let xCoor = workCell.xCoor
        let yCoor = workCell.yCoor
        
        var surroundCell = 0
        
        // array containing boolean of surrounding cells (living vs dead)
        let boolArray = [colonyCells.contains(Cell(x: xCoor - 1, y: yCoor - 1)),
                         colonyCells.contains(Cell(x: xCoor, y: yCoor - 1)),
                         colonyCells.contains(Cell(x: xCoor + 1, y: yCoor - 1)),
                         colonyCells.contains(Cell(x: xCoor - 1, y: yCoor)),
                         colonyCells.contains(Cell(x: xCoor + 1, y: yCoor)),
                         colonyCells.contains(Cell(x: xCoor - 1, y: yCoor + 1)),
                         colonyCells.contains(Cell(x: xCoor, y: yCoor + 1)),
                         colonyCells.contains(Cell(x: xCoor + 1, y: yCoor + 1))]
        
        // loops through array, counts living cells
        for bool in boolArray{
            if bool == true{
                surroundCell += 1
            }
        }
        
        return surroundCell
    }
    
    // EXTRA CREDIT: returns tuple of bounding coordinates (xMin, yMin), (xMax, yMax)
    func boundingCoord()-> ((Int, Int), (Int, Int)){
        var minX = size - 1
        var minY = size - 1
        var maxX = 0
        var maxY = 0
        
        for cell in colonyCells{
            if(cell.xCoor < minX){
                minX = cell.xCoor
            }
            if(cell.yCoor < minY){
                minY = cell.yCoor
            }
            if(cell.xCoor > maxX){
                maxX = cell.xCoor
            }
            if(cell.yCoor > maxY){
                maxY = cell.yCoor
            }
        }
        return ((minX, minY), (maxX, maxY))
    }
}
